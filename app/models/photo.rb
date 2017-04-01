class Photo < ApplicationRecord

  belongs_to :topic, :optional => true
  belongs_to :comment, :optional => true
  belongs_to :user, :optional => true

  mount_uploader :image, PhotoImageUploader

end
