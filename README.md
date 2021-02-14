# keep-clean

A bash script I use to watch for certain file extensions and move them from the Downloads directory to the appropriate home directory (Documents/Pictures/Videos).

## Dependencies

- `inotify-tools`
    - On Ubuntu and its derivatives: `sudo apt install inotify-tools`
- `rsync` to move files and delete the source after

## Usage

- The bash script is available as `clean.sh`. Copy it wherever you'd like to keep the script.
- A systemd unit configuration file, `clean-docs.service`, is also available. This must be copied to `/etc/systemd/system/clean-docs.service`. Configure the service environment variables to move different file extensions to different directories (`source`, `destination`, `look_for`).
    - Each configuration set can be a new `.service` file.
- Since we have added or edited a service file, reload systemctl: `systemctl daemon-reload`
- _Enable_ the service to start on login automatically: `systemctl enable clean-docs`
- Start now with `systemctl start clean-docs`.
- Check logs (and test) with `journalctl -u clean-docs --follow`