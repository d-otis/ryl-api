class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :address
      t.uuid :landlord_id
      t.float :rating

      t.timestamps
    end
  end
end
