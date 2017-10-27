class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :display_name, :first_name, :last_name

  belongs_to :user
end
