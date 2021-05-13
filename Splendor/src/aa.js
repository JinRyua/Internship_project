
var ctx = document.getElementById('canvas').getContext('2d');
var offset = 0;


var start = null;
var element = document.getElementById('canvas');
element.style.position = 'absolute';

var a = 0;
function step(timestamp) {
  if (!start) start = timestamp;
  var progress = timestamp - start;
  if(progress >=20){
    ctx.clearRect(0,0,300,300);
    ctx.save();
    ctx.translate(100,100);
    ctx.save(); 
    ctx.rotate( ((2*Math.PI)/60)*a);
    a++;
    ctx.fillStyle = "white"
    ctx.fillRect(0, 0, 100, 10);
    ctx.restore();
    ctx.restore();
    

    start=null;
  }
  window.requestAnimationFrame(step);
  
}


window.requestAnimationFrame(step);
