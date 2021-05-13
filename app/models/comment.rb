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
    content.include?("@#{username}")
    # binding.pry
  end

  after_create :send_email, if: :has_username?

  private

  def send_email
    CommentMailer.mention(user).deliver_now
  end
end
