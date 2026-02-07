# Project: ADS-B Aircraft Receiver

> Track aircraft in real-time using an RTL-SDR and feed data to flight tracking networks.

---

## 1. Project Overview

| Item          | Details                               |
|---------------|---------------------------------------|
| Difficulty    | Beginner                              |
| SDR required  | RTL-SDR (V3/V4 recommended)           |
| Antenna       | 1090 MHz ground-plane or collinear    |
| Software      | dump1090 / readsb / tar1090           |
| Frequency     | 1090 MHz                              |
| Cost          | ~$30–50 (SDR + antenna)               |

## 2. How ADS-B Works

Aircraft broadcast **Mode S Extended Squitter** messages at **1090 MHz** containing:

- ICAO 24-bit address (unique aircraft ID)
- Position (latitude, longitude, altitude)
- Velocity (ground speed, heading, vertical rate)
- Callsign / flight number
- Squawk code

```
┌──────────┐    1090 MHz    ┌──────────┐    HTTP    ┌──────────┐
│  Aircraft │ ─────────────►│  RTL-SDR  │ ─────────►│  Browser  │
│  ADS-B TX │  PPM pulses   │  dump1090 │  :8080    │  Map View │
└──────────┘                └──────────┘            └──────────┘
```

## 3. Antenna Build

### Quarter-Wave Ground Plane (recommended for beginners)

```
            ↑ Vertical element: 69 mm (λ/4 at 1090 MHz)
            │
            │
     ───────┼───────  Ground plane: 4× radials, 69 mm each
     ╲      │      ╱   drooping at ~45°
      ╲     │     ╱
       ╲    │    ╱
        ╲   │   ╱
         └──┴──┘
           SMA connector → coax → SDR
```

Materials: SMA chassis connector, stiff copper wire, solder.

## 4. Software Setup

### Option A: dump1090-mutability (classic)

```bash
sudo apt install rtl-sdr librtlsdr-dev build-essential pkg-config
git clone https://github.com/flightaware/dump1090.git
cd dump1090
make
./dump1090 --interactive --net
# Open http://localhost:8080 in browser
```

### Option B: readsb + tar1090 (modern, recommended)

```bash
# One-line installer
sudo bash -c "$(wget -qO- https://github.com/wiedehopf/adsb-scripts/raw/master/readsb-install.sh)"

# Install tar1090 web interface
sudo bash -c "$(wget -qO- https://github.com/wiedehopf/tar1090/raw/master/install.sh)"

# Open http://localhost/tar1090
```

### Option C: Docker

```bash
docker run -d \
  --name readsb \
  --device=/dev/bus/usb \
  -p 8080:8080 \
  -p 30005:30005 \
  ghcr.io/sdr-enthusiasts/docker-readsb-protobuf
```

## 5. Performance Tuning

| Parameter      | Recommendation             |
|----------------|----------------------------|
| Gain           | Start at max, reduce if saturated |
| LNA            | 1090 MHz filtered LNA (saw + LNA) |
| Antenna height | As high as possible, clear sky view |
| Cable          | Short, low-loss coax (LMR-240+) |
| Max range      | ~200–400 km with good setup |

## 6. Feeding Flight Tracking Networks

| Network         | Benefit                    | Feed Setup             |
|-----------------|---------------------------|------------------------|
| FlightAware     | Free Enterprise account    | piaware package        |
| Flightradar24   | Free Business subscription | fr24feed package       |
| ADSBexchange    | Community, no filtering    | adsb-exchange scripts  |
| OpenSky Network | Academic use               | opensky-feeder         |

```bash
# Example: Feed to FlightAware
sudo bash -c "$(wget -qO- https://www.flightaware.com/adsb/piaware/install)"
```

## 7. India-Specific Notes

- Major airports (DEL, BOM, BLR, MAA, HYD) have heavy ADS-B traffic
- Indian military aircraft generally do not broadcast ADS-B
- Domestic airlines (IndiGo, Air India, SpiceJet) are ADS-B equipped
- Best ranges achieved in flat terrain (Indo-Gangetic plain)
- Coastal sites can track aircraft approaching from sea routes

## 8. Script

See [scripts/adsb_setup.sh](scripts/adsb_setup.sh) for automated setup.

---

**See also**: [ADS-B Decoding](../06_Protocols/ADS-B_Decoding.md) | [FM Broadcast Receiver](FM_Broadcast_Receiver.md) | [Antenna Reference](../Reference/Antenna_Reference.md)
