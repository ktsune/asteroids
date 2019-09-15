class ApiBaseController < ActionController::API
  before_action :authenticate!

  def authenticate!
    render json: { message: "Invalid credentials." }, status: :unauthorized unless current_user
  end

  def api_key
    @api_key ||= ApiKey.find_by(value: params[:api_key])
  end

  def current_user
    @current_user ||= api_key.user if api_key
  end
end
