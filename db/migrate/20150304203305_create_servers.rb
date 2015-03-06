class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :domain, null: false
      t.string :server_type, null: false, default: :web
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
