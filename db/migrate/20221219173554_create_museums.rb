class CreateMuseums < ActiveRecord::Migration[7.0]
  def change
    create_table :museums do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :postcode

      t.timestamps
    end
  end
end
