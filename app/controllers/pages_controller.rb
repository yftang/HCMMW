class PagesController < ApplicationController
  def home
    @title = "Home"
    redirect_to current_user if signed_in?
  end

  def contact
    @title = "Contact"
  end

  def help
    @title = "Help"
  end
end
