# 08_Practical_Projects

> **Hands-On SDR Projects** - Step-by-step guides for practical SDR applications.

---

## 📖 Contents

| Project | Difficulty | Hardware | Description |
|---------|------------|----------|-------------|
| [Project_FM_Radio.md](Project_FM_Radio.md) | ⭐ Beginner | Any SDR | Listen to FM broadcast |
| [Project_ADS_B_Receiver.md](Project_ADS_B_Receiver.md) | ⭐ Beginner | RTL-SDR | Track aircraft |
| [Project_Weather_Satellite.md](Project_Weather_Satellite.md) | ⭐⭐ Intermediate | RTL-SDR | Receive NOAA images |
| [Project_AIS_Receiver.md](Project_AIS_Receiver.md) | ⭐ Beginner | RTL-SDR | Track ships |
| [Project_433MHz_Decoder.md](Project_433MHz_Decoder.md) | ⭐ Beginner | RTL-SDR | Decode ISM devices |
| [Project_Pager_Decoder.md](Project_Pager_Decoder.md) | ⭐⭐ Intermediate | RTL-SDR | Decode POCSAG |
| [Project_Trunked_Radio.md](Project_Trunked_Radio.md) | ⭐⭐⭐ Advanced | RTL-SDR | P25/DMR monitoring |

---

## ⭐ Beginner Projects

### Project 1: FM Broadcast Radio

The simplest SDR project - listen to local FM radio stations.

```
    FM RADIO PROJECT
    
    Hardware:          Software:           Output:
    
    ┌────────────┐     ┌────────────┐     ┌────────────┐
    │  RTL-SDR   │────▶│  SDR# or   │────▶│  Speakers  │
    │  + Dipole  │     │  GQRX      │     │            │
    └────────────┘     └────────────┘     └────────────┘
    
    Frequency: 88-108 MHz
    Mode: WFM (Wide FM)
```

**Steps:**
1. Connect RTL-SDR with included antenna
2. Open SDR# or GQRX
3. Set mode to WFM (Wide FM)
4. Tune to 88-108 MHz range
5. Find a station peak in spectrum
6. Enjoy!

---

### Project 2: Aircraft Tracking (ADS-B)

Track aircraft in real-time on a map.

```
    ADS-B PROJECT
    
    Hardware:                    Software:                  Display:
    
    ┌────────────────┐          ┌────────────────┐         ┌────────────┐
    │    RTL-SDR     │─────────▶│   dump1090     │────────▶│  Browser   │
    │  + 1090 MHz    │          │   tar1090      │         │  Map View  │
    │    Antenna     │          └────────────────┘         └────────────┘
    └────────────────┘
    
    Frequency: 1090 MHz
    Range: Up to 400 km
```

**Steps:**
1. Get a 1090 MHz antenna (or make a simple quarter-wave)
2. Install dump1090: `sudo apt install dump1090-mutability`
3. Run: `dump1090 --interactive --net`
4. Open browser to http://localhost:8080
5. Watch aircraft appear on map!

**Antenna Note:** A dedicated 1090 MHz antenna significantly improves range. Commercial options or a DIY collinear work well.

---

### Project 3: ISM Band Decoder (433 MHz)

Decode signals from weather stations, car key fobs, tire pressure sensors, etc.

```
    433 MHz PROJECT
    
    ┌────────────────┐          ┌────────────────┐         ┌────────────┐
    │    RTL-SDR     │─────────▶│    rtl_433     │────────▶│  Console   │
    │  + Antenna     │          │   (decoder)    │         │  or JSON   │
    └────────────────┘          └────────────────┘         └────────────┘
    
    Frequency: 433.92 MHz (EU) / 315 MHz (US)
    Devices: Weather stations, sensors, remotes
```

**Steps:**
1. Install rtl_433: `sudo apt install rtl-433`
2. Run: `rtl_433`
3. Wait for devices to transmit
4. See decoded data in console

**Sample Output:**
```
time      : 2024-01-15 14:32:45
model     : Acurite-Tower  id        : 1234
channel   : A              battery_ok: 1
temperature_C: 21.700       humidity  : 45
```

---

## ⭐⭐ Intermediate Projects

### Project 4: Weather Satellite Imagery

Receive images directly from NOAA weather satellites.

```
    WEATHER SATELLITE PROJECT
    
    ┌──────────────┐
    │ NOAA 15/18/19│  ◄── Polar orbiting satellite
    └──────┬───────┘
           │ 137 MHz FM
           ▼
    ┌────────────────┐          ┌────────────────┐         ┌────────────┐
    │ V-Dipole or    │─────────▶│  SDR + Record  │────────▶│  SatDump   │
    │ QFH Antenna    │          │  (15 min pass) │         │  Decode    │
    └────────────────┘          └────────────────┘         └────────────┘
```

**Hardware Required:**
- RTL-SDR
- V-Dipole antenna (simple) or QFH antenna (better)
- Optional: LNA for weak signals

**Steps:**
1. Build or buy a V-dipole for 137 MHz
2. Use Gpredict or N2YO to predict satellite passes
3. Record the pass as WAV (WFM, 48k sample rate)
4. Process with SatDump or WXtoImg
5. View your satellite image!

**Satellite Frequencies:**

| Satellite | Frequency | Status |
|-----------|-----------|--------|
| NOAA-15 | 137.620 MHz | Active |
| NOAA-18 | 137.9125 MHz | Active |
| NOAA-19 | 137.100 MHz | Active |

---

### Project 5: Ship Tracking (AIS)

Track vessels in your area (if near water).

```
    AIS PROJECT
    
    ┌────────────────┐          ┌────────────────┐         ┌────────────┐
    │    RTL-SDR     │─────────▶│   rtl-ais or   │────────▶│  OpenCPN   │
    │  + VHF Antenna │          │   AISdeco      │         │  Chart     │
    └────────────────┘          └────────────────┘         └────────────┘
    
    Frequencies: 161.975 MHz, 162.025 MHz
    Range: 20-50 km (line of sight to water)
```

**Steps:**
1. Install rtl-ais: `sudo apt install rtl-ais`
2. Install OpenCPN for display
3. Run: `rtl_ais -n`
4. Configure OpenCPN to receive AIS data
5. Watch ships appear on the chart!

---

## ⭐⭐⭐ Advanced Projects

### Project 6: Trunked Radio Monitoring

Monitor P25 or DMR trunked radio systems (public safety, etc.).

```
    TRUNKED RADIO PROJECT
    
    ┌────────────────┐          ┌────────────────┐         ┌────────────┐
    │  RTL-SDR(s)    │─────────▶│  SDRTrunk or   │────────▶│   Audio    │
    │  + Scanner     │          │  OP25          │         │   Output   │
    │   Antenna      │          └────────────────┘         └────────────┘
    └────────────────┘
    
    Requires: System information (frequencies, talkgroups)
    Note: Encrypted channels cannot be decoded
```

**Software Options:**
- **SDRTrunk** (Java, cross-platform) - Easier setup
- **OP25** (Linux) - More powerful

**Steps:**
1. Find local system info on RadioReference.com
2. Install SDRTrunk
3. Configure with system frequencies
4. Listen to unencrypted channels

---

## 🔧 Project Hardware Summary

The following table shows hardware needed for each project:

| Project | SDR | Antenna | LNA | Other |
|---------|-----|---------|-----|-------|
| FM Radio | Any | Included dipole | ❌ | - |
| ADS-B | RTL-SDR | 1090 MHz specific | Optional | - |
| Weather Sat | RTL-SDR | V-Dipole/QFH | Recommended | Tracking software |
| AIS | RTL-SDR | Marine VHF | Optional | Near water |
| 433 MHz | RTL-SDR | Any | ❌ | Devices nearby |
| Pager | RTL-SDR | VHF/UHF | ❌ | - |
| Trunked | RTL-SDR(s) | Scanner | Optional | System info |

---

## 📚 Learning Path

The following diagram shows the recommended project progression:

```
    SDR PROJECT LEARNING PATH
    
    ┌─────────────────┐
    │  FM Radio       │  ◄── Start here!
    │  (Beginner)     │
    └────────┬────────┘
             │
    ┌────────┴────────┐
    │                 │
    ▼                 ▼
┌──────────┐   ┌──────────┐
│ ADS-B    │   │ 433 MHz  │
│ Aircraft │   │ Sensors  │
└────┬─────┘   └────┬─────┘
     │              │
     └──────┬───────┘
            │
    ┌───────┴───────┐
    │               │
    ▼               ▼
┌──────────┐   ┌──────────┐
│ Weather  │   │ AIS      │
│ Satellite│   │ Ships    │
└────┬─────┘   └────┬─────┘
     │              │
     └──────┬───────┘
            │
            ▼
    ┌─────────────────┐
    │ Advanced:       │
    │ Trunked, P25    │
    │ Custom GNU Radio│
    └─────────────────┘
```

---

## 🛠️ Troubleshooting

The following table lists common issues and solutions:

| Problem | Cause | Solution |
|---------|-------|----------|
| No signal | Wrong frequency | Verify frequency for your region |
| Weak signal | Poor antenna | Upgrade antenna, add LNA |
| No decode | Wrong mode/settings | Check mode (AM, FM, WFM) |
| Dropouts | CPU overload | Lower sample rate |
| Drift | SDR warming up | Wait 5-10 minutes, use TCXO version |
| Strong interference | Local RF noise | Move antenna, add filtering |

---

*See individual project pages for detailed step-by-step instructions.*
