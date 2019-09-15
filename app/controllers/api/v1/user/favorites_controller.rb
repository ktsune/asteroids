class Api::V1::User::FavoritesController < ApiBaseController
  def show
    render json: FavoritesSerializer.new(current_user.favorites)
  end
end
