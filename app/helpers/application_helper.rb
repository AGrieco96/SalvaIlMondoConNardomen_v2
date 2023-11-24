module ApplicationHelper
	
	# returns full title
	def full_title(title = '')
		base_title = 'Nardomen 2.0'
		if title.empty?
			base_title
		else
			title+" | "+base_title
		end
	end

end
