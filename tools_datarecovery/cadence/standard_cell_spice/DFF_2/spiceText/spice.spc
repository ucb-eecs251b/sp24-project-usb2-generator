* "spice" description for "standard_cell_spice", "DFF_2", "spiceText" 


simulator lang=spice

.SUBCKT DFF_2 CLK D VGND VNB VPB VPWR Q
M0 a_891_413# a_193_47# a_975_413# VPB pfet_01v8_hvt w=0.42u l=0.15u
M1 a_1059_315# a_891_413# VGND VNB nfet_01v8 w=0.65u l=0.15u
M2 a_466_413# a_27_47# a_561_413# VPB pfet_01v8_hvt w=0.42u l=0.15u
M3 a_634_159# a_27_47# a_891_413# VPB pfet_01v8_hvt w=0.42u l=0.15u
M4 a_381_47# a_193_47# a_466_413# VPB pfet_01v8_hvt w=0.42u l=0.15u
M5 VPWR D a_381_47# VPB pfet_01v8_hvt w=0.42u l=0.15u
M6 VPWR a_466_413# a_634_159# VPB pfet_01v8_hvt w=0.75u l=0.15u
M7 VGND a_466_413# a_634_159# VNB nfet_01v8 w=0.64u l=0.15u
M8 a_1017_47# a_1059_315# VGND VNB nfet_01v8 w=0.42u l=0.15u
M9 a_1059_315# a_891_413# VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M10 Q a_1059_315# VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M11 a_561_413# a_634_159# VPWR VPB pfet_01v8_hvt w=0.42u l=0.15u
M12 VPWR a_1059_315# Q VPB pfet_01v8_hvt w=1u l=0.15u
M13 a_891_413# a_27_47# a_1017_47# VNB nfet_01v8 w=0.36u l=0.15u
M14 a_634_159# a_193_47# a_891_413# VNB nfet_01v8 w=0.36u l=0.15u
M15 a_592_47# a_634_159# VGND VNB nfet_01v8 w=0.42u l=0.15u
M16 a_466_413# a_193_47# a_592_47# VNB nfet_01v8 w=0.36u l=0.15u
M17 VGND a_27_47# a_193_47# VNB nfet_01v8 w=0.42u l=0.15u
M18 a_381_47# a_27_47# a_466_413# VNB nfet_01v8 w=0.36u l=0.15u
M19 a_27_47# CLK VGND VNB nfet_01v8 w=0.42u l=0.15u
M20 a_27_47# CLK VPWR VPB pfet_01v8_hvt w=0.64u l=0.15u
M21 Q a_1059_315# VGND VNB nfet_01v8 w=0.65u l=0.15u
M22 VPWR a_27_47# a_193_47# VPB pfet_01v8_hvt w=0.64u l=0.15u
M23 VGND D a_381_47# VNB nfet_01v8 w=0.42u l=0.15u
M24 a_975_413# a_1059_315# VPWR VPB pfet_01v8_hvt w=0.42u l=0.15u
M25 VGND a_1059_315# Q VNB nfet_01v8 w=0.65u l=0.15u
.ENDS