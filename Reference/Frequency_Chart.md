# RF Frequency Chart

> Quick-reference allocation chart for commonly monitored frequencies with SDR.

---

## 1. HF Bands (3–30 MHz)

| Frequency       | Allocation                  | Notes                      |
|----------------|-----------------------------|----------------------------|
| 2.500 MHz      | WWV time signal             | NIST standard frequency    |
| 3.5–4.0 MHz    | 80m amateur                 | Night propagation          |
| 5.0 MHz        | WWV / WWVH                  | Time and frequency         |
| 5.332 MHz      | USB HFDL                    | Aircraft data link         |
| 7.0–7.3 MHz    | 40m amateur                 | Day + night                |
| 10.0 MHz       | WWV / WWVH                  | Time signal                |
| 10.1–10.15 MHz | 30m amateur                 | CW and digital             |
| 14.0–14.35 MHz | 20m amateur                 | Best DX band               |
| 15.0 MHz       | WWV / WWVH                  | Time signal                |
| 21.0–21.45 MHz | 15m amateur                 | Daytime DX                 |
| 28.0–29.7 MHz  | 10m amateur                 | Solar cycle dependent      |

## 2. VHF Bands (30–300 MHz)

| Frequency         | Allocation                  | Notes                     |
|-------------------|-----------------------------|---------------------------|
| 74.6–75.4 MHz     | Aeronautical marker beacons | —                         |
| 87.5–108.0 MHz    | FM broadcast                | Wideband FM, stereo       |
| 108.0–117.975 MHz | VOR / ILS navigation        | Aviation                  |
| 118.0–136.975 MHz | Airband (AM)                | ATC, pilot communications |
| 137.0–138.0 MHz   | Weather satellites          | NOAA APT, Meteor LRPT     |
| 144.0–148.0 MHz   | 2m amateur                  | FM repeaters, APRS        |
| 148.0–174.0 MHz   | VHF business/paging         | POCSAG pagers             |
| 156.0–162.025 MHz | Marine VHF                  | Ship-to-shore, AIS        |
| 161.975 MHz       | AIS Channel 1               | Vessel tracking           |
| 162.025 MHz       | AIS Channel 2               | Vessel tracking           |
| 162.400–162.550 MHz | NOAA Weather Radio        | USA/Canada weather        |

## 3. UHF Bands (300–3000 MHz)

| Frequency         | Allocation                  | Notes                     |
|-------------------|-----------------------------|---------------------------|
| 315 MHz           | ISM (Americas)              | Key fobs, garage doors    |
| 400.15 MHz        | Radiosondes (weather)       | Weather balloons          |
| 420–450 MHz       | 70cm amateur                | FM repeaters, digital     |
| 433.92 MHz        | ISM (worldwide)             | Sensors, remotes, LoRa    |
| 462–467 MHz       | FRS / GMRS                  | Family / general mobile   |
| 470–608 MHz       | UHF TV (digital)            | DVB-T, ATSC              |
| 840–845 MHz       | RFID UHF                    | Passive tags              |
| 865–867 MHz       | ISM (India)                 | LoRa, IoT                |
| 868 MHz           | ISM (Europe)                | LoRa, IoT                |
| 902–928 MHz       | ISM (Americas)              | LoRa, IoT                |
| 935–960 MHz       | GSM downlink                | Mobile phone base station |
| 1090 MHz          | ADS-B (Mode S)              | Aircraft tracking        |
| 1176.45 MHz       | GPS L5 / NavIC L5           | Navigation satellite      |
| 1227.60 MHz       | GPS L2                      | Navigation satellite      |
| 1575.42 MHz       | GPS L1                      | Navigation satellite      |
| 1602.0 MHz        | GLONASS L1                  | Russian navigation        |
| 2.4 GHz           | ISM (WiFi, Bluetooth)       | Very crowded              |

## 4. India-Specific Frequencies

### FM Broadcast

| City      | Station              | Frequency   |
|-----------|----------------------|-------------|
| Delhi     | All India Radio FM   | 102.6 MHz   |
| Mumbai    | Radio Mirchi          | 98.3 MHz    |
| Bangalore | Radio City           | 91.1 MHz    |
| Chennai   | Suryan FM            | 93.5 MHz    |
| Kolkata   | Fever FM             | 104.0 MHz   |

### All India Radio MW (Medium Wave)

| Frequency   | Service               |
|-------------|-----------------------|
| 666 kHz     | AIR Delhi (A)         |
| 819 kHz     | AIR Kolkata           |
| 936 kHz     | AIR Mumbai            |
| 1008 kHz    | AIR Chennai           |
| 1134 kHz    | AIR Bangalore         |

### Indian Amateur Radio Allocations

| Band  | Frequency         | Allocation     |
|-------|-------------------|----------------|
| 80m   | 3.5–3.9 MHz       | CW, SSB, Digi  |
| 40m   | 7.0–7.2 MHz       | CW, SSB, Digi  |
| 20m   | 14.0–14.35 MHz    | CW, SSB, Digi  |
| 2m    | 144–146 MHz       | FM, CW, SSB    |
| 70cm  | 430–440 MHz       | FM, digital    |

Indian amateur licence classes: **Restricted**, **General**, **Advanced**
(WPC licensing under Indian Telegraph Act)

### ISM / IoT Bands

| Band           | Use               | Max Power   |
|----------------|-------------------|-------------|
| 433 MHz        | Short-range devices| 10 mW      |
| 865–867 MHz    | LoRa / IoT        | 1 W (EIRP) |
| 2.4 GHz        | WiFi, BT          | 4 W (EIRP) |

## 5. Satellite Frequencies

| Satellite Service | Downlink          | Notes                    |
|-------------------|-------------------|--------------------------|
| NOAA APT          | 137.x MHz         | Weather images (VHF)     |
| Meteor LRPT       | 137.9 MHz         | Digital weather images   |
| Iridium           | 1616–1626.5 MHz   | Satellite phone          |
| Inmarsat          | 1525–1559 MHz     | Maritime/aero satcom     |
| GOES (HRIT)       | 1694.1 MHz        | Weather (dish required)  |
| Starlink           | 10.7–12.7 GHz    | Ku-band downlink         |

## 6. Emergency & Distress

| Frequency   | Use                        |
|-------------|----------------------------|
| 121.5 MHz   | Aviation emergency          |
| 156.8 MHz   | Marine Channel 16 (distress)|
| 243.0 MHz   | Military emergency          |
| 406 MHz     | EPIRB / PLB (satellite)     |

---

**See also**: [Antenna Reference](Antenna_Reference.md) | [Unit Conversions](Unit_Conversions.md) | [Signal Identification](../07_Spectrum_Analysis/Signal_Identification.md)
