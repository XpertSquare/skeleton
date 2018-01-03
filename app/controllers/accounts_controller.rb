class AccountsController < ApplicationController
def new
  @account = Account.new
  
   respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
end

# POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new
    @account.name = params[:name]

   @user = User.find_by_username(params[:email])
   if @user == nil
     @user = User.new
     @user.username = params[:email]
     #generate random password
     @char_map =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
     @user.password = (0...10).map{ @char_map[rand(@char_map.length)] }.join
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
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

end
