   .org 0x0
   .set noat
   .global _start
_start:

   ######### add\addi\addiu\addu\sub\subu ##########

   ori  $1,$0,0x8000           # $1 = 0x8000
   sll  $1,$1,16               # $1 = 0x80000000
   ori  $1,$1,0x0010           # $1 = 0x80000010

   ori  $2,$0,0x8000           # $2 = 0x8000
   sll  $2,$2,16               # $2 = 0x80000000
   ori  $2,$2,0x0001           # $2 = 0x80000001

   ori  $3,$0,0x0000           # $3 = 0x00000000
   addu $3,$2,$1               # $3 = 0x00000011
   ori  $3,$0,0x0000           # $3 = 0x00000000
   add  $3,$2,$1               # overflow,$3 keep 0x00000000

   sub   $3,$1,$3              # $3 = 0x80000010         
   subu  $3,$3,$2              # $3 = 0xF

   addi $3,$3,2                # $3 = 0x11
   ori  $3,$0,0x0000           # $3 = 0x00000000
   addiu $3,$3,0x8000          # $3 = 0xffff8000

   #########     slt\sltu\slti\sltiu     ##########

   or   $1,$0,0xffff           # $1 = 0xffff
   sll  $1,$1,16               # $1 = 0xffff0000
   slt  $2,$1,$0               # $2 = 1
   sltu $2,$1,$0               # $2 = 0
   slti $2,$1,0x0800           # $2 = 1
   sltiu $2,$1,0x0800          # $2 = 1

   nop
   nop