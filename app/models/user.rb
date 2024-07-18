class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, format: {with: /\A[a-z0-9]+\z/}

  belongs_to :current_team, class_name: Team.name, optional: true
  has_many :owned_teams, class_name: Team.name, foreign_key: :owner_id, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships

  def all_teams
    @all_teams ||= Team.by_user(self)
  end

  def all_team_ids
    @all_team_ids ||= all_teams.pluck(:id)
  end

  def own?(team)
    team&.owner_id == id
  end

  def member_of?(team)
    team_ids.include?(team&.id)
  end
end
