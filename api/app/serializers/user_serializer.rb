class UserSerializer < ActiveModel::Serializer
  attributes :email

  has_one :profile
  has_many :games, through: :user_games
end
