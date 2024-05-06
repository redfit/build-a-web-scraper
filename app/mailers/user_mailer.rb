class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.success.subject
  #
  def success
    @page = params[:result].page

    mail to: "nagita.0724.0812@gmail.com"
  end
end
