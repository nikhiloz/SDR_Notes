# Project: AIS Maritime Receiver

> Track ships and vessels in real-time using RTL-SDR on VHF marine frequencies.

---

## 1. Project Overview

| Item          | Details                               |
|---------------|---------------------------------------|
| Difficulty    | Beginner                              |
| SDR required  | RTL-SDR (any)                         |
| Antenna       | VHF marine whip or DIY quarter-wave   |
| Software      | AIS-catcher + OpenCPN                 |
| Frequency     | 161.975 / 162.025 MHz                 |
| Cost          | ~$30 (SDR + DIY antenna)              |

## 2. Quick Setup

### Install AIS-catcher

```bash
# Build from source
sudo apt install git build-essential cmake librtlsdr-dev
git clone https://github.com/jvde-github/AIS-catcher.git
cd AIS-catcher && mkdir build && cd build
cmake .. && make -j$(nproc)
sudo make install
```

### Run

```bash
# Basic reception
AIS-catcher

# With web interface
AIS-catcher -N 8100

# Open http://localhost:8100 in browser
```

## 3. Antenna

Quarter-wave whip for 162 MHz:

```
     ↑ 46 cm vertical element
     │
     │
  ───┼───  Ground plane (optional for portable use)
     │
    SMA → coax → SDR
```

- Element length: λ/4 ≈ **46 cm** at 162 MHz
- Polarisation: **vertical**
- Placement: outdoor, elevated, line-of-sight to water

## 4. Map Display

### OpenCPN (full chart plotter)

```bash
sudo apt install opencpn
# Connections → Network → TCP → localhost:10110
```

### Feed from AIS-catcher to OpenCPN

```bash
AIS-catcher -u 127.0.0.1 10110
```

### Web-based alternatives

- AIS-catcher's built-in web UI (port 8100)
- MarineTraffic station program
- AISHub community network

## 5. Feeding to Networks

| Network          | URL                        | Benefit              |
|------------------|----------------------------|----------------------|
| MarineTraffic    | marinetraffic.com          | Free premium access  |
| AISHub           | aishub.net                 | Community sharing    |
| VesselFinder     | vesselfinder.com           | Free station gear    |
| ShipXplorer      | shipxplorer.com            | Free subscription    |

```bash
# Feed to MarineTraffic
AIS-catcher -u YOUR_MT_IP YOUR_MT_PORT
```

## 6. Performance

| Factor           | Impact                          |
|------------------|---------------------------------|
| Antenna height   | Critical — VHF is line-of-sight |
| Distance to water| Closer = more traffic           |
| LNA              | Helpful but not critical for strong signals |
| Cable loss       | Keep coax short (<10 m)         |
| Typical range    | 20–60 km depending on antenna   |

## 7. India Coastal Notes

- Active port areas: Mumbai (JNPT), Chennai, Kochi, Kolkata, Visakhapatnam
- Indian Navy and Coast Guard vessels may not transmit AIS
- Fishing vessels <20m may not carry AIS
- Arabian Sea and Bay of Bengal shipping lanes are very active

---

**See also**: [AIS Protocol](../06_Protocols/AIS.md) | [Project: ADS-B Receiver](Project_ADS_B_Receiver.md)
