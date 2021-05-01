class Api::CommentsController < Api::ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @article = Article.find(params[:article_id])
    comments = @article.comments
    render json: comments
  end

  def new
    @article = Article.find(params[:article_id])
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!

    render json: @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
