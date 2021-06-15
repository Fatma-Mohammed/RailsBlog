class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post, only: [:show, :update, :destroy]
  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    # abort current_user.inspect
    # post_params[:user_id] = current_user.id
    # abort post_params.inspect

    @post = current_user.posts.new(post_params)
    

    if @post.save
      params[:tag_ids].each do |tag|
        if tag = Tag.find(tag)
        # abort tag.inspect
        @post.tags << tag
        else
          render json: { message: 'Tag not found'}
        end
      end
      expiry_date = @post.created_at + 24.hours
      HardWorker.perform_at(expiry_date,  @post.id)
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      if params.has_key?(:tag_ids)
        post_tags = []
        params[:tag_ids].each do |tag|
          if tag = Tag.find(tag)
          post_tags  << tag
          # abort tag.inspect
          @post.tags = post_tags
          else
            render json: { message: 'Tag not found'}
          end
        end
      end
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.permit(:title, :body, tag_ids: [])
    end


end
