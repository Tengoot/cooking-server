# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def forgot_password
    @user = User.find(params[:user_id])
    @url = URI(Settings.client_domain)
    @url.path = Settings.reset_password_path
    mail(to: @user.email, subject: 'Reset hasla')
  end
end
