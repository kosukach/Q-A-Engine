import $ from "jquery";

$("document").ready(function(){
    let height = $(window).height();

    $(".show-question").css({
        "min-height": `${height}px`,
        "height": "100%"
    })

    $("#create-answer-button").on("click", function(){
        $(this).css("display", "none")
        $("#answer-form-container").css("display", "block")
        
    });
    
    $("#cancel").on("click", function(e){
        e.preventDefault();
        $("#answer-form-container").css("display", "none")
        $("#create-answer-button").css("display", "block")
    })
});