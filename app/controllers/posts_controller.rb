class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post_form = PostForm.new
  end

  def edit
    @post_form = PostForm.build_from_post(@post)
  end

  def create
    @post_form = PostForm.new(post_params)
    @post_form.save!
    redirect_to @post_form.post, notice: 'Post was successfully created.'
  rescue PostForm::Invalid => e
    render :new
  end

  def update
    @post_form = PostForm.build_from_post(@post)
    @post_form.update!(post_params)
    redirect_to @post, notice: 'Post was successfully updated.'
  rescue PostForm::Invalid => e
    render :edit
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    def set_post
      @post = Post.find_by!(name: params[:name])
    end

    def post_params
      params.require(:post_form).permit(
        :description,
        entries_attributes: [:path, :content]
      )
    end
end
