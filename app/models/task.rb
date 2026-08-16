class Task < ApplicationRecord
  attribute :completed, :boolean, default: false

  validates :title, presence: true

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
end
