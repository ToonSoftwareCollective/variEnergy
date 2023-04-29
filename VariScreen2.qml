import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

Screen {
	id: variScreen
	
	onShown: {    
		addCustomTopRightButton("Instellingen")
    }
	
	onCustomButtonClicked: {
		//stage.openFullscreen(app.solarPanelConfigScreenUrl)
	}
	
	Component.onCompleted: {
		app.valuesUpdated.connect(updateTile);
	}	

	
	function updateTile(){
		todaybarGraph.dataValues = app.prices10
		todaybarGraph.xAxisValues= app.xAxisValues
	}

	
	VariBarGraph {
        id: todaybarGraph
        anchors {
            bottom: parent.bottom
            bottomMargin: isNxt? 80:64
            left : parent.left
            leftMargin : isNxt? 10:8
        }
        height:  isNxt? parent.height-100 : parent.height-80
        width: isNxt?  parent.width - 40 : parent.width - 32
		
		hourGridColor: "red"
		titleText: "   Energiekosten per kWh"
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
		visible: app.currentPrice.length>1
		
	}
		
}




