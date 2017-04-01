class Comment < ApplicationRecord

  validates_presence_of :content

  belongs_to :user
  belongs_to :topic, :counter_cache => true

  has_one :photo, dependent: :destroy
  accepts_nested_attributes_for :photo

end
