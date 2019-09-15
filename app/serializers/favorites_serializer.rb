class FavoritesSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :user_id, :neo_reference_id
end
