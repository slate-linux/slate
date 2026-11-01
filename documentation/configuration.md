# System Configuration

System configuration files are generally stored under /etc.
Before changing configuration files, make a backup of the original.

## Users

User account information is maintained through the standard system account files.
Use the account management utilities provided by the system to create and maintain users.

## Hostname

The system hostname identifies the machine on the local network.
Configure the hostname using the system configuration provided by the installation.

## Timezone

The system timezone determines how local time is displayed.
Ensure the required timezone data is installed before configuring a timezone.

## Filesystems

Filesystem mount configuration is maintained in /etc/fstab.
Check device names and mount points carefully before editing this file.

## Groups and Permissions

Some devices and services require users to belong to specific groups.
Check the documentation for the relevant service or device when configuring permissions.
