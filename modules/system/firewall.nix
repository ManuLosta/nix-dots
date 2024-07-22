_: {
  networking.firewall = {
    allowedUDPPorts = [5353]; # For device discovery
    allowedUDPPortRanges = [
      {
        from = 32768;
        to = 61000;
      }
    ]; # For Streaming
    allowedTCPPorts = [8010]; # For gnomecast server
  };
}
