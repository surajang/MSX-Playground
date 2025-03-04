ThinkPositive equ 1
PrintChar equ &BB5A

org &8100
    ld hl,Introduction
    call PrintString
    call NewLine
    ld hl,Message
    call PrintString
ret

PrintString:
    ld a,(hl)
    cp 255
    ret z
    inc hl
    call PrintChar
jr PrintString

Introduction:
    db "Thought of the day...',255

ifdef ThinkPositive
    Message:    db 'Z80 is awesome!',255
else
    Message:    db 'nah :(',255
endif

NewLine:
    ld a,13
    call PrintChar
    ld a,10
    call PrintChar
ret
