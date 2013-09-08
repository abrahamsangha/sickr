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

  def self.authenticate(email, password)
  	@user.find_by_email(email)
  	if @user && @user.password == password
  		@user
  	else
  		redirect to '/'
  	end
  end
end
