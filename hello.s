# ----------------------------------------------------------------------------------------
#
# ----------------------------------------------------------------------------------------

        .global _start

        .text
dofun:
        lea     -4(%ebp),%ebp           # push reg on
        movl    %esi,(%ebp)             #    to return stack
        addl    $4,%eax
        movl    %eax,%esi
        lodsl                           # NEXT
        jmp     *(%eax)

_start:
        mov     $4,%eax
        push    %eax
        mov     $cold,%esi
        lodsl
        jmp     *(%eax)

        # write(1, message, 13)
        mov     $1, %eax                # system call 1 is write
        mov     $1, %edi                # file handle 1 is stdout
        mov     $message, %ecx          # address of string to output
        mov     $13, %edx               # number of bytes
        int     $0x80                   # invoke operating system to do the write

        # exit(0)
        mov     $60, %eax               # system call 60 is exit
        xor     %edi, %edi              # we want return code 0
        int     $0x80                   # invoke operating system to exit
message:
        .ascii  "Hello, world\n"
cold:
        .int    double

        .section rodata

        .align  4
        .global s_double
s_double:
        .int    0
        .byte   6
        .ascii  "DOUBLE"
        .align  4
        .global double
double:
        .int    dofun
        .int    dup
        .int    plus

        .global s_dup
s_dup:  .int    s_double
        .byte   3
        .ascii  "DUP"
        .align  4
        .global dup
dup:    .int    c_dup
        .text
        .global c_dup
c_dup:  mov     (%esp),%eax
        push    %eax
        lodsl
        jmp     *(%eax)
 
        .align  4
        .global s_plus
s_plus: .int    s_dup
        .byte   4
        .ascii  "PLUS"
        .align  4
        .global plus
plus:   .int    c_plus
        .text
        .global c_plus
c_plus: pop     %eax
        addl    %eax,(%esp)
        lodsl
        jmp     *(%eax)

