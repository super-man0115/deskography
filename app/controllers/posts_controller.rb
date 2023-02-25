class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit destroy]
  before_action :require_login, only: %i[new edit]
  before_action :check_post, only: %i[edit]

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
      redirect_to posts_path, notice: '投稿完了！！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @post = current_user.posts.find(params[:id])
    @post.assign_attributes(post_params)
    if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
      redirect_to post_path(@post), notice: 'アップデート完了！！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除したぜ'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :business_attribute, :age_group, :main_image, sub_images: [])
  end
end
