class FavoritesController < ApplicationController
  before_action :set_user, only: [:index]
  def create
    favorite = current_user.favorites.create(feed_id: params[:feed_id])
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの投稿をお気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの投稿をお気に入り解除しました"
  end
  def index
    @favorites = Favorite.where(user_id: @user.id)
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

end
