class Role < ApplicationRecord
  belongs_to :team

  validates :name, :description, presence: true
end
