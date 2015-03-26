class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post_form = PostForm.new
  end

  # GET /posts/1/edit
  def edit
    @post_form = PostForm.build_from_post(@post)
  end

  # POST /posts
  # POST /posts.json
  def create
    @post_form = PostForm.new(post_params)

    @post_form.save!
    redirect_to @post_form.post, notice: 'Post was successfully created.'
  rescue PostForm::Invalid => e
    render :new
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post_form = PostForm.build_from_post(@post)
    @post_form.update!(post_params)
    redirect_to @post, notice: 'Post was successfully updated.'
  rescue PostForm::Invalid => e
    render :edit
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by!(name: params[:name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post_form).permit(
        :description,
        entries_attributes: [:path, :content]
      )
    end
end
