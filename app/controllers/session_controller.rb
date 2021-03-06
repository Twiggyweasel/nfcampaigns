class SessionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def new

  end

  def create
    auth = request.env['omniauth.auth']

    # Find an authentication or create an authentication
    @authentication = Authentication.find_with_omniauth(auth)
    if @authentication.nil?
      # If no authentication was found, create a brand new one here
      @authentication = Authentication.create_with_omniauth(auth)
    end

    if logged_in?
      if @authentication.user == current_user
        # User is signed in so they are trying to link an authentication with their
        # account. But we found the authentication and the user associated with it
        # is the current user. So the authentication is already associated with
        # this user. So let's display an error message.
        redirect_to user_account_settings_path(current_user), :flash => { :warning => "You have already linked this account" }
      else
        # The authentication is not associated with the current_user so lets
        # associate the authentication
        @authentication.user = current_user
        @authentication.save
        redirect_to user_account_settings_path(current_user), :flash => { :success => "Account successfully authenticated" }
      end
    else # no user is signed_in
      if @authentication.user.present?
        # The authentication we found had a user associated with it so let's
        # just log them in here
        self.current_user = @authentication.user
        if current_user.profile.nil?
          redirect_to new_user_profile_path(current_user)
        else
          if session[:return_url]
            redirect_to session[:return_url], :flash => { :success => "You have been signed in" }
          else
            redirect_to root_path, :flash => { :success => "You have been signed in"}
          end
        end
      else
        # The authentication has no user assigned and there is no user signed in
        # Our decision here is to create a new account for the user
        # But your app may do something different (eg. ask the user
        # if he already signed up with some other service)
        if @authentication.provider == 'identity'
          u = User.find(@authentication.uid)
          # If the provider is identity, then it means we already created a user
          # So we just load it up

          # self.current_user = u
          # redirect_to root_path :flash => { :success => "You have been signed in!" } and return
        else
          # otherwise we have to create a user with the auth hash
          if !User.find_by_email(auth['info']['email']).blank?
            redirect_to login_path, :flash => { :warning => "Your email address is already associated with an account, please sign in using or reset your password." } and return
          else
            u = User.create_with_omniauth(auth)
          end
          # NOTE: we will handle the different types of data we get back
          # from providers at the model level in create_with_omniauth
        end
        # We can now link the authentication with the user and log him in
        u.authentications << @authentication
        self.current_user = u
        if u.profile.nil?
          redirect_to new_user_profile_path(u)
        elsif session[:return_url]
            redirect_to session[:return_url], :flash => { :success => "You have been signed in" }
        else
            redirect_to root_path, :flash => { :success => "You have been signed in"}
        end
      end
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_path, :flash => { :danger => "Signed out!" }
  end

  def failure
    redirect_to login_path, :flash => { :danger => "Authentication failed, please try again." }
  end
end

