import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;
import BxtClient 1.0

App {

    property bool 		debugOutput: false
	property url 		tileUrl : "VariTile1.qml"
	property 			VariTile1 variTile1
	
	property url 		tileUrl2 : "VariTile2.qml"
	property 			VariTile2 variTile2
	
	property url 		tileUrl3 : "VariTile3.qml"
	property 			VariTile3 variTile3
	
	property url 		variScreenUrl : "VariScreen.qml"
	property			VariScreen  variScreen

	//property url 		thumbnailIcon: "qrc:/tsc/refresh.png     "
	property url 		thumbnailIcon: ("qrc://apps/eMetersSettings/drawables/display-graphs.svg") 

	
	property real		currentPriceRaw : 0
	property string		currentPrice : ""
	property string		lastUpdate : ""
	property variant 	prices: []
	property variant 	prices10: []
	property variant 	pricesToday10: []
	property variant 	xAxisValues: []
	property variant 	xAxisValuesToday: []
	
	property string 	dateTimeNextStr
	property string 	dateTimeNowStr
	property string		pwrUsageUuid
	
	property string		fromdate
	property string		tilldate
	
	property string		oldHour
	property string		newHour
	
	property real 		electricUsedThisDay:0
	property real 		priceElectricUsedThisDay:0
	
	property real 		electricUsedtillThisHour:0
	property real 		priceelectricUsedtillThisHour:0
	
	property real 		lastHourValue:0
	property real 		lastHourValuePrice:0
	
	property real 		maxValue:1
	property string 	p1Uuid
	
	property real 		todayStartPower:0
	property real 		todayPower:0
	
	property real 		previousHourValue:0
	property real 		thisHourPower:0
	property real 		thisHourCost:0
	property real 		todayCost:0
	property real 		todayTemp:0
		
	signal 				valuesUpdated()	

	


	function init() {
		registry.registerWidget("tile", tileUrl, this, "variTile1", {thumbLabel: qsTr("variEnergy 1"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"})
		registry.registerWidget("screen", variScreenUrl, this, "variScreen")
	    registry.registerWidget("tile", tileUrl2, this, "variTile2", {thumbLabel: qsTr("variEnergy 2"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"})
		registry.registerWidget("tile", tileUrl3, this, "variTile3", {thumbLabel: qsTr("variEnergy 3"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"})
	}

	Component.onCompleted: {
		variInfoTimer.running =true
		getUsageTimer.running =true
	}
	

	function sleep(milliseconds) {
      var start = new Date().getTime();
      while ((new Date().getTime() - start) < milliseconds )  {
      }
    }


	function getVariprices(){
		if (debugOutput) console.log("*********variEnergy getVariprices() (getdates)")
		prices10 = []
		prices = []
		xAxisValues = []
		pricesToday10 = []
		xAxisValuesToday =[]
	
		var dateTimeNow= new Date()
		dateTimeNowStr = dateTimeNow.toString()
		var dtime = parseInt(Qt.formatDateTime (dateTimeNow,"hh") + "" + Qt.formatDateTime (dateTimeNow,"mm"))
		var dday = dateTimeNow.getDate()
		var dyear = "20" + parseInt(Qt.formatDateTime(dateTimeNow,"yy"))
		var dmonth = parseInt(Qt.formatDateTime(dateTimeNow,"MM")) 
		var hrs = parseInt(Qt.formatDateTime(dateTimeNow,"hh"))
		var mins = parseInt(Qt.formatDateTime(dateTimeNow,"mm"))

		var milliSecondsLeftToNewHour = (61-mins)*60 * 1000
		variInfoTimer.interval = milliSecondsLeftToNewHour

		dateTimeNowStr = hrs  + ":00"

		var dateTimeTomorrow= new Date(new Date().getTime() + 24 * 60 * 60 * 1000)
		var ttime = parseInt(Qt.formatDateTime (dateTimeTomorrow,"hh") + "" + Qt.formatDateTime (dateTimeTomorrow,"mm"))
		var tday = dateTimeTomorrow.getDate()
		var tyear = "20" + parseInt(Qt.formatDateTime(dateTimeTomorrow,"yy"))
		var tmonth = parseInt(Qt.formatDateTime(dateTimeTomorrow,"MM")) 
		var thrs = parseInt(Qt.formatDateTime(dateTimeTomorrow,"hh"))

		dateTimeNextStr = thrs  + ":00"
		
		if(mins.length <2 ) mins = "0" + mins
		lastUpdate = hrs + ":" + mins
		
		for (var i = 0; i < 5; i++) {
			var dateTimeNew= new Date(new Date().getTime() + (6*i) * 60 * 60 * 1000)
			var hrsNew = parseInt(Qt.formatDateTime(dateTimeNew,"hh")) + ":00"
			xAxisValues.push(hrsNew)
		}
		
		for (var i = 0; i < 5; i++) {
			var hrsNewToday = (6*i) + ":00"
			xAxisValuesToday.push(hrsNewToday)
		}

		if (hrs === 0){
			if (debugOutput) console.log("*********variEnergy hrs = 0: " + hrs);
			electricUsedThisDay=0
			priceElectricUsedThisDay=0
			electricUsedtillThisHour = 0
			priceelectricUsedtillThisHour = 0
			lastHourValue = 0
			lastHourValuePrice = 0
			todayStartPower = 0
		}

		var fromdate0 = dyear + "-" + dmonth + "-" + dday + "T0"
		var tilldate0 = tyear + "-" + tmonth + "-" + tday + "T0"
		getVaripricesToday(fromdate0, tilldate0)
		
		fromdate = dyear + "-" + dmonth + "-" + dday + "T" + hrs
		var tilldate = tyear + "-" + tmonth + "-" + tday + "T" + thrs 
		getVaripricesFromNow(fromdate, tilldate)
		
	}


    function getVaripricesToday(fromdate, tilldate){
		if (debugOutput) console.log("*********variEnergy getVaripricesToday()")
		if (debugOutput) console.log("*********variEnergy fromdate: " + fromdate);
		if (debugOutput) console.log("*********variEnergy tilldate: " + tilldate);
		
        var xhr = new XMLHttpRequest();
        xhr.withCredentials = true;
        //xhr.open("GET", "https://api.energyzero.nl/v1/energyprices?fromDate=2023-4-8T00%3A00%3A00.000Z&tillDate=2023-4-9T21%3A59%3A59.999Z&interval=4&usageType=1&inclBtw=true");
        xhr.open("GET", "https://api.energyzero.nl/v1/energyprices?fromDate=" + fromdate + "%3A00%3A00.000Z&tillDate=" + tilldate + "%3A59%3A59.999Z&interval=4&usageType=1&inclBtw=true");
        //xhr.open("GET", "http://192.168.10.230/variable.json");

		xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = function() {
            if( xhr.readyState === 4){
                if (xhr.status === 200 || xhr.status === 300  || xhr.status === 302) {
                    if (debugOutput) console.log("*********variEnergy xhr.responseText getVaripricesToday : " + xhr.responseText)
                    var JsonString = xhr.responseText
                    var JsonObject= JSON.parse(JsonString)
					var priceVari
					for (var i = 0; i < 24; i++) {
						if(JsonObject.Prices[i]){
							priceVari = JsonObject.Prices[i].price
						}else{
							priceVari = 0
						}
						pricesToday10.push(priceVari*10)
					}
/*                    for (var a in JsonObject.Prices){
						priceVari = JsonObject.Prices[a].price
						pricesToday10.push(priceVari*10)
					}
*/
					if (debugOutput) console.log("*********variEnergy pricesToday10 getVaripricesToday: " + JSON.stringify(pricesToday10));
					valuesUpdated()
                }
            }
        }
        xhr.send()
    }
	


    function getVaripricesFromNow(fromdate, tilldate){
		if (debugOutput) console.log("*********variEnergy getVaripricesFromNow")
		
        var xhr = new XMLHttpRequest();
        xhr.withCredentials = true;
        //xhr.open("GET", "https://api.energyzero.nl/v1/energyprices?fromDate=2023-4-8T00%3A00%3A00.000Z&tillDate=2023-4-9T21%3A59%3A59.999Z&interval=4&usageType=1&inclBtw=true");
        xhr.open("GET", "https://api.energyzero.nl/v1/energyprices?fromDate=" + fromdate + "%3A00%3A00.000Z&tillDate=" + tilldate + "%3A59%3A59.999Z&interval=4&usageType=1&inclBtw=true");
        //xhr.open("GET", "http://192.168.10.230/variable.json");

		xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = function() {
            if( xhr.readyState === 4){
                if (xhr.status === 200 || xhr.status === 300  || xhr.status === 302) {
                    if (debugOutput) console.log("*********variEnergy xhr.responseText getVaripricesFromNow : " + xhr.responseText)
                    var JsonString = xhr.responseText
                    var JsonObject= JSON.parse(JsonString)
					var priceVari
					for (var i = 0; i < 24; i++) {
						if (debugOutput) console.log("*********variEnergy xhr.responseText checking : " + "Prices["+i+"].price")
						if(JsonObject.Prices[i]){
							if (debugOutput) console.log("*********variEnergy found : " + "Prices["+i+"].price")
							priceVari = JsonObject.Prices[i].price
						}else{
							if (debugOutput) console.log("*********variEnergy not found : " + "Prices["+i+"].price")
							priceVari = 0
						}
						prices.push(priceVari)
						prices10.push(priceVari*10)
					}

 /*                   for (var a in JsonObject.Prices)
					{
						priceVari = JsonObject.Prices[a].price
						prices.push(priceVari)
						prices10.push(priceVari*10)
					}
*/



					if (debugOutput) console.log("*********variEnergy prices10 getVaripricesToday: " + JSON.stringify(prices10));
					currentPriceRaw = JsonObject.Prices[0].price
					currentPrice = currentPriceRaw
					currentPrice = currentPrice.replace(".",",")
					maxValue = Math.max.apply(null, prices);
					valuesUpdated()
					setTariffElec(currentPriceRaw)
                }
            }
        }
        xhr.send()
    }
	

	
	function parseUsageDataset(msg, varName, initVar) {
		if (debugOutput) console.log("*********variEnergy parseUsageDataset (BXT) msg : " + msg);
		var node = msg.child;
		var totalReading = 0
		while (node) {
			//if (debugOutput) console.log("*********variEnergy " + node.name + " : " + parseFloat(node.text));
			if(node.name === "meterReading"){
				totalReading = totalReading +  parseFloat(node.text)
				if (debugOutput) console.log("*********variEnergy Reading NT (BXT) : " + parseFloat(node.text));
			}
			if(node.name === "meterReadingLow"){
				totalReading = totalReading +  parseFloat(node.text)
				if (debugOutput) console.log("*********variEnergy Reading LT (BXT) : " + parseFloat(node.text));
			}
			node = node.sibling;
		}

		if (todayStartPower == 0) {
			todayStartPower = totalReading
			previousHourValue = totalReading
			todayPower = 0
			todayCost = 0
			todayTemp = 0
		} else {
			todayPower = totalReading - todayStartPower
			var dateTimeNow= new Date()
			newHour = parseInt(Qt.formatDateTime(dateTimeNow,"hh"))
		
			if (newHour === oldHour){
				if (debugOutput) console.log("*********variEnergy hrs is not a new hour (BXT) ");
				thisHourPower = totalReading - previousHourValue
				thisHourCost = parseFloat(thisHourPower/1000 * currentPriceRaw).toFixed(2)
				todayCost = (todayTemp + thisHourCost).toFixed(2)
			}else{
				if (debugOutput) console.log("*********variEnergy hrs is a new hour (BXT) ");
				todayCost = (todayTemp + thisHourCost).toFixed(2)
				todayTemp = todayCost
				previousHourValue = totalReading
				thisHourPower = 0
				thisHourCost = 0
				if (newHour === 0) {//new day
					if (debugOutput) console.log("*********variEnergy hrs is a new day (BXT) ");
					todayStartPower = totalReading
					todayPower = 0
					todayCost = 0
					todayTemp = 0
				}
				oldHour = newHour
			}
		}
		if (debugOutput) console.log("*********variEnergy totalReading (BXT) : " + totalReading);
		if (debugOutput) console.log("*********variEnergy currentPriceRaw (BXT) : " + currentPriceRaw.toFixed(2));
		if (debugOutput) console.log("*********variEnergy thisHourPower (BXT) : " + thisHourPower);
		if (debugOutput) console.log("*********variEnergy thisHourCost (BXT) : " + thisHourCost);
		if (debugOutput) console.log("*********variEnergy todayPower (BXT) : " + todayPower);
		if (debugOutput) console.log("*********variEnergy todayCost (BXT) : " + todayCost);
		valuesUpdated()	
	}
	
	
	
	function setTariffElec(tariff){
		var msg = bxtFactory.newBxtMessage(BxtMessage.ACTION_INVOKE, pwrUsageUuid, "specific1", "BaseData");
		msg.addArgumentXmlText("<BaseField><Type>POWER</Type><SeparateBilling>true</SeparateBilling><TariffPeak>" + tariff+ "</TariffPeak><TariffOffPeak>" + tariff+ "</TariffOffPeak></BaseField>");
		bxtClient.sendMsg(msg);
	}

	Timer {
		id: variInfoTimer
		interval: 6000
		triggeredOnStart: true
		running: false
		repeat: true
		onTriggered: {
			getVariprices()
		}
	}
	
	Timer {
		id: getUsageTimer
		interval: 10000
		triggeredOnStart: true
		running: false
		repeat: true
		onTriggered: {
			getUsageTimer.interval=20000
			var dateTime= new Date(new Date().getTime() - 24 * 60 * 60 * 1000) 
			if (debugOutput) console.log("*********variEnergy testBXT(): " + dateTime);
		}
	}
	
	BxtDiscoveryHandler {
		id: pwrusageDiscoHandler
		deviceType: "happ_pwrusage"
		onDiscoReceived: {
				pwrUsageUuid = deviceUuid;
		}
	}
	
	BxtDatasetHandler {
		id: powerUsageDataset
		dataset: "powerUsage"
		discoHandler: pwrusageDiscoHandler
		onDatasetUpdate: parseUsageDataset(update, "powerUsageData", 2)
	}
	
	
	BxtDiscoveryHandler {
		id: p1DiscoHandler
		deviceType: "hdrv_p1"
		onDiscoReceived: {
			p1Uuid = deviceUuid;
		}
	}
		
}
