.686
.model flat, c
printf proto c : vararg
EXTERN K : DWORD

.data
msg db 'Output from asm module is: %x', 0

.code
calc PROC
    ; ���������� �������� ���������
    push ebp
    mov ebp, esp

    ; ������������ ��������� � �����
    movsx eax, word ptr [ebp+8]   ; ����������� B2 (short) � ���������� �� 32-��
    movsx ecx, byte ptr [ebp+12]  ; ����������� C1 (char) � ���������� �� 32-��
    mov edx, dword ptr [ebp+16]   ; ����������� E4 (int)

    ; ���������� K - B2 - C1
    mov ebx, K                    ; ����������� �������� K � ������ ebx
    sub ebx, eax                  ; ³������ B2
    sub ebx, ecx                  ; ³������ C1

    ; ��������� ��������� �� 2
    imul ebx, 2                   ; ebx = (K - B2 - C1) * 2

    ; ĳ���� E4 �� 4 � ������ �� ����������
    mov eax, edx                  ; ���������� E4 � eax ��� ������
    cdq                           ; ���������� ���� � eax � edx (edx:eax)
    mov esi, 4
    idiv esi                      ; ĳ���� edx:eax �� 4 (eax = E4 / 4)

    add ebx, eax                  ; ������ ��������� ����� �� ebx

    ; �������� ���������
    push        ebx  
    push        offset msg
    call        printf   
    add         esp, 8 

    ; ��������� �������� ���������� � eax
    mov eax, ebx

    ; ³��������� ������� �������� � �����������
    pop ebp
    ret
calc ENDP
END
