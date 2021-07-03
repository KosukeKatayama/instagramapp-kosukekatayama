require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET /articles' do
    let!(:user) { create(:user) }
    let!(:article) { create_list(:article, 10, user: user) }

    before do
      sign_in user
    end
    it 'フォローしているユーザーの投稿が表示される' do
      get articles_path
      expect(response).to have_http_status(200)
    end

    it '投稿作成ページが表示される' do
      get new_article_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /articles' do
    let!(:user) { create(:user) }
    let!(:article) { create_list(:article, 10, user: user) }

    context 'ログインしていた場合' do
      before do
        sign_in user
      end
      it '新規投稿ができる' do
        article_params = attributes_for(:article)
        post articles_path({ article: article_params })
        expect(response).to have_http_status(302)
        expect(Article.last.content).to eq(article_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        article_params = attributes_for(:article)
        post articles_path({ article: article_params })
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
