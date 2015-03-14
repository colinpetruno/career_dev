class ProcessPayment
  @queue = :payments

  def self.perform(payment_id)
    payment = Payment.find(payment)


    # order = Balanced::Order.fetch('/orders/OR6c6n11zKSFfjE6kGNKtsE8')
    # bank_account = Balanced::BankAccount.fetch('/bank_accounts/BA6m4zboF7ocvKbkhjszP5NS')
    # order.debit_from(
    #  :source => bank_account,
    #  :amount => 5000
    # )
  end
end
