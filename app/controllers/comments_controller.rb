class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :find_post!

  # GET /comments
  def index
    @comments = @post.comments.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    # @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.permit( :body)
    end

    def find_post!
      @post = Post.find_by_id!(params[:post_id])
    end
end
