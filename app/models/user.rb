class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook],
          authentication_keys: [:login]

  validates :username, presence: :true, uniqueness: { case_sensitive: false }, format: {with: /\A[\w]*\z/ }
  # validates :first_name, :last_name, :gender, presence: true
  validates :email, uniqueness: true
  # validates :phone_number, presence: true, uniqueness: true, numericality: {only_integer: true}, length: {is: 9}

  attr_writer :login

  def login
   @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.from_omniauth(auth)
   user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     user.first_name = auth.info.first_name
     user.last_name = auth.info.last_name
     user.gender = auth.extra.raw_info.gender
     user.date_of_birth = Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y')
     # user.image = auth.info.image # assuming the user model has an image
   end
   user.save(validate: false)
   user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.email = data["first_name"] if user.first_name.blank?
        user.email = data["last_name"] if user.last_name.blank?
      end
    end
  end
end
