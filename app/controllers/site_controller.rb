class SiteController < ApplicationController
  def index
    @registration = Registration.new
  end
end
