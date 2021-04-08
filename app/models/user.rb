class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  Devise.setup do |config|
    config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
    require 'devise/orm/active_record'

    config.scoped_views = true
  end

  has_one :profile, dependent: :destroy
end
