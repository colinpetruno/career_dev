class SubmissionsController < AuthenticatedController

  def new
    offer = current_company.offers.find(params[:offer_id])
    @submission = offer.build_submission
  end
end
