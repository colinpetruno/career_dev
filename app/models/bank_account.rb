class BankAccount < FundingInstrument
  before_create :redeem_url

  private
  def redeem_url
    self.name = bank_account[:bank_name]
    self.account_type = bank_account[:account_type]
    self.description = bank_account[:name]
    self.account_number = bank_account[:account_number]
  end

  def bank_account
    unless @bank_account.present?
      puts "BANK ACCOUNT BLANK - FETCHING"
    end
    @bank_account ||= fetch_bank_account[:bank_accounts].first
  end

  def fetch_bank_account
    Balanced::BankAccount.find(url)
  end
end

# bank_name
# account_type
# name
# account_number


#{"bank_accounts"=>
 #[{"routing_number"=>"021000021",
   #"bank_name"=>"JPMORGAN CHASE BANK",
   #"account_type"=>"checking",
   #"name"=>"Test Name",
   #"links"=>{"customer"=>nil, "bank_account_verification"=>nil},
   #"can_credit"=>true,
   #"created_at"=>"2015-03-06T04:20:06.359912Z",
   #"fingerprint"=>"2ef53fa3f76e47c5930f77fe0a59aa103b5abfd5622f08305b786808ec574a1e",
   #"updated_at"=>"2015-03-06T04:20:06.359914Z",
   #"href"=>"/bank_accounts/BA2xgn5za9S9UXZ9ec1wBf3Y",
   #"meta"=>{},
   #"account_number"=>"xxxxxx0002",
   #"address"=>{"city"=>nil, "line2"=>nil, "line1"=>nil, "state"=>nil, "postal_code"=>nil, "country_code"=>nil},
   #"can_debit"=>false,
   #"id"=>"BA2xgn5za9S9UXZ9ec1wBf3Y"}],
   #"links"=>
 #{"bank_accounts.settlements"=>"/bank_accounts/{bank_accounts.id}/settlements",
  #"bank_accounts.bank_account_verification"=>"/verifications/{bank_accounts.bank_account_verification}",
  #"bank_accounts.debits"=>"/bank_accounts/{bank_accounts.id}/debits",
  #"bank_accounts.customer"=>"/customers/{bank_accounts.customer}",
  #"bank_accounts.credits"=>"/bank_accounts/{bank_accounts.id}/credits",
  #"bank_accounts.bank_account_verifications"=>"/bank_accounts/{bank_accounts.id}/verifications"}}
