# System Configuration

System configuration files are generally stored under /etc.

## Hostname

The hostname identifies the machine on the local network.

## Filesystems

Persistent filesystem mounts are configured through /etc/fstab.

## Users

User account information is maintained through the standard system account files.

## Timezone

Install the required timezone data before configuring a timezone.

## Groups

Some devices and services require users to belong to specific groups.

## Repositories

Repository configuration is stored under:

    /etc/slate.conf/repos

Slate 0.6 introduces multiple repository support, including Git-based sources, tag selection, and a testing repository.

Consult the current package manager implementation for exact configuration syntax.
