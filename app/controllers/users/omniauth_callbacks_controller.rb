# frozen_string_literal: true
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback_for(:facebook)
  end

  def google
    callback_for(:google)
  end

  def callback_for(provider)
    ## find_oauthメソッドで既に登録されているかなどを調べる。返り値としてハッシュ形式でuserとsns_credentialをもらう。

    session["devise.sns_auth"] = User.find_oauth(request.env["omniauth.auth"])
    # googleやfacebookからの情報がコントローラのrequest.env["omniauth.auth"]に入ってくる
    # user.rbのfind_oauthメソッドにrequest.env["omniauth.auth"]を渡す


    # userとsns_credentialが登録済み、userのみ未登録、両方未登録、の3パターンに応じてfind_oauthメソッドがuserとsns_credentialのハッシュを返す

    if session["devise.sns_auth"][:user].persisted?   #登録済みだったらログイン。コントローラは受け取ったハッシュをsessionに入れる
      # sessionに入れることで新規登録画面にredirectしてもuserとsns_credentialの情報が保持できる
      sign_in_and_redirect session["devise.sns_auth"][:user], event: :authentication

    else #まだ登録されていないなら新規登録画面へ飛ばす。

      redirect_to new_user_registration_path　　
      #受け取ったハッシュ内のuserが登録済みだったらログインさせ、未登録だったら新規登録画面にredirectさせる
    end

  end

  def failure
    redirect_to root_path and return
  end
end




# class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

#   def google_oauth2
#     # You need to implement the method below in your model (e.g. app/models/user.rb)
#     @user = User.from_omniauth(request.env['omniauth.auth'])

#     if @user.persisted?
#       flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
#       sign_in_and_redirect @user, event: :authentication
#     else
#       # session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
#       render devise/registrations/new   #, alert: @user.errors.full_messages.join("\n")
#     end
    
#   end

# end


