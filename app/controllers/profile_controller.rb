class ProfileController < ApplicationController
  before_action :authenticate_user!

  ALLOWED_FIELDS = %w(first_name last_name email country city
      state zip sex date_of_birth marital_status education
      weekly_hours sleep_hours commute_hours exercise_hours diet
      present_roles future_roles role_category)

  def index
    @present_roles = current_user.present_roles.map(&:label).join(' ')
    @future_roles = current_user.future_roles.map(&:label).join(' ')
  end

  def update
    # TODO: All temporary; Make this more railsy and keep DRY
    if update_params.include? :present_roles
      current_user.roles.where(tense: :present).destroy_all
      update_params[:present_roles].split.each do |label|
        role = Role.find_or_create_by! label: label
        current_user.roles.create!({ role_id: role.id, tense: :present })
      end
      update_params.delete :present_roles
    end
    if update_params.include? :future_roles
      current_user.roles.where(tense: :future).destroy_all
      update_params[:future_roles].split.each do |label|
        role = Role.find_or_create_by! label: label
        current_user.roles.create!({ role_id: role.id, tense: :future })
      end
      update_params.delete :future_roles
    end
    if update_params.include? :role_category
      update_params[:role_category].each do |label,importance|
        role = current_user.role_categories.find_or_initialize_by(role_category_id: label)
        role.importance = importance
        role.save!
      end
      update_params.delete :role_category
    end
    if update_params.include? :goal
      update_params[:goal].each do |term,goals|
        goals.each do |category,text|
          next unless text.present?
          role_category = RoleCategory.find category
          goal = current_user.goals.find_or_initialize_by term: term, role_category: role_category
          goal.text = text
          goal.save!
        end
      end
      # TODO: Handle last step properly
      update_params.delete :goal
      current_user.onboarded_at = Time.now
      current_user.save!
    end

    if update_params.include? :date_of_birth
      current_user.update_attributes! update_params.merge({
          date_of_birth: Date.strptime(update_params[:date_of_birth], '%m/%d/%Y')
      })
    end

    render json: { msg: 'okay!' }
  end

  protected

  def update_params
    @update_params ||= params.require(:user).permit(*ALLOWED_FIELDS, { role_category: {}, goal: {} })
  end
end
