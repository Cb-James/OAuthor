class CreateGatekeepers < ActiveRecord::Migration
  def change
    create_table :gatekeepers do |t|

      t.timestamps null: false
    end
  end
end
