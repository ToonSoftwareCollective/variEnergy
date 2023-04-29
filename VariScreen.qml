import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

Screen {
	id: variScreen
	
	property bool isDayschreen:false
	
	onShown: {    
		//addCustomTopRightButton("Instellingen")
    }
	
	onCustomButtonClicked: {
		//stage.openFullscreen(app.solarPanelConfigScreenUrl)
	}
	
	Component.onCompleted: {
		app.valuesUpdated.connect(updateTile);
	}	

	
	function updateTile(){
		fromNowbarGraph.dataValues = app.prices10
		fromNowbarGraph.xAxisValues= app.xAxisValues
		todaybarGraph.dataValues = app.pricesToday10
		todaybarGraph.xAxisValues= app.xAxisValuesToday
	}

	
	VariBarGraph {
        id: fromNowbarGraph
        anchors {
            bottom: parent.bottom
            bottomMargin: isNxt? 100:80
            left : parent.left
            leftMargin : isNxt? 10:8
        }
        height:  isNxt? parent.height-100 : parent.height-80
        width: isNxt?  parent.width - 40 : parent.width - 32
		
		hourGridColor: "red"
		titleText: "   Energiekosten per kWh (vanaf nu)"
		titleFont: qfont.bold.name
		titleSize: isNxt ? 40 : 32
		showTitle: true
		//backgroundcolor : "lightgrey"
		backgroundcolor : colors.canvas
		axisColor : "black"
		barColor : colors.graphElecSingleOrLowTariff
		lineXaxisvisible : true
		textXaxisColor : "blue"
		stepXtext: 3
		valueFont: qfont.regular.name
		valueSize: isNxt ? 16 : 12
		valueTextColor : "black"
		showValuesOnBar : true
		levelColor :"red"
		levelTextColor : "blue"
		showLevels  : true
		showValuesOnLevel : true
		dataValues: app.prices10
		xAxisValues: app.xAxisValues
		visible: app.currentPrice.length>1 & !isDayschreen
	}
	
	VariBarGraph {
        id: todaybarGraph
        anchors {
            bottom: parent.bottom
            bottomMargin: isNxt? 100:80
            left : parent.left
            leftMargin : isNxt? 10:8
        }
        height:  isNxt? parent.height-100 : parent.height-80
        width: isNxt?  parent.width - 40 : parent.width - 32
		
		hourGridColor: "red"
		titleText: "   Energiekosten per kWh (vandaag)"
		titleFont: qfont.bold.name
		titleSize: isNxt ? 40 : 32
		showTitle: true
		//backgroundcolor : "lightgrey"
		backgroundcolor : colors.canvas
		axisColor : "black"
		barColor : colors.graphElecSingleOrLowTariff
		lineXaxisvisible : true
		textXaxisColor : "blue"
		stepXtext: 3
		valueFont: qfont.regular.name
		valueSize: isNxt ? 16 : 12
		valueTextColor : "black"
		showValuesOnBar : true
		levelColor :"red"
		levelTextColor : "blue"
		showLevels  : true
		showValuesOnLevel : true
		dataValues: app.pricesToday10
		xAxisValues: app.xAxisValuesToday
		visible: app.currentPrice.length>1 & isDayschreen
	}
	
	
	SonosStandardButton {
		id: switchButton
        anchors {
            bottom: parent.bottom
            bottomMargin: isNxt? 10:8
            right : parent.right
            rightMargin : isNxt? 10:8
        }
		text: isDayschreen? "Vanaf nu" : "Vandaag"
		width:isNxt ? 180: 144
		height: isNxt ? 40:32
		fontColorUp: "darkslategray"
		fontPixelSize: isNxt ? 20 : 16
		onClicked: 
			isDayschreen = !isDayschreen
	}

		
}




