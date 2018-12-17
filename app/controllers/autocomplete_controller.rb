class AutocompleteController < ApplicationController
  before_action :authenticate_user!

  def views
    q = params[:q]
    return render json: [] unless q.present?

    res = RoleCategory.where('label LIKE ?', "#{q}%").all.map { |role_category|
      { label: role_category.label }
    }
    puts "Results: #{res}"
    render json: res
  end

  def tags
    q = params[:q]
    return render json: [] unless q.present?

    res = current_user.tags.where('label LIKE ?', "#{q}%").all.map { |tag|
      { label: tag.label }
    }
    puts "Results: #{res}"
    render json: res
  end
end
