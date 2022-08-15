var app = new Vue({
    el: '#app', 
    data: {
        OPENED: false,
        APPLICATION: '',
        PRESSED:false,
        USERTABLES: [  
          
        ], 
    },
   
    methods: {        
        SendCoods(coords, id){
            $.post('https://lb_deathalert/markubi', JSON.stringify({x : coords.x, y : coords.y, id:id}));
        
        }
    }
})

var starter = false

$(function(){
    window.addEventListener('message', function(event){
        let DATA = event.data 
        
        if(DATA.SHOW == true){
            app.OPENED = true
        } else if(DATA.SHOW == false){
            app.OPENED = false
        }

        if(DATA.OPEN == true && starter){
        app.OPENED = DATA.OPEN
        $.post('https://lb_deathalert/onmenu', JSON.stringify({}));
        starter = true
        }else if (DATA.OPEN == true && !starter){
            app.OPENED = DATA.OPEN
        }

        if(DATA.ACTION == 'open' ){
            app.USERTABLES = DATA.USERTABLES
        }
        if(DATA.ACTION == 'close') {
            app.OPENED = false 
           
        }
        if(DATA.PRESSED == true){
            app.PRESSED = DATA.PRESSED
           
        }
           
        
    })
    document.addEventListener('keydown', (e) => {
        if (e.key === "Escape") {
            /*app.OPENED = false*/
            $.post('https://lb_deathalert/escape', JSON.stringify({}));
        } 
        console.log(JSON.stringify(e.keyCode))
        if (e.keyCode === 118) {
            if(app.PRESSED == true){
            $.post('https://lb_deathalert/coma', JSON.stringify({}));
            app.PRESSED = false
            }
        }
    })
})

