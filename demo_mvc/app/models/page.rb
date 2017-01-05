class Page < ApplicationRecord

	acts_as_list :scope => :subject

	belongs_to :subject #, { :optional => true }#, {:foreign_key => 'foo_id'}
	has_many :sections
	has_and_belongs_to_many :admin_users #, :join_table => 'pages_admin_users'

	scope :sorted, lambda { order("position ASC") }
	scope :visible, lambda { where(:visible => true) }

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_presence_of :permalink
	validates_length_of :permalink, :within => 3..255
	validates_uniqueness_of :permalink
end
