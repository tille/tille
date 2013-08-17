class AddItemIdToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :item_id, :integer
  end
end
