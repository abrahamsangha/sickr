class User < ActiveRecord::Base
  validates :name, :password_hash, :email, presence: true
  validates :name, :email, uniqueness: true
  validates :email, format: { with: /.+@.+\../}

  include BCrypt

  def password
  	@password ||= Password.new(password_hash)
  end

  def password=(new_password)
  	@password = Password.create(new_password)
  	self.password_hash = @password
  end

  def self.authenticate(credentials)
    p credentials["email"]
  	user = User.find_by_email(credentials["email"])
  	if user && user.password == credentials["password"]
  		user
  	else
  		redirect to '/'
  	end
  end
end
