class PaymentsController < AuthenticatedController
  # TODO: DELETE ME
  def create
    payment = current_company.payments.build(payment_params)
    if payment.save
      redirect_to company_billing_plan_path
    else
      # TODO: Implement this
    end
  end

  private

  def payment_params
    params.
      require(:payment).
      permit(:funding_instrument_id,
             :billing_plan_id,
             :amount_in_cents
            )
  end
end
