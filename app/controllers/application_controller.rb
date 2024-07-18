class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  helper_method :current_team

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username])
  end

  def current_team
    return unless user_signed_in?
    return @current_team if @current_team

    if current_user.current_team_id.in?(current_user.all_team_ids)
      @current_team = current_user.current_team
    else
      @current_team = current_user.owned_teams.first
    end

    current_user.update(current_team_id: @current_team.id) if @current_team
    @current_team
  end
end
