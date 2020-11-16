class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :correct_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    @feeds = Feed.where(user_id: @user.id)
    if @user != current_user
      flash[:notice] = "権限がないです"
      redirect_to feeds_path
    end
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      flash[:notice] = "権限がないです"
      redirect_to feeds_path
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    # redirect_to(show_users_url) unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                               :password_confirmation, :image, :image_cache)
  end
end
