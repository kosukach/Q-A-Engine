import $ from "jquery";

$("document").ready(function() {
    $(".rate-answer").on("click", function(e) {
        e.preventDefault()
        let container = $(this).parent()
        let answerId = container.attr("answer_id");
        let questionId = container.attr("question_id");
        let userId = container.attr("user_id");
        let status = container.attr("status");
        let csrf = $(this).attr("csrf");
        let action = $(this).attr("action");
        
        let req = $.ajax({
            url: "/answer",
            type: "POST",
            data: {
                
                answer_id: answerId,
                question_id: questionId,
                user_id: userId,
                action: action,
                status: status
            },
            beforeSend: function(xhr){
                xhr.setRequestHeader("x-csrf-token", csrf)
            }
            
        });
        req.done(function(data){
            
            $(`#score-p-${answerId}`).text(`${data.new_score}`);

            if(status == action){
                container.attr("status", "neither");
                $(".like-answer").attr("src", "/images/white-like-arrow.png")
                $(".dislike-answer").attr("src", "/images/white-dislike-arrow.png")
            }else{
                container.attr("status", action)
                if(action == "dislike"){
                    $(".like-answer").attr("src", "/images/white-like-arrow.png")
                    $(".dislike-answer").attr("src", "/images/dislike-arrow.png")

                }else if(action == "like"){
                    $(".like-answer").attr("src", "/images/like-arrow.png")
                    $(".dislike-answer").attr("src", "/images/white-dislike-arrow.png")
                    
                }
            }
            
        });
        
    })


    $(".delete-answer").on("click", function(e){

        let id = $(this).attr("answer_id");
        let csrf = $(this).attr("csrf");

        let req = $.ajax({
            url: "/answer",
            type: "DELETE",
            data: {
                id: id,
                
            },
            beforeSend: function(xhr){
                xhr.setRequestHeader("x-csrf-token", csrf)
            }
            
        });

        req.done(function(data){
            console.log(data)
            $(`#answer-${id}`).css("display", "none");
        });
    })
})