/*
 * jQuery.bounds
 * author: Andrew Powell
*/

(function($){
       
        $.fn['bounds'] = function()
        {
                var t = this, e = t[0];
                if (!e) return;
               
                var offset = t.offset(), pos = { width:e.offsetWidth, height:e.offsetHeight, left: 0, top: 0, right: 0, bottom: 0, x: 0, y: 0 };

                pos.left = offset.left;
                pos.top = offset.top;

                //right and bottom
                pos.right = (pos.left + pos.width);
                pos.bottom = (pos.top + pos.height);
                pos.x = pos.left;
                pos.y = pos.top;
                pos.inner = {width: t.width(), height: t.height()};

                $.extend(pos, {toString: function(){ var t = this; return 'x: ' + t.x + ' y: ' + t.y + ' width: ' + t.width + ' height: ' + t.height + ' right: ' + t.right + ' bottom: ' + t.bottom; }});

                return pos;
        };

})(jQuery);
