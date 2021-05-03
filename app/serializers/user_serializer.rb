class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :username, :comment_avatar_image

  def comment_avatar_image
    rails_blob_path(object.avatar_image) if object.avatar_image.attached?
  end
end
