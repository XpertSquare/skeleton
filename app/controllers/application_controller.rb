class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  #around_action :scope_current_account, :account_time_zone, if: :current_account  
  
  around_action :scope_current_account

private

  
  def current_account    
    if request.subdomain.present? && !Account.is_reserved_subdomain(request.subdomains.last)
      @current_account ||= Account.find_by_subdomain! request.subdomains.last
    end
  end
  helper_method :current_account
  
  
  def scope_current_account
      if current_account
        Account.current_id = current_account.id        
      end
      yield
  ensure
    Account.current_id = nil
  end
  
  def account_time_zone(&block)
    Time.use_zone(current_account.time_zone, &block)
  end
  
  def current_user
    logger.debug 'cookie: ' + cookies[:_calendo_auth_token].to_s 
    @current_user ||= User.find_by_auth_token!(cookies[:_calendo_auth_token]) if cookies[:_calendo_auth_token]
  end
  helper_method :current_user
  
  def authorize!(return_url = request.url)
    unless current_user
      set_return_url(return_url)
      redirect_to login_url, alert: "Not authorized. You need to be logged in to access the page requested "
    end   
  end
  
  def set_return_url(path, overwrite = false)
    if overwrite or session[:return_url].blank?
      session[:return_url] = path
    end
  end
    
  def return_url
    session[:return_url] ? session[:return_url] : root_path
  end
  
end
