||||Table 981. CTRL  Register 

<bit-table>
>>>31:27  Reserved.   
>>>26  NEXTPREV_CLKDIV_RESTART: Write 1 to restart the clock dividers of state  SC  0x0  machines in neighbouring PIO blocks, as specified by NEXT_PIO_MASK and  PREV_PIO_MASK in the same write.  This is equivalent to writing 1 to the corresponding CLKDIV_RESTART bits in  those PIOs' CTRL registers. 
>>>25  NEXTPREV_SM_DISABLE: Write 1 to disable state machines in neighbouring  SC  0x0  PIO blocks, as specified by NEXT_PIO_MASK and PREV_PIO_MASK in the  same write.  This is equivalent to clearing the corresponding SM_ENABLE bits in those  PIOs' CTRL registers. 
>>>24  NEXTPREV_SM_ENABLE: Write 1 to enable state machines in neighbouring  SC  0x0  PIO blocks, as specified by NEXT_PIO_MASK and PREV_PIO_MASK in the  same write.  This is equivalent to setting the corresponding SM_ENABLE bits in those PIOs'  CTRL registers.  If both OTHERS_SM_ENABLE and OTHERS_SM_DISABLE are set, the disable  takes precedence.   Bits  Description  Type  Reset 
>>>23:20  NEXT_PIO_MASK: A mask of state machines in the neighbouring higher-  SC  0x0  numbered PIO block in the system (or PIO block 0 if this is the highest-  numbered PIO block) to which to apply the operations specified by  NEXTPREV_CLKDIV_RESTART, NEXTPREV_SM_ENABLE, and  NEXTPREV_SM_DISABLE in the same write.  This allows state machines in a neighbouring PIO block to be  started/stopped/clock-synced exactly simultaneously with a write to this PIO  block’s CTRL register.  Note that in a system with two PIOs, NEXT_PIO_MASK and PREV_PIO_MASK  actually indicate the same PIO block. In this case the effects are applied  cumulatively (as though the masks were OR’d together).  Neighbouring PIO blocks are disconnected (status signals tied to 0 and  control signals ignored) if one block is accessible to NonSecure code, and one  is not. 
>>>19:16  PREV_PIO_MASK: A mask of state machines in the neighbouring lower-  SC  0x0  numbered PIO block in the system (or the highest-numbered PIO block if this  is PIO block 0) to which to apply the operations specified by  OP_CLKDIV_RESTART, OP_ENABLE, OP_DISABLE in the same write.  This allows state machines in a neighbouring PIO block to be  started/stopped/clock-synced exactly simultaneously with a write to this PIO  block’s CTRL register.  Neighbouring PIO blocks are disconnected (status signals tied to 0 and  control signals ignored) if one block is accessible to NonSecure code, and one  is not. 
>>>15:12  Reserved. 
>>>11:8  CLKDIV_RESTART: Restart a state machine’s clock divider from an initial  phase of 0. Clock dividers are free-running, so once started, their output  (including fractional jitter) is completely determined by the integer/fractional  divisor configured in SMx_CLKDIV. This means that, if multiple clock dividers  with the same divisor are restarted simultaneously, by writing multiple 1 bits to  this field, the execution clocks of those state machines will run in precise  lockstep.  Note that setting/clearing SM_ENABLE does not stop the clock divider from  running, so once multiple state machines' clocks are synchronised, it is safe to  disable/reenable a state machine, whilst keeping the clock dividers in sync.  Note also that CLKDIV_RESTART can be written to whilst the state machine is  running, and this is useful to resynchronise clock dividers after the divisors  (SMx_CLKDIV) have been changed on-the-fly.  -  SC  -  0x0   Bits 
>>>7:4  Description  Type  Reset  SM_RESTART: Write 1 to instantly clear internal SM state which may be  SC  0x0  otherwise difficult to access and will affect future execution.  Specifically, the following are cleared: input and output shift counters; the  contents of the input shift register; the delay counter; the waiting-on-IRQ state;  any stalled instruction written to SMx_INSTR or run by OUT/MOV EXEC; any  pin write left asserted due to OUT_STICKY.  The contents of the output shift register and the X/Y scratch registers are not  affected. 
>>>3:0  SM_ENABLE: Enable/disable each of the four state machines by writing 1/0 to  RW  0x0  each of these four bits. When disabled, a state machine will cease executing  instructions, except those written directly to SMx_INSTR by the system.  Multiple bits can be set/cleared at once to run/halt multiple state machines  simultaneously. 
</bit-table>


||||## PIO: FSTAT Register  Offset: 0x004  Description  FIFO status register  

||||Table 982. FSTAT  Register 

<bit-table>
>>>31:28  Reserved. 
>>>27:24  TXEMPTY: State machine TX FIFO is empty 
>>>23:20  Reserved. 
>>>19:16  TXFULL: State machine TX FIFO is full 
>>>15:12  Reserved. 
>>>11:8  RXEMPTY: State machine RX FIFO is empty 
>>>7:4 
>>>3:0  Reserved.  RXFULL: State machine RX FIFO is full 
</bit-table>


||||## PIO: FDEBUG Register  Offset: 0x008  Description  FIFO debug register  

||||Table 983. FDEBUG  Register 

<bit-table>
>>>31:28  Reserved.  Type  Reset  -  RO  -  RO  -  RO  -  RO  -  0xf  -  0x0  -  0xf  -  0x0  Type  Reset  -  - 
>>>27:24  TXSTALL: State machine has stalled on empty TX FIFO during a blocking  WC  0x0  PULL, or an OUT with autopull enabled. Write 1 to clear. 
>>>23:20  Reserved.  -  -   Bits  Description  Type  Reset 
>>>19:16  TXOVER: TX FIFO overflow (i.e. write-on-full by the system) has occurred.  WC  0x0  Write 1 to clear. Note that write-on-full does not alter the state or contents of  the FIFO in any way, but the data that the system attempted to write is  dropped, so if this flag is set, your software has quite likely dropped some data  on the floor. 
>>>15:12  Reserved.  -  - 
>>>11:8  RXUNDER: RX FIFO underflow (i.e. read-on-empty by the system) has  WC  0x0  occurred. Write 1 to clear. Note that read-on-empty does not perturb the state  of the FIFO in any way, but the data returned by reading from an empty FIFO is  undefined, so this flag generally only becomes set due to some kind of 
>>>7:4 
>>>3:0  software error.  Reserved.  -  -  RXSTALL: State machine has stalled on full RX FIFO during a blocking PUSH,  WC  0x0  or an IN with autopush enabled. This flag is also set when a nonblocking  PUSH to a full FIFO took place, in which case the state machine has dropped  data. Write 1 to clear. 
</bit-table>


||||## PIO: FLEVEL Register  Offset: 0x00c  Description  FIFO levels  

||||Table 984. FLEVEL  Register 

<bit-table>
>>>31:28 
>>>27:24 
>>>23:20 
>>>19:16 
>>>15:12 
>>>11:8 
>>>7:4 
>>>3:0  RX3  TX3  RX2  TX2  RX1  TX1  RX0  TX0  RO  RO  RO  RO  RO  RO  RO  RO  0x0  0x0  0x0  0x0  0x0  0x0  0x0  0x0 
</bit-table>


||||## PIO: TXF0, TXF1, TXF2, TXF3 Registers  Offsets: 0x010, 0x014, 0x018, 0x01c  

||||Table 985. TXF0,  TXF1, TXF2, TXF3  Registers 

<bit-table>
>>>31:0  Direct write access to the TX FIFO for this state machine. Each write pushes  WF  0x00000000  one word to the FIFO. Attempting to write to a full FIFO has no effect on the  FIFO state or contents, and sets the sticky FDEBUG_TXOVER error flag for this  FIFO. 

||||## PIO: RXF0, RXF1, RXF2, RXF3 Registers  Offsets: 0x020, 0x024, 0x028, 0x02c   

||||Table 986. RXF0,  RXF1, RXF2, RXF3  Registers 

<bit-table>
>>>31:0  Direct read access to the RX FIFO for this state machine. Each read pops one  RF  -  word from the FIFO. Attempting to read from an empty FIFO has no effect on  the FIFO state, and sets the sticky FDEBUG_RXUNDER error flag for this FIFO.  The data returned to the system on a read from an empty FIFO is undefined. 

||||## PIO: IRQ Register  Offset: 0x030  Bits  Description   

||||Table 987. IRQ  Register 

<bit-table>
>>>31:8  Reserved.   
>>>7:0  State machine IRQ flags register. Write 1 to clear. There are eight state  WC  0x00  machine IRQ flags, which can be set, cleared, and waited on by the state  machines. There’s no fixed association between flags and state  machines — any state machine can use any flag.  Any of the eight flags can be used for timing synchronisation between state  machines, using IRQ and WAIT instructions. Any combination of the eight  flags can also routed out to either of the two system-level interrupt requests,  alongside FIFO status interrupts — see e.g. IRQ0_INTE. 
</bit-table>


||||## PIO: IRQ_FORCE Register  Offset: 0x034  

||||Table 988. IRQ_FORCE  Register 

<bit-table>
>>>31:8  Reserved.  Type  Reset  -  - 
>>>7:0  Writing a 1 to each of these bits will forcibly assert the corresponding IRQ.  WF  0x00  Note this is different to the INTF register: writing here affects PIO internal  state. INTF just asserts the processor-facing IRQ signal for testing ISRs, and is  not visible to the state machines.  Table 989.  INPUT_SYNC_BYPASS  Register 
</bit-table>


||||## PIO: INPUT_SYNC_BYPASS Register  Offset: 0x038  Bits  Description  Type  Reset   

||||Table 989. INPUT_SYNC_BYPASS Register

<bit-table>
>>>31:0  There is a 2-flipflop synchronizer on each GPIO input, which protects PIO logic  RW  0x00000000  from metastabilities. This increases input delay, and for fast synchronous IO  (e.g. SPI) these synchronizers may need to be bypassed. Each bit in this  register corresponds to one GPIO. 0 → input is synchronized (default) 1 → synchronizer is bypassed  If in doubt, leave this register as all zeroes.  

||||## PIO: DBG_PADOUT Register  Offset: 0x03c    

||||Table 990.  DBG_PADOUT Register

<bit-table>
>>>31:0  Read to sample the pad output values PIO is currently driving to the GPIOs. On  RO  0x00000000  RP2040 there are 30 GPIOs, so the two most significant bits are hardwired to  0. 

||||## PIO: DBG_PADOE Register  Offset: 0x040  

||||Table 991.  DBG_PADOE Register

<bit-table>
>>>31:0  Read to sample the pad output enables (direction) PIO is currently driving to  RO  0x00000000  the GPIOs. On RP2040 there are 30 GPIOs, so the two most significant bits are  hardwired to 0. 

||||## PIO: DBG_CFGINFO Register  Offset: 0x044  Description  The PIO hardware has some free parameters that may vary between chip products.  These should be provided in the chip datasheet, but are also exposed here.  

||||Table 992.  DBG_CFGINFO  Register 

<bit-table>
>>>31:28  VERSION: Version of the core PIO hardware.  Type  Reset  RO  0x1  Enumerated values:  0x0 → V0: Version 0 (RP2040)  0x1 → V1: Version 1 (RP2350) 
>>>27:22  Reserved. 
>>>21:16  IMEM_SIZE: The size of the instruction memory, measured in units of one  instruction 
>>>15:12  Reserved. 
>>>11:8  SM_COUNT: The number of state machines this PIO instance is equipped 
>>>7:6 
>>>5:0  with.  Reserved.  FIFO_DEPTH: The depth of the state machine TX/RX FIFOs, measured in  words.  Joining fifos via SHIFTCTRL_FJOIN gives one FIFO with double  this depth.  -  RO  -  RO  -  RO  -  -  -  -  -  - 
</bit-table>


||||## PIO: INSTR_MEM0, INSTR_MEM1, …, INSTR_MEM30, INSTR_MEM31 Registers  Offsets: 0x048, 0x04c, …, 0x0c0, 0x0c4   

||||Table 993.  INSTR_MEM0,  INSTR_MEM1, …,  INSTR_MEM30,  INSTR_MEM31  Registers 

<bit-table>
>>>31:16  Reserved.  Type  Reset  -  - 
>>>15:0  Write-only access to instruction memory location N  WO  0x0000 
</bit-table>


||||## PIO: SM0_CLKDIV, SM1_CLKDIV, SM2_CLKDIV, SM3_CLKDIV Registers  Offsets: 0x0c8, 0x0e0, 0x0f8, 0x110  Description  Clock divisor register for state machine N  Frequency = clock freq / (CLKDIV_INT + CLKDIV_FRAC / 256)  Bits  Description   

||||Table 994.  SM0_CLKDIV,  SM1_CLKDIV,  SM2_CLKDIV,  SM3_CLKDIV  Registers 

<bit-table>
>>>31:16  INT: Effective frequency is sysclk/(int + frac/256).  Value of 0 is interpreted as 65536. If INT is 0, FRAC must also be 0.  RW  0x0001  
>>>15:8  FRAC: Fractional part of clock divisor  RW  0x00  
>>>7:0  Reserved.  -  -  
</bit-table>


||||## PIO:  SM0_EXECCTRL,  SM1_EXECCTRL,  SM2_EXECCTRL,  SM3_EXECCTRL Registers  Offsets: 0x0cc, 0x0e4, 0x0fc, 0x114  Description  Execution/behavioural settings for state machine N

||||Table 995.  SM0_EXECCTRL,  SM1_EXECCTRL,  SM2_EXECCTRL,  SM3_EXECCTRL  Registers 

<bit-table>
>>>31  Description  Type  Reset  EXEC_STALLED: If 1, an instruction written to SMx_INSTR is stalled, and  latched by the state machine. Will clear to 0 once this instruction completes. RO  0x0
>>>30  SIDE_EN: If 1, the MSB of the Delay/Side-set instruction field is used as side-    set enable, rather than a side-set data bit. This allows instructions to perform  side-set optionally, rather than on every instruction, but the maximum possible  side-set width is reduced from 5 to 4. Note that the value of  PINCTRL_SIDESET_COUNT is inclusive of this enable bit. RW  0x0 
>>>29  SIDE_PINDIR: If 1, side-set data is asserted to pin directions, instead of pin values  RW  0x0  
>>>28:24  JMP_PIN: The GPIO number to use as condition for JMP PIN. Unaffected by input mapping.  RW  0x00  
>>>23:19  OUT_EN_SEL: Which data bit to use for inline OUT enable RW  0x00  
>>>18  INLINE_OUT_EN: If 1, use a bit of OUT data as an auxiliary write enable  When used in conjunction with OUT_STICKY, writes with an enable of 0 will  deassert the latest pin write. This can create useful masking/override  behaviour  due to the priority ordering of state machine pin writes (SM0 < SM1 < …)  RW  0x0 
>>>17  OUT_STICKY: Continuously assert the most recent OUT/SET to the pins 
>>>16:12  WRAP_TOP: After reaching this address, execution is wrapped to  wrap_bottom.  If the instruction is a jump, and the jump condition is true, the jump takes  RW  RW  0x0  0x1f  priority.   Bits  Description  Type  Reset 
>>>11:7  WRAP_BOTTOM: After reaching wrap_top, execution is wrapped to this  RW  0x00  address. 
>>>6:5  STATUS_SEL: Comparison used for the MOV x, STATUS instruction.  RW  0x0  Enumerated values:  0x0 → TXLEVEL: All-ones if TX FIFO level < N, otherwise all-zeroes  0x1 → RXLEVEL: All-ones if RX FIFO level < N, otherwise all-zeroes  0x2 → IRQ: All-ones if the indexed IRQ flag is raised, otherwise all-zeroes 
>>>4:0  STATUS_N: Comparison level or IRQ index for the MOV x, STATUS instruction.  RW  0x00  If STATUS_SEL is TXLEVEL or RXLEVEL, then values of STATUS_N greater  than the current FIFO depth are reserved, and have undefined behaviour.  Enumerated values:  0x00 → IRQ: Index 0-7 of an IRQ flag in this PIO block  0x08 → IRQ_PREVPIO: Index 0-7 of an IRQ flag in the next lower-numbered PIO  block  0x10 → IRQ_NEXTPIO: Index 0-7 of an IRQ flag in the next higher-numbered  PIO block 
</bit-table>


||||## PIO:  SM0_SHIFTCTRL,  SM1_SHIFTCTRL,  SM2_SHIFTCTRL,  SM3_SHIFTCTRL Registers  Offsets: 0x0d0, 0x0e8, 0x100, 0x118  Description  Control behaviour of the input/output shift registers for state machine N  

||||Table 996.  SM0_SHIFTCTRL,  SM1_SHIFTCTRL,  SM2_SHIFTCTRL,  SM3_SHIFTCTRL  Registers 

<bit-table>
>>>31  Description  Type  Reset  FJOIN_RX: When 1, RX FIFO steals the TX FIFO’s storage, and becomes twice  RW  0x0  as deep.  TX FIFO is disabled as a result (always reads as both full and empty).  FIFOs are flushed when this bit is changed. 
>>>30  FJOIN_TX: When 1, TX FIFO steals the RX FIFO’s storage, and becomes twice  RW  0x0  as deep.  RX FIFO is disabled as a result (always reads as both full and empty).  FIFOs are flushed when this bit is changed. 
>>>29:25  PULL_THRESH: Number of bits shifted out of OSR before autopull, or  RW  0x00  conditional pull (PULL IFEMPTY), will take place.  Write 0 for value of 32. 
>>>24:20  PUSH_THRESH: Number of bits shifted into ISR before autopush, or  RW  0x00  conditional push (PUSH IFFULL), will take place.  Write 0 for value of 32. 
>>>19 OUT_SHIFTDIR: 1 = shift out of output shift register to right. 0 = to left.  RW
>>>18 IN_SHIFTDIR: 1 = shift input shift register to right (data enters from left). 0 = to  RW  0x1  0x1  left.
>>>17  Description  Type  Reset  AUTOPULL: Pull automatically when the output shift register is emptied, i.e. on  RW  0x0  or following an OUT instruction which causes the output shift counter to reach  or exceed PULL_THRESH. 
>>>16  AUTOPUSH: Push automatically when the input shift register is filled, i.e. on an  RW  0x0  IN instruction which causes the input shift counter to reach or exceed  PUSH_THRESH. 
>>>15  FJOIN_RX_PUT: If 1, disable this state machine’s RX FIFO, make its storage  RW  0x0  available for random write access by the state machine (using the put  instruction) and, unless FJOIN_RX_GET is also set, random read access by the  processor (through the RXFx_PUTGETy registers).  If FJOIN_RX_PUT and FJOIN_RX_GET are both set, then the RX FIFO’s  registers can be randomly read/written by the state machine, but are  completely inaccessible to the processor.  Setting this bit will clear the FJOIN_TX and FJOIN_RX bits. 
>>>14  FJOIN_RX_GET: If 1, disable this state machine’s RX FIFO, make its storage  RW  0x0  available for random read access by the state machine (using the get  instruction) and, unless FJOIN_RX_PUT is also set, random write access by  the processor (through the RXFx_PUTGETy registers).  If FJOIN_RX_PUT and FJOIN_RX_GET are both set, then the RX FIFO’s  registers can be randomly read/written by the state machine, but are  completely inaccessible to the processor.  Setting this bit will clear the FJOIN_TX and FJOIN_RX bits. 
>>>13:5  Reserved.  -  - 
>>>4:0  IN_COUNT: Set the number of pins which are not masked to 0 when read by an  RW  0x00  IN PINS, WAIT PIN or MOV x, PINS instruction.  For example, an IN_COUNT of 5 means that the 5 LSBs of the IN pin group are  visible (bits 4:0), but the remaining 27 MSBs are masked to 0. A count of 32 is  encoded with a field value of 0, so the default behaviour is to not perform any  masking.  Note this masking is applied in addition to the masking usually performed by  the IN instruction. This is mainly useful for the MOV x, PINS instruction, which  otherwise has no way of masking pins. 
</bit-table>


||||## PIO: SM0_ADDR, SM1_ADDR, SM2_ADDR, SM3_ADDR Registers  Offsets: 0x0d4, 0x0ec, 0x104, 0x11c  

||||Table 997. SM0_ADDR,  SM1_ADDR,  SM2_ADDR,  SM3_ADDR Registers

<bit-table>
>>>31:5  Reserved. 
>>>4:0  Current instruction address of state machine N  Type  Reset  -  RO  -  0x00 
</bit-table>


||||## PIO: SM0_INSTR, SM1_INSTR, SM2_INSTR, SM3_INSTR Registers  Offsets: 0x0d8, 0x0f0, 0x108, 0x120   

||||Table 998.  SM0_INSTR,  SM1_INSTR,  SM2_INSTR,  SM3_INSTR Registers

<bit-table>
>>>31:16  Reserved. 
>>>15:0  Read to see the instruction currently addressed by state machine N's program  RW  counter.  Write to execute an instruction immediately (including jumps) and then  resume execution.  Type  Reset  -  -  - 
</bit-table>


||||Table 999.  SM0_PINCTRL,  SM1_PINCTRL,  SM2_PINCTRL,  SM3_PINCTRL  Registers 

<bit-table>
>>>31:29  SIDESET_COUNT: The number of MSBs of the Delay/Side-set instruction field  RW  0x0  which are used for side-set. Inclusive of the enable bit, if present. Minimum of  0 (all delay bits, no side-set) and maximum of 5 (all side-set, no delay).  
>>>28:26  SET_COUNT: The number of pins asserted by a SET. In the range 0 to 5  RW  0x5  inclusive.  
>>>25:20  OUT_COUNT: The number of pins asserted by an OUT PINS, OUT PINDIRS or  RW  0x00  MOV PINS instruction. In the range 0 to 32 inclusive.  
>>>19:15  IN_BASE: The pin which is mapped to the least-significant bit of a state  RW  0x00  machine’s IN data bus. Higher-numbered pins are mapped to consecutively  more-significant data bits, with a modulo of 32 applied to pin number.  
>>>14:10  SIDESET_BASE: The lowest-numbered pin that will be affected by a side-set  RW  0x00  operation. The MSBs of an instruction’s side-set/delay field (up to 5,  determined by SIDESET_COUNT) are used for side-set data, with the remaining  LSBs used for delay. The least-significant bit of the side-set portion is the bit  written to this pin, with more-significant bits written to higher-numbered pins.  
>>>9:5  SET_BASE: The lowest-numbered pin that will be affected by a SET PINS or  RW  0x00  SET PINDIRS instruction. The data written to this pin is the least-significant bit  of the SET data. 
>>> 4:0  OUT_BASE: The lowest-numbered pin that will be affected by an OUT PINS,  RW  0x00  OUT PINDIRS or MOV PINS instruction. The data written to this pin will always  be the least-significant bit of the OUT or MOV data.  

||||## PIO: RXF0_PUTGET0 Register  Offset: 0x128

||||Table 1000.  RXF0_PUTGET0  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 0 of SM0’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.   

||||## PIO: SM0_PINCTRL, SM1_PINCTRL, SM2_PINCTRL, SM3_PINCTRL Registers  Offsets: 0x0dc, 0x0f4, 0x10c, 0x124  Description  State machine pin control  Bits  Description  Type  Reset   

||||## PIO: RXF0_PUTGET1 Register  Offset: 0x12c   

||||Table 1001.  RXF0_PUTGET1  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 1 of SM0’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set. 


||||## PIO: RXF0_PUTGET2 Register  Offset: 0x130  Bits  Description  Type  Reset   
||||Table 1002.  RXF0_PUTGET2  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 2 of SM0’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||## PIO: RXF0_PUTGET3 Register  Offset: 0x134  Bits  Description  Type  Reset  
||||Table 1003.  RXF0_PUTGET3  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 3 of SM0’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||## PIO: RXF1_PUTGET0 Register  Offset: 0x138  Bits  Description  Type  Reset  
||||Table 1004.  RXF1_PUTGET0  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 0 of SM1’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||## PIO: RXF1_PUTGET1 Register  Offset: 0x13c  Bits  Description  Type  Reset  
||||Table 1005.  RXF1_PUTGET1  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 1 of SM1’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||## PIO: RXF1_PUTGET2 Register  Offset: 0x140  Bits  Description  Type  Reset  
||||Table 1006.  RXF1_PUTGET2  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 2 of SM1’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||PIO: RXF1_PUTGET3 Register  Offset: 0x144    
||||Table 1007.  RXF1_PUTGET3  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 3 of SM1’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set. 



||||## PIO: RXF2_PUTGET0 Register  Offset: 0x148  Bits  Description  Type  Reset   
||||Table 1008.  RXF2_PUTGET0  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 0 of SM2’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||PIO: RXF2_PUTGET1 Register  Offset: 0x14c  Bits  Description  Type  Reset  
||||Table 1009.  RXF2_PUTGET1  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 1 of SM2’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||PIO: RXF2_PUTGET2 Register  Offset: 0x150  Bits  Description  Type  Reset  
||||Table 1010.  RXF2_PUTGET2  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 2 of SM2’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  
||||PIO: RXF2_PUTGET3 Register  Offset: 0x154  Bits  Description  Type  Reset  
||||Table 1011.  RXF2_PUTGET3  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 3 of SM2’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||PIO: RXF3_PUTGET0 Register  Offset: 0x158  Bits  Description  Type  Reset  
||||Table 1012.  RXF3_PUTGET0  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 0 of SM3’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||PIO: RXF3_PUTGET1 Register  Offset: 0x15c    
||||Table 1013.  RXF3_PUTGET1  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 1 of SM3’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set. 

||||Table 1015.  RXF3_PUTGET3  Register 

||||## PIO: RXF3_PUTGET2 Register  Offset: 0x160  Bits  Description  Type  Reset   
||||Table 1014.  RXF3_PUTGET2  Register 

<bit-table>
>>>31:0  Direct read/write access to entry 2 of SM3’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||## PIO: RXF3_PUTGET3 Register  Offset: 0x164  Bits  Description  Type  Reset  

<bit-table>
>>>31:0  Direct read/write access to entry 3 of SM3’s RX FIFO, if  RW  0x00000000  SHIFTCTRL_FJOIN_RX_PUT xor SHIFTCTRL_FJOIN_RX_GET is set.  

||||## PIO: GPIOBASE Register   Offset: 0x168
||||Table 1016.  GPIOBASE Register

<bit-table>
>>>31:5  Reserved.  Type  Reset  -  - 
>>>4  Relocate GPIO 0 (from PIO’s point of view) in the system GPIO numbering, to  RW  0x0  access more than 32 GPIOs from PIO.  Only the values 0 and 16 are supported (only bit 4 is writable). 
>>>3:0  Reserved.  -  - 
</bit-table>


||||## PIO: INTR Register  Offset: 0x16c  Description  Raw Interrupts  
||||Table 1017. INTR  Register 

<bit-table>
>>>31:16  Reserved. 
>>>15 SM7  RO 0x0
>>>14 SM6  RO 0x0
>>>13 SM5  RO 0x0
>>>12 SM4  RO 0x0
>>>11 SM3  RO 0x0
>>>10 SM2  RO 0x0
>>>9 SM1  RO 0x0
>>>8  SM0  RO 0x0
>>>7 SM3_TXNFULL  RO 0x0
>>>6 SM2_TXNFULL  RO 0x0
>>>5 SM1_TXNFULL  RO 0x0
>>>4 SM0_TXNFULL  RO 0x0
>>>3 SM3_RXNEMPTY  RO 0x0
>>>2 SM2_RXNEMPTY  RO 0x0
>>>1 SM1_RXNEMPTY  RO 0x0
>>>0 SM0_RXNEMPTY  RO 0x0
</bit-table>


||||## PIO: IRQ0_INTE Register  Offset: 0x170  Description  Interrupt Enable for irq0  
||||Table 1018.  IRQ0_INTE Register

<bit-table>
>>>31:16  Reserved. 
>>>15 SM7 RW 0x0
>>>14 SM6 RW 0x0
>>>13 SM5 RW 0x0
>>>12 SM4 RW 0x0
>>>11 SM3 RW 0x0
>>>10 SM2 RW 0x0
>>>9 SM1 RW 0x0
>>>8 SM0 RW 0x0
>>>7 SM3_TXNFULL RW 0x0
>>>6 SM2_TXNFULL RW 0x0
>>>5 SM1_TXNFULL RW 0x0
>>>4 SM0_TXNFULL RW 0x0
>>>3 SM3_RXNEMPTY RW 0x0
>>>2 SM2_RXNEMPTY RW 0x0
>>>1 SM1_RXNEMPTY RW 0x0
>>>0 SM0_RXNEMPTY        RW 0x0                        
</bit-table>


||||## PIO: IRQ0_INTF Register  Offset: 0x174  Description  Interrupt Force for irq0
||||Table 1019.  IRQ0_INTF Register

<bit-table>
>>>31:16  Reserved. 
>>>15 SM7 RW 0x0
>>>14 SM6 RW 0x0
>>>13 SM5 RW 0x0
>>>12 SM4 RW 0x0
>>>11 SM3 RW 0x0
>>>10 SM2 RW 0x0
>>>9 SM1 RW 0x0
>>>8 SM0 RW 0x0
>>>7 SM3_TXNFULL RW 0x0
>>>6 SM2_TXNFULL RW 0x0
>>>5 SM1_TXNFULL RW 0x0
>>>4 SM0_TXNFULL RW 0x0
>>>3 SM3_RXNEMPTY RW 0x0
>>>2 SM2_RXNEMPTY RW 0x0
>>>1 SM1_RXNEMPTY RW 0x0
>>>0 SM0_RXNEMPTY        RW 0x0                         
</bit-table>


||||## PIO: IRQ0_INTS Register  Offset: 0x178  Description  Interrupt status after masking & forcing for irq0  

||||Table 1020.  IRQ0_INTS Register

<bit-table>
>>>31:16  Reserved. 
>>>15 SM7 RO 0x0
>>>14 SM6 RO 0x0
>>>13 SM5 RO 0x0
>>>12 SM4 RO 0x0
>>>11 SM3 RO 0x0
>>>10 SM2 RO 0x0
>>>9 SM1 RO 0x0
>>>8 SM0 RO 0x0
>>>7 SM3_TXNFULL RO 0x0
>>>6 SM2_TXNFULL RO 0x0
>>>5 SM1_TXNFULL RO 0x0
>>>4 SM0_TXNFULL RO 0x0
>>>3 SM3_RXNEMPTY RO 0x0
>>>2 SM2_RXNEMPTY RO 0x0
>>>1 SM1_RXNEMPTY RO 0x0
>>>0 SM0_RXNEMPTY RO 0x0    
</bit-table>


||||## PIO: IRQ1_INTE Register  Offset: 0x17c  Description  Interrupt Enable for irq1  
||||Table 1021.  IRQ1_INTE Register

<bit-table>
>>>31:16  Reserved. 
>>>15 SM7 RW 0x0
>>>14 SM6 RW 0x0
>>>13 SM5 RW 0x0
>>>12 SM4 RW 0x0
>>>11 SM3 RW 0x0
>>>10 SM2 RW 0x0
>>>9 SM1 RW 0x0
>>>8 SM0 RW 0x0
>>>7 SM3_TXNFULL RW 0x0
>>>6 SM2_TXNFULL RW 0x0
>>>5 SM1_TXNFULL RW 0x0
>>>4 SM0_TXNFULL RW 0x0
>>>3 SM3_RXNEMPTY RW 0x0
>>>2 SM2_RXNEMPTY RW 0x0
>>>1 SM1_RXNEMPTY RW 0x0
>>>0 SM0_RXNEMPTY        RW 0x0     
</bit-table>


||||## PIO: IRQ1_INTF Register  Offset: 0x180  Description  Interrupt Force for irq1  
||||Table 1022.  IRQ1_INTF Register

<bit-table>
>>>31:16  Reserved. 
>>>15 SM7 RW 0x0
>>>14 SM6 RW 0x0
>>>13 SM5 RW 0x0
>>>12 SM4 RW 0x0
>>>11 SM3 RW 0x0
>>>10 SM2 RW 0x0
>>>9 SM1 RW 0x0
>>>8 SM0 RW 0x0
>>>7 SM3_TXNFULL RW 0x0
>>>6 SM2_TXNFULL RW 0x0
>>>5 SM1_TXNFULL RW 0x0
>>>4 SM0_TXNFULL RW 0x0
>>>3 SM3_RXNEMPTY RW 0x0
>>>2 SM2_RXNEMPTY RW 0x0
>>>1 SM1_RXNEMPTY RW 0x0
>>>0 SM0_RXNEMPTY        RW 0x0     
</bit-table>


||||## PIO: IRQ1_INTS Register  Offset: 0x184  Description  Interrupt status after masking & forcing for irq1  
||||Table 1023.  IRQ1_INTS Register

<bit-table>
>>>31:16  Reserved. 
>>>15 SM7 RO 0x0
>>>14 SM6 RO 0x0
>>>13 SM5 RO 0x0
>>>12 SM4 RO 0x0
>>>11 SM3 RO 0x0
>>>10 SM2 RO 0x0
>>>9 SM1 RO 0x0
>>>8 SM0 RO 0x0
>>>7 SM3_TXNFULL RO 0x0
>>>6 SM2_TXNFULL RO 0x0
>>>5 SM1_TXNFULL RO 0x0
>>>4 SM0_TXNFULL RO 0x0
>>>3 SM3_RXNEMPTY RO 0x0
>>>2 SM2_RXNEMPTY RO 0x0
>>>1 SM1_RXNEMPTY RO 0x0
>>>0 SM0_RXNEMPTY RO 0x0    
</bit-table>

