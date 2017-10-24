/* global $, Stripe */
//Document ready
$(document).on('turbolinks:load', function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-signup-btn');
  
  //Set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  //When user clicks form submit btn
  submitBtn.click(function(event){
    //prevent defualt submission behaviou
    event.preventDefault();
    submitBtn.val("Processing").prop('disabled', true);
    
    //Collect the credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
        
        alert(expMonth);

    //Use STripe JS library to check for card errors
    var error = false;
    
    //Validate card number
    if(!Stripe.card.validateCardNumber(ccNum)) {
      error = true;
      alert('The credit card number is invalid');
    }

    //Validate card CVC number
    if(!Stripe.card.validateCVC(cvcNum)) {
      error = true;
      alert('The credit card CVC number is invalid');
    }
    
    //Validate card exp date
    if(!Stripe.card.validateExpiry(expMonth, expYear)) {
      error = true;
      alert('The credit card exp date is invalid');
    }
    
    if (error) {
      //If there are card errors dont send to Stripe
      submitBtn.prop('disabled', false).val("Sign Up");
    } else {
      //Send the card info to Stripe
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    }
  });  

  //Stripe will return a card token.
  function stripeResponseHandler(status, response) {
    // Get token from the response
    var token = response.id;

    // Enject card token in a hidden field
    theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    
    //Submit form to our Rails app
    theForm.get(0).submit();
  }
  return false;
});