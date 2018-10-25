$(() => {
  const $loadingSpinner = $('<div>').addClass('text-center');
  $loadingSpinner.append($('<span>').addClass('fa fa-spinner fa-spin fa-4x'));

  const $validator = $("#step1-form").validate({
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
        minlength: 5
      }
    }
  });

  function submitStep1(data) {
    let valid = false;

    // TODO: Asynchronous way of validation AJAX call?
    $.ajax({
      url: $('script[data-post-url]').data('post-url'),
      method: 'PUT',
      async: false,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      dataType: 'json',
      data: data,
      success: res => {
        console.log(JSON.stringify(res, null, 2));
        valid = true;
      },
      error: err => {
        console.error(JSON.stringify(err, null, 2));
      }
    });

    return valid;
  }

  function validateStep1() {
    const formValid = $('#step1-form').valid();

    if (!formValid) {
      $validator.focusInvalid();
      return false;
    } else {
      const $step = $('#step1');
      const stepContent = $step.html();
      const data = {
        user: {
          first_name: $('input[name=first_name]').val(),
          last_name: $('input[name=last_name]').val(),
          email: $('input[name=email]').val(),
          country: $('select[name=country]').val(),
          city: $('input[name=city]').val(),
          state: $('select[name=state]').val(),
          zip: $('input[name=zip]').val(),
          sex: $('select[name=sex]').val(),
          date_of_birth: $('input[name=date_of_birth]').val(),
          marital_status: $('select[name=marital_status]').val()
        }
      };
      $step.html($loadingSpinner);
      const submitValid = submitStep1(data);
      $step.html(stepContent);
      return submitValid;
    }
  }

  function validationChecking(tab, navigation, nextIndex) {
    console.log(`Next: ${nextIndex}`);
    switch (nextIndex) {
      case 1: return validateStep1();
    }
  }

  $('#onboarding-wizard').bootstrapWizard({
    tabClass: '',
    'nextSelector': '.button-next',
    'previousSelector': '.button-previous',
    onNext: validationChecking,
    // onLast: validationChecking,
    // onTabClick: validationChecking,
    onTabShow: function (tab, navigation, index) {
      const $total = navigation.find('li').length;
      const $current = index + 0;
      const $percent = ($current / $total) * 133;
      $('#onboarding-wizard .progress-bar').css({width: $percent + '%'});
    }
  });

  $('.button-next').removeClass('disabled');

  $('input[name=date_of_birth]').fullCalendar({
    header: { center: 'month,year' },
    views: {
      month: {
        titleFormat: 'YYYY-MM-DD'
      }
    }
  });

  $('select').selectize({
  });
});
