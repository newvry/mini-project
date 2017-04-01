class AddViewsCounterToTopics < ActiveRecord::Migration[5.0]
  def change

    add_column :topics, :views_count, :integer, :default => 0

  end
end
