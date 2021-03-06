require 'uuid'
require 'digest/sha1'


class User < ActiveRecord::Base
	has_many :todos
	before_save :create_hashed_password

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

	validates :email, :presence => true, :length => { :within => 5..100 }, 
		:format=>EMAIL_REGEX, :confirmation => true, :uniqueness=>true
	validates :password, :presence => true

	def self.authenticate(email='', password = '')
		user = User.find_by_email( email)
		if user && user.password == get_hashed_password(password)
			return user
		else
			return false
		end
	end

	def self.get_hashed_password(password="")
		if password != nil
			Digest::SHA1.hexdigest(password)
		else 
			puts 'fail'
	  end
	end
  
	def private_token
		Digest::SHA1.hexdigest salt
	end

	def self.find_by_token(t)
		User.all.find{ |u| u.private_token == t }
	end

	def self.make_salt
		UUID.state_file = false
		UUID.generator.next_sequence
		UUID.new.generate
	end

	def create_hashed_password
		unless password.blank?
			self.salt ||= User.make_salt
			self.password = User.get_hashed_password(password)
		end
		
	end

end
