// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .

document.addEventListener("turbolinks:load", function() {
    $('.datepicker').datetimepicker({
        format: "DD/MM/YYYY",
        icons: {
            previous: "fa fa-arrow-left",
            next: "fa fa-arrow-right"
        }
    });

   $("div[id|='reply-to-micropost']").hide()
   window.toggleReply = function (id) {
        $("#reply-to-micropost-" + id.toString()).slideToggle(500);
    }

    if ($('#scrolling').size() > 0) {
        $(window).on('scroll', function() {
            var url;
            url = $('.pagination .next_page a').attr('href');
            if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
                document.getElementById("loading").style.display = 'block';
                $('.pagination').html('<h4>Loading...</h4>');
                $.getScript(url);
            }
        });
        return;
    }
})
