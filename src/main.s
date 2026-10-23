.segment "HEADER"
.byte "NES", $1A
.byte 2
.byte 1
.byte $00
.byte $00
.res 8, $00

.segment "ZEROPAGE"
.segment "CODE"

reset:
    sei
    cld
    ldx #$40
    stx $4017
    ldx #$FF
    txs
    inx
    stx $2000
    stx $2001
    stx $4010

vblankwait:
    bit $2002
    bpl vblankwait

vblankwait2:
    bit $2002
    bpl vblankwait2

    lda #$3F
    sta $2006
    lda #$00
    sta $2006

    lda #$21
    sta $2007

    lda #$00
    sta $2001

loop:
    jmp loop

.segment "VECTORS"
.word reset
.word reset
.word reset
