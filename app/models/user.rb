class User < ApplicationRecord
  has_many :items
  has_many :dealings
  has_one :sns_credential
  has_one :profile
  has_one :credit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

      # Uncomment the section below if you want users to be created if they don't exist
      unless user
          pass = Devise.friendly_token[0,20],  # ランダムでパスワード生成する
                                               # ２回実行すると違う値になってしまう
          user = User.new(name: data['name'],
            email: data['email'],
            password: pass
          )
      end
    user
  end

end
