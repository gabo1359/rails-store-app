# frozen_string_literal: false

class User < ApplicationRecord
  include Discard::Model

  has_many :orders
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :user_reviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  def self.from_omniauth(auth)
    name_split = auth.info.name
    # This line checks if the user email received by the Omniauth is already included in our databases.
    user = User.where(email: auth.info.email).first
    # This line sets the user unless there is a user found in the line above, therefore we use ||= notation to evaluate if the user is nill, then set it to the User.create
    user ||= User.create!(provider: auth.provider, uid: auth.uid, first_name: name_split,
                          email: auth.info.email, password: Devise.friendly_token[0, 20])
    user
  end

  protected
  
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
