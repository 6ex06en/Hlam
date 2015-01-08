module MessagesHelper
	def short_content(opt = 65, content)
		return content if content.length < opt
		short = content[0, opt]+"..."
	end
end
