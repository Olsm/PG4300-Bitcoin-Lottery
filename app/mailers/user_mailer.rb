class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #
  def registration_confirmation user
    if user.provider == 'facebook' || user.provider == 'twitter' || user.provider == 'google_oauth2'
      @greeting = "Hi you registered with omniauth, therefore we generated a password for you if you wish to login manually #{user.password}"
    else
      @greeting = "Hi"
    end
    @email = user.email
    @password = user.password
    mail to: @email
  end
end
