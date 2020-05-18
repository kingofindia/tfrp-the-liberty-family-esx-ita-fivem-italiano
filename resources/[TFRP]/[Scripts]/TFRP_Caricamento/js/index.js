
$.firefly({
  color: '#fff',
  minPixel: 1,
  maxPixel: 1,
  total : 300,
  on: '#firefly',
  borderRadius: 10
});


var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;

function UpdateCursorPos() {
    cursor.style.left = cursorX;
    cursor.style.top = cursorY;
}

function Click(x, y) {
    var element = $(document.elementFromPoint(x, y));
    element.focus().click();
}

window.onload = function() 
{
	cursor.style.display = "none";
}

$(function() {
	
    $(document).mousemove(function(event) {
        cursorX = event.pageX;
        cursorY = event.pageY;
        UpdateCursorPos();
    });
});