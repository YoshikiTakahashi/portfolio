class Client < ApplicationRecord
  validates :company, presence: true
  validates :name, presence: true
  default_scope -> { order(created_at: :desc) }
end
