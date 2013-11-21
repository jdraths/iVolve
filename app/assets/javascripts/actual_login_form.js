// This function downcases the user login!

var ready;
ready = function() {
	$('#actual-login-form, #actual-signup-form').on('submit', function(){

	   //lower case auth key (email addresses) for all user validation
	 $(this).find('.user-auth-key').val( $(this).find('.user-auth-key').val().toLowerCase()  )
	});
};

$(document).ready(ready)
$(document).on('page:load', ready)