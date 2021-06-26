require 'rails_helper'

RSpec.describe 'Apps::Profiles', type: :request do
  describe 'GET /profile' do
    let!(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'プロフィールが表示される' do
      get profile_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /profile' do
    let!(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'アバターを変更できる' do
      put profile_path
      expect(response).to have_http_status(302)
    end
  end
end
