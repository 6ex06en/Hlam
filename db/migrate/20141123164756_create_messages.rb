class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :user_id
      t.integer :reciever_id
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
