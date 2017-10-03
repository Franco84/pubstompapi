class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_secure_password

  has_one :profile
  has_many :user_games  
  has_many :games, through: :user_games  

end