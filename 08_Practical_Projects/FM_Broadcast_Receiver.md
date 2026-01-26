# FM Broadcast Receiver

> **Project: FM Radio** - Build a complete FM broadcast receiver with SDR.

---

## 📖 Project Overview

| Aspect | Details |
|--------|---------|
| **Difficulty** | Beginner |
| **Time** | 30 minutes |
| **Hardware** | RTL-SDR + antenna |
| **Software** | GNU Radio / SDR++ / rtl_fm |
| **Skills Learned** | WFM demod, stereo, RDS |

---

## 🎯 Objectives

By completing this project you will:

1. ✅ Receive FM broadcast stations
2. ✅ Understand WFM demodulation
3. ✅ Decode stereo audio
4. ✅ Extract RDS data
5. ✅ Build a GNU Radio flowgraph

---

## 🛠️ Requirements

### Hardware

| Component | Purpose |
|-----------|---------|
| RTL-SDR dongle | RF reception |
| FM antenna | Signal capture |
| Computer | Processing |
| Speakers/headphones | Audio output |

### Software

| Option | Platform | Complexity |
|--------|----------|------------|
| SDR++ | Any | Easiest |
| GQRX | Linux/Mac | Easy |
| rtl_fm | Any | CLI |
| GNU Radio | Any | Most flexible |

---

## 📻 Method 1: SDR++ (Easiest)

### Steps

The following procedure receives FM with SDR++:

```
    SDR++ FM RECEPTION
    
    Step 1: Start SDR++
    ┌─────────────────────────────────────────┐
    │ Launch SDR++ application                │
    └─────────────────────────────────────────┘
    
    Step 2: Select Source
    ┌─────────────────────────────────────────┐
    │ Source → RTL-SDR                        │
    │ Sample Rate → 2.4 MSPS                  │
    │ Click Start (▶)                         │
    └─────────────────────────────────────────┘
    
    Step 3: Tune to FM Band
    ┌─────────────────────────────────────────┐
    │ Set frequency to 88-108 MHz             │
    │ Click on strong signal in waterfall     │
    └─────────────────────────────────────────┘
    
    Step 4: Select WFM Mode
    ┌─────────────────────────────────────────┐
    │ Radio → WFM                             │
    │ Enable Stereo if desired                │
    │ Adjust volume                           │
    └─────────────────────────────────────────┘
```

---

## 💻 Method 2: Command Line (rtl_fm)

### Basic Mono FM

```bash
# Listen to 100.3 MHz FM
rtl_fm -M wbfm -f 100.3M -s 200000 -r 48000 - | aplay -r 48000 -f S16_LE
```

### Parameters Explained

| Parameter | Value | Meaning |
|-----------|-------|---------|
| -M wbfm | | Wideband FM mode |
| -f 100.3M | | Center frequency |
| -s 200000 | | Sample rate (200 kHz) |
| -r 48000 | | Audio output rate |
| - | | Output to stdout |

### Stereo FM with sox

```bash
rtl_fm -M wbfm -f 100.3M -s 200000 -A std -l 0 -E deemp - | \
    sox -t raw -r 200000 -e signed -b 16 -c 1 - -t raw - rate 48000 | \
    aplay -r 48000 -f S16_LE
```

---

## 🔧 Method 3: GNU Radio

### Flowgraph Overview

```
    GNU RADIO WFM RECEIVER FLOWGRAPH
    
    ┌─────────────────────────────────────────────────────────────────────┐
    │                                                                      │
    │  ┌──────────────┐   ┌──────────────┐   ┌──────────────────────────┐│
    │  │   RTL-SDR    │──▶│   Low Pass   │──▶│      WBFM Receive        ││
    │  │   Source     │   │    Filter    │   │                          ││
    │  │              │   │              │   │  - Quadrature Rate: 480k ││
    │  │ Fc: 100.3M   │   │ Cutoff: 100k │   │  - Audio Decimation: 10  ││
    │  │ Fs: 2.4M     │   │ Width: 20k   │   │                          ││
    │  └──────────────┘   └──────────────┘   └────────────┬─────────────┘│
    │                                                      │              │
    │                                         ┌────────────┘              │
    │                                         │                           │
    │                                         ▼                           │
    │                          ┌──────────────────────────┐              │
    │                          │      Audio Sink          │              │
    │                          │                          │              │
    │                          │  Sample Rate: 48000      │              │
    │                          │                          │              │
    │                          └──────────────────────────┘              │
    │                                                                      │
    └─────────────────────────────────────────────────────────────────────┘
```

### Block Configuration

| Block | Key Parameters |
|-------|---------------|
| **RTL-SDR Source** | fc=100.3e6, sample_rate=2.4e6 |
| **Low Pass Filter** | cutoff=100e3, width=20e3 |
| **WBFM Receive** | quad_rate=480e3, audio_decimation=10 |
| **Audio Sink** | sample_rate=48000 |

### Python Code (gr-python)

```python
#!/usr/bin/env python3
from gnuradio import gr, blocks, filter, analog, audio
import osmosdr

class fm_receiver(gr.top_block):
    def __init__(self, freq=100.3e6):
        gr.top_block.__init__(self, "FM Receiver")
        
        # Parameters
        samp_rate = 2.4e6
        audio_rate = 48000
        quad_rate = 480e3
        
        # RTL-SDR Source
        self.source = osmosdr.source(args="numchan=1")
        self.source.set_sample_rate(samp_rate)
        self.source.set_center_freq(freq)
        self.source.set_gain_mode(True)
        
        # Low Pass Filter
        lpf_taps = filter.firdes.low_pass(1, samp_rate, 100e3, 20e3)
        self.lpf = filter.fir_filter_ccf(int(samp_rate/quad_rate), lpf_taps)
        
        # WBFM Demodulator
        self.wbfm = analog.wfm_rcv(
            quad_rate=quad_rate,
            audio_decimation=int(quad_rate/audio_rate)
        )
        
        # Audio Sink
        self.audio_sink = audio.sink(audio_rate)
        
        # Connect
        self.connect(self.source, self.lpf, self.wbfm, self.audio_sink)

if __name__ == '__main__':
    receiver = fm_receiver(freq=100.3e6)
    receiver.run()
```

---

## 🎵 Stereo FM Decoding

### MPX Signal Structure

```
    FM STEREO MULTIPLEX (MPX)
    
    Baseband after FM demod:
    
    ┌────────────────────────────────────────────────────────────────┐
    │                                                                 │
    │    L+R (Mono)     19kHz     L-R (Stereo)      RDS              │
    │    ┌───────┐       │        ┌───────┐       ┌───────┐          │
    │    │       │       ▼        │       │       │       │          │
    │    │       │      ╱╲       │       │       │       │          │
    │    └───────┘               └───────┘       └───────┘          │
    │                                                                 │
    └────┴───────┴───────┴───────┴───────┴───────┴───────┴──────────┘
         0      15k      19k     23k     53k    57k    76k   Hz
    
    Pilot tone at 19 kHz synchronizes stereo decoding
```

### Stereo Decoder Flow

| Step | Operation |
|------|-----------|
| 1 | Demodulate WFM to get MPX |
| 2 | Extract 19 kHz pilot with PLL |
| 3 | Generate 38 kHz from pilot |
| 4 | Mix L-R with 38 kHz |
| 5 | Filter L-R to audio band |
| 6 | Add/subtract: L=(L+R)+(L-R), R=(L+R)-(L-R) |

---

## 📡 RDS Decoding

### What is RDS?

Radio Data System transmits digital data:

| Field | Content |
|-------|---------|
| PI | Program Identification |
| PS | Program Service (station name) |
| RT | Radio Text (scrolling text) |
| PTY | Program Type (genre) |
| TA | Traffic Announcement |
| AF | Alternative Frequencies |

### RDS with GNU Radio

```
    RDS DECODER ADDITION
    
    MPX ──▶ ┌────────────┐   ┌────────────┐   ┌────────────┐
            │  BPF       │──▶│   RDS      │──▶│   RDS      │
            │ 57 kHz     │   │   Decoder  │   │   Parser   │
            │ ±2 kHz     │   │            │   │            │
            └────────────┘   └────────────┘   └─────┬──────┘
                                                    │
                                                    ▼
                                               Station: WXYZ
                                               Now Playing: Song
```

---

## 📊 Performance Tuning

### Signal Quality Indicators

| Indicator | Good | Poor |
|-----------|------|------|
| Signal level | -30 to -50 dBm | Below -70 dBm |
| Stereo pilot | Clear 19 kHz | Weak/absent |
| Audio quality | Clean | Noisy/distorted |
| RDS decode | Stable text | Garbled |

### Optimization Tips

| Issue | Solution |
|-------|----------|
| Weak signal | Better antenna, add LNA |
| Noise | Reduce bandwidth, add filter |
| No stereo | Check pilot, mono fallback |
| Distortion | Reduce gain |

---

## 🔊 De-emphasis

### What is De-emphasis?

FM broadcasts use pre-emphasis (boost high frequencies) at transmitter. Receiver applies matching de-emphasis:

```
    DE-EMPHASIS FILTER
    
    Gain (dB)
    ▲
    │  Before de-emphasis
    │  ╱
    │ ╱
    │╱                    After de-emphasis
    └─────────────────────────────────────────▶ Freq
                          (flat)
```

### Time Constants

| Region | τ (time constant) |
|--------|-------------------|
| North America | 75 μs |
| Europe | 50 μs |

---

## ✅ Project Checklist

| Task | Status |
|------|--------|
| Install software | ☐ |
| Connect RTL-SDR | ☐ |
| Tune to FM station | ☐ |
| Hear mono audio | ☐ |
| Enable stereo | ☐ |
| Decode RDS (optional) | ☐ |
| Save as preset | ☐ |

---

## 🚀 Extensions

### Try These Next

| Extension | Difficulty |
|-----------|------------|
| Scan entire FM band | Easy |
| Record favorite station | Easy |
| Build stereo decoder in GNU Radio | Medium |
| Add RDS decoder | Medium |
| Make auto-scanning receiver | Hard |

---

*Your first SDR project - FM radio!*
