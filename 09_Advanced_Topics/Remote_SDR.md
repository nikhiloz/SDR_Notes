# Remote SDR Access

> Access SDR receivers over the network — run the SDR on a remote machine and control it from anywhere.

---

## 1. Why Remote SDR?

- **Antenna placement**: SDR near the antenna (rooftop), control from desk
- **Noise reduction**: Keep noisy PC away from the receiver
- **Shared access**: Multiple users access one SDR
- **Travel**: Access your home SDR from anywhere via VPN

```
┌──────────┐    Coax    ┌──────────┐    Network    ┌──────────┐
│  Antenna  │ ─────────►│  SDR +   │ ────────────► │  Client  │
│  (roof)   │           │  Server  │   TCP/UDP     │  (desk)  │
└──────────┘            │  (Pi/PC) │               └──────────┘
                        └──────────┘
```

## 2. Solutions Overview

| Method            | SDR Support   | Latency  | Setup       |
|-------------------|---------------|----------|-------------|
| **rtl_tcp**       | RTL-SDR only  | Low      | Trivial     |
| **SoapyRemote**   | Any SoapySDR  | Low      | Easy        |
| **SpyServer**     | Airspy family | Very low | Easy        |
| **GNU Radio ZMQ** | Any           | Medium   | Moderate    |
| **WebSDR/OpenWebRX** | Any       | Medium   | Moderate    |
| **KiwiSDR**       | KiwiSDR HW   | Low      | Turnkey     |

## 3. rtl_tcp (RTL-SDR)

### Server Side

```bash
# Start server (default port 1234)
rtl_tcp -a 0.0.0.0 -p 1234 -g 40

# With specific device and sample rate
rtl_tcp -a 0.0.0.0 -p 1234 -d 0 -s 2400000
```

### Client Side

In SDR++, GQRX, or SDR#:
1. Select source: **RTL-SDR TCP**
2. Enter server IP and port (1234)
3. Connect and tune normally

```bash
# Or use rtl_fm remotely via netcat
# Server: rtl_tcp -a 0.0.0.0
# Client: ... connect via TCP in your SDR app
```

### Limitations

- Streams raw IQ over TCP → high bandwidth (~4.8 MB/s at 2.4 MSPS)
- Works over LAN; over internet needs VPN or SSH tunnel
- Only supports RTL-SDR devices

## 4. SoapyRemote (Universal)

Works with any SoapySDR-supported device (RTL-SDR, Airspy, LimeSDR, PlutoSDR, etc.).

### Server

```bash
sudo apt install soapyremote-server

# Start server
SoapySDRServer --bind="0.0.0.0:55132"
```

### Client

```bash
# In SDR++ or GNU Radio, select SoapySDR source
# Set device string: remote:driver=rtlsdr,remote=192.168.1.100

# Test from command line
SoapySDRUtil --find="remote:remote=192.168.1.100"
```

## 5. SpyServer (Airspy)

Extremely efficient streaming — supports many simultaneous clients with minimal bandwidth.

### Server

```bash
# Download from airspy.com
wget https://airspy.com/downloads/spyserver-linux-x86.tgz
tar xzf spyserver-linux-x86.tgz
# Edit spyserver.config: device_type, center_frequency, gain
./spyserver
```

### Client

SDR++ and SDR# natively support SpyServer connections.

### Advantages

- Server-side decimation → low bandwidth
- Multiple clients on different frequencies simultaneously
- Very low CPU usage on server

## 6. OpenWebRX+ (Web-Based)

Full SDR receiver accessible from any web browser.

```bash
# Install on Raspberry Pi or server
sudo apt install openwebrx

# Or Docker
docker run -d --name openwebrx \
    --device=/dev/bus/usb \
    -p 8073:8073 \
    slechev/openwebrxplus

# Access: http://server-ip:8073
```

Features:
- Web-based waterfall and spectrum
- Multiple demodulators (AM, FM, SSB, digital)
- Multi-user access
- No client software needed

## 7. Bandwidth Requirements

| Sample Rate | Bit Depth | Bandwidth    | Over Internet? |
|-------------|-----------|--------------|----------------|
| 250 kHz     | 8-bit     | 0.5 MB/s     | Yes (VPN)      |
| 1 MHz       | 8-bit     | 2 MB/s       | Marginal       |
| 2.4 MHz     | 8-bit     | 4.8 MB/s     | No (LAN only)  |
| 2.4 MHz     | 16-bit    | 9.6 MB/s     | No (LAN only)  |

### Reducing Bandwidth

- **Server-side decimation**: SpyServer, SoapyRemote with reduced rate
- **Compression**: Some servers support zlib compression
- **Reduced bandwidth**: Request only the BW you need

## 8. Security

| Concern          | Solution                          |
|------------------|-----------------------------------|
| Open port        | VPN (Tailscale, WireGuard)        |
| Unencrypted      | SSH tunnel or VPN                 |
| Authentication   | OpenWebRX has user auth           |
| DDoS             | Firewall + rate limiting          |

```bash
# SSH tunnel for rtl_tcp
ssh -L 1234:localhost:1234 user@sdr-server
# Then connect client to localhost:1234

# Tailscale (recommended for easy remote access)
# Install on both machines → access via Tailscale IP
```

---

**See also**: [Software Overview](../03_Software/GNU_Radio.md) | [Hardware Comparison](../02_Hardware/Hardware_Comparison.md)
