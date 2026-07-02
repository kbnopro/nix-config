pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

import qs.utils

QtObject {
    id: notif

    property bool popup
    property bool closed
    property var locks: new Set()

    property date time: new Date()
    property string timeStr: qsTr("now")
    readonly property Timer timeStrTimer: Timer {
        running: !notif.closed
        interval: 5000
        repeat: true

        onTriggered: notif.updateTimeStr()
    }

    property Notification notification

    function updateTimeStr() {
        const diff = Date.now() - notif.time;
        const m = Math.floor(diff / TimeConstants.millisecondPerMinute);

        if (m < 1) {
            notif.timeStr = qsTr("now");
            notif.timeStrTimer.interval = 5 * TimeConstants.millisecondPerSecond;
        } else {
            const h = Math.floor(m / TimeConstants.minutePerHour);
            const d = Math.floor(h / TimeConstants.hourPerDay);

            if (d > 0) {
                notif.timeStr = `${d}d`;
                notif.timeStrTimer.interval = TimeConstants.milliSecondPerDay;
            } else if (h > 0) {
                notif.timeStr = `${h}h`;
                notif.timeStrTimer.interval = TimeConstants.millisecondPerHour;
            } else {
                notif.timeStr = `${m}m`;
                notif.timeStrTimer.interval = m < 10 ? 0.5 * TimeConstants.millisecondPerMinute : TimeConstants.millisecondPerMinute;
            }
        }
    }
}
