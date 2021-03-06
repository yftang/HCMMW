class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :description
      t.string :input
      t.string :output
      t.integer :user_id

      t.timestamps
    end
    add_index :experiments, :user_id
  end
end
