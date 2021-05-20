class Administrator < ApplicationRecord
  validates :name, presence: true
  validates :encrypted_password, presence: true
end
