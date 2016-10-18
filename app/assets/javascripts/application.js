// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require turbolinks
//= require bootstrap
//= require ie-emulation-modes-warning.js
//= require ie10-viewport-bug-workaround.js
//= require moment 
//= require fullcalendar
//= require bootstrap-multiselect

$(document).on('turbolinks:load', function () {
    $('table.display').DataTable({
        "processing": true,
        "serverSide": true,
        "ajax": $('table.display').data('source')
    });
    $('#room_facility_ids').multiselect();
    
$('#calendar').fullCalendar({header: {
        left: 'prev,next today myCustomButton',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
    },
     weekends: { default: true
    	
    },
    // events: gon.bookings,
    // color: 'yellow',   // an option!
    // textColor: 'black' // an option!
     events: {
        url: window.location.href+'.json',
        error: function() {
            alert('there was an error while fetching events!');
        },
    }

});
} );