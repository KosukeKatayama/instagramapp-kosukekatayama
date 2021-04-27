class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @article = Article.find(params[:article_id])
    comments = article.commets
  end

  def new
  end

  def create
  end
end