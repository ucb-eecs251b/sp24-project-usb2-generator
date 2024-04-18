* "spice" description for "standard_cell_spice", "inv_4", "spiceText" 


simulator lang=spice

.SUBCKT inv_4 A VGND VNB VPB VPWR Y
M0 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M1 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M2 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u
M3 Y A VGND VNB nfet_01v8 w=0.65u l=0.15u
M4 VGND A Y VNB nfet_01v8 w=0.65u l=0.15u
M5 VPWR A Y VPB pfet_01v8_hvt w=1u l=0.15u
M6 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u
M7 Y A VPWR VPB pfet_01v8_hvt w=1u l=0.15u

.ENDS