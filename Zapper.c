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

	//	music_play(0); // silence

	set_vram_buffer(); // points ppu update to vram_buffer, do this at least once

	ppu_on_all(); // turn on screen
	initialize();
	while (1)
	{
		// game mode title
		//  wait for both players to pull trigger
		// game mode game
		//  ball starts in middle, then starts to move
		//  game mode gameover
		//  shows the name of the winner
		//  both players press to start again
		// zapper_ready = pad2_zapper ^ 1; // XOR last frame, make sure not held down still

		// // is trigger pulled?
		// pad2_zapper = zap_shoot(1); // controller slot 2

		if (game_mode == MODE_TITLE)
		{
			ppu_wait_nmi();
			// wait for both players to pull trigger?

			game_mode = MODE_COUNTDOWN;
			multi_vram_buffer_horz("Point zappers at circle", 23, NTADR_A(4, 24));
			draw_circle();
		}
		if (game_mode == MODE_COUNTDOWN)
		{
			ppu_wait_nmi();
			++frame_counter;
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
				game_mode = MODE_GAME;
				multi_vram_buffer_horz("                       ", 23, NTADR_A(4, 24));
			}
		}

		if (game_mode == MODE_GAME)
		{
			++frame_counter;
			ppu_wait_nmi();
			oam_clear();
			move_circle();
			draw_circle();
			// if ((pad2_zapper) && (zapper_ready))
			// {

			// 	// trigger pulled, play bang sound
			// 	sfx_play(0, 0);

			// 	// bg off, project white boxes
			// 	oam_clear();
			// 	ppu_mask(0x16); // BG off, won't happen till NEXT frame

			// 	ppu_wait_nmi(); // wait till the top of the next frame
			// 	// this frame will display no BG and a white box

			// 	oam_clear();		// clear the NEXT frame
			// 	draw_circle();	// draw a star on the NEXT frame
			// 	ppu_mask(0x1e); // bg on, won't happen till NEXT frame

			// 	hit_detected = zap_read(1); // look for light in zapper, port 2

			// 	// if hit failed, it should have already ran into the next nmi
			// }
		}
	}
}

void initialize(void)
{
	frame_counter = 0;
	game_mode = MODE_GAME;
	circle_color = (circle_color + 1) & 1; // 0 or 1
	circle_x = 0x6000;										 // should give 0x4000-0xbf80
	circle_y = 0x6000;										 // int
	circle_x_speed = 0x0100;
	circle_y_speed = 0x0100;
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
