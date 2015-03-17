class CreditCard < FundingInstrument
  before_create :redeem_token
  # TODO: Align attribute names to database

  private

  def redeem_token
    customer = company.stripe_customer
    card = customer.sources.create({source: token})
    self.stripe_id = card.id

    # self.name
    self.description = card.brand

    self.number = card.last4
    #self.account_type = details.type

    self.expiration_month = card.exp_month
    self.expiration_year = card.exp_year
    self
  end

  def details
    @credit_card ||= fetch_credit_card
  end

  def fetch_credit_card
    customer = company.stripe_customer
    customer.sources.retrieve(stripe_id)
  end
end
