class CreateMatyakaDataRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :matyaka_data_records do |t|
      t.string   :account_name
      t.string   :site_url_address
      t.string   :advertising_group
      t.float    :remaining_funds
      t.timestamps
    end
  end
end
