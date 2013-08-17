class RemoveTimeField < ActiveRecord::Migration
  def change
    remove_column :commits, :time
  end
end
