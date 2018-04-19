

function setup() {
    $(".dropdown-trigger").dropdown({coverTrigger: false, closeOnClick: false});
    $("select").material_select();
    $(".modal").modal();
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
}

$(document).ready(setup);
$(document).on('turbolinks:load', setup);