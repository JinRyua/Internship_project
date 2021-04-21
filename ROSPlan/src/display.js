
var ros = new ROSLIB.Ros();
 
// rosbridge websocket server와의 연결을 생성합니다.
ros.connect('ws://0.0.0.0:9090');
 
///////////////////ros 상태 관련 구문///////////////////
// ros와의 연결 상태에 따라 상단 액션바의 색깔이 녹색, 회색, 빨간색으로 변동됩니다.
 
// 이상이 생길 경우 다음 구문이 실행됩니다.
ros.on('error', function (error) {
  console.log(error);
});
 
// 정상 연결
ros.on('connection', function () {
  console.log('Connection made!');
});
 
// 연결 닫힘
ros.on('close', function () {
  console.log('Connection closed.');
});

//subscriber 토픽
var display = new ROSLIB.Topic({
  ros : ros,
  name : '/board/display',
  messageType : 'board/display_info'
});
//display info
let player;
let agents;
let lcookies;
let scookies;
let block;
let ghost;

var selecting_menu;
var score;
var life;
var map_row;
var map_col;
var pixel_size = 20;


//subscribe function
var a =0;
display.subscribe(function(message) {
  player = message.player_axis;
  agents = message.agents_axis;
  lcookies = message.lcookies_loc;
  scookies = message.scookies_loc;
  block = message.block;
  ghost = message.ghost;
  selecting_menu = message.selecting_menu;
  score = message.score;
  life = message.life;
  map_row = message.map_row;
  map_col = message.map_col;

  // a++;
  // if(a>3){
  // display.unsubscribe();
  // }
});

//image parsing
var pacman = new Array(4);
var t;
for(t = 0; t < 4; t++){
  pacman[t] = new Image();
}
pacman[0].src = "Custom/image/pacman_left.png";
pacman[1].src = "Custom/image/pacman_up.png";
pacman[2].src = "Custom/image/pacman_right.png";
pacman[3].src = "Custom/image/pacman_down.png";

var agent_imgs = new Array(4);

var ghost_imgs = new Image();
ghost_imgs.src = "Custom/image/ghost_small.png";


var color = ["red","blue","pink","orange"];
for(t = 0; t < 4; t++){
  agent_imgs[t] = new Array(4);
  var a;
  for(a = 0; a < 4; a++){
    agent_imgs[t][a] = new Image();
  }
  agent_imgs[t][0].src = "Custom/image/"+color[t]+"_left.png";
  agent_imgs[t][1].src = "Custom/image/"+color[t]+"_up.png";
  agent_imgs[t][2].src = "Custom/image/"+color[t]+"_right.png";
  agent_imgs[t][3].src = "Custom/image/"+color[t]+"_down.png";
}



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
    ctx.clearRect(0,0,1000,1000);
    ctx.fillStyle = "black";
    ctx.fillRect(0,0,pixel_size*map_col,pixel_size*map_row);
    var i;
    
    //block
    if(typeof block !== 'undefined'){
      for(i = 0 ; i < block.length; i++){
      ctx.save();
      ctx.translate((block[i].col - 1)*pixel_size, (block[i].row - 1)*pixel_size);
      ctx.fillStyle = "#0022ff";
      ctx.fillRect(0, 0, pixel_size, pixel_size);
      ctx.fillStyle = "#000";
      ctx.fillRect(pixel_size*0.15, pixel_size*0.15, pixel_size*0.7, pixel_size*0.7);
      //ctx.stroke();
      ctx.restore();
      }
    }

    if(typeof scookies !== 'undefined'){
      for(i = 0 ; i < scookies.length; i++){
      ctx.save();
      ctx.translate((scookies[i].col - 1)*20, (scookies[i].row - 1)*20);
      ctx.fillStyle = "yellow";
      ctx.beginPath();
      ctx.arc(pixel_size/2, pixel_size/2, pixel_size*0.1, 0, Math.PI*2);
      ctx.fill();
      ctx.closePath();
      ctx.restore();
      }
    }

    if(typeof lcookies !== 'undefined'){
      for(i = 0 ; i < lcookies.length; i++){
      ctx.save();
      ctx.translate((lcookies[i].col - 1)*20, (lcookies[i].row - 1)*20);
      ctx.fillStyle = "yellow";
      ctx.beginPath();
      ctx.arc(pixel_size/2, pixel_size/2, pixel_size*0.25, 0, Math.PI*2);
      ctx.fill();
      ctx.closePath();
      ctx.restore();
      }
    }
    
    //player display
    if(typeof player !== 'undefined'){
      for(i = 0 ; i < player.length; i++){
      ctx.save();
      ctx.translate((player[i].col-1)*pixel_size, (player[i].row-1)*pixel_size);
      //ctx.rotate((Math.PI/180) * ((player[i].direction * 90) + 90));
      ctx.drawImage(pacman[player[i].direction-1],0,0);
      ctx.restore();
      }
    }
    //agent display
    if(typeof agents !== 'undefined'){
      for(i = 0 ; i < agents.length; i++){
      ctx.save();
      ctx.translate((agents[i].col-1)*pixel_size, (agents[i].row-1)*pixel_size);
      //ctx.rotate((Math.PI/180) * ((agents[i].direction * 90) + 90));
      if(ghost[i] == 0) //not ghost
        ctx.drawImage(agent_imgs[i][agents[i].direction-1],0,0);
      else if(ghost[i] == 1)  //ghost
        ctx.drawImage(ghost_imgs,0,0);
      ctx.restore();
      }
    }
    ctx.save();
    
    ctx.restore();
    

    start=null;
  }
  window.requestAnimationFrame(step);
  
}

window.requestAnimationFrame(step);


