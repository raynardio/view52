$(() => {
  const $step1Form = $('#step1-form');
  const $step2Form = $('#step2-form');

  const step1Url = $step1Form.data('post-url');
  const step2Url = $step2Form.data('post-url');
  const csrfToken = $('meta[name="csrf-token"]').attr('content');

  const $loadingSpinner = $('<div>').addClass('text-center');
  $loadingSpinner.append($('<span>').addClass('fa fa-spinner fa-spin fa-4x'));

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

  function submitStep1(data) {
    let valid = false;

    // TODO: Asynchronous way of validation AJAX call?
    $.ajax({
      url: step1Url,
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

  function submitStep2(data) {
    let valid = false;

    $.ajax({
      url: step2Url,
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
      // const $step = $('#step1');
      // const stepContent = $step.html();
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
          marital_status: $('select[name=marital_status]').val(),
          education: $('select[name=education]').val(),
          weekly_hours: parseFloat($('select[name=weekly_hours]').val()),
          sleep_hours: parseFloat($('select[name=sleep_hours]').val()),
          commute_hours: parseFloat($('select[name=commute_hours]').val()),
          exercise_hours: parseFloat($('select[name=exercise_hours]').val()),
          diet: $('select[name=diet]').val()
        }
      };
      // $step.html($loadingSpinner);
      const submitValid = submitStep1(data);
      // $step.html(stepContent);
      return submitValid;
    }
  }

  function validateStep2() {
    console.log('Validating 2');
    const formValid = $step2Form.valid();

    if (!formValid) {
      $step2Validator.focusInvalid();
      return false;
    } else {
      $.ajax({
        url: step2Url,
        method: 'PUT',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', csrfToken)},
        dataType: 'json',
        data: { user: formToJson($step2Form) },
        success: res => {
          console.log(JSON.stringify(res, null, 2));
          // valid = true;
        },
        error: err => {
          console.error(JSON.stringify(err, null, 2));
        }
      });
      return false;
    }
  }

  function validationChecking(tab, navigation, nextIndex) {
    console.log(`Next: ${nextIndex}`);
    switch (nextIndex) {
      case 1: return validateStep1();
      case 2: return validateStep2();
    }
  }

  $('#onboarding-wizard').bootstrapWizard({
    tabClass: '',
    'nextSelector': '.button-next',
    'previousSelector': '.button-previous',
    onNext: validationChecking,
    // onLast: validationChecking,
    // onTabClick: validationChecking,
    // onTabShow: function (tab, navigation, index) {
    //   const $total = navigation.find('li').length;
    //   const $current = index + 0;
    //   const $percent = ($current / $total) * 133;
    //   $('#onboarding-wizard .progress-bar').css({width: $percent + '%'});
    // }
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

  $('select').selectize({});

  $('.selectize').selectize({
    delimiter: ' ',
    persist: false,
    createOnBlur: true,
    create: true
  });
});
