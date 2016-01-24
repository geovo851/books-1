class Role < ActiveRecord::Base
  has_many :users

  validates :title, presence: true
end
