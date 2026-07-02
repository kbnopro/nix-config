pragma Singleton

import Quickshell

Singleton {
    id: root

    readonly property int millisecondPerSecond: 1000
    readonly property int millisecondPerMinute: 60 * millisecondPerSecond
    readonly property int millisecondPerHour: 60 * millisecondPerMinute
    readonly property int milliSecondPerDay: 24 * millisecondPerHour

    readonly property int secondPerMinute: 60
    readonly property int secondPerHour: 60 * secondPerMinute
    readonly property int secondPerDay: 24 * secondPerHour

    readonly property int minutePerHour: 60
    readonly property int minutePerDay: 24 * minutePerHour

    readonly property int hourPerDay: 24
}
