module V1p1
  class ApplicationController < ActionController::API
    before_action :doorkeeper_authorize!
    before_action :restrict_remote_ip
    ORDER_VALUES = %w[desc asc].freeze

    protected

    def restrict_remote_ip
      render text: 'Forbidden', status: 403 unless permit_ip_address?(request.remote_ip)
    end

    def orderby_validvalue(param)
      orderby = param.nil? ? 'desc' : param.downcase
      ORDER_VALUES.include?(orderby) ? orderby : 'desc'
    end

    def indexbase(model_class)
      relations = model_class.all
      relations = indexbase_with_condition(model_class, relations)
      render_json(model_class.name, relations)
    end

    def indexbase_with_condition(model_class, relations)
      # sourcedId
      sourced_id = params[:sourcedId]
      relations = relations.where(sourcedId: sourced_id) unless sourced_id.nil?
      # filter
      filter_param = params[:filter]
      unless filter_param.nil?
        # filter_parm to url decode
        filtervalue = URI.decode_www_form_component(filter_param, enc=Encoding::UTF_8)
        # divide with logical operation
        logical = nil
        filtervalues = filtervalue.split(' AND ')
        logical = 'AND' if filtervalues.size > 1
        filtervalues = filtervalue.split(' OR ') if logical.nil?
        logical = 'OR' if filtervalues.size > 1
        where1 = predict_formula(filtervalues.first)
        where2 = predict_formula(filtervalues.last) unless logical.nil?
        relations = relations.where(where1[:criteria], where1[:value]) if logical.nil?
        relations = relations.where(where1[:criteria] + ' ' + logical + ' ' + where2[:criteria], where1[:value], where2[:value]) unless logical.nil?
      end
      # limit & offset
      limit = params[:limit].nil? ? LIMIT : params[:limit]
      offset = params[:offset].nil? ? OFFSET : params[:offset]
      # sort
      sort = params[:sort].nil? ? 'sourcedId' : params[:sort]
      sort = model_class.columns_hash[sort].nil? ? 'sourcedId' : sort
      # orderby
      orderby = orderby_validvalue(params[:orderby])
      relations.order(sort + ' ' + orderby).limit(limit).offset(offset)
    end

    def render_json(model_name, relations)
      title = model_name[0].downcase + model_name[1, model_name.length - 1]
      title = title.pluralize if params[:sourcedId].nil?
      relations = relations[0] if params[:sourcedId].present?
      render json: {title => relations}, except: %i[id created_at updated_at]
    end

    private

    def predict_formula(str)
      filter_hash = predict_kind(str)
      value = filter_hash[:value]
      match = value.match(/\'(?<value>.+)\'/)
      value = match[:value] unless match.nil?
      case filter_hash[:ope]
      when '~' then
        criteria = filter_hash[:key] + ' like ?'
        return { criteria: criteria, value: '%' + value + '%' }
      else
        criteria = filter_hash[:key] + ' ' + filter_hash[:ope] + ' ? '
        return { criteria: criteria, value: value }
      end
    end

    def predict_kind(str)
      predicts = ['!=', '>=', '<=', '=', '>', '<', '~']
      predicts.each do |p|
        values = str.split(p)
        return { ope: p, key: values[0], value: values[1] } if values.size > 1
      end
    end

    def permit_ip_address?(ip)
      return false unless doorkeeper_token
      permit_address = doorkeeper_token.application.permit_ips
      return true if permit_address.nil?
      permit_address = doorkeeper_token.application.permit_ips.split(',')
      return true unless defined? permit_address
      return true if permit_address.empty?
      return true if permit_address.include?(request.remote_ip)
      permit_address.each do |pa|
        pa = pa.delete(' ')
        return true if ip.start_with?(pa) # begins-with match
      end
      false
    end
  end
end
