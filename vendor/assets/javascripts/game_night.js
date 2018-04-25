var loading_spinner = '<div class="preloader-wrapper big active"><div class="spinner-layer spinner-blue"><div class="circle-clipper left"><div class="circle></div></div><div class="gap-patch"><div class="circle"></div></div><div class="circle-clipper right"><div class="circle"></div></div></div></div>'

function setup() {
    $(".dropdown-trigger").dropdown({coverTrigger: false, closeOnClick: false});
    $("select").material_select();
    $(".modal").modal();
    $(".tooltipped").tooltip();
    $(".collapsible").collapsible();
    $(".bgg_search").submit(function(e){
        e.preventDefault();
        $("#search_results").html(loading_spinner);
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
    $("#random_game_form").submit(function(e){
        e.preventDefault();
        $.ajax({
            url: $(this).attr("action"),
            method: "post",
            data: $(this).serialize(),
            success: function(res){
                $("#random_game").html(res);
                $(".materialboxed").materialbox();
            }
        });
    });
}

// $(document).ready(setup);
$(document).on('turbolinks:load', setup);