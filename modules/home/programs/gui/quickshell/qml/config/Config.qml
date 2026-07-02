pragma Singleton

import Quickshell
import Quickshell.Io

import qs.utils

Singleton {
    id: root

    FileView {
        id: fileView

        path: `${Paths.config}/shell.json`
    }
}
