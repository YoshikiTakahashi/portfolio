class Client < ApplicationRecord
  validates :company,  presence: true
  validates :name,  presence: true
end
