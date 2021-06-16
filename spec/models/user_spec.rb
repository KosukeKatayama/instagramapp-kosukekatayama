require 'rails_helper'

RSpec.describe User, type: :model do

  context 'メールアドレス、パスワード、ユーザーネームがある場合' do
    let!(:user) { create(:user) }

    it 'ユーザーが正常に作成される' do
      expect(user).to be_valid
    end
  end
end
