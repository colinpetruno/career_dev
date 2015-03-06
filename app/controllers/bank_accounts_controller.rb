class BankAccountsController < FundingInstrumentsController
  load_and_authorize_resource

  def new
    @bank_account = current_user.company.bank_accounts.build
  end

  def create
    bank_account = current_user.company.bank_accounts.build(bank_account_params)
    bank_account.save
  end

  def bank_account_params
    params.
      require(:bank_account).
      permit(:url)
  end
end
