$(() => {
  const $get_started_button = $('#get-started-button');
  const $onboarding = $('#onboarding');

  $get_started_button.click(() => {
    $get_started_button.hide();
    $onboarding.show();
  });
});
