class RenameGroupToTopic < ActiveRecord::Migration[5.0]
  def change
    rename_table 'groups', 'topics'
  end
end
