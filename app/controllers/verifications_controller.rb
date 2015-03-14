class VerificationsController < AuthenticatedController
  layout "settings"

  def show
    @account = current_company.bank_accounts.find(params[:bank_account_id])
  end

  def update
    account = current_company.bank_accounts.find(params[:bank_account_id])
    verification = account.verification

    verification.update(verification_params)

    if verification.verify
      redirect_to company_funding_instruments_path(current_company)
    else
      render :show
    end
  end

  private

  def verification_params
    params.require(:verification).permit(:amount_one, :amount_two)
  end
end


#"verification"=>{"amount_one"=>"1", "amount_two"=>"1"},
  #"commit"=>"Update Verification",
  #"controller"=>"verifications",
  #"action"=>"update",
  #"company_id"=>"example-company",
  #"bank_account_id"=>"4",
  #"format"=>"1"}
