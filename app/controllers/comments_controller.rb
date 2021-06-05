class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end
end
