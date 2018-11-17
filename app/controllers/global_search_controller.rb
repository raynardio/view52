class GlobalSearchController < ApplicationController
  before_action :authenticate_user!

  def search
    render json: global_search.global_search(
        params[:term],
        current_user.id
    ).map { |item| as_js item }
  end

  private

  def as_js(item)
    js = { type: item['_type'], params: {} }
    item['_source'].each do |k,v|
      key = k.gsub /^(.+\.)/, ''
      js[:params][key] = v
    end
  end

  def global_search
    @global_search ||= GlobalSearch.new
  end
end
