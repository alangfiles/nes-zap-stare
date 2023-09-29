;
; File generated by cc65 v 2.18 - N/A
;
	.fopt		compiler,"cc65 v 2.18 - N/A"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.forceimport	__STARTUP__
	.import		_pal_bg
	.import		_pal_spr
	.import		_ppu_wait_nmi
	.import		_ppu_off
	.import		_ppu_on_all
	.import		_oam_clear
	.import		_oam_meta_spr
	.import		_bank_spr
	.import		_vram_adr
	.import		_vram_put
	.import		_set_vram_buffer
	.import		_multi_vram_buffer_horz
	.import		_zap_read
	.export		_pad2_zapper
	.export		_zapper_ready
	.export		_zapper1_on_target
	.export		_zapper2_on_target
	.export		_winner
	.export		_game_mode
	.export		_circle_y_direction
	.export		_circle_x_direction
	.export		_circle_color
	.export		_circle_x
	.export		_circle_y
	.export		_circle_x_speed
	.export		_circle_y_speed
	.export		_circle_wait
	.export		_frame_counter
	.export		_temp1
	.export		_temp2
	.export		_move_circle
	.export		_draw_circle
	.export		_read_light
	.export		_check_for_winner
	.export		_initialize
	.export		_initialize_mode_end
	.export		_GiantWhiteCircle
	.export		_pal1
	.export		_pal2
	.export		_main

.segment	"RODATA"

_GiantWhiteCircle:
	.byte	$08
	.byte	$00
	.byte	$09
	.byte	$00
	.byte	$10
	.byte	$00
	.byte	$0A
	.byte	$00
	.byte	$18
	.byte	$00
	.byte	$0B
	.byte	$00
	.byte	$20
	.byte	$00
	.byte	$0C
	.byte	$00
	.byte	$28
	.byte	$00
	.byte	$0D
	.byte	$00
	.byte	$30
	.byte	$00
	.byte	$0E
	.byte	$00
	.byte	$00
	.byte	$08
	.byte	$18
	.byte	$00
	.byte	$08
	.byte	$08
	.byte	$19
	.byte	$00
	.byte	$10
	.byte	$08
	.byte	$1A
	.byte	$00
	.byte	$18
	.byte	$08
	.byte	$1B
	.byte	$00
	.byte	$20
	.byte	$08
	.byte	$1C
	.byte	$00
	.byte	$28
	.byte	$08
	.byte	$1D
	.byte	$00
	.byte	$30
	.byte	$08
	.byte	$1E
	.byte	$00
	.byte	$38
	.byte	$08
	.byte	$1F
	.byte	$00
	.byte	$00
	.byte	$10
	.byte	$28
	.byte	$00
	.byte	$08
	.byte	$10
	.byte	$29
	.byte	$00
	.byte	$10
	.byte	$10
	.byte	$2A
	.byte	$00
	.byte	$18
	.byte	$10
	.byte	$2B
	.byte	$00
	.byte	$20
	.byte	$10
	.byte	$2C
	.byte	$00
	.byte	$28
	.byte	$10
	.byte	$2D
	.byte	$00
	.byte	$30
	.byte	$10
	.byte	$2E
	.byte	$00
	.byte	$38
	.byte	$10
	.byte	$2F
	.byte	$00
	.byte	$00
	.byte	$18
	.byte	$38
	.byte	$00
	.byte	$08
	.byte	$18
	.byte	$39
	.byte	$00
	.byte	$10
	.byte	$18
	.byte	$3A
	.byte	$00
	.byte	$18
	.byte	$18
	.byte	$3B
	.byte	$00
	.byte	$20
	.byte	$18
	.byte	$3C
	.byte	$00
	.byte	$28
	.byte	$18
	.byte	$3D
	.byte	$00
	.byte	$30
	.byte	$18
	.byte	$3E
	.byte	$00
	.byte	$38
	.byte	$18
	.byte	$3F
	.byte	$00
	.byte	$00
	.byte	$20
	.byte	$48
	.byte	$00
	.byte	$08
	.byte	$20
	.byte	$49
	.byte	$00
	.byte	$10
	.byte	$20
	.byte	$4A
	.byte	$00
	.byte	$18
	.byte	$20
	.byte	$4B
	.byte	$00
	.byte	$20
	.byte	$20
	.byte	$4C
	.byte	$00
	.byte	$28
	.byte	$20
	.byte	$4D
	.byte	$00
	.byte	$30
	.byte	$20
	.byte	$4E
	.byte	$00
	.byte	$38
	.byte	$20
	.byte	$4F
	.byte	$00
	.byte	$00
	.byte	$28
	.byte	$58
	.byte	$00
	.byte	$08
	.byte	$28
	.byte	$59
	.byte	$00
	.byte	$10
	.byte	$28
	.byte	$5A
	.byte	$00
	.byte	$18
	.byte	$28
	.byte	$5B
	.byte	$00
	.byte	$20
	.byte	$28
	.byte	$5C
	.byte	$00
	.byte	$28
	.byte	$28
	.byte	$5D
	.byte	$00
	.byte	$30
	.byte	$28
	.byte	$5E
	.byte	$00
	.byte	$38
	.byte	$28
	.byte	$5F
	.byte	$00
	.byte	$00
	.byte	$30
	.byte	$68
	.byte	$00
	.byte	$08
	.byte	$30
	.byte	$69
	.byte	$00
	.byte	$10
	.byte	$30
	.byte	$6A
	.byte	$00
	.byte	$18
	.byte	$30
	.byte	$6B
	.byte	$00
	.byte	$20
	.byte	$30
	.byte	$6C
	.byte	$00
	.byte	$28
	.byte	$30
	.byte	$6D
	.byte	$00
	.byte	$30
	.byte	$30
	.byte	$6E
	.byte	$00
	.byte	$38
	.byte	$30
	.byte	$6F
	.byte	$00
	.byte	$08
	.byte	$38
	.byte	$79
	.byte	$00
	.byte	$10
	.byte	$38
	.byte	$7A
	.byte	$00
	.byte	$18
	.byte	$38
	.byte	$7B
	.byte	$00
	.byte	$20
	.byte	$38
	.byte	$7C
	.byte	$00
	.byte	$28
	.byte	$38
	.byte	$7D
	.byte	$00
	.byte	$30
	.byte	$38
	.byte	$7E
	.byte	$00
	.byte	$80
_pal1:
	.byte	$0F
	.byte	$00
	.byte	$10
	.byte	$30
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
_pal2:
	.byte	$0F
	.byte	$12
	.byte	$22
	.byte	$30
	.byte	$0F
	.byte	$15
	.byte	$25
	.byte	$30
	.byte	$0F
	.byte	$17
	.byte	$27
	.byte	$30
	.byte	$0F
	.byte	$19
	.byte	$29
	.byte	$30
L0176:
	.byte	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	.byte	$20,$20,$20,$20,$20,$20,$20,$00
L012A:
	.byte	$50,$6F,$69,$6E,$74,$20,$7A,$61,$70,$70,$65,$72,$73,$20,$61,$74
	.byte	$20,$63,$69,$72,$63,$6C,$65,$00
L0197:
	.byte	$50,$4C,$41,$59,$45,$52,$20,$31,$20,$57,$4F,$4E,$21,$00
L01A2:
	.byte	$50,$4C,$41,$59,$45,$52,$20,$32,$20,$57,$4F,$4E,$21,$00

.segment	"BSS"

.segment	"ZEROPAGE"
_pad2_zapper:
	.res	1,$00
_zapper_ready:
	.res	1,$00
_zapper1_on_target:
	.res	1,$00
_zapper2_on_target:
	.res	1,$00
_winner:
	.res	1,$00
_game_mode:
	.res	1,$00
_circle_y_direction:
	.res	1,$00
_circle_x_direction:
	.res	1,$00
_circle_color:
	.res	1,$00
_circle_x:
	.res	2,$00
_circle_y:
	.res	2,$00
_circle_x_speed:
	.res	2,$00
_circle_y_speed:
	.res	2,$00
_circle_wait:
	.res	1,$00
_frame_counter:
	.res	1,$00
_temp1:
	.res	1,$00
_temp2:
	.res	1,$00

; ---------------------------------------------------------------
; void __near__ move_circle (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_move_circle: near

.segment	"CODE"

;
; if (circle_x_speed <= MAX_SPEED && frame_counter == 0)
;
	lda     _circle_x_speed+1
	cmp     #$0F
	bne     L01E3
	lda     _circle_x_speed
	cmp     #$01
L01E3:	bcs     L0219
	lda     _frame_counter
	bne     L0219
;
; circle_x_speed += 0x0010; // always increases x speed
;
	lda     #$10
	clc
	adc     _circle_x_speed
	sta     _circle_x_speed
	bcc     L0219
	inc     _circle_x_speed+1
;
; if (high_byte(circle_x) >= 180)
;
L0219:	lda     _circle_x+1
	cmp     #$B4
	bcc     L021A
;
; circle_x_direction = 1;
;
	lda     #$01
	sta     _circle_x_direction
;
; if (high_byte(circle_x) <= 10)
;
L021A:	lda     _circle_x+1
	cmp     #$0B
	bcs     L01EE
;
; circle_x_direction = 0;
;
	lda     #$00
	sta     _circle_x_direction
;
; if (circle_x_direction)
;
L01EE:	lda     _circle_x_direction
	beq     L01F3
;
; circle_x -= circle_x_speed;
;
	lda     _circle_x_speed
	eor     #$FF
	sec
	adc     _circle_x
	sta     _circle_x
	lda     _circle_x_speed+1
	eor     #$FF
;
; else
;
	jmp     L021E
;
; circle_x += circle_x_speed;
;
L01F3:	lda     _circle_x_speed
	clc
	adc     _circle_x
	sta     _circle_x
	lda     _circle_x_speed+1
L021E:	adc     _circle_x+1
	sta     _circle_x+1
;
; if (high_byte(circle_y) >= 170)
;
	lda     _circle_y+1
	cmp     #$AA
	bcc     L021B
;
; circle_y_direction = 1;
;
	lda     #$01
	sta     _circle_y_direction
;
; if (high_byte(circle_y) <= 10)
;
L021B:	lda     _circle_y+1
	cmp     #$0B
	bcs     L01FF
;
; circle_y_direction = 0;
;
	lda     #$00
	sta     _circle_y_direction
;
; if (circle_y_direction)
;
L01FF:	lda     _circle_y_direction
	beq     L0204
;
; circle_y -= circle_y_speed;
;
	lda     _circle_y_speed
	eor     #$FF
	sec
	adc     _circle_y
	sta     _circle_y
	lda     _circle_y_speed+1
	eor     #$FF
;
; else
;
	jmp     L021F
;
; circle_y += circle_y_speed;
;
L0204:	lda     _circle_y_speed
	clc
	adc     _circle_y
	sta     _circle_y
	lda     _circle_y_speed+1
L021F:	adc     _circle_y+1
	sta     _circle_y+1
;
; }
;
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ draw_circle (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_draw_circle: near

.segment	"CODE"

;
; temp1 = high_byte(circle_x);
;
	lda     _circle_x+1
	sta     _temp1
;
; temp2 = high_byte(circle_y);
;
	lda     _circle_y+1
	sta     _temp2
;
; oam_meta_spr(temp1, temp2, GiantWhiteCircle);
;
	jsr     decsp2
	lda     _temp1
	ldy     #$01
	sta     (sp),y
	lda     _temp2
	dey
	sta     (sp),y
	lda     #<(_GiantWhiteCircle)
	ldx     #>(_GiantWhiteCircle)
	jmp     _oam_meta_spr

.endproc

; ---------------------------------------------------------------
; void __near__ read_light (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_read_light: near

.segment	"CODE"

;
; zapper1_on_target = zap_read(0);
;
	lda     #$00
	jsr     _zap_read
	sta     _zapper1_on_target
;
; zapper2_on_target = zap_read(1);
;
	lda     #$01
	jsr     _zap_read
	sta     _zapper2_on_target
;
; }
;
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ check_for_winner (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_check_for_winner: near

.segment	"CODE"

;
; if (zapper1_on_target == 1 && zapper2_on_target == 1)
;
	lda     _zapper1_on_target
	cmp     #$01
	bne     L0224
	lda     _zapper2_on_target
	cmp     #$01
	bne     L0224
;
; return;
;
	rts
;
; if (zapper1_on_target == 0 && zapper2_on_target == 0)
;
L0224:	lda     _zapper1_on_target
	bne     L0228
	lda     _zapper2_on_target
	bne     L0228
;
; if (frame_counter % 2 == 0)
;
	lda     _frame_counter
	and     #$01
	bne     L0229
;
; winner = 1;
;
	lda     #$01
;
; else
;
	jmp     L0220
;
; if (zapper1_on_target == 1)
;
L0228:	lda     _zapper1_on_target
	cmp     #$01
;
; else
;
	beq     L0220
;
; winner = 2;
;
L0229:	lda     #$02
L0220:	sta     _winner
;
; }
;
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ initialize (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_initialize: near

.segment	"CODE"

;
; frame_counter = 0;
;
	lda     #$00
	sta     _frame_counter
;
; game_mode = MODE_TITLE;
;
	sta     _game_mode
;
; circle_color = (circle_color + 1) & 1; // 0 or 1
;
	lda     _circle_color
	clc
	adc     #$01
	and     #$01
	sta     _circle_color
;
; circle_x = 0x6000;           // should give 0x4000-0xbf80
;
	ldx     #$60
	lda     #$00
	sta     _circle_x
	stx     _circle_x+1
;
; circle_y = 0x6000;           // int
;
	sta     _circle_y
	stx     _circle_y+1
;
; circle_x_speed = 0x0100;
;
	ldx     #$01
	sta     _circle_x_speed
	stx     _circle_x_speed+1
;
; circle_y_speed = 0x0100;
;
	sta     _circle_y_speed
	stx     _circle_y_speed+1
;
; winner = 0;
;
	sta     _winner
;
; }
;
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ initialize_mode_end (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_initialize_mode_end: near

.segment	"CODE"

;
; game_mode = MODE_END;
;
	lda     #$03
	sta     _game_mode
;
; ppu_off();
;
	jsr     _ppu_off
;
; oam_clear();
;
	jsr     _oam_clear
;
; if (winner == 1)
;
	lda     _winner
	cmp     #$01
	bne     L0194
;
; multi_vram_buffer_horz("PLAYER 1 WON!", 23, NTADR_A(8, 12));
;
	jsr     decsp3
	lda     #<(L0197)
	ldy     #$01
	sta     (sp),y
	iny
	lda     #>(L0197)
;
; else
;
	jmp     L0230
;
; multi_vram_buffer_horz("PLAYER 2 WON!", 23, NTADR_A(8, 12));
;
L0194:	jsr     decsp3
	lda     #<(L01A2)
	ldy     #$01
	sta     (sp),y
	iny
	lda     #>(L01A2)
L0230:	sta     (sp),y
	lda     #$17
	ldy     #$00
	sta     (sp),y
	ldx     #$21
	lda     #$88
	jsr     _multi_vram_buffer_horz
;
; ppu_on_all();
;
	jmp     _ppu_on_all

.endproc

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

;
; ppu_off(); // screen off
;
	jsr     _ppu_off
;
; pal_bg(pal1);  // load the palette
;
	lda     #<(_pal1)
	ldx     #>(_pal1)
	jsr     _pal_bg
;
; pal_spr(pal2); // load the palette
;
	lda     #<(_pal2)
	ldx     #>(_pal2)
	jsr     _pal_spr
;
; bank_spr(1); // sprites use the 2nd tileset
;
	lda     #$01
	jsr     _bank_spr
;
; ppu_wait_nmi(); // wait
;
	jsr     _ppu_wait_nmi
;
; set_vram_buffer(); // points ppu update to vram_buffer, do this at least once
;
	jsr     _set_vram_buffer
;
; ppu_on_all(); // turn on screen
;
	jsr     _ppu_on_all
;
; initialize();
;
	jsr     _initialize
;
; if (game_mode == MODE_TITLE)
;
L0232:	lda     _game_mode
	bne     L0233
;
; ppu_wait_nmi();
;
	jsr     _ppu_wait_nmi
;
; game_mode = MODE_COUNTDOWN;
;
	lda     #$01
	sta     _game_mode
;
; multi_vram_buffer_horz("Point zappers at circle", 23, NTADR_A(4, 24));
;
	jsr     decsp3
	lda     #<(L012A)
	ldy     #$01
	sta     (sp),y
	iny
	lda     #>(L012A)
	sta     (sp),y
	lda     #$17
	ldy     #$00
	sta     (sp),y
	ldx     #$23
	lda     #$04
	jsr     _multi_vram_buffer_horz
;
; draw_circle();
;
	jsr     _draw_circle
;
; else if (game_mode == MODE_COUNTDOWN)
;
	jmp     L0232
L0233:	lda     _game_mode
	cmp     #$01
	jne     L0238
;
; ppu_wait_nmi();
;
	jsr     _ppu_wait_nmi
;
; ++frame_counter;
;
	inc     _frame_counter
;
; if (frame_counter == 1)
;
	lda     _frame_counter
	cmp     #$01
	bne     L0234
;
; vram_adr(NTADR_A(16, 3));
;
	ldx     #$20
	lda     #$70
	jsr     _vram_adr
;
; vram_put('3');
;
	lda     #$33
;
; else if (frame_counter == 61)
;
	jmp     L0231
L0234:	lda     _frame_counter
	cmp     #$3D
	bne     L0235
;
; vram_adr(NTADR_A(16, 3));
;
	ldx     #$20
	lda     #$70
	jsr     _vram_adr
;
; vram_put('2');
;
	lda     #$32
;
; else if (frame_counter == 121)
;
	jmp     L0231
L0235:	lda     _frame_counter
	cmp     #$79
	bne     L0236
;
; vram_adr(NTADR_A(16, 3));
;
	ldx     #$20
	lda     #$70
	jsr     _vram_adr
;
; vram_put('1');
;
	lda     #$31
;
; else if (frame_counter == 181)
;
	jmp     L0231
L0236:	lda     _frame_counter
	cmp     #$B5
	bne     L0237
;
; vram_adr(NTADR_A(16, 3));
;
	ldx     #$20
	lda     #$70
	jsr     _vram_adr
;
; vram_put('0');
;
	lda     #$30
L0231:	jsr     _vram_put
;
; if (frame_counter == 241)
;
L0237:	lda     _frame_counter
	cmp     #$F1
	jne     L0232
;
; vram_adr(NTADR_A(16, 3));
;
	ldx     #$20
	lda     #$70
	jsr     _vram_adr
;
; vram_put(' ');
;
	lda     #$20
	jsr     _vram_put
;
; game_mode = MODE_GAME;
;
	lda     #$02
	sta     _game_mode
;
; multi_vram_buffer_horz("                       ", 23, NTADR_A(4, 24));
;
	jsr     decsp3
	lda     #<(L0176)
	ldy     #$01
	sta     (sp),y
	iny
	lda     #>(L0176)
	sta     (sp),y
	lda     #$17
	ldy     #$00
	sta     (sp),y
	ldx     #$23
	lda     #$04
	jsr     _multi_vram_buffer_horz
;
; else if (game_mode == MODE_GAME)
;
	jmp     L0232
L0238:	lda     _game_mode
	cmp     #$02
	bne     L0239
;
; ++frame_counter;
;
	inc     _frame_counter
;
; ppu_wait_nmi();
;
	jsr     _ppu_wait_nmi
;
; oam_clear();
;
	jsr     _oam_clear
;
; move_circle();
;
	jsr     _move_circle
;
; draw_circle();
;
	jsr     _draw_circle
;
; read_light();
;
	jsr     _read_light
;
; if (winner == 0)
;
	lda     _winner
	jne     L0232
;
; initialize_mode_end();
;
	jsr     _initialize_mode_end
;
; else if (game_mode == MODE_END)
;
	jmp     L0232
L0239:	lda     _game_mode
	cmp     #$03
	jne     L0232
;
; ppu_wait_nmi();
;
	jsr     _ppu_wait_nmi
;
; while (1) // main loop
;
	jmp     L0232

.endproc

