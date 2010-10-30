$(document).ready(function(){
  $('a.slide').click(function() {
    $('#container').slideUp('slow');
    return false;
  });
});