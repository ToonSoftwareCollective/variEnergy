import QtQuick 2.1

import BasicUIControls 1.0;

StyledButton {
	id: root

	property bool primary: false

	property color colorUp: colors.btnUp
	property color colorUpPrimary: colors.btnUpPrimary
	property color colorDown: colors.btnDown
	property color colorDownPrimary: colors.btnDownPrimary
	property color fontColorUp: colors.btnText
	property color fontColorUpPrimary: colors.btnTextPrimary
	property color fontColorDown: colors.btnTextDown
	property color colorSelected: colors.btnSelected
	property color fontColorSelected: colors.btnTextSelected
	property color colorDisabled: colors.btnDisabled
	property color fontColorDisabled: colors.btnTextDisabled

	fontFamily: qfont.bold.name
	fontPixelSize: qfont.bodyText

	radius: designElements.radius

	overlayColor: fontColor

	leftMargin: designElements.hMargin10
	rightMargin: designElements.hMargin10
	spacing: designElements.spacing10
	defaultHeight: Math.round(36 * verticalScaling)

	leftClickMargin: 10
	rightClickMargin: 10
	topClickMargin: 10
	bottomClickMargin: 10

	state: "up"

	states: [
		State {
			name: "up"
			PropertyChanges { target: root; color: primary ? colorUpPrimary : colorUp}
			PropertyChanges { target: root; fontColor: primary ? fontColorUpPrimary : fontColorUp}
			PropertyChanges { target: root; useOverlayColor: false}
		},
		State {
			name: "down"
			PropertyChanges { target: root; color: primary ? colorDownPrimary : colorDown}
			PropertyChanges { target: root; fontColor: fontColorDown}
			PropertyChanges { target: root; useOverlayColor: true}
		},
		State {
			name: "selected"
			PropertyChanges { target: root; color: colorSelected}
			PropertyChanges { target: root; fontColor: fontColorSelected}
			PropertyChanges { target: root; useOverlayColor: true}
		},
		State {
			name: "disabled"
			PropertyChanges { target: root; color: colorDisabled}
			PropertyChanges { target: root; fontColor: fontColorDisabled}
			PropertyChanges { target: root; useOverlayColor: true}
		}
	]

	onPressed: {
		root.state = "down"
	}

	onReleased: {
		if (selected) {
			root.state = "selected"
		} else {
			root.state = "up"
		}
	}

	onExited: {
		root.state = "up"
	}

	onEntered: {
		root.state = "down"
	}

	onSelectedChanged: {
		if (selected) {
			root.state = "selected"
		} else {
			root.state = "up"
		}
	}

	onEnabledChanged: {
		if (enabled) {
			root.state = "up"
		} else {
			root.state = "disabled"
		}
	}
}
