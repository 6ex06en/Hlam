module MessagesHelper
	def short_content(content)
		return content if content.length < 65
		short = content[0, 65]+"..."
	end
end
