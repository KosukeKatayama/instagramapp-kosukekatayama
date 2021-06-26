require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  describe 'GET /accounts' do
    let!(:user) { create(:user) }

    it 'ユーザーページが表示される' do
      get account_path(id: user.id)
      expect(response).to have_http_status(200)
    end
  end
end
