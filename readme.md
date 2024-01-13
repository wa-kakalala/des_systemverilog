# des-systemverilog

Implement des algorithm with systemverilog.
Reference Model: **https://github.com/wa-kakalala/des.git**

## block diagram

![image-20240107063909169](pic/image-20240107063909169.png)

![image-20240107063935870](pic/image-20240107063935870.png)

![image-20240107064423724](pic/image-20240107064423724.png)

## simulation

![image-20240109160624304](pic/image-20240109160624304.png)

## fpga verification

![image-20240109200706092](pic/image-20240109200706092.png)

## Utilization

xc7z020clg484-1

![image-20240109201039178](pic/image-20240109201039178.png)

## log

- 2023/12/30 des_key_check && des_key  module 's simulation is ok.
- 2024/1/4  des_ip  module 's simulation is ok.
- 2024/1/4  des_ext  module 's simulation is ok.
- 2024/1/5  des_scomp  module 's simulation is ok.
- 2024/1/7  des_p  module 's coding is finished.
- 2024/1/7  des_xor48 && des_xor32  module 's coding is finished.
- 2024/1/7  des_invip  module 's coding is finished.
- 2024/1/7  des_ctrl  module 's design is finished.
- 2024/1/7  des module 's fsm is finished.
- 2024/1/8  des module is finished, but still have some bugs.
- 2024/1/9  fix the bugs and fpga verification is finished.
