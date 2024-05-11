* "spice" description for "standard_cell_spice", "inv_16", "spiceText" 


simulator lang=spice

.SUBCKT inv_16 A VGND VNB VPB VPWR Y
M0 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M1 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M2 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u
M3 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u
M4 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M5 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M6 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M7 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u
M8 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M9 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u
M10 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M11 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u
M12 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u
M13 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M14 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M15 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M16 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M17 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M18 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M19 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M20 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M21 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M22 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M23 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u
M24 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M25 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M26 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M27 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M28 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M29 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M30 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M31 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u

.ENDS