/*!
 * jquery.scrollBottom.js v1.5 - 18 December, 2012
 * By João Gonçalves (http://goncalvesjoao.github.com)
 * Hosted on https://github.com/goncalvesjoao/jQuery-scrollBottom
 * Licensed under MIT license.
 */

(function($){
  var methods = {
    init: function(callback, margin_bottom) {
      if (margin_bottom == undefined) margin_bottom = 0;
      return this.each(function() {
        $(this).data('reached_bottom', false);
        $(this).data('margin_bottom', margin_bottom);
        $(this).scroll(function() {
          $(this).scrollBottom('check_bottom', false);
        });
        $(this).bind('scroll_reached_bottom', function(event) {
          callback(event);
          event.stopPropagation();
        });
      });
    },
    check_bottom: function(bypass_validation) {
      if (bypass_validation == undefined) bypass_validation = true;
      return this.each(function() {
        var container = $(this);
        var container_scrollHeight = (this == window) ? $(document).height() : container[0].scrollHeight;
        if ((container_scrollHeight - container.scrollTop()) <= (container.outerHeight() + container.data('margin_bottom'))) {
          if (bypass_validation || !container.data('reached_bottom')) {
            container.trigger('scroll_reached_bottom');
            container.data('reached_bottom', true);
          }
        } else {
          container.data('reached_bottom', false);
        }
      });
    },
    destroy: function() {
      return this.each(function() {
        $(this).unbind('scroll_reached_bottom');
        $(this).unbind('scroll');
      });
    }
  }
  $.fn.scrollBottom = function(method, margin_bottom) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method == "function") {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' +  method + ' does not exist on jQuery.scrollBottom');
    }
  };
})(jQuery);