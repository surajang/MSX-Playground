        .org 0x4000      ; 실행 주소를 0x4000으로 설정 (일반적인 MSX 프로그램 영역)
        di              ; 인터럽트 비활성화

        ld hl, message  ; HL 레지스터에 문자열 주소 로드

loop:   ld a, (hl)      ; HL이 가리키는 문자 가져오기
        cp 0            ; 널(0) 문자인지 확인
        jp z, done      ; 널 문자이면 종료

        call 0x00A2     ; CHPUT (BIOS 루틴: A 레지스터의 문자를 화면에 출력)
        inc hl          ; 다음 문자로 이동
        jp loop         ; 반복

done:   ret             ; 프로그램 종료

message:
        .byte "Hello, World!", 0   ; 출력할 문자열 (널 문자 포함)