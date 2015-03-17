class CreditCardsController < FundingInstrumentsController
  def new
    @card = current_company.credit_cards.build
  end

  def create
    card = current_company.credit_cards.build(credit_card_params)
    if card.save
      redirect_to company_funding_instruments_path(current_company)
    else
      render "new"
    end
  end

  private

  def credit_card_params
    params.
      require(:credit_card).
      permit(:token, :name)
  end
end
