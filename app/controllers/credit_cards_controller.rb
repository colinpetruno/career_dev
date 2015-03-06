class CreditCardsController < FundingInstrumentsController
  def new
    @card = CreditCard.new()
  end

  def create

  end
end
