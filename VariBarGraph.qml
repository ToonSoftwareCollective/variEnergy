//////  Graph BY OEPI-LOEPI for TOON

import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

Item {
	id: toonTempBarGraph

	width: 400
	height: 200
	
	property string hourGridColor:"red"
	
	property string titleText:"Text"
	property string titleFont: qfont.bold.name
	property int    titleSize: isNxt ? 16 : 12
	property bool   showTitle : true
	property string titleTextColor : "black"
	property string backgroundcolor : "white"
	property string axisColor : "black"
    property string barColor : "blue"
	property bool   lineXaxisvisible : true
 	property string textXaxisColor : "red"
	property int    stepXtext: 5
	property string valueFont: qfont.bold.name
	property int 	valueSize: isNxt ? 16 : 12
	property string valueTextColor : "blue"
	property bool   showValuesOnBar : true
	property string levelColor :"red"
	property string levelTextColor : "blue"
	property bool   showLevels  : true
	property bool   showValuesOnLevel : true	
	property variant dataValues: []
	property variant xAxisValues: []
	property bool	withDecimals: true
	property bool   debugOutput : false
		
	property real freezeTemp: 0
	property int iMin
	property int iMax
	property int maxFormatted
	property int minFormatted
	property int freezeFormatted
	property int barWidthAdjust
	property int numberlevels
	property int degreesPerLevel
	property real level0
	
	property bool activeMe      : false


	signal clicked()

    function doClick(){
		calculateValues()
        clicked()
    }
	
    onVisibleChanged: {
        if (visible) {
            activeMe = true
			calculateValues()
        } else { 
            activeMe = false
        }
    }

    Timer {
        id                      : controlTimer
        interval                : 30000
        running                 : activeMe
        repeat                  : true
        onTriggered             : calculateValues()
    }  

	function calculateValues(){
		iMax = -99
		if (debugOutput) console.log("*********toonTemp Bargraph titleText: " + titleText)
		if (debugOutput) console.log("*********toonTemp Bargraph dataValues: " + dataValues)
		if (debugOutput) console.log("*********toonTemp Bargraph dataValues[0]: " + dataValues[0])
		if (typeof dataValues[0] != 'undefined' && typeof dataValues[0] != 'null' && !isNaN(dataValues[0])){
			if (dataValues[0]!=-99){iMin = dataValues[0]}else{iMin = 100}
			if (debugOutput) console.log("*********toonTemp Bargraph dataValues: " + dataValues)
			for (var i in dataValues){
			  if (dataValues[i] < iMin && dataValues[i]!= -99){iMin = dataValues[i]}
			  if (dataValues[i] > iMax && dataValues[i]!= -99)iMax = dataValues[i]
			}
		}else{
			if (debugOutput) console.log("*********toonTemp Bargraph datavalues[0] is incorrect")
			iMin = 0
			iMax = 1
		}
		if (debugOutput) console.log("*********toonTemp Bargraph calculateValues ------------------------------------------- ")
		if (debugOutput) console.log("*********toonTemp Bargraph calculateValues iMin: " + iMin)
		if (debugOutput) console.log("*********toonTemp Bargraph calculateValues iMax: " + iMax)
		
		if (iMin != 50){
			if(iMin >= -30 & iMin < -25) minFormatted = -30
			if(iMin >= -25 & iMin < -20) minFormatted = -25
			if(iMin >= -20 & iMin < -15) minFormatted = -20
			if(iMin >= -15 & iMin < -10) minFormatted = -15
			if(iMin >= -10 & iMin < -9) minFormatted = -10
			if(iMin >= -9 & iMin < -8) minFormatted = -9
			if(iMin >= -8 & iMin < -7) minFormatted = -8
			if(iMin >= -7 & iMin < -6) minFormatted = -7
			if(iMin >= -6 & iMin < -5) minFormatted = -6
			if(iMin >= -5 & iMin < -4) minFormatted = -5
			if(iMin >= -4 & iMin < -3) minFormatted = -4
			if(iMin >= -3 & iMin < -2) minFormatted = -3
			if(iMin >= -2 & iMin < -1) minFormatted = -2
			if(iMin >= -1 & iMin < 0) minFormatted = -1			
			if(iMin >= 0 & iMin < 3) minFormatted = 0
			if(iMin >= 3 & iMin < 6) minFormatted = 2
			if(iMin >= 6 & iMin < 11) minFormatted = 5
			if(iMin >= 11 & iMin < 16) minFormatted = 10
			if(iMin >= 16 & iMin < 21) minFormatted = 15
			if(iMin >= 21 & iMin < 26) minFormatted = 20
			if(iMin >= 26 & iMin < 31) minFormatted = 25
		}else{
			minFormatted = 0
		}		
		
		if (debugOutput) console.log("*********toonTemp Bargraph calculateValues minFormatted: " + minFormatted)

		if(iMax >= -20 & iMax < -15) maxFormatted = -15
		if(iMax >= -15 & iMax < -10) maxFormatted = -10		
		if(iMax >= -10 & iMax < -9) maxFormatted = -9		
		if(iMax >= -9 & iMax < -8) maxFormatted = -8		
		if(iMax >= -8 & iMax < -7) maxFormatted = -7		
		if(iMax >= -7 & iMax < -6) maxFormatted = -6	
		if(iMax >= -6 & iMax < -5) maxFormatted = -5	
		if(iMax >= -5 & iMax < -4) maxFormatted = -4	
		if(iMax >= -4 & iMax < -3) maxFormatted = -3	
		if(iMax >= -3 & iMax < -2) maxFormatted = -2	
		if(iMax >= -2 & iMax < -1) maxFormatted = -1	
		if(iMax >= -1 & iMax < 0) maxFormatted = 0
		if(iMax >= 0 & iMax < 1) maxFormatted = 1
		if(iMax >= 1 & iMax < 2) maxFormatted = 2
		if(iMax >= 2 & iMax < 3) maxFormatted = 3
		if(iMax >= 3 & iMax < 4) maxFormatted = 4
		if(iMax >= 4 & iMax < 5) maxFormatted = 5
		if(iMax >= 5 & iMax < 6) maxFormatted = 6
		if(iMax >= 6 & iMax < 7) maxFormatted = 7
		if(iMax >= 7 & iMax < 8) maxFormatted = 8
		if(iMax >= 8 & iMax < 9) maxFormatted = 9
		if(iMax >= 9 & iMax < 10) maxFormatted = 10
		if(iMax >= 10 & iMax < 15) maxFormatted = 15
		if(iMax >= 15 & iMax < 20) maxFormatted = 20
		if(iMax >= 20 & iMax < 25) maxFormatted = 25
		if(iMax >= 25 & iMax < 30) maxFormatted = 30
		if(iMax >= 30 & iMax < 35) maxFormatted = 35
		if(iMax >= 35 & iMax < 40) maxFormatted = 40
		if (minFormatted<0) freezeFormatted =-1*minFormatted
		
		if (maxFormatted == 5 & iMax<=0){maxFormatted = 0} 
		if (iMax <2 & iMin<0 & iMin>-2){maxFormatted = 2;minFormatted = -2;freezeFormatted = 2; if (debugOutput) console.log("rond vriespunt")} //rond vriespunt
		if (iMax <1 & iMin<0 & iMin>-1){maxFormatted = 1;minFormatted = -1;freezeFormatted = 1; if (debugOutput) console.log("rond vriespunt")} //rond vriespunt


		if (debugOutput) console.log("*********toonTemp Bargraph calculateValues maxFormatted: " + maxFormatted)			
		if (debugOutput) console.log("*********toonTemp Bargraph calculateValues minFormatted: " + minFormatted)		
		if (debugOutput) console.log("*********toonTemp Bargraph calculateValues freezeFormatted: " + freezeFormatted)
		degreesPerLevel = Math.floor((maxFormatted-minFormatted)/5)
		if (degreesPerLevel==0){degreesPerLevel = 1} // voor kleine verschillen
		if (debugOutput) console.log("*********toonTemp Bargraph calculateValues degreesPerLevel: " + degreesPerLevel)
		
		if (degreesPerLevel == 3){degreesPerLevel = 5}
		if (degreesPerLevel == 4){degreesPerLevel = 5}
		if (degreesPerLevel == 6){degreesPerLevel = 5}
		if (degreesPerLevel == 7){degreesPerLevel = 5}
		if (degreesPerLevel == 8){degreesPerLevel = 5}
		if (degreesPerLevel == 9){degreesPerLevel = 10}
		if (degreesPerLevel == 11){degreesPerLevel = 10}
		if (degreesPerLevel == 13){degreesPerLevel = 15}
		if (degreesPerLevel == 14){degreesPerLevel = 15}
		if (degreesPerLevel == 16){degreesPerLevel = 15}
		if (degreesPerLevel == 17){degreesPerLevel = 20}
		if (degreesPerLevel == 18){degreesPerLevel = 20}
		if (degreesPerLevel == 19){degreesPerLevel = 20}
		if (degreesPerLevel == 21){degreesPerLevel = 25}
		if (degreesPerLevel == 22){degreesPerLevel = 25}
		if (degreesPerLevel == 23){degreesPerLevel = 25}
		if (degreesPerLevel == 24){degreesPerLevel = 25}
		if (degreesPerLevel == 26){degreesPerLevel = 30}
		if (degreesPerLevel == 27){degreesPerLevel = 30}
		if (degreesPerLevel == 28){degreesPerLevel = 30}
		if (degreesPerLevel == 29){degreesPerLevel = 30}



if (debugOutput) console.log("*********toonTemp Bargraph calculateValues degreesPerLevel formatted: " + degreesPerLevel)
		

		if (freezeFormatted>0){
			numberlevels = Math.floor((freezeFormatted + maxFormatted)/degreesPerLevel)
if (debugOutput) console.log("*********toonTemp Bargraph calculateValues maxFormatted: " + maxFormatted)
if (debugOutput) console.log("*********toonTemp Bargraph calculateValues minFormatted: " + minFormatted)
if (debugOutput) console.log("*********toonTemp Bargraph calculateValues freezeFormatted: " + freezeFormatted)
if (debugOutput) console.log("*********toonTemp Bargraph calculateValues numberlevels: " + numberlevels)
//			degreesPerLevel = Math.floor((maxFormatted + freezeFormatted)/numberlevels)
if (debugOutput) console.log("*********toonTemp Bargraph calculateValues degreesPerLevel: " + degreesPerLevel)
		}else{
			numberlevels = Math.floor((maxFormatted-minFormatted)/degreesPerLevel)
if (debugOutput) console.log("*********toonTemp Bargraph calculateValues numberlevels: " + numberlevels)
			degreesPerLevel = Math.floor((maxFormatted-minFormatted)/numberlevels)
		}
		
		if(maxFormatted>0 & minFormatted<0){
			level0 = maxFormatted/(maxFormatted-minFormatted)
		}
		
		if(maxFormatted<=0 & minFormatted<=0){
			level0 = 0
		}

		if(maxFormatted>=0 & minFormatted>=0){
			level0 = 1
		}		
		

if (debugOutput) console.log("*********toonTemp Bargraph calculateValues level0: " + level0)
if (debugOutput) console.log("*********toonTemp Bargraph calculateValues numberlevels * degreesPerLevel: " + numberlevels * degreesPerLevel)


		if(dataValues.length >= 0 & dataValues.length < 1) barWidthAdjust = 1
		if(dataValues.length >= 1 & dataValues.length < 2) barWidthAdjust = 2
		if(dataValues.length >= 2 & dataValues.length < 5) barWidthAdjust = 5
		if(dataValues.length >= 5 & dataValues.length < 11) barWidthAdjust = 7
		if(dataValues.length >= 11 & dataValues.length < 51) barWidthAdjust = 10
		if(dataValues.length >= 51 & dataValues.length < 101)	barWidthAdjust = 20
		if(dataValues.length >= 101 & dataValues.length < 251)  barWidthAdjust = 20
		if(dataValues.length >= 251 & dataValues.length < 501) barWidthAdjust = 20

if (debugOutput) console.log("maxFormatted: " + maxFormatted)
if (debugOutput) console.log("minFormatted: " + minFormatted)
if (debugOutput) console.log("freezeFormatted: " + freezeFormatted)

	}

	Component.onCompleted: {
		calculateValues()
    }

	
	Rectangle {
        id: barGraphRect
		width: showLevels?  (showValuesOnLevel? parent.width-(valueSize*3) : 0):parent.width
		height: showTitle? parent.height-(titleSize*2) : parent.height
        anchors {
			left:parent.left
			leftMargin: showLevels?  (showValuesOnLevel? valueSize*3 : 0):0
			top:parent.top
			topMargin: showTitle? titleSize*2 : 0
        }
        color : backgroundcolor
    }

    Text{
        id: titleTextHolder
        color: titleTextColor
        font.pixelSize: titleSize
        font.family: titleFont
        text: titleText
        anchors {
            bottom: barGraphRect.top
			horizontalCenter: barGraphRect.horizontalCenter
        }
		visible: showTitle
    }
	
	
    Rectangle {
		id: lineYaxis
		color: axisColor
		height: barGraphRect.height
		width: isNxt? 2:1
		anchors {
			bottom: barGraphRect.bottom
			left: barGraphRect.left
		}
	}
	
	Rectangle {
		id: zeroLine
		color: axisColor
		height: 2
		width: barGraphRect.width
		anchors {
			top: barGraphRect.top
			topMargin: level0 * barGraphRect.height
			left: barGraphRect.left
		}
	}

	Rectangle {
		id: lineXaxis
		color: axisColor
		height: isNxt? 2:1
		width: barGraphRect.width
		anchors {
			top: barGraphRect.top
			topMargin : barGraphRect.height
			left: barGraphRect.left
		}
	}
	
	Column {
		id: levels
		anchors.top: barGraphRect.top
		anchors.left: barGraphRect.left
		width: barGraphRect.width
		Repeater {
			id: levelRepeater
			model: numberlevels + 1
			Item {
				height: (barGraphRect.height * numberlevels * degreesPerLevel) / ((maxFormatted-minFormatted)*numberlevels)
				width: barGraphRect.width
				Rectangle {
					id: level
					color: levelColor
					height: 1
					width: barGraphRect.width
				}
				Text{
					id: levelValueText
					color: levelTextColor
					text: (maxFormatted - (degreesPerLevel*index))/10
					font.pixelSize: valueSize
					font.family: valueFont
					anchors {
						verticalCenter: level.verticalCenter
						right: level.left
						rightMargin:5
					}
				}
				visible: showValuesOnLevel
			}
		visible: showLevels
		}
	}
	
	MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: doClick()
    }

	Row {
		id: barHourGraph
		anchors.bottom: barGraphRect.bottom
		anchors.left: barGraphRect.left
		width: barGraphRect.width
		Repeater {
			id: barHourRepeater
			model: xAxisValues.length
			Item {
				height: isNxt? 8:6
				width: barGraphRect.width / 4
				Rectangle {
					id: hourbar
					color: hourGridColor
					height: barGraphRect.height
					width: 1
					anchors {
						bottom: parent.bottom
						left: parent.left
					}
				}
				Text{
					id: linexaxisHourText
					color: textXaxisColor
					font.pixelSize: valueSize
					font.family: valueFont
					text: xAxisValues[index]
					//text: index
					anchors {
						top: hourbar.bottom
						topMargin: isNxt ? 10:8
						horizontalCenter: hourbar.horizontalCenter
					}
				}
			}
		}
	}

	Row {
		id: barGraph
		anchors.left: barGraphRect.left
		anchors.bottom: zeroLine.bottom
		width: barGraphRect.width
		Repeater {
			id: barRepeater
			model: dataValues.length
			Item {
				height: isNxt? 8 :6
				width: barGraphRect.width / dataValues.length
				Rectangle {
					id: bar
					color: barColor	
					height: minFormatted>=0? ((dataValues[index] - minFormatted)/(maxFormatted- minFormatted)) * (barGraphRect.height):((dataValues[index])/(maxFormatted- minFormatted)) * (barGraphRect.height)
					width: parent.width-1
					anchors {
						bottom: parent.bottom
						left: parent.left
					}
					visible: (dataValues[index]>=0)
					
					MouseArea {
						anchors.fill: parent
						onClicked: {
							
						}
					}
				}
				Rectangle {
					id: barNegative
					color: barColor
					height: maxFormatted >=0 ? ((dataValues[index])/minFormatted)   * ((-1* minFormatted)/(maxFormatted - minFormatted))*barGraphRect.height: (((-1 *dataValues[index]) + maxFormatted)/(maxFormatted- minFormatted))* barGraphRect.height
					width: parent.width-1
					anchors {
						top: parent.bottom
						left: parent.left
					}
					visible: (dataValues[index]<0) & dataValues[index] !=-99
				}
				
				Text{
					id: valueText
					color: valueTextColor
					text: dataValues[index]>0? (dataValues[index]/10).toFixed(2).toString():""
					font.pixelSize: valueSize
					font.family: valueFont
					anchors {
						bottom: bar.top
						bottomMargin : isNxt ? freezeTemp + 5:freezeTemp + 4
						horizontalCenter: index>0? bar.horizontalCenter: bar.horizontalCenter
					}
					visible: showValuesOnBar
				}
				
				Text{
					id: valueTextNegative
					color: valueTextColor
					text: dataValues[index]<0? (dataValues[index]/10).toFixed(2).toString():""
					font.pixelSize: valueSize
					font.family: valueFont
					anchors {
						top: barNegative.bottom
						topMargin : isNxt ? freezeTemp + 5:freezeTemp + 4
						horizontalCenter: barNegative.horizontalCenter
					}
					visible: showValuesOnBar
				}


			}
		}

	}
}