import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ShellRoot {
    id: root
    property bool menuOpen: false
    
    // System States
    property string cpuUsage: "0%"
    property string ramUsage: "0%"
    property string currentTrack: "No Media"
    property int volume: 50
    property int brightness: 100

    // Utility for executing and capturing output
    function runCommand(cmd, callback) {
        let proc = processComponent.createObject(root, { command: cmd });
        if (!proc) return;
        proc.stdout.onRead.connect((data) => {
            callback(data.trim());
            proc.destroy();
        });
        proc.running = true;
    }

    Component {
        id: processComponent
        Process {
            stdout: SplitParser {}
        }
    }

    // Fetch System Data
    Timer {
        interval: 3000; running: true; repeat: true
        onTriggered: {
            runCommand(["bash", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4 \"%\"}'"], (out) => { cpuUsage = out });
            runCommand(["bash", "-c", "free -m | awk 'NR==2{printf \"%.0f%%\", $3*100/$2 }'"], (out) => { ramUsage = out });
            runCommand(["playerctl", "metadata", "--format", "{{title}} - {{artist}}"], (out) => { currentTrack = out !== "" ? out : "No Media" });
            
            runCommand(["bash", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}'"], (out) => { 
                let v = parseInt(out);
                if (!isNaN(v)) volume = v;
            });
            
            runCommand(["brightnessctl", "g"], (curr) => {
                runCommand(["brightnessctl", "m"], (max) => {
                    let b = (parseInt(curr) / parseInt(max)) * 100;
                    if (!isNaN(b)) brightness = b;
                })
            });
        }
    }

    // --- THE SWISHER SIDEBAR (MMACK STYLE) ---
    PanelWindow {
        id: dashboardWindow
        anchors { top: true; bottom: true; left: true }
        implicitWidth: 500
        visible: root.menuOpen || sidebarAnim.running || sideContent.opacity > 0
        
        // Background dimming
        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: root.menuOpen ? 0.35 : 0
            Behavior on opacity { NumberAnimation { duration: 500 } }
        }

        Rectangle {
            id: sideContent
            width: 440
            height: parent.height - 40
            anchors.verticalCenter: parent.verticalCenter
            
            // "Swisher" slide animation
            x: root.menuOpen ? 20 : -width - 100
            opacity: root.menuOpen ? 1 : 0
            
            color: "#F20A0A15" // Slightly translucent deep blue
            radius: 32
            border.color: "#3300AAFF"
            border.width: 1

            // MMACK SWISHER TRANSITION: High velocity, overshoot easing
            Behavior on x { NumberAnimation { id: sidebarAnim; duration: 550; easing.type: Easing.OutBack; easing.amplitude: 0.6 } }
            Behavior on opacity { NumberAnimation { duration: 400 } }

            // Inner glass highlight
            Rectangle {
                anchors.fill: parent; radius: 32; color: "transparent"
                border.color: "#1AFFFFFF"; border.width: 1; anchors.margins: 1
            }

            ColumnLayout {
                anchors.fill: parent; anchors.margins: 35; spacing: 25

                // Header
                RowLayout {
                    Layout.fillWidth: true; spacing: 18
                    Rectangle {
                        width: 54; height: 54; radius: 27; color: "#1A00AAFF"
                        Text { anchors.centerIn: parent; text: "󰇄"; color: "#00AAFF"; font.pixelSize: 26 }
                    }
                    Column {
                        Text { text: "CORE_SYSTEM"; color: "white"; font.pixelSize: 24; font.bold: true; font.letterSpacing: 1.5 }
                        Text { text: "MMACK STYLE INTERFACE"; color: "#00AAFF"; font.pixelSize: 9; font.bold: true; opacity: 0.6; font.letterSpacing: 3 }
                    }
                }

                // Stats Dashboard
                Rectangle {
                    Layout.fillWidth: true; height: 100; radius: 24; color: "#0AFFFFFF"; border.color: "#1AFFFFFF"
                    RowLayout {
                        anchors.fill: parent; anchors.margins: 20; spacing: 30
                        Column {
                            Layout.fillWidth: true; spacing: 10
                            Text { text: "CPU LOAD"; color: "white"; font.pixelSize: 10; font.bold: true; opacity: 0.5 }
                            Rectangle {
                                width: parent.width; height: 8; radius: 4; color: "#22FFFFFF"
                                Rectangle { 
                                    width: parent.width * (parseInt(root.cpuUsage) / 100.0); height: 8; radius: 4; color: "#00AAFF"
                                    Behavior on width { NumberAnimation { duration: 1500; easing.type: Easing.OutElastic; easing.period: 0.8 } }
                                }
                            }
                            Text { text: root.cpuUsage; color: "#00AAFF"; font.pixelSize: 16; font.bold: true }
                        }
                        Column {
                            Layout.fillWidth: true; spacing: 10
                            Text { text: "RAM USAGE"; color: "white"; font.pixelSize: 10; font.bold: true; opacity: 0.5 }
                            Rectangle {
                                width: parent.width; height: 8; radius: 4; color: "#22FFFFFF"
                                Rectangle { 
                                    width: parent.width * (parseInt(root.ramUsage) / 100.0); height: 8; radius: 4; color: "#BD93F9"
                                    Behavior on width { NumberAnimation { duration: 1500; easing.type: Easing.OutElastic; easing.period: 0.8 } }
                                }
                            }
                            Text { text: root.ramUsage; color: "#BD93F9"; font.pixelSize: 16; font.bold: true }
                        }
                    }
                }

                // MMACK STAGGERED GRID
                GridLayout {
                    columns: 3; rowSpacing: 15; columnSpacing: 15; Layout.fillWidth: true
                    Repeater {
                        model: [
                            { i: "󰈹", n: "WEB", c: "firefox", clr: "#FF5555" },
                            { i: "󰅩", n: "DEV", c: "kitty", clr: "#50FA7B" },
                            { i: "󰉋", n: "FILE", c: "thunar", clr: "#F1FA8C" },
                            { i: "󰓓", n: "PLAY", c: "steam", clr: "#00AAFF" },
                            { i: "󰙯", n: "CHAT", c: "discord", clr: "#7289DA" },
                            { i: "󰄀", n: "TUNE", c: "spotify", clr: "#1DB954" }
                        ]
                        delegate: MouseArea {
                            id: appItem
                            implicitWidth: 110; implicitHeight: 90; hoverEnabled: true
                            onClicked: { Quickshell.execute([modelData.c]); root.menuOpen = false; }
                            
                            Rectangle {
                                anchors.fill: parent; radius: 24
                                color: appItem.containsMouse ? "#20FFFFFF" : "#0AFFFFFF"
                                border.color: appItem.containsMouse ? modelData.clr : "transparent"
                                border.width: 1.5
                                scale: appItem.pressed ? 0.92 : (appItem.containsMouse ? 1.05 : 1.0)
                                
                                Behavior on color { ColorAnimation { duration: 250 } }
                                Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutBack } }
                                
                                Column {
                                    anchors.centerIn: parent; spacing: 8
                                    Text { 
                                        text: modelData.i; color: appItem.containsMouse ? modelData.clr : "white"
                                        font.pixelSize: 32; anchors.horizontalCenter: parent.horizontalCenter
                                        Behavior on color { ColorAnimation { duration: 250 } }
                                    }
                                    Text { 
                                        text: modelData.n; color: "white"; font.pixelSize: 10; font.bold: true
                                        opacity: appItem.containsMouse ? 1 : 0.4; anchors.horizontalCenter: parent.horizontalCenter 
                                    }
                                }
                            }

                            // STAGGERED ENTRANCE
                            opacity: root.menuOpen ? 1 : 0
                            transform: Translate { 
                                id: trans; y: root.menuOpen ? 0 : 30 
                                Behavior on y { 
                                    SequentialAnimation {
                                        PauseAnimation { duration: index * 40 }
                                        NumberAnimation { duration: 500; easing.type: Easing.OutBack; easing.amplitude: 0.8 }
                                    }
                                }
                            }
                            Behavior on opacity { 
                                SequentialAnimation {
                                    PauseAnimation { duration: index * 40 }
                                    NumberAnimation { duration: 400 }
                                }
                            }
                        }
                    }
                }

                // Media Control
                Rectangle {
                    Layout.fillWidth: true; height: 120; radius: 24; color: "#0AFFFFFF"; border.color: "#1AFFFFFF"
                    ColumnLayout {
                        anchors.fill: parent; anchors.margins: 15; spacing: 8
                        Text { 
                            text: root.currentTrack
                            color: "white"; font.pixelSize: 13; font.bold: true; Layout.alignment: Qt.AlignHCenter
                            elide: Text.ElideRight; Layout.maximumWidth: 350
                        }
                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter; spacing: 35
                            Button { 
                                text: "󰒮"; font.pixelSize: 20
                                onClicked: Quickshell.execute(["playerctl", "previous"]) 
                            }
                            Rectangle {
                                width: 50; height: 50; radius: 25; color: "#00AAFF"
                                Text { anchors.centerIn: parent; text: "󰐊"; color: "black"; font.pixelSize: 26 }
                                MouseArea { 
                                    anchors.fill: parent; hoverEnabled: true
                                    onClicked: Quickshell.execute(["playerctl", "play-pause"]) 
                                    onPressed: parent.scale = 0.9
                                    onReleased: parent.scale = 1.0
                                }
                                Behavior on scale { NumberAnimation { duration: 150 } }
                            }
                            Button { 
                                text: "󰒭"; font.pixelSize: 20
                                onClicked: Quickshell.execute(["playerctl", "next"]) 
                            }
                        }
                    }
                }

                Item { Layout.fillHeight: true }

                // Documentation Button
                Button {
                    text: "󰈙 SYSTEM DOCUMENTATION"
                    Layout.fillWidth: true; height: 50
                    onClicked: { Quickshell.execute(["bash", "-c", "/home/zviel/docs/config/hypr/scripts/docs_view.sh"]); root.menuOpen = false; }
                    contentItem: Text {
                        text: parent.text; color: "white"; 
                        font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 12; font.letterSpacing: 1
                    }
                    background: Rectangle {
                        color: parent.hovered ? "#3300AAFF" : "#1AFFFFFF"
                        radius: 18; border.color: parent.hovered ? "#00AAFF" : "transparent"
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }
                }

                Button {
                    text: "󰐥 LOGOUT SYSTEM"
                    Layout.fillWidth: true; height: 50
                    onClicked: Quickshell.execute(["hyprctl", "dispatch", "exit"])
                    contentItem: Text {
                        text: parent.text; color: parent.pressed ? "#FF5555" : "white"; 
                        font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 12; font.letterSpacing: 1
                    }
                    background: Rectangle {
                        color: parent.hovered ? "#33FF5555" : "#1AFFFFFF"
                        radius: 18; border.color: parent.hovered ? "#FF5555" : "transparent"
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }
                }
            }
        }

        // Close when clicking outside
        MouseArea {
            anchors.fill: parent; z: -1; enabled: root.menuOpen
            onClicked: root.menuOpen = false
        }
    }

    // --- SIGNATURE FLOATING PILL BAR ---
    PanelWindow {
        anchors { top: true; left: true; right: true }
        implicitHeight: 75
        visible: true
        
        RowLayout {
            anchors.fill: parent; anchors.leftMargin: 35; anchors.rightMargin: 35; spacing: 25

            // Logo Trigger
            Rectangle {
                implicitWidth: 200; implicitHeight: 52; radius: 26; color: "#F20A0A15"; border.color: root.menuOpen ? "#00AAFF" : "#22FFFFFF"
                MouseArea {
                    anchors.fill: parent; hoverEnabled: true
                    onClicked: { root.menuOpen = !root.menuOpen; spinAnim.start() }
                    RowLayout {
                        anchors.centerIn: parent; spacing: 16
                        Text { 
                            id: logoZ; text: "Z"; color: "#00AAFF"; font.pixelSize: 30; font.bold: true 
                            RotationAnimation { id: spinAnim; target: logoZ; from: 0; to: 360; duration: 800; easing.type: Easing.OutBack }
                        }
                        Text { text: "ZVIEL.OS"; color: "white"; font.pixelSize: 15; font.bold: true; font.letterSpacing: 2.5 }
                    }
                }
            }

            Item { Layout.fillWidth: true }

            // System Metrics Pill
            Rectangle {
                implicitWidth: 360; implicitHeight: 52; radius: 26; color: "#F20A0A15"; border.color: "#22FFFFFF"
                RowLayout {
                    anchors.centerIn: parent; spacing: 22
                    Text { text: "󰻠 " + root.cpuUsage; color: "#00AAFF"; font.pixelSize: 13; font.bold: true }
                    Rectangle { width: 1; height: 18; color: "white"; opacity: 0.15 }
                    Text { text: "󰍛 " + root.ramUsage; color: "#BD93F9"; font.pixelSize: 13; font.bold: true }
                    Rectangle { width: 1; height: 18; color: "white"; opacity: 0.15 }
                    Text { 
                        text: Qt.formatDateTime(new Date(), "hh:mm:ss")
                        color: "white"; font.pixelSize: 16; font.bold: true; font.family: "Monospace"
                    }
                }
            }
        }
    }
}
