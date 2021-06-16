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

  context '重複していたメールアドレスの場合' do
    let!(:user1) { create(:user, email: 'example@example.com') }
    let!(:user2) { build(:user, email: 'example@example.com') }

    before do
      user2.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user2.errors.messages[:email][0]).to eq('はすでに存在します')
    end
  end

  context '重複していたユーザーネームの場合' do
    let!(:user1) { create(:user)}
    let!(:user2) { build(:user)}

    before do
      user2.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user2.errors.messages[:username][0]).to eq('はすでに存在します')
    end
  end

  context 'パスワードの長さが6文字以下の場合' do
    let!(:user) { build(:user, password: Faker::Lorem.characters(number: 5))}

    before do
      user.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user.errors.messages[:password][0]).to eq('は6文字以上で入力してください')
    end
  end

  context 'パスワードの長さが20文字以上の場合' do
    let!(:user) { build(:user, password: Faker::Lorem.characters(number: 21))}

    before do
      user.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user.errors.messages[:password][0]).to eq('は20文字以内で入力してください')
    end
  end

  context 'ユーザーネームの長さが30文字以上の場合' do
    let!(:user) { build(:user, username: Faker::Lorem.characters(number: 31))}

    before do
      user.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user.errors.messages[:username][0]).to eq('は30文字以内で入力してください')
    end
  end

  context 'メールアドレスが大文字で入力された場合' do
    let!(:user) { create(:user, email: 'EXAMPLE@EXAMPLE.COM')}

    it 'メールアドレスは小文字化される' do
      expect(user.email).to eq('example@example.com')
    end
  end

  context 'メールアドレスの先頭が不正な文字の場合' do
    let!(:user) { build(:user, email: '$example@example.com')}

    before do
      user.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user.errors.messages[:email][0]).to eq('は不正な値です')
    end
  end

  context 'メールアドレスの@がない場合' do
    let!(:user) { build(:user, email: 'example.example.com')}

    before do
      user.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user.errors.messages[:email][0]).to eq('は不正な値です')
    end
  end

  context 'メールアドレスの@の後に.がない場合' do
    let!(:user) { build(:user, email: 'example@example,com')}

    before do
      user.save
    end

    it 'ユーザーの登録に失敗する' do
      expect(user.errors.messages[:email][0]).to eq('は不正な値です')
    end
  end
end
