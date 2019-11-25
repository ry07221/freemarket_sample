class CardsController < ApplicationController

  before_action :authenticate_user!, except: [:create]

  def new
    @card = Card.new
  end

  def create #データベースにカードのcustomerのtokenを保存する
    email = current_user.email

    # params[:card_token]に「tok_hogehoge」という形でカードのトークンが送られてきている
    customer = Card.regist_customer(params[:card_token], email) ## customerを作成
    ## 保存に成功した場合
    @card.user_id = current_user.id
    @card.save
    redirect_to cards_path and return

    ## 保存に失敗した場合
    @card = Card.new(customer_token: customer&.id)
    redirect_to action: "new", alert: "カードの登録に失敗しました。" and return if @card.invalid? 
    
  end

  def show
    @card = Card.get_card(current_user.card&.customer_token)
  end

  def destroy
    @card = current_user.card
    @card.destroy
    redirect_to cards_path
  end
  
end
