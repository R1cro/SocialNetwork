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
//= require dropzone
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
    }

    Dropzone.autoDiscover = false;
    var imageDropzone = new Dropzone(document.getElementById('dropzone-area'), {
        url: 'https://api.cloudinary.com/v1_1/r1cro-socialnetwork/image/upload',
        maxFiles: 3,
        parallelUploads: 3,
        maxFilesize: 2, //MB
        addRemoveLinks: true,
        autoProcessQueue: false,
        uploadMultiple: false,
        acceptedFiles:'.jpg,.png,.jpeg,.gif',
        accept: function(file, done) {
            console.log("Uploaded");
            done();
        },
        init: function() {
            this.on("maxfilesexceeded", function(file) {
                this.removeFile(file);
            });
        }
    });

    imageDropzone.on('drop', function(drop) {
        drop.stopPropagation();
        drop.preventDefault();
        var imageUrl = drop.dataTransfer.getData('URL');
        if(imageUrl.length > 0) {  // If URL - ignore
            $('#dropzone-area').removeClass('well');
            document.getElementById('dropzone-upload').style.display = 'none';
        }
        else {
            document.getElementById('dropzone-upload').style.display = 'block';
        }
    });

    $('#dropzone-textarea').bind('dragover', function () {
        $('#dropzone-area').addClass('well');
    });

    $('#dropzone-textarea').bind('dragleave', function() {
        $('#dropzone-area').removeClass('well');
    });

    $('#dropzone-upload').on("click", function (event) {
        event.preventDefault();
        event.stopPropagation();
        if (imageDropzone.getQueuedFiles().length > 0) {
            imageDropzone.processQueue();
        } else {
            imageDropzone.uploadFiles([]);
            document.getElementById('dropzone-upload').style.display='none';
        }
        document.getElementById('dropzone-upload').style.display='none';
    });

    imageDropzone.on('sending', function (file, xhr, formData) {
        formData.append('api_key', 419667145398731);
        formData.append('timestamp', Date.now() / 1000 | 0);
        formData.append('upload_preset', 'r1cro-images');
    });

    imageDropzone.on('success', function (file, response) {
        console.log('Success! Cloudinary public ID is', response.public_id);
        imageDropzone.removeAllFiles();
        $('#dropzone-area').removeClass('well');
    });

})
