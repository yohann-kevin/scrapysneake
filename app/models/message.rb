class Message < ApplicationRecord
  validates :mail, presence: true
  validates :object, presence: true
  validates :content, presence: true
  # temporally disable
  # validates :is_open, presence: true
end
