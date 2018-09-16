module Admin::AccessoriesHelper
	def boolean_to_text(accessory_boolean)
		if accessory_boolean
			'Retired'
		else
			'Active'
		end
	end
end