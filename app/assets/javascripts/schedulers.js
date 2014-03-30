$.schedulers = {

	onAirProgressIntervaller: null,

	init: function(date) {
		var picker = $("#datetimepicker").datepick({
			defaultDate: new Date(date),
	    minDate: new Date(2012, 2, 1),

			onSelect: function(dates) { 
				var _date = dates[0];
				var dateStr = "" + _date.getFullYear() +"-" + (_date.getMonth() + 1) + "-" + _date.getDate();
				$("#new_date_query").attr("href", "/schedules/of_day?date=" + dateStr);
				$("#new_date_query")[0].click();
			}, 
		});
	},

	startMovieOnAirProgress: function(id, start, end, movieName) {
		var $progDiv = $("#progress_div_" + id),
		    $progSpan = $("#span_percentage_" + id),
				fullMoviePercentage = 100,
		    movieTimeInMinutes = (end - start) / 1000 / 60,
				now, percentage;

		var movieTime = convertMinutesToHourAndMinutes((end - start) / 1000 / 60);

		$.schedulers.onAirProgressIntervaller = setInterval(function() {
			now = new Date().addHours(-1 * new Date().getTimezoneOffset() / 60).getTime();
			// now = new Date().getTime();
			percentage = parseFloat(((now - start) / (end - start) * 100)).toFixed(2);
			var $marquee = $("#on_air_marqee_element");

			if(percentage < fullMoviePercentage && percentage > 0) {
				var elapsedTime = convertMinutesToHourAndMinutes(parseInt((now - start) / 1000 / 60));
				$progDiv.parent().parent().show();
				$progDiv.css("width", percentage + "%");
				$progSpan.text(elapsedTime + " de " + movieTime + " (" + percentage + "%)");
				$("#schedule_progress_bar_" + id).prev().hide();
				$("#schedule_progress_bar_"+ id).closest("li").find("img.on_air_image").show();
				
				if($marquee.data("movie_id") != id) {
					$marquee.data("movie_id", id).text("Agora no ar: " + movieName);
				}

			} else {
				if (percentage > fullMoviePercentage) {
					$("#schedule_progress_bar_"+ id).closest("li").find("img.on_air_image").hide();
					$("#schedule_progress_bar_" + id).prev().show();
					$progDiv.parent().hide();
					clearInterval($.schedulers.onAirProgressIntervaller);
				}
			}
		}, 1000);
	},

}