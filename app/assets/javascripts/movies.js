$.movies = {

	load: function() {
		$(window).scrollBottom(function(e) {
      var $endlessPaginationLink = $('#endless_pagination_link');
      if ($endlessPaginationLink.length > 0) $endlessPaginationLink.click();
    }, 175);
	},

	toggleYoutube: function(movieId) {
		var $el = $("#movie_" + movieId + "_youtube");
		$el.toggle();
		$.movies.hideActorOrYoutubeEl("actors", movieId);
		$el.parent().toggleClass("youtube_visible");
	},

	toggleActors: function(movieId) {
		var $el = $("#movie_" + movieId + "_actors");
		$el.toggle();
		$.movies.hideActorOrYoutubeEl("youtube", movieId);
		$el.parent().toggleClass("actors_visible");
	},

	displayActorOrYoutubeEl: function(elementName, movieId) {
		var $el = $("#movie_" + movieId + "_" + elementName);
		$el.addClass(elementName + "_visible");
		$el.show();
	},

	hideActorOrYoutubeEl: function(elementName, movieId) {
		var $el = $("#movie_" + movieId + "_" + elementName);
		$el.removeClass(elementName + "_visible");
		$el.hide();
	},

	refreshMovie: function(refreshImageButton, element, movieId) {
		var $el = $(element);
		$el.find("img").attr("src", "/assets/fancy_spinner.gif");
		$.ajax({
			dataType:"JSON",
			url: "/movies/" + movieId + "/refresh",
			success: function(data, textStatus, jqXHR) {
				$el.find("img").attr("src", data.image);
				$el.removeClass("no_image_yet");
				$(refreshImageButton).remove();
			}, 
			error: function(data, textStatus, jqXHR) {
				$el.attr("src", "/assets/refresh.png");
			}
		});
	},

	displayMoviesOfYear: function(year) {
		$.ajax({
      type: 'GET',
      url: '/statistics/movies_of_year?year=' + year,
      dataType: "script",
    });
	},
}