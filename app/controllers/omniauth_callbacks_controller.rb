class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    redirect_to "/users"
  end
  alias_method :twitter, :all
end
