class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end
  
  def create
    @registration = Registration.new(registration_params)
    @registration.ip_address=request.remote_ip
    @registration.user_agent = request.user_agent
    #@registration.status="new"
    
    if @registration.save        
      #RegistrationMailer.registration_confirmation(@registration).deliver
      
      
      @account = Account.new
      @account.name = @registration.business_name
      @account.subdomain = @account.name.parameterize
      @account.billing_cycle_code = Time.now.strftime("%d").to_i
      if @account.billing_cycle_code >28
         @account.billing_cycle_code = 1
      end
      @user = User.find_by_username(@registration.email)
      if @user == nil
        @user = User.new
        @user.username = @registration.email
        @user.email = @registration.email
        @user.display_name = @registration.name
        #generate random password
        @user.generate_password
        
        logger.info "User password: " + @user.password
     
        @user.password_confirmation = @user.password
      end     
   
      ActiveRecord::Base.transaction do
        @account.save
        @user.save  
        @membership = Membership.new
        @membership.account_id = @account.id
        @membership.user_id = @user.id
        @membership.is_active = true
        @membership.save
      end
      logger.info "Account ID: " + @account.id.to_s
      respond_to do |format|
        if @account.id > 0 
         #ApplicationMailer.registration_confirmation(@account, @user).deliver         
          format.html { redirect_to root_url, notice: 'Account was successfully created.' }
          format.json { render json: root_url, status: :created, location: @account }
        else
          format.html { render action: "new" }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
     else
          format.html { render action: "new" }
          format.json { render json: @registration.errors, status: :unprocessable_entity }
     end   
 
      
      
      
#        respond_to do |format|
#        format.html { redirect_to root_url, notice: 'The registration was successfully submitted.' }
#        format.json { render action: 'show', status: :created, location: @registration }
#      end
#    else
#      respond_to do |format|
#        format.html { render action: 'new' }
#        format.json { render json: @registration.errors, status: :unprocessable_entity }
#      end
#    end
      
end

  
  # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:name, :business_name, :email)
    end
end
