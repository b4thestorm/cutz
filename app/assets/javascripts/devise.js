// var stripeResponseHandler = function (status, response) {
//  var $form = $("#new_subscription");

//  if (response.error) {
//     $form.find('.payment-errors').text(response.error.message);
//     $form.find('button').prop('disabled', false);
//   } else {
//     var token = response.id;
//     $('#stripe_card_token').val(token);
//     console.log(token);
//     $form.get(0).submit();
//   }
// };

// jQuery(function($) {
//    $('#new_subscription').submit( function(event) {
//       var $form = (this);
//       $form.find("input[type=submit]").prop('disabled', true);  
//       Stripe.card.createToken($form, stripeResponseHandler);

//       //Prevent the form from submitting with the default action;
//       return false;
//   });
// })



    






//        $form.append($("<input type=\"hidden\" name=\"registration[card_token]\" />").val(token));
//        //THIS DATA ATTRIBUTE NEEDS TO BE RECOGNIZED
//        $("[data-stripe=number]").remove();
//        $("[data-stripe=cvv]").remove();
//        $("[data-stripe=exp-year]").remove();
//        $("[data-stripe=exp-month]").remove();
//        $form.post(0).submit();
//      }
//      return false;
//    };


