# Specialized SDR Software — Decoders & Analysis Tools

> **Specialized Tools** - Purpose-built applications for decoding, analysis, and reverse engineering.

---

## 1. Decoders

### 1.1 dump1090 (ADS-B / Aircraft Tracking)

```bash
sudo apt install dump1090-mutability
dump1090 --interactive --net
# Web map: http://localhost:8080
```

| Feature | Details |
|---------|---------|
| Frequency | 1090 MHz |
| Protocol | ADS-B (Mode S) |
| Output | Console, JSON, web map |

### 1.2 rtl_433 (ISM Band Devices)

```bash
sudo apt install rtl-433
rtl_433                      # Auto-detect mode
rtl_433 -F json              # JSON output
rtl_433 -F mqtt              # MQTT for Home Assistant
```

Decodes 200+ device types: weather stations, TPMS, doorbells, remotes.

### 1.3 multimon-ng (Pager / AFSK / POCSAG)

```bash
sudo apt install multimon-ng
rtl_fm -f 152840000 -s 22050 | multimon-ng -t raw -a POCSAG512 -a POCSAG1200 -
```

### 1.4 SatDump (Satellite Imagery)

Open-source satellite data processor — NOAA APT, Meteor M2 LRPT, GOES, and more.

```bash
# Install from GitHub releases or build from source
# https://github.com/SatDump/SatDump
```

### 1.5 Direwolf (APRS / Packet Radio)

Software TNC for AX.25 packet and APRS:

```bash
sudo apt install direwolf
direwolf    # Starts with default config
```

---

## 2. Analysis Tools

### 2.1 Inspectrum

Offline signal analysis — view recordings as spectrograms and extract symbols:

```bash
sudo apt install inspectrum
inspectrum recorded_signal.cf32
```

### 2.2 URH (Universal Radio Hacker)

Protocol reverse engineering tool — record, demodulate, analyze, and replay signals:

```bash
pip install urh
urh
```

| Feature | Details |
|---------|---------|
| Record & playback | From any SDR |
| Demodulation | ASK, FSK, PSK auto-detect |
| Protocol analysis | Bit-level decoding |
| Fuzzing | Generate test signals |

### 2.3 Baudline

Real-time signal analysis with detailed spectrogram, waveform, and histogram views. Excellent for identifying unknown signals.

---

## 3. Tool Selection Guide

| Task | Tool |
|------|------|
| Track aircraft | dump1090 + tar1090 |
| Decode weather sensors | rtl_433 |
| Decode pagers | multimon-ng |
| Satellite images | SatDump |
| Packet radio / APRS | Direwolf |
| Analyze unknown signals | Inspectrum |
| Reverse engineer protocols | URH |
| Detailed spectrogram | Baudline |

---

*See also: [GNU Radio](GNU_Radio.md) | [Back to 03_Software](README.md)*
