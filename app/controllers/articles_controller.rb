class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    user_ids = current_user.followings.pluck(:id)
    @articles = Article.where(user_id: user_ids).order(created_at: :desc)
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path(@article), notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render.new
    end
  end

  private

  def article_params
    params.require(:article).permit(:content, images: [])
  end
end
