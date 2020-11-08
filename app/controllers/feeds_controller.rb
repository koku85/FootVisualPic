class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:index]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end
  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = current_user.feeds.build(feed_params)
    if params[:back]
      render :new
    else
      if @feed.save
        redirect_to feeds_path, notice: "投稿を作成しました！"
      else
        render :new
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
  end

  def authenticate_user
     @current_user = User.find_by(id: session[:user_id])
     if @current_user == nil
       flash[:notice] = "ログインが必要です。"
       redirect_to new_session_path
     end
   end

  def feed_params
    params.require(:feed).permit(:title, :content, :image, :image_cache)
  end
end
