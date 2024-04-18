* "spice" description for "standard_cell_spice", "Latch_1", "spiceText" 


simulator lang=spice

.SUBCKT Latch_1 CLK D RESET_B VGND VNB VPB VPWR Q
M0 a_1270_413# a_1283_21# VPWR VPB pfet_01v8_hvt w=0.42u l=0.15u
M1 VPWR a_543_47# a_761_289# VPB pfet_01v8_hvt w=0.84u l=0.15u
M2 VGND a_543_47# a_761_289# VNB nfet_01v8 w=0.64u l=0.15u
M3 VGND D a_448_47# VNB nfet_01v8 w=0.42u l=0.15u
M4 a_1108_47# a_193_47# a_1270_413# VPB pfet_01v8_hvt w=0.42u l=0.15u
M5 VGND a_1283_21# Q VNB nfet_01v8 w=0.65u l=0.15u
M6 a_1217_47# a_1283_21# VGND VNB nfet_01v8 w=0.42u l=0.15u
M7 a_448_47# a_27_47# a_543_47# VNB nfet_01v8 w=0.36u l=0.15u
M8 a_448_47# a_193_47# a_543_47# VPB pfet_01v8_hvt w=0.42u l=0.15u
M9 a_543_47# a_193_47# a_639_47# VNB nfet_01v8 w=0.36u l=0.15u
M10 a_1108_47# a_27_47# a_1217_47# VNB nfet_01v8 w=0.36u l=0.15u
M11 a_1462_47# a_1108_47# a_1283_21# VNB nfet_01v8 w=0.42u l=0.15u
M12 a_543_47# a_27_47# a_651_413# VPB pfet_01v8_hvt w=0.42u l=0.15u
M13 a_805_47# RESET_B VGND VNB nfet_01v8 w=0.42u l=0.15u
M14 a_761_289# a_193_47# a_1108_47# VNB nfet_01v8 w=0.36u l=0.15u
M15 VPWR RESET_B a_651_413# VPB pfet_01v8_hvt w=0.42u l=0.15u
M16 VGND a_27_47# a_193_47# VNB nfet_01v8 w=0.42u l=0.15u
M17 a_27_47# CLK VGND VNB nfet_01v8 w=0.42u l=0.15u
M18 a_27_47# CLK VPWR VPB pfet_01v8_hvt w=0.64u l=0.15u
M19 VPWR a_1283_21# Q VPB pfet_01v8_hvt w=1u l=0.15u
M20 VPWR a_27_47# a_193_47# VPB pfet_01v8_hvt w=0.64u l=0.15u
M21 a_1283_21# a_1108_47# VPWR VPB pfet_01v8_hvt w=0.42u l=0.15u
M22 VGND RESET_B a_1462_47# VNB nfet_01v8 w=0.42u l=0.15u
M23 VPWR D a_448_47# VPB pfet_01v8_hvt w=0.42u l=0.15u
M24 a_651_413# a_761_289# VPWR VPB pfet_01v8_hvt w=0.42u l=0.15u
M25 a_761_289# a_27_47# a_1108_47# VPB pfet_01v8_hvt w=0.42u l=0.15u
M26 VPWR RESET_B a_1283_21# VPB pfet_01v8_hvt w=0.42u l=0.15u
M27 a_639_47# a_761_289# a_805_47# VNB nfet_01v8 w=0.42u l=0.15u

.ENDS