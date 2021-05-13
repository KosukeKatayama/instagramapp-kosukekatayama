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

  def has_username?
    username = User.pluck(:username)
    # 全てのユーザーの中からusernameカラムの値のみを配列で取得
    mention = username.join("")
    # 配列を文字列に変換
    content.include?("@#{mention}")
    # コメント内にusernameが含まれているかどうかを検索
  end

  # def get_username
  #   if has_username? == true

  # end

  after_create :send_email, if: :has_username?
  binding.pry

  private

  def send_email
    CommentMailer.mention(user).deliver_now
  end
end
