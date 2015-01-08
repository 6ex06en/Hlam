atom_feed do |feed|
	feed.title "All about me"
	if @followers.present?
	  @followers.each do |follower|
		feed_entry_options = {
      	published: follower.created_at, 
      	updated:   follower.updated_at
    	}
		feed.entry follower, feed_entry_options do |entry|
			entry.title "New follower"
			entry.content "You have #{@followers.count} followers, last - #{follower.name}"
			entry.author do |author|
				author.name "Kerz"
			end
		end
	  end
	end

	if @messages.present?
	  @messages.each do |message|
		feed_entry_options = {
      	published: message.created_at, 
      	updated:   message.updated_at,
      	url: user_message_path(@user, message)
    	}
    	feed.entry message, feed_entry_options do |entry|
			entry.title "New message: #{short_content(30, message.content)}"
			entry.content message.content
			entry.author do |author|
				author.name "Kerz"
			end
		end
	  end
	end

	if @replies.present? 
	  @replies.each do |reply|
		feed_entry_options = {
      	published: reply.created_at, 
      	updated:   reply.updated_at,
      	url: micropost_path(reply.including_replies)
    	}
    	feed.entry reply, feed_entry_options do |entry|
			entry.title "New reply: #{short_content(30, reply.content)}"
			entry.content reply.content
			entry.author do |author|
				author.name "Kerz"
			end
		end
	  end
	end
end




#xml.instruct! :xml, :version => '1.0'
#xml.rss :version => '2.0' do
#	xml.channel do
#		xml.title "News"
#		xml.description "All about me"
#		xml.link feed_user_url(@user)
#		for follower in @followers
#			xml.item do
#				xml.title "New follower - #{follower.name}"
#				xml.description "You have #{@followers.count} followers, last - #{follower.name}"
#				xml.pubDate @followers.last.created_at.to_s(:rfc822)
#				xml.link feed_user_url(@user)
#        		xml.guid feed_user_url(@user)
#        	end
#		end
#	end	
#end
