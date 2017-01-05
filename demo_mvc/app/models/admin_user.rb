class AdminUser < ApplicationRecord

	FORBIDDEN_USERNAMES = ['user', 'admin', 'basic']

	#self.table_name = "admin_users"

	has_secure_password

	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, :through => :section_edits

	scope :sorted, lambda { order(last_name: :asc).order(first_name: :asc) }

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	validates_presence_of :first_name
	validates_length_of :first_name, :maximum => 25

	validates_presence_of :last_name
	validates_length_of :last_name, :maximum => 50

	validates :username,
		:presence => true,
		:length => { :within => 8..25 },
		:uniqueness => true

	validates_presence_of :email
	validates_length_of :email, :maximum => 100
	validates_format_of :email, :with => EMAIL_REGEX
	validates_uniqueness_of :email
	validates_confirmation_of :email

	validate :username_is_allowed
	validate :no_new_users_on_mondays, :on => :create

	def full_name
		first_name + " " + last_name
	end

	private

	def username_is_allowed
		if FORBIDDEN_USERNAMES.include?(username)
			errors.add(:username, "has been restricted from use.")
		end
	end

	def no_new_users_on_mondays
		if Time.now.wday == 1
			errors.add(:base, "No new users on Mondays.")
		end
	end
end
