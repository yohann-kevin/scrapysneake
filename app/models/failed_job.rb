class FailedJob < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :error, presence: true
  validates :stack_trace, presence: true
end
