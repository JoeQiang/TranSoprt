/**
 * Created by JIAXIN on 2016/1/20.
 */
$(function(){
    $("#login2").click(function(){
        $(".login1").addClass("hidden");
        $(".login2").removeClass("hidden");
        $("#login1").removeClass("active");
        $("#login2").addClass("active");
    });
    $("#login1").click(function(){
        $(".login2").addClass("hidden");
        $(".login1").removeClass("hidden");
        $("#login2").removeClass("active");
        $("#login1").addClass("active");
    });
});

$(function(){
   $(".btnShouhuo").click(function(){
       $(this).parents().addClass("shouhuo");
   });
});