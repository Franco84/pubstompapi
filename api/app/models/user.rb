class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_secure_password

  has_one :profile
  has_many :user_games  
  has_many :games, through: :user_games  

  has_and_belongs_to_many :teammates,
  class_name: "User",
  join_table: :teammates,
  foreign_key: :user_id,
  association_foreign_key: :teammate_id

end