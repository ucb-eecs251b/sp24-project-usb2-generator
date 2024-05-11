# USB 2.0 Chipyard Generator

The **Universal Serial Bus (USB)** is one of the most common interfaces for establishing communication between peripherals
and host controllers (usually a personal computer). **USB 2.0**, released in 2000, is an upgraded version of the protocol
with support for data transfer rates of **12 Mbps (Full-Speed, FS)** and **480 Mbps (High-Speed, HS)**. Access to the USB protocol allows SoCs, such as large digital CPUs, to interface with an increased variety of peripherals, such as cameras, scanners, and hard drives.

This repository chronicles the (yet incomplete) **USB 2.0 generator for Chipyard developed Spring 2024, targeting the HS/FS interface in either 8-bit or 16-bit (ideally integrated to be parametrizable) in SKY130**. It contains a data recovery unit (not integrated into top level), TX, RX, and UTMI logic, and relevant Chisel and Verilog tests.  The main branch has been compiled and ran through PAR with TX, RX, and UTMI, however, there may still be bugs.  Module-specific documentation and status is documented in the READMEs in the module folders. 

**Next steps** might involve implementing an analog PHY, integrating data recovery, developing a PLL, clock recovery, power, or creating more robust integration testing. Note that there is a USB Chipyard repository this generator is being tested with, which contains a great array of integration tests that did not yet get a chance to be tested on this module.

Opportunity and excitment (and debugging) abound!

*Feel free to read on into the module READMEs for more information.*

# Dev Notes

This branch is the combination of the dedicated USB2.0 submodule branches as of (around) May 10.
Note that that considering the teams' various implementations, the fool-proof way of merging into main without polluting invididual branches is:

- Checkout the branch in question (```checkout slowy-rx```) 
- Make a clone of the branch in question (```checkout -b slowy-rx-clone```) 
- Pull from main and follow the command git recommends using for upstream (```git pull origin main```)
- There will be conflicts, many - due to main's directory structure - fix them 
- Push changes to branch (```git add / commit / push```)
- Create a PR request to main, approve it (obama awarding obama meme .jpg)
- Delete the clone branch

(When people are ready to integrate with main and work off of it, this will not longer be so laborious.)

Bonus: got a whole bunch of deleted files, like build files popping up, that aren't getting staged? Try:

```git status | grep 'deleted:' | cut -d':' -f2  | xargs -t   -I {}  git add  -u "{}"```

Right now (May 10) data recovery is not integrated, but should be doable with a simple(?!) black box.

**FAQ for the Forgetful** 

How do I compile locally?
- Comment out your preferred sbt file that's renamed to txt file and run `sbt run`
- UTMI's seems to work the best right now
- Note that the .sbt files need to returned to .txt mode when integrated with main because they interfere with Chipyard .sbt

Uh oh.. Sad ``java.lang.RuntimeException`` noises?
- Usually a firtool issue
- Note that some blocks are using Chisel 6 constructs that need to be commented out before they can be used in Chipyard's Chisel 3 environment

*See the USB Chipyard repository README for more relevant notes to using this block as a generator.*
