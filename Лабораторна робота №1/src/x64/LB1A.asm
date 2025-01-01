IFDEF RAX
includelib kernel32.lib
includelib user32.lib
includelib libcmt.lib
includelib legacy_stdio_definitions.lib

 externdef printf:proc

EXTERN K: DWORD

.data
format db '64 ASM res is %x', 0  ; Format string with %d for integer

.code
a_calc proc
    sub rsp, 28h; NEED TO BE ALLIGNED TO 16                           
    xor rax, rax
    xor rbx,rbx

    mov eax, K
    cdqe
    mov rbx,rax
    movsx rcx,cx
    sub rbx, rcx
    movsx rdx, dl
    sub rbx, rdx
    shl rbx, 1
    mov rcx,rbx

    mov rax,r8
    mov ebx,4
    cdq
    idiv ebx
    add rcx,rax


   
    mov r12,rcx ;preserver for ret
    mov rdx,rcx
    lea rcx, offset format

    call printf
    add rsp, 28h               
    mov rax,r12
    ret
a_calc endp
ENDIF; RAX
end
