class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :nickname, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
