class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:error] = nil
      flash.now[:notice] = 'Thank you. We will respond as soon as possible.'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end