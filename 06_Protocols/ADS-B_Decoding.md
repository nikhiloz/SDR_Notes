# ADS-B Decoding

> **ADS-B** - Automatic Dependent Surveillance-Broadcast for aircraft tracking.

---

## 📖 Contents

| Section | Description |
|---------|-------------|
| [Overview](#-overview) | What is ADS-B |
| [Signal Characteristics](#-signal-characteristics) | Technical details |
| [Message Format](#-message-format) | Packet structure |
| [Decoding](#-decoding-with-sdr) | Software and setup |
| [Projects](#-projects) | Practical applications |

---

## ✈️ Overview

### What is ADS-B?

Automatic Dependent Surveillance-Broadcast (ADS-B) is a surveillance technology where aircraft broadcast their position, altitude, speed, and identification.

The following diagram shows the ADS-B concept:

```
    ADS-B CONCEPT
    
                         ┌──── Satellites provide GPS position
                         │
                         ▼
    ╭─────╮         ┌─────────┐
    │  ●  │◄────────┤   GPS   │
    │ ╱|╲ │         │ Receiver│
    ╰─┴─╯           └─────────┘
       │
       │ ADS-B Broadcast
       │ 1090 MHz
       │
       ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼
    
    ┌─────────┐    ┌─────────┐    ┌─────────┐
    │  Other  │    │   ATC   │    │   SDR   │
    │Aircraft │    │ Ground  │    │Receiver │
    │ (TCAS)  │    │ Station │    │  (You!) │
    └─────────┘    └─────────┘    └─────────┘
    
    Aircraft broadcasts: Position, Altitude, Speed, Callsign, ICAO
```

### Why ADS-B with SDR?

| Benefit | Description |
|---------|-------------|
| Free | No subscription required |
| Real-time | See aircraft now |
| Local | Better coverage nearby |
| Educational | Learn RF and protocols |
| Contributing | Feed to FlightAware/FR24 |

---

## 📊 Signal Characteristics

### Technical Specifications

The following table lists ADS-B signal parameters:

| Parameter | Value | Notes |
|-----------|-------|-------|
| **Frequency** | 1090 MHz | Same as Mode S |
| **Modulation** | PPM | Pulse Position Modulation |
| **Data Rate** | 1 Mbps | |
| **Pulse Width** | 0.5 μs | |
| **Message Length** | 112 bits | Long squitter |
| **TX Power** | 75-500 W | High power |
| **Range** | 200+ nm | Line of sight |

### Signal Structure

```
    ADS-B SIGNAL TIMING
    
    Preamble (8 μs)                Data (112 bits × 1 μs = 112 μs)
    ◄──────────────────────►◄─────────────────────────────────────────►
    
    │██│  │██│  │██│  │██│     │D│D│D│D│D│D│D│D│......│D│D│D│D│D│
    └──┴──┴──┴──┴──┴──┴──┴─────┴─┴─┴─┴─┴─┴─┴─┴─┴──────┴─┴─┴─┴─┴─
    0  1  2  3  4  5  6  7  8    Bit 0              Bit 111
    
    Preamble: Fixed pattern for sync
              4 pulses at specific positions
    
    Data Bit Encoding (PPM):
    
    "1" bit:     "0" bit:
    │██│  │      │  │██│
    └──┴──┘      └──┴──┘
    High-Low     Low-High
```

### Spectrum View

```
    ADS-B AT 1090 MHz
    
    Power
    ▲
    │                 ┌──────────────────┐
    │                 │                  │
    │                 │    ADS-B         │
    │                 │    1090 MHz      │
    │                 │                  │
    │                 │    ~2 MHz BW     │
    └─────────────────┴──────────────────┴─────────────────────▶ Freq
                     1089              1091 MHz
```

---

## 📦 Message Format

### ADS-B Frame Structure

```
    112-BIT EXTENDED SQUITTER (ADS-B)
    
    ┌────────────────────────────────────────────────────────────────┐
    │  5 bits  │  3 bits  │    24 bits    │  56 bits │   24 bits   │
    ├──────────┼──────────┼───────────────┼──────────┼─────────────┤
    │    DF    │    CA    │  ICAO Address │   ME     │    CRC      │
    │ Downlink │Capability│   (Unique ID) │ Message  │  Checksum   │
    │  Format  │          │               │Extension │             │
    └──────────┴──────────┴───────────────┴──────────┴─────────────┘
    
    DF = 17 for ADS-B
```

### Message Types (Type Codes)

| TC | Type | Data Provided |
|----|------|---------------|
| 1-4 | Aircraft ID | Callsign |
| 5-8 | Surface Position | Lat/Lon on ground |
| 9-18 | Airborne Position (Baro) | Lat/Lon, Altitude |
| 19 | Airborne Velocity | Speed, Heading |
| 20-22 | Airborne Position (GNSS) | Lat/Lon, GNSS Alt |
| 23-27 | Reserved | - |
| 28 | Aircraft Status | Emergency, SPI |
| 29 | Target State | Autopilot info |
| 31 | Aircraft Operational Status | Version, capability |

### Example Decoded Message

```
    SAMPLE ADS-B DECODE
    
    Raw: 8D4840D6202CC371C32CE0576098
    
    ┌────────────────────────────────────────────────────┐
    │ Field          │ Value                             │
    ├────────────────┼───────────────────────────────────┤
    │ Downlink Format│ 17 (ADS-B)                        │
    │ ICAO Address   │ 4840D6                            │
    │ Type Code      │ 4 (Aircraft ID)                   │
    │ Callsign       │ KLM1023_                          │
    │ CRC            │ Valid                             │
    └────────────────┴───────────────────────────────────┘
```

---

## 🛠️ Decoding with SDR

### Software Options

| Software | Platform | Features |
|----------|----------|----------|
| **dump1090** | Linux/Win/Mac | CLI, web interface |
| **dump1090-mutability** | Linux | Enhanced fork |
| **dump1090-fa** | Linux | FlightAware fork |
| **RTL1090** | Windows | GUI application |
| **ADSB# (SDRSharp)** | Windows | SDRSharp plugin |
| **readsb** | Linux | Modern replacement |

### dump1090 Setup

```bash
# Install dump1090
git clone https://github.com/flightaware/dump1090.git
cd dump1090
make

# Run dump1090
./dump1090 --interactive

# Run with web server
./dump1090 --interactive --net

# Then open http://localhost:8080 in browser
```

### Recommended RTL-SDR Settings

| Setting | Value | Notes |
|---------|-------|-------|
| **Frequency** | 1090 MHz | Fixed |
| **Sample Rate** | 2 MSPS | Minimum for 1 Mbps data |
| **Gain** | AGC or fixed | Test for best |
| **Bias-T** | On (if using LNA) | Power external amp |

---

## 📡 Antenna Recommendations

### Optimal Antenna Setup

```
    ADS-B ANTENNA OPTIONS
    
    Basic Setup:              Optimized Setup:
    
         │                         │
         │ Dipole/Whip            │ Collinear
         │                        ┬┬┬
         │                        │││
         │                        ┴┴┴
         │                         │
    ─────┴─────                ────┴────
      Inside                   Outside/Roof
      window                   with LNA
    
    Range: 50-100 nm         Range: 200+ nm
```

### Antenna Comparison

| Antenna Type | Gain | Range | Notes |
|--------------|------|-------|-------|
| Stock RTL-SDR | 0 dBi | 30-50 nm | Poor |
| Quarter-wave (λ/4) | 2 dBi | 50-100 nm | DIY easy |
| Ground plane | 3 dBi | 75-125 nm | Good |
| Collinear | 6-9 dBi | 150-250 nm | Best |
| With LNA | +10-20 dB | +50% | Recommended |

### DIY Quarter-Wave Antenna

```
    λ/4 GROUND PLANE ANTENNA FOR 1090 MHz
    
                │
                │ ◄── Vertical element: 6.9 cm (69 mm)
                │     (quarter wavelength)
                │
    ────────────┼────────────
       ╲        │        ╱
        ╲       │       ╱     Radials: 4 × 6.9 cm
         ╲      │      ╱      at 45° angle down
          ╲     │     ╱
    
    Materials: Coat hanger wire, SO-239/SMA
    Formula: λ/4 = 300 / (1090 × 4) = 0.069 m = 6.9 cm
```

---

## 🗺️ Projects

### Project 1: Basic Flight Tracker

| Step | Action |
|------|--------|
| 1 | Install dump1090 |
| 2 | Connect RTL-SDR with antenna |
| 3 | Run `dump1090 --interactive --net` |
| 4 | Open http://localhost:8080 |
| 5 | Watch aircraft appear on map! |

### Project 2: Feed to FlightAware

The following diagram shows feeding flight tracking services:

```
    FEEDING FLIGHT TRACKERS
    
    ┌─────────┐     ┌──────────┐     ┌────────────────────┐
    │ RTL-SDR │────▶│ dump1090 │────▶│ FlightAware/FR24   │
    │         │     │ PiAware  │     │ (Cloud Service)    │
    └─────────┘     └──────────┘     └────────────────────┘
                          │                    │
                          ▼                    ▼
                    ┌───────────┐       ┌───────────────┐
                    │Local Map  │       │ Global Map    │
                    │(you only) │       │ (everyone)    │
                    └───────────┘       └───────────────┘
    
    Benefits: Free FlightAware subscription!
```

### Project 3: Long-Range Setup

| Component | Purpose |
|-----------|---------|
| RTL-SDR Blog V3 | Best RTL-SDR for 1090 |
| 1090 MHz LNA | Boost weak signals |
| Bandpass filter | Remove interference |
| Outdoor collinear | Maximum gain |
| Raspberry Pi | Headless operation |

---

## 📊 Performance Metrics

### Understanding dump1090 Stats

| Metric | Description | Good Value |
|--------|-------------|------------|
| **Messages/sec** | ADS-B messages received | 100+ |
| **Aircraft** | Unique aircraft seen | 20+ |
| **Range** | Maximum distance | 100+ nm |
| **Positions/sec** | Position updates | 50+ |

### Troubleshooting

| Problem | Solution |
|---------|----------|
| Few aircraft | Check antenna, add LNA |
| Short range | Antenna placement, LNA |
| Missing messages | Increase gain |
| Intermittent | Check USB cable |
| Interference | Add 1090 MHz filter |

---

## 🔗 Resources

| Resource | Description |
|----------|-------------|
| FlightAware | https://flightaware.com |
| FlightRadar24 | https://flightradar24.com |
| ADSBexchange | https://adsbexchange.com |
| OpenSky Network | https://opensky-network.org |
| dump1090 | https://github.com/flightaware/dump1090 |

---

*Track aircraft from your backyard!*
