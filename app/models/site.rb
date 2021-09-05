class Site < ApplicationRecord
  validates :name, presence: true
end
