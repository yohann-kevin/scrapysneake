class Site < ApplicationRecord
  # include Extensions::UUID

  validates :name, presence: true
end
