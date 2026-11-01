# Service Configuration

Optional service scripts are located in /etc/init.d.
Slate does not require every available service to run.

## Available Services

List the installed service scripts with:
    ls /etc/init.d

## Running a Service

Service scripts are invoked directly. For example:
    /etc/init.d/sshd

Check the individual script to determine whether it supports arguments such as start, stop or restart.

## Service Selection

Only run services required by the system or the applications being used.
For example, a graphical session may require seatd, while a headless machine may not need it.
A service being installed does not mean it must be running.

## Troubleshooting

If a service fails to start:
1. Check that its package is installed.
2. Check that its executable exists.
3. Check that its configuration files are present.
4. Check that required users, groups and directories exist.
5. Run the service manually and inspect its error output.
