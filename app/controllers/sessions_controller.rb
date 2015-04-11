class SessionsController < ApplicationController

	def new
	end

  def vk
   if hash = request.env["omniauth.auth"]
    if user = User.find_by(email: hash[:info][:email])
      flash[:success] = "Welcome, #{hash[:info][:name] || hash[:info][:nickname]}"
       sign_in user
       redirect_back_or user
    else
      pass = SecureRandom.urlsafe_base64
      user = User.create!(name: hash[:info][:nickname] || hash[:info][:name], 
        email: hash[:info][:email], password: pass, password_confirmation: pass)
      sign_in user
      redirect_back_or user
    end
   end
  end

	def create
      user = User.find_by(email: params[:session][:email].downcase)
  		if user && user.authenticate(params[:session][:password])
        unless user.active
        flash.now[:error] = "Пользователь не активирован"
        return render 'new'
        end 
  		sign_in user
    	redirect_back_or user
  		else
  			flash.now[:error] = 'Invalid email/password combination'
  		render 'new'	
      	end
  	end

  def destroy
    sign_out
    redirect_to root_url
  end

  def forgot
  end

  def remind
    keyword = params[:sclerosis]
    regexp = /\A[a-z]+[\w.\-+]+@[a-z]+\.[a-z]{1,2}\Z/i
    if regexp =~ keyword
      user = User.find_by(email: keyword)
      if user != nil && temp_link(user)
      flash.now[:success] = "На ваш e-mail отправлено письмо по восстановлению пароля"  
      return render 'forgot'
      end
      flash.now[:error] = "Такой пользователь не найден"
      render 'forgot'
    else
      flash.now[:error] = "Неправильный e-mail"
      render 'forgot'
    end
  end

  def edit
    if User.find_by(remember_token: User.encrypt(params[:id])) != nil
    @user = User.find_by(remember_token: User.encrypt(params[:id]))
    else 
    redirect_to forgot_path
    flash[:error] = "Ссылка устарела, попробуйте восстановить пароль снова"
    end                          
  end

  private

  def temp_link(user)
    remember_token = User.new_remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    UserMailer.reset_password(user, remember_token).deliver
  end

end
