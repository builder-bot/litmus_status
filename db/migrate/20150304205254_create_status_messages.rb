class CreateStatusMessages < ActiveRecord::Migration
  def change
    create_table :status_messages do |t|
      t.text :body, null: false
      t.integer :server_id, null: false
      t.timestamps
    end
    add_index :status_messages, :server_id
  end
end
