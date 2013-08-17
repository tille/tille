class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :estimated_time

      t.timestamps
    end
  end
end
