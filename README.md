<div align="center">

# Nova Core

**A dependency-free DVB → MPEG-TS streaming headend.**

Tune satellite, terrestrial, and cable muxes and restream them over IP —
one static binary, no ffmpeg, no libraries.

[![Release](https://img.shields.io/github/v/release/novaheadend/nova-core-releases?color=5b6cf2)](https://github.com/novaheadend/nova-core-releases/releases/latest)
![Platform](https://img.shields.io/badge/platform-linux%2Fx86--64-444)
![License](https://img.shields.io/badge/license-proprietary%20freeware-888)

<img src="docs/dashboard.png" alt="Nova Core dashboard" width="900">

</div>

---

## What it does

Nova Core turns a Linux box with DVB tuners into a live IPTV headend:

- **DVB-S/S2, DVB-T/T2, DVB-C** tuning
- **Native Go MPEG-TS** demux + single-program PAT/PMT rewrite — **no ffmpeg, no transcode, no re-mux artifacts**
- **HTTP-TS** and **UDP / RTP multicast** egress, with per-output interface binding
- **EPG / XMLTV** harvesting (SDT + EIT)
- **M3U playlist** of every channel — paste straight into VLC or a set-top box
- Live **web dashboard**: streams, tuners, connected clients, logs, real-time signal / quality
- **Security**: IP allow-list, login captcha after repeated failures, API brute-force lockout
- **Operations**: scheduled restarts, idle-tuner signal monitoring, one-click log export, in-UI config editor

One static binary. Zero runtime dependencies. Runs as a `systemd` service.

## Quick start

```bash
# 1. Download the latest release
curl -LO https://github.com/novaheadend/nova-core-releases/releases/latest/download/nova-core
curl -LO https://github.com/novaheadend/nova-core-releases/releases/latest/download/nova-core.sha256

# 2. Verify the download
sha256sum -c nova-core.sha256

# 3. Install as a systemd service
chmod +x nova-core
sudo ./nova-core -install
```

The installer creates `/opt/nova-core`, registers a `systemd` service, and prints your dashboard URL plus a generated admin password:

```
  Nova Core installed
  URL    http://<your-ip>:<port>
  user   admin
  pass   3f9a…c8
```

Open the URL, sign in, change the password from **Settings → Users**, then add your tuners and channels.

## Requirements

| | |
|---|---|
| OS | Linux x86-64 |
| Tuners | DVB kernel drivers for your card (TBS and similar) |
| Privileges | root (for `/dev/dvb` access) |
| Dependencies | **none** — no ffmpeg, no libraries |

## Updating

```bash
# Re-run the installer with a newer binary — your config is preserved.
sudo ./nova-core -install
```

## Uninstall

```bash
# Removes the service and binary. Keeps nova.json + users.json.
sudo /opt/nova-core/nova-core -uninstall
```

## Verifying integrity

Every release ships a `nova-core.sha256`. Always verify before installing:

```bash
sha256sum -c nova-core.sha256
```

## License

Nova Core is **proprietary freeware** — free to use, closed-source. Only the
compiled binary is distributed here; the source is not public.

---

<div align="center">

© 2026 [novaheadend.com](https://novaheadend.com)

</div>
