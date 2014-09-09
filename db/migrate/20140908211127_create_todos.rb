class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.boolean :is_complete
      t.references :user
      t.timestamps
    end
  end
end
