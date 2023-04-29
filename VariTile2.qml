import QtQuick 2.1



HourTile {
	id: root
	hourTileTitle: qsTr("Variable Energy rate")
	values: app.prices
	dataType: "electricity"
	maxValue: 1
	isSolar: false
	startTime: app.dateTimeNextStr
	endTime: app.dateTimeNowStr
	graphColor: dimmableColors.graphSolar
	timeTextsVisible: values.length > 0
}