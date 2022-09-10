class PostImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @post_image = PostImage.find(params[:id])
    # @post_comment = PostComment.new
  end

  def index
    @post_images = PostImage.all
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_image_path(@post_image), notice: "You have created post successfully."
    else
      @post_images = PostImage.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image), notice: "You have updated post successfully."
    else
      render "edit"
    end
  end

  def destroy
    @post_image.destroy
    redirect_to post_images_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :body, :image)
  end

  def ensure_correct_user
    @post_image = PostImage.find(params[:id])
    unless @post_image.user == current_user
      redirect_to post_images_path
    end
  end
end
