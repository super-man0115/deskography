class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit destroy]
  before_action :require_login, only: %i[new edit]
  before_action :check_post, only: %i[edit]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
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
      redirect_to post_path(@post)
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

  def upload_image
    @image_blob = create_blob(params[:image])
    render json: @image_blob
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :business_attribute, :age_group, item_ids: []).merge(images: uploaded_images)
  end

  # アップロード済み画像の検索
  def uploaded_images
    params[:post][:images].drop(1).map { |id| ActiveStorage::Blob.find(id) } if params[:post][:images]
  end

  # blobデータの作成
  def create_blob(file)
    ActiveStorage::Blob.create_and_upload!(
      io: file.open,
      filename: file.original_filename,
      content_type: file.content_type
    )
  end

  
end
