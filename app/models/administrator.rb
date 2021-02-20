class Administrator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable,  :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
    :trackable, :validatable

  # Validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def to_s
    name
  end
end
