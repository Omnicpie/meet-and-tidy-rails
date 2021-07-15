class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  # Validations
  validates :name, presence: true
  validates :email, presence: true

  # Associations
  has_many :attendances
  has_many :events, through: :attendances
end
