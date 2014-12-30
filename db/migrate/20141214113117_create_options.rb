class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.boolean :email_notice
      t.references :user, index: true

      t.timestamps
    end
  end
end
