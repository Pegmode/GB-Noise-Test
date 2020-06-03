;noise test rom
;By Pegmode

;Tests all the noise values from Deflemask for 15 and 7 step polly modes
;Then steps through all possible values 

;Constant Includes (DO NOT ADD CODE)
;==================================================
include "hardware.asm"
include "constants.asm"
	
;Header
;==================================================
include "GBHeader.asm" 

;User Program
;==================================================
SECTION "Main Program",ROM0[$155]

Init:
	ld hl,rNR41
	ld [hl],$80
	ld hl,rNR51
	ld [hl],$FF
	ld hl,rNR50
	ld [hl],$FF

	ld hl,rNR42
	ld [hl],%11110010
	ld hl,NTablePointer
	ld bc,NoiseCounterVal
	;ld bc,NoiseValueGen
	ld [hl],b
	inc hl
	ld [hl],c
	ld hl,WaitTimer
	ld [hl],WaitTime
	ld hl,rNR52
	ld [hl],%10000000
	ld hl,rIE
	ld [hl],%00000001
	ei

Main:
	nop
	jp Main


UpdateNoise:
	ld hl,NTablePointer
	ld d,[hl]
	inc hl
	ld e,[hl]
	ld l,e
	ld h,d
	ld a,[hl]
	cp $FF
	jr z,Main
	ld hl,rNR43
	ld [hl],a
	inc de
	ld hl,NTablePointer
	ld [hl],d
	inc hl
	ld [hl],e
	ret

VBlank:
	ld hl,WaitTimer
	ld a,[hl]
	cp 0
	jr nz,.waitThisFrame
	call UpdateNoise
	ld hl,rNR44
	ld [hl],$80
	ld a,WaitTime + 1
.waitThisFrame:
	dec a
	ld hl,WaitTimer
	ld [hl],a
	reti




NoiseCounterVal:
	;from deflemask
	;15 step
	db $a4,$97,$96,$95,$94,$87,$86,$85,$84,$77,$76,$75,$74,$67,$66,$65,$64
	db $57,$56,$55,$54,$47,$46,$45,$44,$37,$36,$35,$34,$27,$26,$25,$24
	db $17,$16,$15,$14,$07,$06,$05,$04,$03,$02,$01,$00
	;7 step
	db $ac,$9f,$9e,$9d,$9c,$8f,$8e,$8d,$8c,$7f,$7e,$7d,$7c,$6f,$6e,$6d,$6c
	db $5f,$5e,$5d,$5c,$4f,$4e,$4d,$4c,$3f,$3e,$3d,$3c,$2f,$2e,$2d,$2c
	db $1f,$1e,$1d,$1c,$0f,$0e,$0d,$0c,$0b,$0a,$09,$08

	;db $FF ;sentin


NoiseValueGen:
;15 Step
db $d7,  $d6,  $d5,  $d4,  $c7,  $d3,  $c6,  $c5,  $d2,  $c4,  $b7,  $c3,  $b6,  $b5,  $d1,  $c2,  $b4,  $a7,  $b3,  $a6,  $a5,  $d0,  $c1,  $b2,  $a4,  $97,  $a3,  $96,  $95,  $c0,  $b1,  $a2,  $94,  $87,  $93,  $86,  $85,  $b0,  $a1,  $92,  $84,  $77,  $83,  $76,  $75,  $a0,  $91,  $82,  $74,  $67,  $73,  $66,  $65,  $90,  $81,  $72,  $64,  $57,  $63,  $56,  $55,  $80,  $71,  $62,  $54,  $47,  $53,  $46,  $45,  $70,  $61,  $52,  $44,  $37,  $43,  $36,  $35,  $60,  $51,  $42,  $34,  $27,  $33,  $26,  $25,  $50,  $41,  $32,  $24,  $17,  $23,  $16,  $15,  $40,  $31,  $22,  $14,  $7,  $13,  $6,  $5,  $30,  $21,  $12,  $4,  $3,  $20,  $11,  $2,  $10,  $1,  $0
;7 Step
db $df,  $de,  $dd,  $dc,  $cf,  $db,  $ce,  $cd,  $da,  $cc,  $bf,  $cb,  $be,  $bd,  $d9,  $ca,  $bc,  $af,  $bb,  $ae,  $ad,  $d8,  $c9,  $ba,  $ac,  $9f,  $ab,  $9e,  $9d,  $c8,  $b9,  $aa,  $9c,  $8f,  $9b,  $8e,  $8d,  $b8,  $a9,  $9a,  $8c,  $7f,  $8b,  $7e,  $7d,  $a8,  $99,  $8a,  $7c,  $6f,  $7b,  $6e,  $6d,  $98,  $89,  $7a,  $6c,  $5f,  $6b,  $5e,  $5d,  $88,  $79,  $6a,  $5c,  $4f,  $5b,  $4e,  $4d,  $78,  $69,  $5a,  $4c,  $3f,  $4b,  $3e,  $3d,  $68,  $59,  $4a,  $3c,  $2f,  $3b,  $2e,  $2d,  $58,  $49,  $3a,  $2c,  $1f,  $2b,  $1e,  $1d,  $48,  $39,  $2a,  $1c,  $f,  $1b,  $e,  $d,  $38,  $29,  $1a,  $c,  $b,  $28,  $19,  $a,  $18,  $9,  $8

db $FF ;sentin