class Bookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
