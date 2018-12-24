$(() => {
  const $step1Form = $('#step1-form');
  const $step2Form = $('#step2-form');
  const $step3Form = $('#step3-form');

  const step1Url = $step1Form.data('post-url');
  const step2Url = $step2Form.data('post-url');
  const step3Url = $step3Form.data('post-url');

  const csrfToken = $('meta[name="csrf-token"]').attr('content');

  const $step1Validator = $step1Form.validate({
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
      },
      sex: {
        required: true
      },
      marital_status: {
        required: true
      },
      date_of_birth: {
        required: true,
        date: true
      },
      education: {
        required: true
      },
      weekly_hours: {
        required: true
      },
      sleep_hours: {
        required: true
      },
      commute_hours: {
        required: true
      },
      exercise_hours: {
        required: true
      },
      diet: {
        required: true
      }
    }
  });

  const $step2Validator = $step2Form.validate({
    rules: {
      present_roles: {
        required: true
      },
      future_roles: {
        required: true
      }
    }
  });

  function submitStep(url, data) {
    let valid = false;

    // TODO: Asynchronous way of validation AJAX call?
    $.ajax({
      url: url,
      method: 'PUT',
      async: false,
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', csrfToken)},
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
      $step1Validator.focusInvalid();
      return false;
    } else {
      const data = { user: formToJson($step1Form) };
      return submitStep(step1Url, data);
    }
  }

  function validateStep2() {
    const formValid = $step2Form.valid();

    if (!formValid) {
      $step2Validator.focusInvalid();
      return false;
    } else {
      const data = { user: formToJson($step2Form) };
      return submitStep(step2Url, data);
    }
  }

  function validateStep3() {
    // const formValid = $step3Form.valid();

    // if (!formValid) {
    //   $step2Validator.focusInvalid();
    //   return false;
    // } else {
      const data = { user: formToJson($step3Form) };
      return submitStep(step3Url, data);
    // }
  }

  function validationChecking(tab, navigation, nextIndex) {
    console.log(`Next: ${nextIndex}`);
    switch (nextIndex) {
      case 1: return validateStep1();
      case 2:
        if (validateStep2()) {
          // TODO: Use wizard library to handle final step
          setTimeout(function() {
            $('.button-next').text('Finish').removeClass('disabled');
          }, 100);
          return true;
        }
        return false;
      case 3:
        if(validateStep3()) {
          location.href = '/';
        } else {
          return false;
        }
    }
  }

  $('#onboarding-wizard').bootstrapWizard({
    tabClass: '',
    'nextSelector': '.button-next',
    'previousSelector': '.button-previous',
    onNext: validationChecking
  });

  $('.button-next').removeClass('disabled');

  $('input[name=date_of_birth]').fullCalendar({
    header: { center: 'month,year' },
    views: {
      month: {
        titleFormat: 'MM/DD/YYYY'
      }
    }
  });

  $('select').selectize({
    create: true
  });

  $('.selectize').selectize({
    delimiter: ' ',
    persist: false,
    createOnBlur: true,
    create: true
  });
});
