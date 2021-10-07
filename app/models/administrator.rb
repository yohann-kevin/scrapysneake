class Administrator < ApplicationRecord
  validates :name, presence: true
  validates :encrypted_password, presence: true

  def self.find_admin_by_name(name)
    Administrator.where(name: name)
  end
end
