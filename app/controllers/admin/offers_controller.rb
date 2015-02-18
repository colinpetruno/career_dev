class Admin::OffersController < ApplicationController
  def update
    offer = Offer.find(params[:id])
    if offer.update(offer_params)
      redirect_to admin_task_path(offer.task), flash: { success: "Approved" }
    else
      redirect_to admin_task_path(offer.task), flash: { error: "Something went wrong" }
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:approved, :accepted)
  end
end
