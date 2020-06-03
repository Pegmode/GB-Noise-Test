;Generic GB ROM Header
;Based off of header from DevEd


SECTION	"Reset $00",ROM0[$00]
Reset00:	ret

SECTION	"Reset $08",ROM0[$08]
Reset08:	ret

SECTION	"Reset $10",ROM0[$10]
Reset10:	ret

SECTION	"Reset $18",ROM0[$18]
Reset18:	ret

SECTION	"Reset $20",ROM0[$20]
Reset20:	ret

SECTION	"Reset $28",ROM0[$28]
Reset28:	ret

SECTION	"Reset $30",ROM0[$30]
Reset30:	ret

SECTION	"Reset $38",ROM0[$38]
Reset38:	ret

; ================================================================
; Interrupt vectors
; ================================================================

SECTION	"VBlank interrupt",ROM0[$40]
IRQ_VBlank:
	jp VBlank
	

SECTION	"LCD STAT interrupt",ROM0[$48]
IRQ_STAT:
	reti

SECTION	"Timer interrupt",ROM0[$50]
IRQ_Timer:
	reti

SECTION	"Serial interrupt",ROM0[$58]
IRQ_Serial:
	reti

SECTION	"Joypad interrupt",ROM0[$60]
IRQ_Joypad:
	reti
SECTION	"ROM header",ROM0[$100]

EntryPoint:
	nop
	jp	Init

NintendoLogo:	; DO NOT MODIFY!!!
	db	$ce,$ed,$66,$66,$cc,$0d,$00,$0b,$03,$73,$00,$83,$00,$0c,$00,$0d
	db	$00,$08,$11,$1f,$88,$89,$00,$0e,$dc,$cc,$6e,$e6,$dd,$dd,$d9,$99
	db	$bb,$bb,$67,$63,$6e,$0e,$ec,$cc,$dd,$dc,$99,$9f,$bb,$b9,$33,$3e

ROMTitle:		db	"NOISE TEST "	; ROM title (11 bytes)
ProductCode:	db	"PEG "			; Product code (4 bytes)
GBCSupport:		db	0				; GBC support (0 = DMG only, $80 = DMG/GBC, $C0 = GBC only)
NewLicenseCode:	dw	0				; new license code (2 bytes)
SGBSupport:		db	SGB_UNSUPPORTED				; SGB support
CartType:		db	CART_MBC5				; Cart type, see hardware.inc for a list of values
ROMSize:		ds	CART_ROM_2M				; ROM size (handled by post-linking tool)
RAMSize:		db	0				; RAM size
DestCode:		db	1				; Destination code (0 = Japan, 1 = All others)
OldLicenseCode:	db	$33				; Old license code (if $33, check new license code)
ROMVersion:		db	0				; ROM version
HeaderChecksum:	ds	1				; Header checksum (handled by post-linking tool)
ROMChecksum:	ds	2				; ROM checksum (2 bytes) (handled by post-linking tool)
