class Favorite < ApplicationRecord
  belongs_to :user

  def initialize(data)
    # binding.pry
  end

end
