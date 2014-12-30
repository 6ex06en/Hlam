class OptionsController < ApplicationController

def update
    if current_user.build_option(options_params).save!
	redirect_to edit_user_path(current_user)
	else
	render text: "#{options_params} + params: #{params} "
 	end
end

private

def optFromParams
	opt = { :option => {"email_notice" => 0} } 
	params.each_pair do |key, value| # if keys will be more
	opt[:option][:email_notice] = value if key == "email_notice"
	end
	opt = ActionController::Parameters.new(opt)
end


def options_params
	optFromParams.require(:option).permit(:email_notice)
end

end
