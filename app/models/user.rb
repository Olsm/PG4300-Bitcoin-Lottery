class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  cattr_accessor :current_user

  after_create :send_confirmation_email
  def send_confirmation_email
    UserMailer.registration_confirmation(self).deliver_now
  end

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      omniauth_user = self.where(email: auth.info.email).first
      omniauth_user.provider = auth.provider
      omniauth_user.uid = auth.uid
    elsif self.where(uid: auth.uid).exists?
           omniauth_user = self.where(uid: auth.uid).first
           omniauth_user.provider = auth.provider
           omniauth_user.uid = auth.uid

    else
      omniauth_user = self.create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token.first(10)
      end
    end
    return omniauth_user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end
end