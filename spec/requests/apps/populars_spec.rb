require 'rails_helper'

RSpec.describe 'Apps::Populars', type: :request do
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 10, user: user) }

  before do
    sign_in user
  end

  describe 'GET /popular' do
    it '200 Statos' do
      get popular_path
      expect(response).to have_http_status(200)
      binding.pry
    end

    # it '5件のみ表示される' do
    #   get popular_path
    #   expect(response.body).to eq 5
    # end

    # it '24時間以内の投稿である' do
    #   get popular_path
    #   expect(response).to have_http_status(200)
    # end
  end
end
