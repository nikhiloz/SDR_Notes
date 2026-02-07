# ISM 433 MHz — Decoding Unlicensed Device Signals

> Monitor and decode wireless sensors, weather stations, doorbells, car remotes, and other ISM-band devices using rtl_433.

---

## 1. What Is ISM 433 MHz?

The **433.92 MHz ISM band** is a licence-free frequency allocation used by millions
of consumer devices for short-range wireless communication. Being unencrypted and
simple, these signals are easy to receive and decode with SDR.

```
┌──────────────┐                  ┌──────────────┐
│ Weather Stn  │ ──┐              │              │
│ Car Remote   │ ──┤  433.92 MHz  │  RTL-SDR     │
│ Doorbell     │ ──┼─────────────►│  + rtl_433   │
│ Temp Sensor  │ ──┤   OOK/FSK   │              │
│ TPMS         │ ──┘              │              │
└──────────────┘                  └──────────────┘
```

## 2. ISM Band Allocations

| Region       | Frequency       | Bandwidth | Power Limit |
|-------------|-----------------|-----------|-------------|
| Europe       | 433.05–434.79   | 1.74 MHz  | 10 mW ERP   |
| Americas     | 433.05–434.79   | 1.74 MHz  | Varies      |
| **India**    | **433–434 MHz** | **1 MHz** | **10 mW**   |
| Also common  | 315 MHz (US)    | —         | FCC Part 15 |
| Also common  | 868 MHz (EU)    | —         | 25 mW       |
| Also common  | 915 MHz (US)    | —         | 1 W         |

## 3. Common Modulation Schemes

| Modulation | Description                    | Devices                |
|------------|--------------------------------|------------------------|
| **OOK**    | On-Off Keying (AM pulse)       | Remotes, doorbells     |
| **ASK**    | Amplitude Shift Keying         | Weather stations       |
| **FSK**    | Frequency Shift Keying         | Sensors, TPMS          |
| **GFSK**   | Gaussian FSK                   | Smart home, LoRa       |

## 4. Decoding with rtl_433

**rtl_433** is the Swiss Army knife for ISM-band decoding. It supports
**250+ device protocols** out of the box.

### Installation

```bash
# Ubuntu/Debian
sudo apt install rtl-433

# Or build latest from source
git clone https://github.com/merbanan/rtl_433.git
cd rtl_433 && mkdir build && cd build
cmake .. && make -j$(nproc)
sudo make install
```

### Basic Usage

```bash
# Auto-detect all protocols on 433.92 MHz
rtl_433

# Specify frequency
rtl_433 -f 433920000

# JSON output for processing
rtl_433 -F json

# Log to file
rtl_433 -F json -F "log:sensor_log.json"

# Filter specific protocol
rtl_433 -R 40    # protocol #40 = Acurite 592TXR

# Scan multiple frequencies
rtl_433 -f 433920000 -f 868000000 -H 30
```

### Sample Output

```json
{
  "time": "2024-01-15 10:30:45",
  "model": "Acurite-Tower",
  "id": 12345,
  "channel": "A",
  "battery_ok": 1,
  "temperature_C": 23.4,
  "humidity": 55
}
```

## 5. Common Decodable Devices

| Device Type        | Protocol          | Data                    |
|--------------------|-------------------|-------------------------|
| Weather station    | Oregon, Acurite   | Temp, humidity, wind    |
| Tyre pressure (TPMS) | Various        | Pressure, temp, ID      |
| Door/window sensor | Various OOK      | Open/closed state       |
| Car key fob        | Rolling code      | Cannot replay (secure)  |
| Smart plug         | Various           | On/off state            |
| Soil moisture      | Various           | Moisture %, temp        |

## 6. Signal Analysis

### Using Universal Radio Hacker (URH)

```bash
# Install URH for manual signal analysis
pip install urh
urh    # Launch GUI

# Workflow:
# 1. Record signal → 2. Interpret modulation → 3. Decode bits
# 4. Assign protocol fields → 5. Generate/replay (TX capable SDR)
```

### Using Inspectrum

```bash
# Record raw IQ
rtl_sdr -f 433920000 -s 1000000 -n 2000000 capture.raw

# Analyse
inspectrum capture.raw
```

## 7. Home Automation Integration

```bash
# Pipe rtl_433 JSON to MQTT for Home Assistant
rtl_433 -F "mqtt://localhost:1883,events=rtl_433/events"

# Home Assistant auto-discovers sensors via MQTT
```

## 8. India-Specific Notes

- 433 MHz ISM is allocated for **low-power devices** under WPC rules
- Many imported wireless weather stations and sensors use 433.92 MHz
- **865–867 MHz** is also available for IoT (see [LoRa](LoRa.md))
- Indian car key fobs often use 433.92 MHz rolling-code OOK

---

**See also**: [LoRa](LoRa.md) | [FSK Modulation](../05_Modulation/FSK.md) | [Project: 433 MHz Decoder](../08_Practical_Projects/Project_433MHz_Decoder.md)
