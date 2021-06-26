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
end
