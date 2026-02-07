# POCSAG — Pager Protocol Decoding

> Decode pager messages on UHF frequencies using multimon-ng and any RTL-SDR dongle.

---

## 1. What Is POCSAG?

**POCSAG** (Post Office Code Standardisation Advisory Group) is a one-way paging
protocol still widely used by hospitals, emergency services, and restaurants.
Messages are transmitted unencrypted on UHF frequencies.

```
┌──────────────┐    UHF (150-470 MHz)    ┌─────────────┐
│  Paging       │ ──────────────────────► │  RTL-SDR     │
│  Transmitter  │    FSK @ 512/1200/      │  + Decoder   │
└──────────────┘    2400 bps              └──────┬──────┘
                                                 │
                                          ┌──────▼──────┐
                                          │  multimon-ng │
                                          │  (text out)  │
                                          └─────────────┘
```

## 2. Protocol Details

| Parameter       | Value                              |
|-----------------|------------------------------------|
| Modulation      | 2-FSK (±4.5 kHz deviation)         |
| Baud rates      | 512, 1200, or 2400 bps             |
| Encoding        | BCH(31,21) error correction        |
| Message types   | Numeric, alphanumeric, tone-only   |
| Bandwidth       | ~12.5 kHz channel                  |

### Frame Structure

```
┌───────────┬──────────┬──────────┬──────────┐
│ Preamble  │ Sync     │ Batch 1  │ Batch 2… │
│ 576 bits  │ 32 bits  │ 544 bits │          │
│ (101010…) │ 7CD215D8 │ 16 CW/8F │          │
└───────────┴──────────┴──────────┴──────────┘
```

Each batch contains **16 codewords** in **8 frames**. Address codewords identify
the recipient; message codewords carry the payload.

## 3. Common Frequencies

| Region       | Frequency Range     | Notes                |
|-------------|--------------------|-----------------------|
| Europe       | 148–174 MHz        | VHF paging            |
| USA          | 152, 157, 462 MHz  | Various carriers      |
| Australia    | 148, 157 MHz       | Hospital/emergency    |
| India        | 147–174 MHz        | Limited commercial    |

> **Note**: Frequencies vary by city and service. Use your SDR to scan and identify
> active pager transmitters in your area.

## 4. Decoding with RTL-SDR

### Using multimon-ng (recommended)

```bash
# Install
sudo apt install multimon-ng rtl-sdr sox

# Decode (replace FREQ with found frequency)
rtl_fm -f 148800000 -s 22050 -g 40 - | \
    multimon-ng -t raw -a POCSAG512 -a POCSAG1200 -a POCSAG2400 -f alpha -
```

### Output Example

```
POCSAG1200: Address: 1234567  Function: 0  Alpha:   FIRE STATION 5 - STRUCTURE FIRE
POCSAG1200: Address: 2345678  Function: 3  Numeric: 5551234
```

### Using PDW (Windows)

PDW is a dedicated pager decoder with GUI, frequency database, and filtering.
Runs under Wine on Linux.

## 5. Finding Active Frequencies

1. Open **SDR++** or **GQRX**
2. Tune to your region's paging band (e.g., 148–174 MHz)
3. Look for **regular bursts** of ~12.5 kHz wide FSK signals
4. POCSAG has a distinctive "warbling" sound in NFM mode
5. Note the frequency and feed it to multimon-ng

## 6. Legal Considerations

- **Receiving** pager signals is legal in most countries (passive listening)
- **Publishing** or **acting on** intercepted messages may violate privacy laws
- Use for educational purposes and RF analysis only
- Some jurisdictions require that intercepted content not be disclosed

## 7. Related Protocols

| Protocol  | Type      | Speed      | Status            |
|-----------|-----------|------------|-------------------|
| POCSAG    | 1-way     | 512–2400   | Still active      |
| FLEX      | 1-way     | 1600–6400  | Declining         |
| ERMES     | 1-way     | 6250       | Mostly retired    |
| DAPNET    | 2-way ham | 1200       | Amateur radio net |

---

**See also**: [FSK Modulation](../05_Modulation/FSK.md) | [Project: Pager Decoder](../08_Practical_Projects/Project_Pager_Decoder.md)
