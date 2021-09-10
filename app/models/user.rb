class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :stocks, dependent: :destroy


  before_save :default
  after_create :send_admin_mail
  after_update :update_approve

  def send_admin_mail
    if self.approved == 'true' 
      UserMailer.welcome_email(self).deliver_now
    else
      UserMailer.pending_email(self).deliver_now
    end
  end

  def update_approve
    if self.approved == 'true'
      UserMailer.welcome_email(self).deliver_now
    end
  end


  def default
   self.approved = 'true' unless self.role == 'Broker'
  end


  def active_for_authentication? 
    super && approved? 
  end 
    
  def inactive_message 
    approved? ? super : :not_approved
  end
end
