

function setup() {
    $(".dropdown-trigger").dropdown({coverTrigger: false, closeOnClick: false});
    $("select").material_select();
    $(".modal").modal();
    $(".tooltipped").tooltip();
    $("#bgg_game_search").submit(function(e){
        e.preventDefault();
        $.ajax({
            url: $(this).attr("action"),
            data: $(this).serialize(),
            method: "post",
            success: function(res){
                $("#search_results").html(res);
            }
        });
    });
    $(".submit_rating").click(function(e){
        var form_id = $(this).attr("form-target")
        $.ajax({
            url: $(form_id).attr("action"),
            data: $(form_id).serialize(),
            method: "post",
            success: function(res){
                $(form_id).siblings(".form_result").text(res);
            }
        });
    });
}

$(document).ready(setup);
$(document).on('turbolinks:load', setup);