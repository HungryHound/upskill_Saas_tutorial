class MatyakaDataRecord < ActiveRecord::Base
  validates :account_name, presence: true
  validates :site_url_address, presence: true
  validates :advertising_group, presence: true
  validates :remaining_funds, presence: true
end