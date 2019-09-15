class Api::V1::User::FavoritesController < ApiBaseController
  def show
    service = NasaService.new
    favorites = current_user.favorites.map do |favorite|
      asteroid = service.find_asteroids_using_neo_id(favorite.neo_reference_id)

        {
          "id": favorite.id,
          "neo_reference_id": favorite.neo_reference_id,
          "user_id": favorite.user_id,
          "asteroid": {
            "name": asteroid[:name],
            "is_potentially_hazardous_asteroid": asteroid[:is_potentially_hazardous_asteroid]
          }
        }

    end

    # binding.pry
    render json: favorites
  end
end
