import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0;


Tile {
	id: variTile
	property bool debugOutput: app.debugOutput
	property bool dimState: screenStateController.dimmedColors
	
	
	Component.onCompleted: {
		app.valuesUpdated.connect(updateTile);
		updateTile()
	}
	
	function updateTile(){
		txtCurrentPrice.text = "Huidig: EUR " + app.currentPrice
		txtHourUsageWatt.text = "Dit uur: " + app.thisHourPower + " Watt"
		txtHourUsagePrice.text = "Dit uur: EUR " + app.thisHourCost.toString()
		
		txtDayUsageWatt.text = "Vandaag: " + app.todayPower + " Watt"
		txtDayUsagePrice.text = "Vandaag: EUR " + app.todayCost.toString()
		
		txtUpdate.text = app.lastUpdate
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
		text: "Variabele Energie Prijzen"
	}
	

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
		text: ""
		visible: app.currentPrice.length>1
	}
	

	Text {
		id: txtHourUsageWatt
		anchors {
			top: txtCurrentPrice.bottom
			topMargin:  isNxt ? 3:2
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.tileTitle
		}
		color: !dimState? "black" : "white"
		text: ""
		visible: app.currentPrice.length>1
	}
	
	Text {
		id: txtHourUsagePrice
		anchors {
			top: txtHourUsageWatt.bottom
			topMargin:  isNxt ? 3:2
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.tileTitle
		}
		color: !dimState? "black" : "white"
		text: ""
		visible: app.currentPrice.length>1
	}
	
	Text {
		id: txtDayUsageWatt
		anchors {
			top: txtHourUsagePrice.bottom
			topMargin:  isNxt ? 2:3
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.tileTitle
		}
		color: !dimState? "black" : "white"
		text: ""
		visible: app.currentPrice.length>1
	}
	
	Text {
		id: txtDayUsagePrice
		anchors {
			top: txtDayUsageWatt.bottom
			topMargin:  isNxt ? 2:2
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.tileTitle
		}
		color: !dimState? "black" : "white"
		text: ""
		visible: app.currentPrice.length>1
	}
	
	Text {
		id: txtUpdate
		anchors {
			top: txtDayUsagePrice.bottom
			topMargin:  2
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: isNxt ? 12:10
		}
		color: !dimState? "black" : "white"
		text: "(" + app.lastUpdate + ")"
		visible: app.currentPrice.length>1
	}

}
