$(function(){

  function handleResponse(response) {
    console.log('handle response bank account');
    console.log(response);
    console.log(response.status_code);

    if (response.status_code === 201) {
      var fundingInstrument = response.cards != null ? response.cards[0] : response.bank_accounts[0];

      $('#bank_account_url').val(fundingInstrument.href);
      $('#new_bank_account').off("submit").submit();
    } else {
      alert("Something went wrong");
      console.log("Failed");
    }
  }


  $('#new_bank_account').submit(function (e) {
    e.preventDefault();

    var payload = {
      name: $('#ba-name').val(),
      routing_number: $('#ba-routing').val(),
      account_number: $('#ba-number').val()
    };

    balanced.bankAccount.create(payload, handleResponse);
  });
});
