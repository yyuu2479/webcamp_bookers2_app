class Drop < ActiveRecord::Migration[5.2]
  def change
    drop_table :entries
    drop_table :messages
  end
end
