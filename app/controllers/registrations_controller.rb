class RegistrationsController < ApplicationController

  def select  ##登録方法の選択ページ
    redirect_to root_path, alert: "ログインしています。" if user_signed_in?
    @auth_text = "で登録する"
    session.delete(:"devise.sns_auth") if session["devise.sns_auth"]
  end
  
end

