module V1p1
class ApplicationController < ActionController::API
  before_action :doorkeeper_authorize! 
  ORDER_VALUES = 'desc', 'asc'
  protected
  def orderby_validvalue(param)
    orderby = params[:orderby].nil? ? 'desc' : params[:orderby].downcase
    orderby =  ORDER_VALUES.include?(orderby)? orderby : 'desc'
  end

  def indexbase(modelClass)
    datas = modelClass.all
    datas = indexbase_with_condition(modelClass,datas)
    render json: datas
  end
  
  def indexbase_with_condition(modelClass, datas)
    # sourcedId
    sourcedId = params[:sourcedId]
    datas = datas.where(sourcedId: sourcedId) unless sourcedId.nil?
    # filter
    filter_param = params[:filter]
    if not filter_param.nil?
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
      datas = datas.where(where1[:criteria], where1[:value]) if logical.nil?
      datas = datas.where(where1[:criteria] + ' ' + logical + ' ' + where2[:criteria], where1[:value], where2[:value]) unless logical.nil?
    end
    # limit & offset
    limit = params[:limit].nil? ? LIMIT : params[:limit]
    offset = params[:offset].nil? ? OFFSET : params[:offset]
    # sort
    sort = params[:sort].nil? ? 'sourcedId' : params[:sort]
    sort = modelClass.columns_hash[sort].nil? ? 'sourcedId' : sort
    # orderby
    orderby = orderby_validvalue(params[:orderby])
    datas = datas.order(sort + ' ' + orderby).limit(limit).offset(offset)
    return datas
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
      return {:criteria => criteria, :value => '%' + value + '%'}
    else
      criteria = filter_hash[:key] + ' ' + filter_hash[:ope] + ' ? '
      return {:criteria => criteria, :value => value}
    end
  end
    
  def predict_kind(str)
    predicts = ['!=','>=','<=','=','>','<','~']
    predicts.each{|p|
      values = str.split(p)
    return { :ope => p, :key => values[0], :value => values[1] } if values.size > 1
    }
  end
end
end