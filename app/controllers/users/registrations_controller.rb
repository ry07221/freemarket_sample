# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  redirect_to new_user_registration_path, alert: "reCAPTCHAを承認してください" and return unless verify_recaptcha
  
  def select  ##登録方法の選択ページ
    session.delete(:"omniauth.auth") if session["omniauth.auth"]
  end 


  def new
    ## ↓sessionにsns認証のデータがある場合
    @user = User.new(session["omniauth.auth"]["user"]) if session["omniauth.auth"]
    ## ↓sessionにsns認証のデータがない場合
    super if !session["devise.sns_auth"]
  end

  def create
    super if !session["devise.sns_auth"]
    if session["devise.sns_auth"]
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
      sns = SnsCredential.new(session["devise.sns_auth"]["sns"])
      super
      if user_signed_in?
        sns.user_id = current_user.id
        sns.save
      end
    end
  end

end
