class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.datetime :begin_time
      t.datetime :end_time
      t.string :time
      t.integer :spent_time

      t.timestamps
    end
  end
end
