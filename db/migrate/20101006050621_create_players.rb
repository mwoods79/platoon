class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :gamertag
      t.string :service_tag
      t.integer :games_total

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
