/*
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/
function showChildren(id) {
  if ($('#a_children_' + id).length == 0) {
    $.get('/articles/' + id + '/children', function(data) {
      createSubtree(id, data);
    }, 'json');
  } else {
    $('#a_children_' + id).toggle();
  }
  $('#icon_' + id).toggleClass('icon-plus icon-minus');
}

function createSubtree(id, data) {
  if (data.children) {
      var html = $('<ul>').attr('id', 'a_children_' + id).addClass('tree');
      for (var i = 0; i < data.children.length; i++) {
        article = data.children[i];
        var ele = $('<li>').attr('id', 'article_' + article.id);
        if (article.has_children == true) {
          var link = $('<a>').attr({href: 'javascript:void(0)',
              onclick: 'showChildren(' + article.id + ')'});
          link.html($('<span>').html('<i id="icon_' + article.id + '" class="icon-plus"></i>' + article.content)).appendTo(ele);
        } else {
          ele.append($('<span>').html(article.content));
        }
        html.append(ele);
      }
      $('#article_' + id).append(html);
    }
}

$(document).ready(function() {
  $('.to_edit').click(function() {
    $(this).hide().next('.editing_form').css('display', 'inline-block').children('.editing').focus();
  });
  
  $('.editing').blur(function() {
    var _this = $(this);
    var to_edit = _this.parent().hide().prev('.to_edit').show();
    if (to_edit.text() != _this.val()) {
      _this.parent().submit();
      to_edit.text(_this.val());
    }
  });
  
  $('.editing').keypress(function(event) {
    if (event.which == 13) {
      $(this).blur();
    }
  });
});