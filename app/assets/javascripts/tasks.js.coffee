# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
`$('button[data-toggle]').on('click', function() {
	toggle = $(this).data('toggle');
	//$('h3:not(toggle)').hide();
	//$('h3, table').hide();
	//$('h3').hasClass(toggle).show();
	//$('table').hasClass(toggle).show();
	if(toggle === 'Development') {
		$('.Marketing').hide();
		$('.Product').hide();
		$('.Development').show();	
	}

	if(toggle === 'Marketing') {
		$('.Development').hide();
		$('.Product').hide();
		$('.Marketing').show();
	}

	if(toggle === 'Product') {
		$('.Development').hide();
		$('.Marketing').hide();
		$('.Product').show();
	}

	if(toggle === 'All') {
		$('.Development').show();
		$('.Marketing').show();
	}
})`