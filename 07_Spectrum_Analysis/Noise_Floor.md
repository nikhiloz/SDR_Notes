# Noise Floor & Sensitivity

> Understanding noise floor, thermal noise, SNR, and how they determine what you can receive.

---

## 1. What Is the Noise Floor?

The **noise floor** is the sum of all unwanted signal energy in your receiver's
bandwidth. It sets the **minimum detectable signal** — any signal below the noise
floor is invisible.

```
 Power
   ▲
   │         ┌──┐
   │    ┌─┐  │  │    ← Detectable signals (above noise floor)
   │    │ │  │  │
   │────┤ ├──┤  ├── ← Noise floor
   │ ░░░│ │░░│  │░░░
   │ ░░░└─┘░░└──┘░░░  ← Buried in noise (undetectable)
   └─────────────────► Frequency
```

## 2. Sources of Noise

| Source              | Type           | Mitigation                    |
|---------------------|----------------|-------------------------------|
| **Thermal noise**   | Fundamental    | Cool receiver / narrow BW     |
| **Quantisation**    | ADC            | Higher bit depth              |
| **Phase noise**     | Oscillator     | Better LO / TCXO             |
| **Intermodulation** | Non-linearity  | Reduce gain / add filtering   |
| **External RFI**    | Environment    | Shielding, antenna placement  |
| **USB noise**       | Computer       | Ferrite chokes, USB isolator  |

## 3. Thermal Noise

The theoretical minimum noise power:

$$
P_n = kTB
$$

Where:
- $k$ = Boltzmann's constant = $1.38 \times 10^{-23}$ J/K
- $T$ = Temperature in Kelvin (290K at room temp)
- $B$ = Bandwidth in Hz

In dBm:

$$
P_n(\text{dBm}) = -174 + 10\log_{10}(B)
$$

### Thermal Noise Floor by Bandwidth

| Bandwidth   | Noise Floor (dBm) | Typical Use              |
|-------------|-------------------|--------------------------|
| 1 Hz        | −174              | Theoretical minimum      |
| 500 Hz      | −147              | CW reception             |
| 3 kHz       | −139              | SSB voice                |
| 12.5 kHz    | −133              | NFM radio                |
| 200 kHz     | −121              | FM broadcast             |
| 2.4 MHz     | −110              | RTL-SDR full bandwidth   |

## 4. Signal-to-Noise Ratio (SNR)

$$
SNR(\text{dB}) = P_{signal}(\text{dBm}) - P_{noise}(\text{dBm})
$$

### Minimum SNR for Demodulation

| Modulation | Min SNR (dB) | Notes                     |
|------------|-------------- |---------------------------|
| AM         | 10           | Understandable voice      |
| NFM        | 12           | Clear voice               |
| SSB        | 5            | Understandable            |
| POCSAG     | 6            | Reliable decode           |
| ADS-B      | 10           | Reliable decode           |
| DMR        | 8            | Digital threshold         |

## 5. Noise Figure (NF)

The noise figure quantifies how much noise a device **adds** to the signal:

$$
NF(\text{dB}) = SNR_{in}(\text{dB}) - SNR_{out}(\text{dB})
$$

### Typical Noise Figures

| Device              | NF (dB) | Notes                    |
|---------------------|---------|--------------------------|
| RTL-SDR (no LNA)    | 6–8    | V3 with bias-T LNA: ~3  |
| Airspy Mini          | 3.5    | Built-in LNA             |
| HackRF One           | 10–15  | Relatively poor NF       |
| LimeSDR              | 6–8    | Depends on frequency     |
| External LNA (good)  | 0.5–1  | SAWbird, Nooelec         |

### Cascaded Noise Figure (Friis Formula)

$$
NF_{total} = NF_1 + \frac{NF_2 - 1}{G_1} + \frac{NF_3 - 1}{G_1 G_2} + \cdots
$$

> **Key insight**: The first amplifier's noise figure dominates. A good LNA
> at the antenna vastly improves system sensitivity.

## 6. Improving Your Noise Floor

| Technique              | Improvement           | Difficulty |
|------------------------|-----------------------|-----------|
| Add LNA at antenna     | 3–10 dB               | Easy      |
| Use bandpass filter     | Reduces out-of-band   | Easy      |
| Ferrite on USB cable    | Reduces USB RFI       | Easy      |
| Move antenna outdoors   | Less indoor noise     | Medium    |
| Use shielded enclosure  | Reduces SDR self-noise| Medium    |
| Higher-quality SDR      | Lower noise figure    | $$        |
| Longer integration      | √N improvement        | Software  |

## 7. Measuring Your Noise Floor

```bash
# 1. Disconnect antenna (terminate with 50Ω load)
# 2. Set gain to 0
# 3. Observe power level → this is your receiver's internal noise floor
# 4. Connect antenna
# 5. Observe new floor → this includes external noise

# With rtl_power (wideband spectrum scan)
rtl_power -f 100M:1G:1M -g 0 -i 10 -e 60 noise_floor.csv

# Plot with gnuplot or heatmap.py
python3 heatmap.py noise_floor.csv noise_floor.png
```

---

**See also**: [Spectrum Basics](Spectrum_Basics.md) | [Spurious Signals](Spurious_Signals.md) | [AGC](../04_DSP_Fundamentals/AGC.md)
