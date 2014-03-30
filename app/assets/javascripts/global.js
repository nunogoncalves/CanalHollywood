function convertMinutesToHourAndMinutes(min) {
  var hours = padWithLeftZeroIfLessThan10(Math.floor(min / 60));
  var minutes = padWithLeftZeroIfLessThan10((min % 60));
  return  hours + ":" + minutes
}

function padWithLeftZeroIfLessThan10(val) {
  return parseInt(val) < 10 ? "0" + val : "" + val;
}


function convertDateToUTC(date) { 
	return new Date(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate(), date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds()); 
}

Date.prototype.addHours= function(h){
    this.setHours(this.getHours()+h);
    return this;
}
