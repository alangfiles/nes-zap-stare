/*	example code for cc65, for NES
 *  testing the zapper gun on controller slot 2
 *	using neslib
 *	Doug Fraker 2018
 */

#include "LIB/neslib.h"
#include "LIB/nesdoug.h"

#include "LIB/zaplib.h"
#include "Zapper.h"
#include "Sprites.h"

const unsigned char pal1[] = {
		0x0f, 0x00, 0x10, 0x30,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0};

const unsigned char pal2[] = {
		0x0f,
		0x12,
		0x22,
		0x30,
		0x0f,
		0x15,
		0x25,
		0x30,
		0x0f,
		0x17,
		0x27,
		0x30,
		0x0f,
		0x19,
		0x29,
		0x30,
};

void main(void)
{

	ppu_off(); // screen off

	pal_bg(pal1);	 //	load the palette
	pal_spr(pal2); //	load the palette

	bank_spr(1); // sprites use the 2nd tileset

	ppu_wait_nmi(); // wait

	set_vram_buffer(); // points ppu update to vram_buffer, do this at least once
	initialize_variables();
	ppu_on_all(); // turn on screen

	while (1) // main loop
	{
		ppu_wait_nmi();
		++frame_counter;

		if (game_mode == MODE_TITLE)
		{
			// wait for both players to pull trigger?

			initialize_mode_countdown();
		}
		else if (game_mode == MODE_COUNTDOWN)
		{

			// draw the circle, but don't move it.

			// count down 3-2-1, then start the game

			if (frame_counter == 1)
			{
				vram_adr(NTADR_A(16, 3));
				vram_put('3');
			}
			else if (frame_counter == 61)
			{
				vram_adr(NTADR_A(16, 3));
				vram_put('2');
			}
			else if (frame_counter == 121)
			{
				vram_adr(NTADR_A(16, 3));
				vram_put('1');
			}
			else if (frame_counter == 181)
			{
				vram_adr(NTADR_A(16, 3));
				vram_put('0');
			}

			if (frame_counter == 241)
			{
				initialize_mode_game();
			}
		}

		else if (game_mode == MODE_GAME)
		{
			oam_clear();
			move_circle();
			draw_circle();

			read_light();

			if (winner != 0)
			{
				initialize_mode_end();
			}
		}
		else if (game_mode == MODE_END)
		{
			// wait then go back to game
			if (frame_counter == 255)
			{
				initialize_variables();
			}
		}
	}
}

void initialize_mode_game(void)
{
	vram_adr(NTADR_A(16, 3));
	vram_put(' ');
	game_mode = MODE_GAME;
	multi_vram_buffer_horz("                       ", 23, NTADR_A(4, 24));
}

void initialize_mode_countdown(void)
{
	game_mode = MODE_COUNTDOWN;
	multi_vram_buffer_horz("Point zappers at circle", 23, NTADR_A(4, 24));
	draw_circle();
}

void initialize_mode_end(void)
{
	game_mode = MODE_END;
	ppu_off();
	oam_clear();

	if (winner == 1)
	{
		multi_vram_buffer_horz("PLAYER 1 WON!", 23, NTADR_A(8, 12));
	}
	else
	{
		multi_vram_buffer_horz("PLAYER 2 WON!", 23, NTADR_A(8, 12));
	}
	ppu_on_all();
}

void read_light(void)
{
	// Reading light takes a full frame, so every other
	// frame we check zapper 1 or zapper 2
	if ((frame_counter % 2) == 0)
	{
		zapper1_on_target = zap_read(0);
	}
	else
	{
		zapper2_on_target = zap_read(1);
	}
}

void check_for_winner(void)
{

	if (zapper1_on_target == 1 && zapper2_on_target == 1)
	{
		// nobody's won, keep playing
		return;
	}
	else if (zapper1_on_target == 1)
	{
		winner = 1;
	}
	else
	{
		winner = 2;
	}
}

void initialize_variables(void)
{
	frame_counter = 0;
	game_mode = MODE_TITLE;
	circle_x = 0x6000;
	circle_y = 0x6000;
	circle_x_speed = 0x0100;
	circle_y_speed = 0x0100;
	winner = 0;
	zapper1_on_target = 1;
	zapper2_on_target = 1;
}

void move_circle(void)
{
	// update speed for x movement

	if (circle_x_speed <= MAX_SPEED && frame_counter == 0)
	{
		circle_x_speed += 0x0010; // always increases x speed
	}

	if (high_byte(circle_x) >= 180)
	{
		// start movign in other direction
		circle_x_direction = 1;
	}
	if (high_byte(circle_x) <= 10)
	{
		circle_x_direction = 0;
	}

	if (circle_x_direction)
	{
		circle_x -= circle_x_speed;
	}
	else
	{
		circle_x += circle_x_speed;
	}

	// circle_y movement
	if (high_byte(circle_y) >= 170)
	{
		// start moving in other direction
		circle_y_direction = 1;
	}
	if (high_byte(circle_y) <= 10)
	{
		circle_y_direction = 0;
	}

	if (circle_y_direction)
	{
		circle_y -= circle_y_speed;
	}
	else
	{
		circle_y += circle_y_speed;
	}
}

void draw_circle(void)
{
	temp1 = high_byte(circle_x);
	temp2 = high_byte(circle_y);
	oam_meta_spr(temp1, temp2, GiantWhiteCircle);
}
