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

    render json: favorites
  end

  def create
    service = NasaService.new
    create_favorite = current_user.favorites.create!(neo_reference_id: params[:neo_reference_id])
    asteroid = service.find_asteroids_using_neo_id(create_favorite.neo_reference_id)

    {
      "id": create_favorite.id,
      "neo_reference_id": create_favorite.neo_reference_id,
      "user_id": create_favorite.user_id,
      "asteroid": {
        "name": asteroid[:name],
        "is_potentially_hazardous_asteroid": asteroid[:is_potentially_hazardous_asteroid]
      }
    }

    render json: create_favorite
  end
end
