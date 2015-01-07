class Article < ActiveRecord::Base
	has_many :comments
	belongs_to :section
	belongs_to :author
end
