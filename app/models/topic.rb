class Topic < ApplicationRecord
  validates_presence_of :name

  belongs_to :user
  has_many :comments
  has_many :topic_categoryships
  has_many :categories, :through => :topic_categoryships

  has_one :photo, dependent: :destroy
  accepts_nested_attributes_for :photo


  def comment_user
    comment_user = []
    self.comments.each do |f|
    #self是指show的@topic，哪個topic呼叫，self就是指呼叫的那個topic，所以這裡不能打@topic，
    #因為我們在show裡，已經要用@topic.comment_user來呼叫這個方法，@topic就是指self
      comment_user << f.user.first_email
    end

    return comment_user.uniq
  end

end
