class Comment < ApplicationRecord

  validates_presence_of :content

  belongs_to :topic

end
