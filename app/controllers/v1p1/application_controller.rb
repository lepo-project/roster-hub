module V1p1
  class ApplicationController < ActionController::API
    before_action :doorkeeper_authorize!
    before_action :restrict_remote_ip
    ORDER_VALUES = %w[desc asc].freeze

    def index
      relations = model_class.all
      relations = indexbase_with_condition(relations)
      render_json(model_class.name, relations)
    end

    def show
      index
    end

    def create
      record = model_class.new(strong_params.merge({application_id: doorkeeper_token.application_id}))
      if record.save
        render_titled_json json_title, record
      else
        # Status code 400: Bad Request - the Request was invalid and cannot be served.
        render nothing: true, status: 400
      end
    end

    def update
      record = model_class.find_by(sourcedId: params[:sourcedId])
      if record.nil?
        # Status code 404: Not Found - there is no resource behind the URI.
        render nothing: true, status: 404
      elsif (record.application_id != doorkeeper_token.application_id)
        # Status code 401: Unauthorized - the Request requires authorization.
        render nothing: true, status: 401
      elsif !record.update_attributes(strong_params)
        # Status code 400: Bad Request - the Request was invalid and cannot be served.
        render nothing: true, status: 400
      else
        render_titled_json json_title, record
      end
    end

    def destroy
      record = model_class.find_by(sourcedId: params[:sourcedId])
      if record.nil?
        # Status code 404: Not Found - there is no resource behind the URI.
        render nothing: true, status: 404
      elsif (record.application_id != doorkeeper_token.application_id)
        # Status code 401: Unauthorized - the Request requires authorization.
        render nothing: true, status: 401
      else
        record.destroy
        # Status code 204: OK - The resource was deleted successfully.
        render nothing: true, status: 204
      end
    end

    protected

    def restrict_remote_ip
      # Status code 403: Forbidden - to indicate that the server can be reached and process the request but refuses to take any further action.
      render text: 'Forbidden', status: 403 unless permit_ip_address?(request.remote_ip)
    end

    def orderby_validvalue(param)
      orderby = param.nil? ? 'desc' : param.downcase
      ORDER_VALUES.include?(orderby) ? orderby : 'desc'
    end

    def indexbase_with_condition(relations)
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
      if params[:sourcedId].present?
        if relations.empty?
          # Status code 404: Not Found - there is no resource behind the URI.
          render nothing: true, status: 404
        else
          render_titled_json title, relations[0]
        end
      else
        render_titled_json title.pluralize, relations
      end
    end

    def render_titled_json(title, relation)
      render json: {title => relation}, except: %i[id application_id created_at updated_at]
    end

    private

    def json_title
      (controller_name == 'rclasses') ? 'class' : controller_name.singularize
    end

    def model_class
      controller_name.singularize.camelize.constantize
    end

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
