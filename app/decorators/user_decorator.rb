# frozen_string_literal: true

module UserDecorator
  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'baseline_account_circle_black_48dp.png'
    end
  end
end
