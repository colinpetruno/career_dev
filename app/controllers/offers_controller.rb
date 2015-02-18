class OffersController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    @offer = task.offers.build.for_user(current_user)
    if @offer.save
      redirect_to task_path(task), flash: { success: "Interest Expressed" }
    else
      redirect_to task_path(task), flash: { error: "Something Went Wrong" }
    end
  end

  def update
    offer = Offer.find(params[:id])
    if offer.update(offers_params)
      redirect_to task_path(offer.task), flash: { success: "Success" }
    else
      redirect_to task_path(offer.task), flash: { success: "Oops.. Error" }
    end
  end

  private

  def offers_params
    params.require(:offer).permit(:completed)
  end
end
