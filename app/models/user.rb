class User < ApplicationRecord
  has_many :items
  has_many :dealings
  has_one :sns_credential, , dependent: :destroy
  has_one :profile
  has_one :credit
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  validates :nickname, :birthday, :earnings, :points, presence: true
  validates :first_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :last_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook google]

        def self.find_oauth(auth)
          ## ↓既にsns_credentialのレコードがあるかを検索する。
          ## first_or_initialize→既にDBに存在するならDBから読み込む。無いなら新しく作る（newする）
          sns_credential = SnsCredential.where(uid: auth.uid, provider: auth.provider).first_or_initialize
          ## ↓①既にsns_credentialが登録済みのパターン
          ## ↓がomniauthコントローラのsession["devise.sns_auth"]に入る
          return {user: sns_credential.user, sns: sns_credential} if sns_credential.persisted?
          ## ↓まだsns_credentialが未登録の場合。
          ## 既にuserがemailで登録されているか調べる（例：googleでログインしようとしたが既にメールアドレスで新規登録済み）
          user = User.where(email: auth.info.email).first_or_initialize
          if user.persisted? ## ②sns_credentialは無いがuserは登録済みのパターン
            ## sns_credentialとuserを紐付ける。
            sns_credential.user_id = user.id
            sns_credential.save
          else ## ③sns_credentialとuserの両方が未登録のパターン
            user.nickname = auth.info.name
          end
          ## ↓がomniauthコントローラのsession["devise.sns_auth"]に入る
          return {user: user, sns: sns_credential}
        end


#   def self.from_omniauth(access_token)
#     data = access_token.info
#     user = User.where(email: data['email']).first
#   # sns_credential = SnsCredential.where(uid: auth.uid, provider: auth.provider).first_or_initialize

#       # Uncomment the section below if you want users to be created if they don't exist
#       unless user
#           pass = Devise.friendly_token[0,20],  # ランダムでパスワード生成する
#                                                # ２回実行すると違う値になってしまう
#           user = User.new(name: data['name'],
#             email: data['email'],
#             password: pass
#           )
#       end
#     user
#   end
# end
