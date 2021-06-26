require 'rails_helper'

RSpec.describe 'Api::Likes', type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  before do
    sign_in user
  end

  describe 'GET /api/likes' do
    let!(:like) { create(:like, article: article, user: user) }

    it '200 Statos' do
      get api_like_path(article_id: article.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/likes' do
    let!(:like) { create(:like, article: article, user: user) }

    it 'JSON形式で送信される' do
      post api_like_path(article_id: article.id, format: :json)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end

    it '正常にいいねできる' do
      post api_like_path(article_id: article.id, format: :json)
      expect(response).to have_http_status(200)
      # expect(Like.count).to eq 1
    end
  end

  describe 'DELETE /api/likes' do
    let!(:like) { create(:like, article: article, user: user) }

    it '200 Statos' do
      delete api_like_path(article_id: article.id)
      expect(response).to have_http_status(200)
      expect(Like.count).to eq 0
    end
  end
end
