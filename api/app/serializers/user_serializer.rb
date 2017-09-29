class UserSerializer < ActiveModel::Serializer
  attributes :email

  has_one :profile
end
