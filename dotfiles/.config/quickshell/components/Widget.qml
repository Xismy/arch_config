import QtQuick
import qs.theme

Item {
	default property alias content: item.data
	property alias color: rect.color
	property var align: center
	property int topPadding: Sizes.widgetOuterMargin
	property int bottomPadding: Sizes.widgetInnerMargin
	property int sidePadding: Sizes.widgetSpacing / 2
	id: widget
	implicitWidth: item.implicitWidth + 2 * sidePadding
	implicitHeight: parent.height

	Rectangle {
		id: rect
		anchors.fill: parent
		anchors.topMargin: topPadding
		anchors.bottomMargin: bottomPadding
		anchors.leftMargin: sidePadding
		anchors.rightMargin: sidePadding
		radius: Math.min(height, width) / 2
		color: Colors.widgetBg

		Item {
			id: item
			implicitWidth: children.lenght == 0? 0 : children[0].implicitWidth
			implicitHeight: children.lenght == 0? 0 : children[0].implicitHeight
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: widget.align == widget.right? parent.right : none
			anchors.left: widget.align == widget.left? parent.left : none
			anchors.centerIn: widget.align == widget.center? parent : none
		}
	}
}

