class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :display_name, :first_name, :last_name, :avatar_url

  def avatar_url
    object.avatar.url
  end

  belongs_to :user
end
