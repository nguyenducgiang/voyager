class Team < ApplicationRecord
  belongs_to :owner, class_name: User.name
  has_many :roles, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, :description, presence: true

  after_create :create_default_role
  after_destroy :update_user_current_team

  scope :by_user, ->(user) do
    joins(:memberships)
      .where(memberships: { user_id: user.id })
      .or(Team.where(owner_id: user.id))
      .distinct
  end

  private

  def create_default_role
    roles.create(name: 'Member', description: 'Regular member of the team')
  end

  def update_user_current_team
    User.where(current_team_id: id).update_all(current_team_id: nil)
  end
end
