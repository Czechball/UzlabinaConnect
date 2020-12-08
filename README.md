# UzlabinaConnect
A simple bash script using NetworkManager and curl to connect to the SPŠE V Úžlabině WiFi network.
## Requirements:
- NetworkManager (nmcli)
- curl
## Features:
- Included anonymous credentials that are used when no credentials are supplied
- Captive portal connectivity check
- Logged in status check
- WiFi spoofing detection
## Usage:
`./uzlabina.sh [login] [password] [timeout]` (arguments are optional)

**This script is obsolete, SPŠE V Úžlabině is now using WPA2 Enterprise instead of the old captive portal**