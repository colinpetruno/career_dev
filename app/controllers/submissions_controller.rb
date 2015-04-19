class SubmissionsController < AuthenticatedController

  def new
    @offer = current_company.offers.find(params[:offer_id])
    @submission = @offer.build_submission
  end

  def create
    offer = current_company.offers.find(params[:offer_id])
    offer.complete_with_submission(submission_params)

    if offer.save
      redirect_to company_task_path(current_company, offer.task)
    else
      render :new
    end
  end

  def show
    @submission = Submission.find(params[:id])
  end

  private

  def submission_params
    params.
      require(:submission).
      permit(:feedback).
      merge(user_id: current_user.id, company_id: current_company.id)
  end
end
