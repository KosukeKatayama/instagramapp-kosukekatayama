class CommentMailer < ApplicationMailer
  def new_mention(mention_user_ids)
    users = User.where(id: mention_user_ids)
    mail to: users.pluck(:email), subject: '【お知らせ】メンションされました'
    binding.pry
  end
end
