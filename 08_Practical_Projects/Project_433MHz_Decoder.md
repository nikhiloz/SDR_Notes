# Project: 433 MHz ISM Band Decoder

> Decode wireless sensors, weather stations, and IoT devices using rtl_433.

---

## 1. Project Overview

| Item          | Details                               |
|---------------|---------------------------------------|
| Difficulty    | Beginner                              |
| SDR required  | RTL-SDR (any)                         |
| Antenna       | Stock antenna or λ/4 whip (17 cm)     |
| Software      | rtl_433                               |
| Frequency     | 433.92 MHz (also 315, 868, 915 MHz)   |
| Cost          | ~$25 (RTL-SDR with stock antenna)     |

## 2. What You Can Decode

| Device Type         | Example Devices              | Data                  |
|--------------------|------------------------------|-----------------------|
| Weather station    | Acurite, Oregon Scientific   | Temp, humidity, rain  |
| Tyre pressure (TPMS)| Most modern cars           | Pressure, temp, ID    |
| Door sensors       | Generic 433 MHz              | Open / closed         |
| Smoke detectors    | Wireless interconnect        | Alarm state           |
| Smart plugs        | Various                      | Energy, state         |
| Doorbells          | Wireless RF                  | Button press          |
| Soil sensors       | Plant moisture monitors      | Moisture %, temp      |
| Pool thermometers  | Floating wireless sensors    | Water temperature     |

## 3. Setup

### Install rtl_433

```bash
# From package manager
sudo apt install rtl-433

# Or from source (latest protocols)
git clone https://github.com/merbanan/rtl_433.git
cd rtl_433 && mkdir build && cd build
cmake .. && make -j$(nproc)
sudo make install
```

### Basic Run

```bash
# Auto-detect everything on 433.92 MHz
rtl_433

# Verbose mode with unknown signals
rtl_433 -A

# JSON output
rtl_433 -F json

# Scan 433 + 868 MHz alternating
rtl_433 -f 433920000 -f 868000000 -H 30
```

## 4. Advanced Usage

### Filter Specific Protocols

```bash
# List all supported protocols (~250+)
rtl_433 -R help

# Only decode Acurite sensors
rtl_433 -R 40 -R 41 -R 42

# Exclude known noisy protocols
rtl_433 -G 4
```

### Home Assistant Integration

```bash
# Feed to MQTT broker
rtl_433 -F "mqtt://192.168.1.100:1883,events=rtl_433[/model][/id]"

# Home Assistant auto-discovers sensors via MQTT Discovery
# Add to configuration.yaml:
# mqtt:
#   sensor:
#     - state_topic: "rtl_433/+/+/temperature_C"
```

### Log to File

```bash
# CSV for spreadsheet analysis
rtl_433 -F csv:sensor_log.csv

# JSON for programmatic analysis
rtl_433 -F json:sensor_log.json

# Both simultaneously
rtl_433 -F csv:log.csv -F json:log.json -F kv
```

## 5. Antenna

### DIY Quarter-Wave Whip

```
     ↑ 17 cm element (λ/4 at 433 MHz)
     │
     │
     SMA connector → SDR

Improvement: Add 4× ground radials (17 cm each) at 45° downward
```

The stock RTL-SDR telescopic antenna works fine for nearby devices. For
longer range, a 433 MHz Yagi or collinear provides significant gain.

## 6. Signal Analysis

When rtl_433 can't auto-decode a signal:

```bash
# Record raw signal
rtl_433 -S unknown -A

# Analyse with Universal Radio Hacker (URH)
pip install urh
urh
# Load saved signal → Interpret → Analyse bit patterns
```

## 7. Example Output

```
time      : 2024-01-15 14:30:22
model     : Acurite-Tower  id        : 12345
channel   : A              battery_ok: 1
temperature_C: 23.4         humidity  : 55

time      : 2024-01-15 14:30:25
model     : TFA-TwinPlus   id        : 87
channel   : 1              battery_ok: 1
temperature_C: 21.7         humidity  : 62
```

## 8. India Notes

- Many imported wireless weather stations use 433.92 MHz
- Car TPMS universally uses 433 MHz in India
- WPC allows 433 MHz ISM at 10 mW (no license)
- Smart home devices (Sonoff RF, etc.) commonly use 433 OOK

---

**See also**: [ISM 433 MHz Protocol](../06_Protocols/ISM_433MHz.md) | [Signal Identification](../07_Spectrum_Analysis/Signal_Identification.md)
