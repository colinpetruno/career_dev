$(function(){

  function handleResponse(response) {

    if (response.status_code === 201) {
      var fundingInstrument = response.cards !== null ? response.cards[0] : response.bank_accounts[0];


      console.log(fundingInstrument);
    } else {
      console.log("Failed");
      //       // Failed to tokenize, your error logic here
    }
  }

  $('#cc-submit').click(function (e) {
    e.preventDefault();

    var payload = {
      name: $('#card-name').val(),
      number: $('#card-number').val(),
      expiration_month: $('#cc-ex-month').val(),
      expiration_year: $('#cc-ex-year').val(),
      cvv: $('#card-cvv').val(),
      address: {
        postal_code: $('#postal-code').val()
      }
    };

    balanced.card.create(payload, handleResponse);
  });
});
