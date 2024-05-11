* "spice" description for "standard_cell_spice", "mux_2", "spiceText" 


simulator lang=spice

.SUBCKT mux_2 A0 A1 S VGND VNB VPB VPWR M
M0 VPWR S a_218_374# VPB pfet_01v8_hvt w=0.42u l=0.15u
M1 a_76_199# A0 a_439_47# VNB nfet_01v8 w=0.42u l=0.15u
M2 a_535_374# a_505_21# VPWR VPB pfet_01v8_hvt w=0.42u l=0.15u
M3 VPWR S a_505_21# VPB pfet_01v8_hvt w=0.42u l=0.15u
M4 a_76_199# A1 a_535_374# VPB pfet_01v8_hvt w=0.42u l=0.15u
M5 a_218_47# A1 a_76_199# VNB nfet_01v8 w=0.42u l=0.15u
M6 a_218_374# A0 a_76_199# VPB pfet_01v8_hvt w=0.42u l=0.15u
M7 M a_76_199# VGND VNB nfet_01v8 w=0.65u l=0.15u
M8 M a_76_199# VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M9 VGND S a_218_47# VNB nfet_01v8 w=0.42u l=0.15u
M10 VGND S a_505_21# VNB nfet_01v8 w=0.42u l=0.15u
M11 a_439_47# a_505_21# VGND VNB nfet_01v8 w=0.42u l=0.15u

.ENDS