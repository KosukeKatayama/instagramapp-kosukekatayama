# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  # def has_username?
  #   username = User.pluck(:username)
  #   # 全てのユーザーの中からusernameカラムの値のみを配列で取得
  #   mention = username.join("")
  #   # 配列を文字列に変換
  #   content.include?("@#{mention}")
  #   # コメント内にusernameが含まれているかどうかを検索
  #   binding.pry
  # end

  # def has_username?
  #   username = User.pluck(:username)
  #   # 全てのユーザーの中からusernameカラムの値のみを配列で取得
  #   if username.any? { |username| content.include?("@#{username}") }
  #   # コメント内に"@"+"username"が含まれているかどうかを検索
  #     puts mention_user
  #     binding.pry
  #   end
  # end

  def has_username?
    username = User.pluck(:username)
    # 全てのユーザーの中からusernameカラムの値のみを配列で取得
    username.any? { |username| content.include?("@#{username}") }
    # コメント内に"@"+"username"が含まれているかどうかを検索
  end

  after_create :send_email, if: :has_username?
  # binding.pry

  # def get_mention_user(content)
  #   content.match(/@/)
  #   content_username = $'
  #   mention_user = User.where(username: "#{content_username}")
  # end

  # def get_mention_user
  #   mention = content.scan(/@\w+/)
  #   # content内から"@"+"username"を配列で抜き出す
  #   mention_username = mention.join(",").scan(/\w+/)
  #   # mentionを配列から文字列に変換し、@以外を抜き出す
  #   mention_user = User.where(username: mention_username)
  #   # ユーザーの中からusrenameキーを指定し、mentionus_rnameに該当するユーザーを探す
  #   mention_user.map(&:id)
  #   # そのままユーザーを渡せないのでmapを使ってidに変換
  # end

  private

  def send_email
    mention = content.scan(/@\w+/)
    # content内から"@"+"username"を配列で抜き出す
    mention_username = mention.join(',').scan(/\w+/)
    # mentionを配列から文字列に変換し、@以外を抜き出す
    mention_user = User.where(username: mention_username)
    # ユーザーの中からusrenameキーを指定し、mentionus_rnameに該当するユーザーを探す
    mention_user_ids = mention_user.map(&:id)
    # そのままユーザーを渡せないのでmapを使ってidに変換
    CommentMailer.new_mention(mention_user_ids).deliver_later
    # binding.pry
  end
end
