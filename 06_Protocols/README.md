# 06_Protocols

> **Radio Protocols** - Common signals and protocols you can receive with SDR.

---

## 📖 Contents

| Document | Description |
|----------|-------------|
| [ADS_B.md](ADS_B.md) | Aircraft tracking (1090 MHz) |
| [AIS.md](AIS.md) | Ship tracking |
| [NOAA_APT.md](NOAA_APT.md) | Weather satellite imagery |
| [POCSAG.md](POCSAG.md) | Pager protocol |
| [DMR.md](DMR.md) | Digital Mobile Radio |
| [LoRa.md](LoRa.md) | Long Range IoT |
| [ISM_433MHz.md](ISM_433MHz.md) | ISM band devices |

---

## 🎯 Quick Reference

### Protocols by Frequency

The following table lists protocols sorted by frequency:

| Frequency | Protocol | What It Is | Software |
|-----------|----------|------------|----------|
| 137 MHz | NOAA APT | Weather satellite images | WXtoImg, SatDump |
| 137 MHz | Meteor M2 | Russian weather satellite | SatDump |
| 144-148 MHz | Amateur 2m | Ham radio, APRS | Direwolf |
| 156.8 MHz | Marine VHF | Ship communications | - |
| 161-162 MHz | AIS | Ship tracking | AISdeco, OpenCPN |
| 162.4 MHz | NOAA Weather | Weather radio | AM/FM receiver |
| 152/454 MHz | POCSAG | Pagers | multimon-ng |
| 406 MHz | EPIRB | Emergency beacons | - |
| 433 MHz | ISM | Remotes, sensors | rtl_433 |
| 462-467 MHz | FRS/GMRS | Walkie-talkies | - |
| 868 MHz | ISM (EU) | IoT, LoRa | rtl_433 |
| 915 MHz | ISM (US) | LoRa | rtl_433 |
| 978 MHz | UAT | US aircraft (ADS-B) | dump978 |
| 1090 MHz | ADS-B | Aircraft tracking | dump1090 |
| 1575 MHz | GPS L1 | GPS signals | - |

---

## ✈️ ADS-B (Aircraft Tracking)

### Overview

ADS-B (Automatic Dependent Surveillance-Broadcast) is transmitted by aircraft at 1090 MHz, broadcasting position, altitude, speed, and callsign.

The following diagram shows ADS-B reception:

```
    ADS-B RECEPTION
    
    ┌──────────┐                              ┌──────────────────┐
    │ Aircraft │ ─── 1090 MHz ────────────────│  RTL-SDR         │
    │          │     PPM Bursts               │  + 1090 Antenna  │
    └──────────┘                              └────────┬─────────┘
                                                       │
                                                       ▼
                                              ┌──────────────────┐
                                              │   dump1090       │
                                              │  (decoder)       │
                                              └────────┬─────────┘
                                                       │
                      ┌────────────────────────────────┼─────────┐
                      ▼                                ▼         ▼
               ┌────────────┐                  ┌────────────┐┌───────┐
               │ Web Map    │                  │ Flight     ││ JSON  │
               │ (tar1090)  │                  │ Tracking   ││ Feed  │
               └────────────┘                  │ Networks   │└───────┘
                                               └────────────┘
```

### ADS-B Parameters

The following table shows ADS-B signal characteristics:

| Parameter | Value |
|-----------|-------|
| **Frequency** | 1090 MHz |
| **Modulation** | PPM (Pulse Position Modulation) |
| **Data Rate** | 1 Mbps |
| **Message Length** | 56 or 112 bits |
| **Range** | 200-400 km line of sight |

### Setup

```bash
# Install dump1090
sudo apt install dump1090-mutability

# Run with RTL-SDR
dump1090 --interactive --net

# View in browser
# http://localhost:8080
```

---

## 🚢 AIS (Ship Tracking)

### Overview

AIS (Automatic Identification System) is used by ships to broadcast position and vessel information on VHF marine frequencies.

The following table shows AIS parameters:

| Parameter | Value |
|-----------|-------|
| **Frequencies** | 161.975 MHz (Ch 87B), 162.025 MHz (Ch 88B) |
| **Modulation** | GMSK (9600 baud) |
| **Protocol** | HDLC framing |
| **Range** | 20-50 km typical |

### Setup

```bash
# Using rtl_ais
sudo apt install rtl-ais

# Run decoder
rtl_ais -n

# Or use GNU Radio AIS block
```

---

## 🌍 Weather Satellites

### NOAA APT

The following table shows NOAA satellite parameters:

| Satellite | Frequency | Pass Duration | Image Width |
|-----------|-----------|---------------|-------------|
| NOAA-15 | 137.620 MHz | ~15 min | 4 km/pixel |
| NOAA-18 | 137.9125 MHz | ~15 min | 4 km/pixel |
| NOAA-19 | 137.100 MHz | ~15 min | 4 km/pixel |

### Reception Diagram

```
    NOAA APT RECEPTION
    
           NOAA Satellite
              ╱╲
             ╱  ╲
            ╱    ╲  137 MHz FM
           ╱      ╲
          ╱        ╲
         ╱ Pass     ╲
        ╱ ~15 min    ╲
       ╱              ╲
      ▼                ▼
    ┌────────────────────┐
    │ V-Dipole or QFH    │
    │ Antenna            │
    └─────────┬──────────┘
              │
              ▼
    ┌────────────────────┐      ┌────────────────────┐
    │ RTL-SDR            │─────▶│ SatDump / WXtoImg  │
    │ FM Demod (17 kHz)  │      │ Image Processing   │
    └────────────────────┘      └────────────────────┘
```

### Setup

```bash
# Track satellite passes
sudo apt install gpredict

# Record and decode
# Use SDR# or GQRX to record WAV during pass
# Process with SatDump
```

---

## 📟 POCSAG (Pagers)

### Overview

POCSAG is a paging protocol still in use in some countries for emergency services and restaurants.

The following table shows POCSAG parameters:

| Parameter | Value |
|-----------|-------|
| **Frequencies** | 152.84, 454.0 MHz (varies by region) |
| **Modulation** | FSK |
| **Baud Rates** | 512, 1200, 2400 baud |
| **Frame Length** | 32 bits |

### Decoding

```bash
# Using multimon-ng
rtl_fm -f 152840000 -s 22050 | multimon-ng -t raw -a POCSAG512 -a POCSAG1200 -a POCSAG2400 -
```

---

## 📡 433 MHz ISM Band

### Overview

The 433 MHz ISM band is used by many consumer devices: remote controls, weather stations, car key fobs, tire pressure sensors, etc.

### Common Devices

The following table lists common 433 MHz devices:

| Device Type | Modulation | Protocol |
|-------------|------------|----------|
| Car key fobs | OOK/ASK | Various rolling codes |
| Weather stations | FSK/OOK | Various |
| Tire pressure (TPMS) | FSK | Various |
| Doorbells | OOK | Simple |
| Smart home | OOK/FSK | Various |

### Decoding with rtl_433

```bash
# Install rtl_433
sudo apt install rtl-433

# Run with auto-detect
rtl_433

# List supported devices
rtl_433 -G

# Output to JSON
rtl_433 -F json
```

### rtl_433 Diagram

```
    rtl_433 OPERATION
    
    ┌───────────────┐     ┌───────────────┐     ┌───────────────┐
    │  433 MHz      │────▶│   RTL-SDR     │────▶│   rtl_433     │
    │  Devices      │     │               │     │   Decoder     │
    └───────────────┘     └───────────────┘     └───────┬───────┘
                                                        │
                              ┌──────────────────────────┼──────────┐
                              ▼                          ▼          ▼
                        ┌──────────┐              ┌──────────┐┌──────────┐
                        │ Console  │              │  JSON    ││  MQTT    │
                        │ Output   │              │  File    ││  Broker  │
                        └──────────┘              └──────────┘└──────────┘
```

---

## 📻 DMR (Digital Mobile Radio)

### Overview

DMR is a digital voice standard used by amateur radio and commercial/public safety.

The following table shows DMR parameters:

| Parameter | Value |
|-----------|-------|
| **Modulation** | 4FSK |
| **Symbol Rate** | 4800 symbols/sec |
| **Data Rate** | 9600 bps |
| **Channel** | 12.5 kHz |
| **Time Slots** | 2 (TDMA) |
| **Vocoder** | AMBE+2 |

### Decoding

```bash
# DSD+ (Windows) or DSD (Linux)
# Requires FM demodulated audio input

# OP25 for P25 (similar setup)
```

---

## 📊 Protocol Comparison

The following table compares common protocols:

| Protocol | Frequency | Range | Data Type | Encryption |
|----------|-----------|-------|-----------|------------|
| **ADS-B** | 1090 MHz | 400 km | Aircraft info | None |
| **AIS** | 162 MHz | 50 km | Ship info | None |
| **NOAA** | 137 MHz | Pass duration | Images | None |
| **POCSAG** | Various | 10 km | Text | Rarely |
| **DMR** | VHF/UHF | 10 km | Voice | Optional |
| **P25** | VHF/UHF | 10 km | Voice | Often |
| **LoRa** | 433/868/915 | 15 km | IoT data | Application layer |

---

## 🛠️ Required Software

The following table lists software for each protocol:

| Protocol | Decoder | Platform |
|----------|---------|----------|
| ADS-B | dump1090, tar1090 | All |
| AIS | rtl-ais, AISdeco | All |
| NOAA APT | SatDump, WXtoImg | All |
| POCSAG | multimon-ng | All |
| 433 MHz | rtl_433 | All |
| DMR | DSD+, DSD | Win/Linux |
| P25 | OP25 | Linux |
| APRS | Direwolf | All |

---

*See individual protocol pages for detailed setup and usage guides.*
