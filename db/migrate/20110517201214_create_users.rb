class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.boolean :admin
      t.boolean :author
      t.boolean :active

      t.timestamps
    end
  end
end
