class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, format: {with: /\A[a-z0-9]+\z/}
end
