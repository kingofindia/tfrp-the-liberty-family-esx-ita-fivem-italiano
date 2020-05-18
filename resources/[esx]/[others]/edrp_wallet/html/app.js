window.addEventListener('message', function(event) {

    let wallet = event.data.wallet;
    let blackMoney = event.data.black_money;
    let bank = event.data.bank;
    let society = event.data.society;
    let control = event.data.control;

    $("#bank").text(bank);
    $("#wallet").text(wallet);
    $("#blackMoney").text(blackMoney);
    $("#society").text(society);

    let display = false;

    if (event.data.action == 'open') {
        
        $('wrapperHUD').css({"display":"none"});
        display = false;
        $('#wallet, #blackMoney').show();
        $('#wrapperHUD').animate({
                marginLeft: "-8px",
                opacity: "1.0"
            },
            0,
            function() {
            });
    }

    if (event.data.action == 'close') {
        window.setTimeout(function() {
            display = true;
            $('#wrapperHUD').animate({
                    marginLeft: "200vw",
                    opacity: "0"
                },
                0,
                function() {
                });
        })

      }
      document.onkeyup = function(data){
        if (data.which == 27 || data.which == 8){
            window.setTimeout(function() {
                $('#wrapperHUD').animate({
                        marginLeft: "200vw",
                        opacity: "0"
                    },
                    0,
                    function() {
                    });
            })
            $.post('http://edrp_wallet/NUIFocusOff', JSON.stringify({}));
        }
    }


    $(document).ready(function(){
        $("#idkort").click(function(){
            window.setTimeout(function() {
                $('#wrapperHUD').animate({
                        marginLeft: "200vw",
                        opacity: "0"
                    },
                    0,
                    function() {
                    });
                    
                    $('#wrapperHUD').animate({
                        marginLeft: "200vw",
                        opacity: "0"
                    },
                    0,
                    function() {
                    });
                    $.post('http://edrp_wallet/idselect', JSON.stringify({}));
            })
        });
      });

      $(document).ready(function(){
        $("#kontant").click(function(){
            window.setTimeout(function() {
                $('#wrapperHUD').animate({
                        marginLeft: "200vw",
                        opacity: "0"
                    },
                    0,
                    function() {
                    });
                    $('#wrapperHUD').animate({
                        marginLeft: "200vw",
                        opacity: "0"
                    },
                    0,
                    function() {
                    });
                    $.post('http://edrp_wallet/cash', JSON.stringify({}));
                    
                   
            })
        });
      });

      $(document).ready(function(){
        $("#kreditkort").click(function(){
            window.setTimeout(function() {
                $('#wrapperHUD').animate({
                        marginLeft: "200vw",
                        opacity: "0"
                    },
                    0,
                    function() {
                    });
            })
            $('#wrapperHUD').animate({
                marginLeft: "200vw",
                opacity: "0"
            },
            0,
            function() {
            });
          $.post('http://edrp_wallet/bank', JSON.stringify({}));
        });
      });

      
      
});