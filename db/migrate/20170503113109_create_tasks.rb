class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.date :due_date
      t.boolean :completed, default: false

      t.timestamps null: false
    end
  end
end
