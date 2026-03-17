.intel_syntax noprefix
.section .data
    title_str:      .short 0x526a, 0x8d34, 0x677f, 0x5185, 0x5bb9, 0x0000
    empty_msg:      .short 0x0028, 0x7a7a, 0x0029, 0x0000

.section .bss
    .align 2
    .lcomm buffer, 8192

.section .text
    .global main
    .extern OpenClipboard
    .extern GetClipboardData
    .extern GlobalLock
    .extern GlobalUnlock
    .extern CloseClipboard
    .extern MessageBoxW
    .extern ExitProcess
    .extern lstrcpynW

main:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    xor rcx, rcx
    call OpenClipboard
    test rax, rax
    jz .exit_app
	
    mov rcx, 13
    call GetClipboardData
    test rax, rax
    jz .use_empty

    mov rcx, rax
    call GlobalLock
    test rax, rax
    jz .use_empty

    # arg1 (rcx): lpString1 (dest)
    # arg2 (rdx): lpString2 (src)
    # arg3 (r8):  iMaxLength (in characters)
    lea rcx, [rip + buffer]
    mov rdx, rax
    mov r8, 4095
    call lstrcpynW

    call CloseClipboard
    jmp .display

.use_empty:
    call CloseClipboard
    lea rdx, [rip + empty_msg]
    lea rcx, [rip + buffer]
    mov r8, 4
    call lstrcpynW

.display:
    xor rcx, rcx            # hWnd
    lea rdx, [rip + buffer] # lpText (UTF-16)
    lea r8, [rip + title_str] # lpCaption (UTF-16)
    mov r9d, 0x00000040     # MB_OK | MB_ICONINFORMATION
    call MessageBoxW

.exit_app:
    xor rcx, rcx
    call ExitProcess
    add rsp, 48
    pop rbp
    ret
