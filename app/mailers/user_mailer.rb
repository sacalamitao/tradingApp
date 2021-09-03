class UserMailer < ApplicationMailer
    def welcome_email(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome to Trading Site')
    end

    def pending_email(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome to Trading Site')
    end


end