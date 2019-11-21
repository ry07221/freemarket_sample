class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  validates :nickname, :birthday, :earnings, :points, presence: true
  validates :first_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :last_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
         
end
