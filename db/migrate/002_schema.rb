class Schema < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.string :title
      t.string :address
      t.string :email
      t.string :phone_number

      t.timestamps
    end

    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.integer :quotation_id

      t.timestamps
    end
  end
end
