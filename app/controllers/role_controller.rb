class RoleController < ApplicationController
  def index
    render html: 'Goals index placeholder'
  end

  def show
    render html: 'Show goal placeholder'
  end
  
  def sort
    params[:role_categories].reverse.each_with_index do |label,i|
      role_category = current_user.role_categories.find_or_create_by!(
        role_category_id: label
      )
      role_category.update_attribute :importance, i + 1
    end

    render json: { error: false }
  end
end
