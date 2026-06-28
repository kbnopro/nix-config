pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import Quickshell.Io
// import Caelestia
// import Caelestia.Config
// import qs.services
import qs.utils

Singleton {
    id: root

    property string scheme
    readonly property M3Palette palette: M3Palette {}

    function load(path: string) {
    }

    FileView {
        path: Paths.state + "/quickshell/theme.json"
        watchChanges: true

        onLoaded: root.load()
        onDataChanged: reload()
    }

    component M3Palette: QtObject {
        property color m3primaryPaletteKeyColor
        property color m3secondaryPaletteKeyColor
        property color m3tertiaryPaletteKeyColor
        property color m3neutralPaletteKeyColor
        property color m3neutralVariantPaletteKeyColor
        property color m3background
        property color m3onBackground
        property color m3surface
        property color m3surfaceDim
        property color m3surfaceBright
        property color m3surfaceContainerLowest
        property color m3surfaceContainerLow
        property color m3surfaceContainer
        property color m3surfaceContainerHigh
        property color m3surfaceContainerHighest
        property color m3onSurface
        property color m3surfaceVariant
        property color m3onSurfaceVariant
        property color m3inverseSurface
        property color m3inverseOnSurface
        property color m3outline
        property color m3outlineVariant
        property color m3shadow
        property color m3scrim
        property color m3surfaceTint
        property color m3primary
        property color m3onPrimary
        property color m3primaryContainer
        property color m3onPrimaryContainer
        property color m3inversePrimary
        property color m3secondary
        property color m3onSecondary
        property color m3secondaryContainer
        property color m3onSecondaryContainer
        property color m3tertiary
        property color m3onTertiary
        property color m3tertiaryContainer
        property color m3onTertiaryContainer
        property color m3error
        property color m3onError
        property color m3errorContainer
        property color m3onErrorContainer
        property color m3info
        property color m3onInfo
        property color m3infoContainer
        property color m3onInfoContainer
        property color m3warning
        property color m3onWarning
        property color m3warningContainer
        property color m3onWarningContainer
        property color m3success
        property color m3onSuccess
        property color m3successContainer
        property color m3onSuccessContainer
        property color m3primaryFixed
        property color m3primaryFixedDim
        property color m3onPrimaryFixed
        property color m3onPrimaryFixedVariant
        property color m3secondaryFixed
        property color m3secondaryFixedDim
        property color m3onSecondaryFixed
        property color m3onSecondaryFixedVariant
        property color m3tertiaryFixed
        property color m3tertiaryFixedDim
        property color m3onTertiaryFixed
        property color m3onTertiaryFixedVariant
        property color term0
        property color term1
        property color term2
        property color term3
        property color term4
        property color term5
        property color term6
        property color term7
        property color term8
        property color term9
        property color term10
        property color term11
        property color term12
        property color term13
        property color term14
        property color term15
    }
}
