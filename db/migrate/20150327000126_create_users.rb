class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :avatar
      t.integer :guess_count, :default => 0
      t.boolean :is_admin, :default => false
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.string :oauth_expires_at
      t.timestamps null: false
    end
  end
end
