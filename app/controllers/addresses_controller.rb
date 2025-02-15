class AddressesController < ApplicationController

  def new
  end

  def show
    @address = Address.find(params[:id])
  end

  def create
    address = current_user.addresses.create!(address_params)
    redirect_to profile_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    address.update(new_params)
    redirect_to profile_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to profile_path
  end


  private

  def address_params
    params.permit(:street, :city, :state, :zip, :nickname)
  end

  def new_params
    params.permit(:street, :city, :state, :zip, :nickname)
  end
end
