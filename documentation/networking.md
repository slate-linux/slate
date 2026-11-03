# Networking

Slate networking is initialized through startup scripts.

## Interfaces

Show interfaces:

    ip link

Show assigned addresses:

    ip addr

Show routes:

    ip route

## Ethernet

Ethernet configuration requires a working kernel driver and an appropriate DHCP client when DHCP is used.

## Wi-Fi

Wi-Fi support generally requires:

- A kernel driver.
- Firmware when required.
- iw.
- wpa_supplicant.
- A DHCP client.

## Loopback

The loopback interface should be initialized during system startup.

## Troubleshooting

- Check interfaces with ip link.
- Check addresses with ip addr.
- Check routes with ip route.
- Inspect kernel messages with dmesg.
- Verify required drivers and firmware.
