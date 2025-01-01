.686
.model flat, c
printf proto c : vararg
EXTERN K : DWORD

.data
msg db 'Output from asm module is: %x', 0

.code
calc PROC
    ; Збереження базового указівника
    push ebp
    mov ebp, esp

    ; Завантаження аргументів зі стеку
    movsx eax, word ptr [ebp+8]   ; Завантажуємо B2 (short) і розширюємо до 32-біт
    movsx ecx, byte ptr [ebp+12]  ; Завантажуємо C1 (char) і розширюємо до 32-біт
    mov edx, dword ptr [ebp+16]   ; Завантажуємо E4 (int)

    ; Обчислюємо K - B2 - C1
    mov ebx, K                    ; Завантажуємо значення K в регістр ebx
    sub ebx, eax                  ; Віднімаємо B2
    sub ebx, ecx                  ; Віднімаємо C1

    ; Помножуємо результат на 2
    imul ebx, 2                   ; ebx = (K - B2 - C1) * 2

    ; Ділимо E4 на 4 і додаємо до результату
    mov eax, edx                  ; Переносимо E4 в eax для ділення
    cdq                           ; Розширюємо знак з eax в edx (edx:eax)
    mov esi, 4
    idiv esi                      ; Ділимо edx:eax на 4 (eax = E4 / 4)

    add ebx, eax                  ; Додаємо результат поділу до ebx

    ; Виводимо результат
    push        ebx  
    push        offset msg
    call        printf   
    add         esp, 8 

    ; Повертаємо значення результату в eax
    mov eax, ebx

    ; Відновлюємо базовий указівник і повертаємося
    pop ebp
    ret
calc ENDP
END
