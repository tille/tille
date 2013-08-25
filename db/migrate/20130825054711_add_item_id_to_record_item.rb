class AddItemIdToRecordItem < ActiveRecord::Migration
  def change
    add_column :recording_items, :item_id, :integer
  end
end
