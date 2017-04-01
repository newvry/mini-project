class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|

      t.integer :topic_id
      t.integer :comment_id
      t.integer :user_id
      t.string :image


      t.timestamps
    end
  end
end
