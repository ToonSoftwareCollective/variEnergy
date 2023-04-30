import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0;


Tile {
	id: variTile
	property bool debugOutput: app.debugOutput
	property bool dimState: screenStateController.dimmedColors
	
	
	Component.onCompleted: {
		app.valuesUpdated.connect(updateTile);
	}
	
	
	function updateTile(){
		bargraph1.dataValues = app.prices10
		bargraph1.xAxisValues= app.xAxisValues
	}


	onClicked: {
		stage.openFullscreen(app.variScreenUrl)
	}


	Text {
		id: txtTitle
		anchors {
			baseline: parent.top
			baselineOffset: 30
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.tileTitle
		}
		color: !dimState? "black" : "white"
		text: "Variabele Energie Prijzen"	}
	

	Text {
		id: txtCurrentPrice
		anchors {
			top: txtTitle.bottom
			topMargin:  isNxt ? 4:3
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.bold.name
			pixelSize: qfont.tileTitle
		}
		color: !dimState? "black" : "white"
		text: "Huidig: EUR " + app.currentPrice
		visible: app.currentPrice.length>1
	}
	
	Text {
		id: txtUpdate
		anchors {
			top: txtCurrentPrice.bottom
			topMargin:  2
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 12:10
		}
		color: !dimState? "black" : "white"
		text: "(" + app.lastUpdate + ")"
		visible: debugOutput
	}
	

	VariBarGraph {
			id: bargraph1
			anchors {
				bottom: parent.bottom
				bottomMargin: isNxt? 35:28
				left:parent.left
			}
			height:  isNxt? 70:56
			width: isNxt? parent.width - 30 : parent.width - 24
			withDecimals: true
			hourGridColor: dimState? "black" : "white"
			titleText: ""
			titleFont: qfont.bold.name
			titleSize: isNxt ? 20 : 16
			showTitle: false
			//backgroundcolor : "lightgrey"
			backgroundcolor : dimState? "black": "white"
			axisColor : dimState? "white": "black"
			//barColor :dimmableColors.graphSolar
			barColor : dimState? "white": colors.graphElecSingleOrLowTariff
			lineXaxisvisible : true
			textXaxisColor : dimState? "white": "blue"
			stepXtext: 30
			valueFont: qfont.regular.name
			valueSize: isNxt ? 16 : 12
			valueTextColor : dimState? "white" : "black"
			showValuesOnBar : false
			levelColor : dimState? "black" : "white"
			levelTextColor : dimState? "white" : "blue"
			showLevels  : true
			showValuesOnLevel : true
			dataValues: app.prices10
			xAxisValues: app.xAxisValues
			debugOutput : false
			onClicked: {}
			visible: app.currentPrice.length>1
		}





}
