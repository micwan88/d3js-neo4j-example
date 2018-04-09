function mapToArray(targetMapObj) {
  return $.map(targetMapObj, function(value, key) {
    return [value];
  });
}

function removeAlert() {
  $('div.alert').remove();
}

function promptAlert(targetElement, msgText, isError) {
  removeAlert();

  var alertType;
  if (!isError)
    alertType = 'info';
  else
    alertType = 'danger';

  var alertDiv = $('<div class="alert alert-' + alertType + ' alert-dismissible fade show" role="alert"></div>');
  var alertCloseBtn = $('<button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>');
  alertCloseBtn.append($('<i class="fa fa-times" aria-hidden="true"></i>'));
  alertDiv.append(alertCloseBtn);

  alertDiv.append(msgText);
  targetElement.prepend(alertDiv);
}

function setupNeo4jLoginForAjax(login, passwd) {
  $.ajaxSetup({
    contentType: 'application/json',
    beforeSend: function(xhr) {
      xhr.setRequestHeader ('Authorization', 'Basic ' + btoa(login + ':' + passwd));
    }
  });
}