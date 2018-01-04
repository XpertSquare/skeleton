class SessionsController < ApplicationController
  
  layout false
  
  def new
    @login = Login.new
  end
  
  def create
    @login = Login.new(params[:login])
    if @login.valid? 
      user = User.unscoped.find_by_email(@login.email)
      if user && user.authenticate(@login.password)
        if params[:remember_me]
          cookies.permanent[:_calendo_auth_token] = {
                                              :value => user.auth_token,
                                              :domain => '.lvh.me',
                                              :expires => 1.month.from_now
                                              
                                            }        
        else
          cookies[:_calendo_auth_token] = { :value => user.auth_token, 
                                            :domain => '.lvh.me' }
        end
        
          logger.debug  "You are now logged in! " + user.account.name   + " +++  " + return_url
          redirect_to admin_url(:subdomain=>user.account.subdomain), :notice => "You are now logged in! " + user.account.name  + " +++  " + return_url  
          #redirect_to return_url, :notice => "You are now logged in! " + user.account.id.to_s  + " +++  " + return_url
         
      else
        flash.now.alert = "Email or password is invalid"
        render "new"
      end
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end

  end
  
  def destroy
    cookies.delete(:_calendo_auth_token,
                   :domain => '.lvh.me')
    session[:return_url] = nil
    redirect_to root_url, notice: "You are now logged out!"
  end
  
end
