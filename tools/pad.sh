#!/bin/bash

# 사용법: ./pad.sh a.out

# 파일명 입력 확인
if [ -z "$1" ]; then
    echo "사용법: $0 [바이너리 파일]"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="padded_$INPUT_FILE"
TARGET_SIZE=32768

# 입력 파일 존재 확인
if [ ! -f "$INPUT_FILE" ]; then
    echo "오류: 파일 '$INPUT_FILE' 이 존재하지 않습니다."
    exit 1
fi

# 현재 파일 크기 확인
CURRENT_SIZE=$(stat -c %s "$INPUT_FILE")

# 이미 충분한 크기일 경우 경고
if [ "$CURRENT_SIZE" -ge "$TARGET_SIZE" ]; then
    echo "경고: 파일 크기 (${CURRENT_SIZE} bytes)가 이미 ${TARGET_SIZE} bytes 이상입니다. 패딩하지 않습니다."
    cp "$INPUT_FILE" "$OUTPUT_FILE"
    exit 0
fi

# 필요한 패딩 크기 계산
PAD_SIZE=$((TARGET_SIZE - CURRENT_SIZE))

# 결과 파일 생성
cp "$INPUT_FILE" "$OUTPUT_FILE"
dd if=/dev/zero bs=1 count=$PAD_SIZE >> "$OUTPUT_FILE" status=none

echo "패딩 완료: $OUTPUT_FILE (${CURRENT_SIZE} → ${TARGET_SIZE} bytes)"
