class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  belongs_to :role, optional: true
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, presence: true
  before_save :assign_role


  def assign_role 
    self.role = Role.find_by name: 'Author' if role.nil?
  end

  def admin?
    role.name == 'Admin'
  end

  def author?
    role.name == 'Author'
  end

  def leader_writer?
    role.name == 'Leader-writer'
  end
end
