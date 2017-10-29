class Profile < ActiveRecord::Base
  validates :display_name, presence: true, uniqueness: true
  
  belongs_to :user

  has_attached_file :avatar, styles: { small: "64x64", medium: "100x100", large: "200x200" }
  validates_attachment :avatar, :presence => true,
  :content_type => { :content_type => /\Aimage\/.*\z/ },
  :size => { :in => 0..100.kilobytes }

end