class CreateRobots < ActiveRecord::Migration[6.0]
  def change
    create_table :robots do |t|
      t.integer :x_position
      t.integer :y_position
      t.integer :max_x
      t.integer :max_y
      t.string :facing

      t.timestamps
    end
  end
end
