class CommentMailer < ApplicationMailer
  def mention(user)
    @user = user
    mail to: user.email, subject: '【お知らせ】メンションされました'
  end
end
