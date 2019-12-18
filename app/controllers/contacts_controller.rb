class ContactsController < ApplicationController
  def index
    @contacts = current_user.contacts
  end

  def new
    @contact = Contact.new
  end

  def create
    user = User.find_by(email: contact_params[:record][:email])
    @contact = current_user.contacts.build(record: user)
    if @contact.save
      flash[:notice] = "Contact saved successfully"
      redirect_to contacts_path
    else
      render :new
    end
  end

  def destroy
    @contact = current_user.contacts.find(params[:id])
    if @contact.destroy
      flash[:notice] = "Contact destroyed successfully"
    else
      flash[:alert] = "An error acurred when trying to remove this contact"
    end
    redirect_to contacts_path
  end

  private

  def contact_params
    params.require(:contact).permit(record: :email)
  end
end
