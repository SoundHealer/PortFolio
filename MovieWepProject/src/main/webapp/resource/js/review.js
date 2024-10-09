	
	    
		function setStar(){
			var rangeValue = document.getElementById(event.target.id).value;

			var image = document.getElementById(event.target.name);
			var result = calculateWidthFromPercentage(rangeValue,image);

			var clipValue = "rect(0, " + result.width + ", " + result.height + ", 0)";
			
			image.style.clip = clipValue;
		}
		function scoreSetting(element){
	    	var rangeValue = document.getElementById(element.id).value;
			var image = document.getElementById(element.name);
			var result = calculateWidthFromPercentage(rangeValue,image);
			var clipValue = "rect(0, " + result.width + ", " + result.height + ", 0)";
			
			image.style.clip = clipValue;
		}
		
		function calculateWidthFromPercentage(value,img) {
			
			var height = parseInt(getComputedStyle(img).height) + "px";
			var currentWidth = parseFloat(getComputedStyle(img).width);

			var width = parseInt(currentWidth * (value / 10)) + "px";

			return {width, height};
		}
		window.onload = function(){
			//setStar();
		}