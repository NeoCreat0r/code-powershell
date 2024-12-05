from scapy.all import sniff

ip_mac_map = {}


def process(packet):
    src_ip = packet['ARP'].psrc
    src_mac = packet['Ether'].src
    if src_mac in ip_mac_map.keys():
        if ip_mac_map[src_mac] != src_ip:
            try:
                old_ip = ip_mac_map[src_mac]
            except:
                old_ip = "unknown"
            message = ("\n Possible ARP attack detected \n "
                       + "It is possible that the machine with IP address \n "
                       + str(old_ip) + " is pretending to be " + str(src_ip) + "\n ")
            return message
    else:
        ip_mac_map[src_mac] = src_ip


sniff(count=0, filter="arp", store=0, prn=process)
