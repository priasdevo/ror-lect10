class Item < ApplicationRecord
	belongs_to :user

	has_one_attached :picture do |attachable|
		attachable.variant :thumb, resize_to_limit: [50, 50]
	end
end
