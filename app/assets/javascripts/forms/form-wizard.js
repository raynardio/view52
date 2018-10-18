// Form Wizard JavaScripts

(function ($) {
	'use strict';

	var $validator = $("#onboarding-form").validate({
	    rules: {
	        first_name: {
		        required: true,
		        minlength: 3
		    },
		    last_name: {
		        required: true,
		        minlength: 3
		    },
		    email: {
		        required: true,
		        minlength: 3,
		        email: true
		    },
		    state: {
		    	required: true
		    },
            country: {
                required: true
            },
            city: {
		    	required: true
		    },
		    zip: {
		    	required: true,
		    	minlength: 3
		    }
	    }
	});

	function validationChecking() {
	    var $valid = $('#onboarding-form').valid();
	    if (!$valid) {
	        $validator.focusInvalid();
	        return false;
	    }
	}

  	$('#rootwizard').bootstrapWizard({
  		tabClass: '',
	    'nextSelector': '.button-next',
	    'previousSelector': '.button-previous',
	    onNext: validationChecking,
	    onLast: validationChecking,
	    onTabClick: validationChecking,
  		onTabShow: function(tab, navigation, index) {
			var $total = navigation.find('li').length;
			var $current = index+0;
			var $percent = ($current/$total) * 133;
			$('#rootwizard .progress-bar').css({width:$percent+'%'});
		}});
})(jQuery);
