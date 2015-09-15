$(document).ready(function(){
    var $arrow = $(".arrow");
    bounce();

    function bounce() {
        $arrow.animate({
            bottom: "+=9"
        }, 500, function() {
            $arrow.animate({
               bottom: "-=9"
            }, 700, function() {
                bounce();
            })
        });
    }   

    var ct = 0 
    $arrow.click(function() {
        switch (ct) {
            case 0:
            $("#text1").css("position","fixed").animate({top: "25%"}); 
            $("#text2").css("position","fixed").animate({top: "35%"});
            ct+=1;
            break;

            case 1:
            $("#text1").css("position","fixed").animate({top: -200});
            $("#text2").css("position","fixed").animate({top: -100});
            $("#text3").css("position","fixed").animate({top: "35%"});
            ct+=1;
            break;

            case 2:
            $("#text3").css("position","fixed").animate({top: -200});
            $("#text4").css("position","fixed").animate({top: "35%"});
            ct+=1;
            break;

            case 3:
            $("#text4").css("position","fixed").animate({top: -200});
            $("#text5").css("position","fixed").animate({top: "35%"});
            ct+=1;
            break;

            case 4:
            $("#text5").css("position","fixed").animate({top: -200});
            $("#email-box").css("position","fixed").animate({top: "35%"});
            $arrow.fadeOut();
            $("#timer").delay(500).fadeIn();
            ct+=1;

            var counter = 10;
            $timer = $("#timer")
              setInterval(function() {
                counter--;
                if (counter > 0) {
                    $timer.fadeOut(400, function() {
                        if(counter <= 3) {
                          $timer.css({"color":"red"});
                       }
                        $timer.html(counter).fadeIn();
                    })
                }

                // Display 'counter' wherever you want to display it.
                if (counter === 0) {
                    $timer.fadeOut()
                    $("#email-box").fadeOut()
                    // clearInterval(counter);
                }
                
                if (counter < 0) {
                    $("#try-again").css('visibility','visible').hide().fadeIn('slow');
                }



              }, 1000);
            break;

            default:
            alert('You pressed the arrows too goddamned fast bro. Slow your roll.');
            break;
        }
    });
});
