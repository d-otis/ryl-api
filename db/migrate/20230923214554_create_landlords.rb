class CreateLandlords < ActiveRecord::Migration[7.1]
  def change
    create_table :landlords, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :company

      t.timestamps
    end
  end
end
