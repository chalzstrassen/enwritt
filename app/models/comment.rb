class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true
	belongs_to(:commenter,
				class_name: "User",
				foreign_key: :commenter_id,
				primary_key: :id,
				inverse_of: :comments 
			  	)
end