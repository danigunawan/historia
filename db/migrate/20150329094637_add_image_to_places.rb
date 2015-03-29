class AddImageToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :image, :text
  end
end
