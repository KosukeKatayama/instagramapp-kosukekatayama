require 'rails_helper'

RSpec.describe User, type: :model do

  context 'メールアドレス、パスワード、ユーザーネームがある場合' do
    let!(:user) { create(:user) }

    it 'ユーザーが正常に登録される' do
      expect(user).to be_valid
    end
  end

  context 'メールアドレスが未入力の場合' do
    let!(:user) { build(:user, email: nil) }

    before do
      user.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user.errors.messages[:email][0]).to eq('を入力してください')
    end
  end

  context 'パスワードが未入力の場合' do
    let!(:user) { build(:user, password: nil) }

    before do
      user.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user.errors.messages[:password][0]).to eq('を入力してください')
    end
  end

  context 'ユーザーネームが未入力の場合' do
    let!(:user) { build(:user, username: nil) }

    before do
      user.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user.errors.messages[:username][0]).to eq('を入力してください')
    end
  end
end
