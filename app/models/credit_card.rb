class CreditCard < FundingInstrument
  before_create :redeem_url

  private

  def redeem_url
    self.name = details.bank_name
    self.description = details.brand
    self.number = details.number
    self.account_type = details.type
    self.expiration_month = details.expiration_month
    self.expiration_year = details.expiration_year
    self
  end

  def details
    @credit_card ||= fetch_credit_card
  end

  def fetch_credit_card
    Balanced::Card.fetch(url)
  end
end
