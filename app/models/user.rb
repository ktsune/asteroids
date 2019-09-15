class User < ApplicationRecord
  has_many :favorites
  has_many :api_keys
end
