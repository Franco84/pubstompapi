class GameSerializer < ActiveModel::Serializer
  attributes :name

  has_many :users, through: :user_games
end
