// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require froala_editor.min.js
//= require plugins/align.min.js
//= require plugins/char_counter.min.js
//= require plugins/code_beautifier.min.js
//= require plugins/code_view.min.js
//= require plugins/colors.min.js
//= require plugins/emoticons.min.js
//= require plugins/entities.min.js
//= require plugins/file.min.js
//= require plugins/font_family.min.js
//= require plugins/font_size.min.js
//= require plugins/fullscreen.min.js
//= require plugins/help.min.js
//= require plugins/image.min.js
//= require plugins/image_manager.min.js
//= require plugins/inline_style.min.js
//= require plugins/line_breaker.min.js
//= require plugins/link.min.js
//= require plugins/lists.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/paragraph_style.min.js
//= require plugins/print.min.js
//= require plugins/quick_insert.min.js
//= require plugins/quote.min.js
//= require plugins/save.min.js
//= require plugins/table.min.js
//= require plugins/special_characters.min.js
//= require plugins/url.min.js
//= require plugins/video.min.js

//= require third_party/embedly.min.js
//= require third_party/image_aviary.min.js
//= require third_party/spell_checker.min.js

//= require languages/zh_cn.js
//= require_tree .

document.addEventListener('turbolinks:load', () => {
    $('#project_description').froalaEditor({
        language: 'zh_cn',
        imageUploadURL: "/upload_image",
        imageUploadParam: 'image',
        fileUploadURL: "/upload_file",
        fileUploadParam: 'file',
        fileMaxSize: 1024 * 1024 * 3,
        requestHeaders: {
            "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
        },
        iconsTemplate: 'font_awesome_5'
    })
        .on('froalaEditor.file.error',function(e, editor, error, response){
            var $popup = editor.popups.areVisible();
            var $layer = $popup.find('.fr-file-progress-bar-layer');
            $layer.find('h3').text('错误：上传文件不能大于3M');
        }
        )
        .on('froalaEditor.image.error',function(e, editor, error, response){
            var $popup = editor.popups.areVisible();
            var $layer = $popup.find('.fr-image-progress-bar-layer');
            $layer.find('h3').text('错误：上传图片不能大于10M');
        }
        );
});