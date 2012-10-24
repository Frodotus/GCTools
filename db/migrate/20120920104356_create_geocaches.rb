class CreateGeocaches < ActiveRecord::Migration
  def change
    create_table :geocaches do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
