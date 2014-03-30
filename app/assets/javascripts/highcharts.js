$.highcharts = {
	chart: null,

	defaults: {
		lang: {
			loading: 'Aguarde...',
			months: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
			weekdays: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
			shortMonths: ['Jan', 'Feb', 'Mar', 'Abr', 'Maio', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
			exportButtonTitle: "Exportar",
			printButtonTitle: "Imprimir",
			rangeSelectorFrom: "De",
			rangeSelectorTo: "Até",
			rangeSelectorZoom: "Periodo",
			downloadPNG: 'Download imagem PNG',
			downloadJPEG: 'Download imagem JPEG',
			downloadPDF: 'Download documento PDF',
			downloadSVG: 'Download imagem SVG'
		}, 	

		chart: {
			renderTo: "chart", //For this to work, we need to have a element with chart id in the page.
			type: 'column',
			width: '800'
		},

		xAxis: {
			type: 'datetime',
			labels: {
				formatter: function() {
					// return Highcharts.dateFormat('%e %b %y', this.value);
					return this.value;
				}
			}
		},

		yAxis: {
			min: 0
		},

		credits: {
			enabled: false
		},

		exporting: {
			enabled: false
		}, 

		legend: {
			enabled: true,
			align: 'right',
			verticalAlign: 'top',
			layout: 'horizontal',
			y: 10,
			itemStyle: {
				color: '#000',
				fontSize: '12px'
			},
			itemHoverStyle: {
				color: '#009ee0'
			},
			borderWidth: 0,
			floating: true
		},

		tooltip: {
			formatter: function() {
			var color = this.points[0].series.color,
					year = this.x,
					movies = this.y
			return '<span style="color:' + color + '; font-weight: bold;">Ano:</span>' + year + '<br/><span style="color:' 
				+ color + '; font-weight: bold;">Filmes:</span>' + movies;
			}
		},

		rangeSelector: {
			selected: 0,
			inputEnabled: false,
			buttons: [{
				type: 'month',
				count: 3,
				text: '3 meses'
			},{
				type: 'month',
				count: 6,
				text: '6 meses'
			},{
				type: 'ytd',
				text: 'Ano até hoje'
			},{
				type: 'year',
				count: 1,
				text: '1 ano'
			}],
			buttonTheme: {
				width: 80
			},
			inputDateFormat: '%Y-%m-%d'
		}
	},

	stock_chart_init: function(data, seriesNames) {
		Highcharts.setOptions($.highcharts.defaults);

		var data = { 
			series: $.highcharts.buildSeriesFromData(data, seriesNames)
		};

		var options = $.extend({}, $.highcharts.defaults, data);
		$.highcharts.chart = new Highcharts.StockChart(options);
		return $.highcharts.chart
	},

	buildSeriesFromData: function(data, seriesNames) {
		var seriesList = [];
		if (seriesNames instanceof Array) {
			$(seriesNames).each(function(index) {
				serie = {
					name: seriesNames[index],
					// data: data[index],
					data: $.highcharts.addCreatorNameToPoint(data[index]),
					marker : {
						enabled : true,
						radius : 3
					},
					shadow: true
				};
				seriesList.push(serie);
			})
		} else {
			serie = {
				name: seriesNames,
				cursor: 'pointer',
				point: {
					events: {
						click: function() {
							$.movies.displayMoviesOfYear(this.x)
						}
					}
				},
				data: $.highcharts.addCreatorNameToPoint(data),
				marker : {
					enabled : true,
					radius : 3
				},
				shadow: true
			};

			seriesList.push(serie)
		}
		return seriesList;
	},

	addCreatorNameToPoint: function(dataInIndex) {
		var pointsArray = [];
		$(dataInIndex).each(function(index) {
			pointsArray.push({x: dataInIndex[index][0], y: dataInIndex[index][1], name: dataInIndex[index][2]})
		});
		return pointsArray;
	},

	centerGraph: function(point_date, graph_dates) {
	  //TODO parametrizar este intervalo (actualmente em 4 meses (validar se sao 4 meses))
	  var begin_date = new Date(point_date);
	  begin_date = begin_date.setMonth(begin_date.getMonth()-4);

	  var end_date = new Date(point_date);
	  end_date = end_date.setMonth(end_date.getMonth()+4);

	  var min_date = Math.min.apply( Math, graph_dates );
	  var max_date = Math.max.apply( Math, graph_dates );

	  //check if begin_date/end_date are lower/higher than min date/max date and handle this
	  if (begin_date < min_date) {
	  	begin_date = min_date;
	  }

	  if (end_date > max_date) {
	  	end_date = max_date;
	  }
	  $.highcharts.chart.xAxis[0].setExtremes(begin_date, end_date,true,true);

	  $.highcharts.setHighStockTooltip(point_date);
	},

	setHighStockTooltip: function(point_date) {
		var index = $.highcharts.getPointIndex(point_date);
	  if($.highcharts.chart.series[1].name === 'Navigator'){
	    $.highcharts.chart.tooltip.refresh([
	      $.highcharts.chart.series[0].points[index]
	    ]);
	  }else{
	    $.highcharts.chart.tooltip.refresh([
	      $.highcharts.chart.series[0].points[index],
	      $.highcharts.chart.series[1].points[index]
	    ]);
	  }
	},

	getPointIndex: function(point_date) {
  for(i = 0; i < $.highcharts.chart.series[0].points.length; i++){
    if ($.highcharts.chart.series[0].points[i].x == point_date) {
      return i;
    }
  }
}
}