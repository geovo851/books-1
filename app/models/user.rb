class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_create :set_role, unless: :role
  validates :name, presence: true

  has_many :books
  belongs_to :role

  def role_symbols
    [role.title.to_sym]
  end

  def set_role
    role_author = Role.find_by(title: 'author')
    unless role_author
      role_author = Role.create(title: 'author')
    end
    self.role = role_author
  end
end
