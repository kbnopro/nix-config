pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property string home: Quickshell.env("HOME")
    readonly property string pictures: Quickshell.env("XDG_PICTURES_DIR") || `${home}/Pictures`
    readonly property string videos: Quickshell.env("XDG_VIDEOS_DIR") || `${home}/Videos`

    readonly property string data: `${Quickshell.env("XDG_DATA_HOME")}`
    readonly property string state: `${Quickshell.env("XDG_STATE_HOME")}`
    readonly property string cache: `${Quickshell.env("XDG_CACHE_HOME")}`
    readonly property string config: `${Quickshell.env("XDG_CONFIG_HOME")}`

    readonly property string imagecache: `${cache}/imagecache`
    readonly property string notifimagecache: `${imagecache}/notifs`
}
