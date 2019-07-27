class AddressesController < ApplicationController

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to profile_path
  end


  private

  def address_params
    params.permit(:street, :city, :state, :zip)
  end
end
