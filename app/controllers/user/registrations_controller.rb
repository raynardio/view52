# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  ALLOWED_FIELDS = %w(first_name last_name email country city
      state zip sex date_of_birth marital_status education
      weekly_hours sleep_hours commute_hours exercise_hours diet
      present_roles future_roles role_category)

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /users/sign_up
  # def new
  #   super
  # end

  # POST /users
  # def create
  #   super
  # end

  # GET /users/edit
  # def edit
  #   super
  # end

  # PUT /users
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
    current_user.update_attributes! update_params
    render json: { msg: 'okay!' }
  end

  # DELETE /users
  # def destroy
  #   super
  # end

  # GET /users/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def update_params
    @update_params ||= params.require(:user).permit(*ALLOWED_FIELDS, { role_category: {}, goal: {} })
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: ALLOWED_FIELDS)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
