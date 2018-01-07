class Admin::DashboardController < ApplicationController
  def index
    @account = current_account
  end
end
