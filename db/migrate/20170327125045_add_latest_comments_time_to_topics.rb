class AddLatestCommentsTimeToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :comment_last, :datetime
  end
end
