class Payment < ActiveRecord::Base
  belongs_to :company
  belongs_to :funding_instrument
  belongs_to :billing_plan

  after_save :update_billing_plan
  after_create :enqueue_process_payment

  def self.change_plan(company, new_plan)
    # funding instrument
    new(company: company,
        funding_instrument: company.funding_instruments.primary,
        amount_in_cents: changed_plan_cost(company, new_plan),
        billing_plan_id: new_plan.id
       )
  end

  private

  def enqueue_process_payment
    Resque.enqueue(ProcessPayment, self.id)
  end

  def process_payment
    customer = company.balanced_customer
    order = customer.create_order
    self.order_url = order.href
    order.description = "Test Description"
    order.save

    if amount_in_cents > 0
      debit = order.debit_from(
        source: funding_instrument.balanced_object,
        amount: amount_in_cents
      )
    else
      debit = order.credit_to(
        destination: funding_instrument.balanced_object,
        amount: amount_in_cents.abs
      )
    end
  end


  def update_billing_plan
    if company.billing_plan != billing_plan
      company.billing_plan = billing_plan
      company.save
    end
  end

  def self.changed_plan_cost(company, new_plan)
    # TODO: Test this
    current_plan = company.billing_plan
    cost_in_dollars = new_plan.monthly_cost - current_plan.monthly_cost
    cost_in_cents = cost_in_dollars * 100
    total_cost = cost_in_cents * percentage_of_month_remaining
    total_cost.ceil.to_i
  end

  def self.percentage_of_month_remaining
    # TODO: Test this
    t = Time.new
    percentage_left = (1.0 - ( ( t.end_of_month.day - (t.day + 1) ).to_f / t.end_of_month.day).to_f)
    percentage_left < 0 ? 0 : percentage_left
  end
end



#2.1.5 :009 > pay.status
#=> "succeeded"
#2.1.5 :010 > pay.transaction_number
#=> "WYA1-R1H-CAP3"
#2.1.5 :011 > pay.href
#=> "/debits/WD44p9G8o7Z5spIxjN5uhIdO"
#
#
# => #<Balanced::Debit:0x007fc38ac95608 @attributes={"status"=>"succeeded", "description"=>nil,
# "links"=>{"customer"=>"CU2HwkKGNjjit5fT4kOEkDWU", "source"=>"BA43XF4ZBfhoOwTNL7yxKv9Z", "card_hold"=>nil, "order"=>"OR43JGEIDw3qFqFwqHnSrra5", "dispute"=>nil}, "updated_at"=>"2015-03-11T12:57:24.107300Z",
# "created_at"=>"2015-03-11T12:57:23.819520Z", "transaction_number"=>"WYA1-R1H-CAP3", "failure_reason"=>nil, "currency"=>"USD", "amount"=>725, "failure_reason_code"=>nil, "meta"=>{}, "href"=>"/debits/WD44p9G8o7Z5spIxjN5uhIdO", "appears_on_statement_as"=>"BAL*example.com",
# "id"=>"WD44p9G8o7Z5spIxjN5uhIdO"}, @hyperlinks={"customer"=>#<Proc:0x007fc389690600@/Users/cpetruno/.rvm/gems/ruby-2.1.5/gems/balanced-1.2.1/lib/balanced/resources/resource.rb:56 (lambda)>,
# "order"=>#<Proc:0x007fc38969abc8@/Users/cpetruno/.rvm/gems/ruby-2.1.5/gems/balanced-1.2.1/lib/balanced/resources/resource.rb:56 (lambda)>, "dispute"=>#<Proc:0x007fc38969a218@/Users/cpetruno/.rvm/gems/ruby-2.1.5/gems/balanced-1.2.1/lib/balanced/utils.rb:6 (lambda)>,
# "source"=>#<Proc:0x007fc389698850@/Users/cpetruno/.rvm/gems/ruby-2.1.5/gems/balanced-1.2.1/lib/balanced/resources/resource.rb:56 (lambda)>, "events"=>#<Proc:0x007fc3896a2918@/Users/cpetruno/.rvm/gems/ruby-2.1.5/gems/balanced-1.2.1/lib/balanced/utils.rb:6 (lambda)>, "refunds"=>#<Proc:0x007fc3896a0a28@/Users/cpetruno/.rvm/gems/ruby-2.1.5/gems/balanced-1.2.1/lib/balanced/utils.rb:6 (lambda)>,
# "card_hold"=>#<Proc:0x007fc3896a0050@/Users/cpetruno/.rvm/gems/ruby-2.1.5/gems/balanced-1.2.1/lib/balanced/utils.rb:6 (lambda)>}, @response=#<Faraday::Response:0x007fc389693cb0 @env={:method=>:post, :body=>{"debits"=>[{"status"=>"succeeded", "description"=>nil, "links"=>{"customer"=>"CU2HwkKGNjjit5fT4kOEkDWU", "source"=>"BA43XF4ZBfhoOwTNL7yxKv9Z",
# "card_hold"=>nil, "order"=>"OR43JGEIDw3qFqFwqHnSrra5", "dispute"=>nil}, "updated_at"=>"2015-03-11T12:57:24.107300Z", "created_at"=>"2015-03-11T12:57:23.819520Z", "transaction_number"=>"WYA1-R1H-CAP3", "failure_reason"=>nil, "currency"=>"USD", "amount"=>725, "failure_reason_code"=>nil, "meta"=>{},
# "href"=>"/debits/WD44p9G8o7Z5spIxjN5uhIdO", "appears_on_statement_as"=>"BAL*example.com", "id"=>"WD44p9G8o7Z5spIxjN5uhIdO"}], "links"=>{"debits.customer"=>"/customers/{debits.customer}", "debits.order"=>"/orders/{debits.order}", "debits.dispute"=>"/disputes/{debits.dispute}", "debits.source"=>"/resources/{debits.source}",
# "debits.events"=>"/debits/{debits.id}/events", "debits.refunds"=>"/debits/{debits.id}/refunds", "debits.card_hold"=>"/holds/{debits.card_hold}"}}, :url=>#<URI::HTTPS:0x007fc38ac948c0 URL:https://api.balancedpayments.com/bank_accounts/BA43XF4ZBfhoOwTNL7yxKv9Z/debits>, :request_headers=>{"User-Agent"=>"balanced-ruby/1.2.1",
# "Content-Type"=>"application/json;revision=1.1", "Accept"=>"application/vnd.api+json;revision=1.1", "Authorization"=>"Basic YWstdGVzdC0ySWZCU01IV1hVNTV4dFExM2o5bHZ0SzhJUmpzYjgwNGc6"}, :parallel_manager=>nil, :request=>{:open_timeout=>60, :timeout=>60, :proxy=>nil}, :ssl=>{:verify=>true}, :status=>201, :response_headers=>{"content-type"=>"application/json",
# "date"=>"Wed, 11 Mar 2015 12:52:49 GMT", "server"=>"ngx_openresty/1.2.6.3", "x-balanced-guru"=>"OHM85bb37c8c7ed11e4ab7e0230f00c9248", "x-balanced-host"=>"bapi-integration-prod-8u30f7-10-3-5-17", "x-balanced-marketplace"=>"TEST-MP1ywSfGAIZj2ihm4v0R6S0y", "x-balanced-merchant"=>"TEST-MR1xPXZo0uSDN5zwYVmKhgJG", "x-balanced-revision"=>"1.1", "x-balanced-software-build"=>"1.14.21", "content-length"=>"1100", "connection"=>"Close"}, :response=>#<Faraday::Response:0x007fc389693cb0 ...>}, @on_complete_callbacks=[]>>
