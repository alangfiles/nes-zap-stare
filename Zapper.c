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

		// infinite loop
		ppu_wait_nmi(); // wait till beginning of the frame

		oam_clear();

		zapper_ready = pad2_zapper ^ 1; // XOR last frame, make sure not held down still

		// is trigger pulled?
		pad2_zapper = zap_shoot(1); // controller slot 2

		if (game_mode == MODE_GAME)
		{
			move_circle();
			draw_circle();
			if ((pad2_zapper) && (zapper_ready))
			{

				// trigger pulled, play bang sound
				sfx_play(0, 0);

				// bg off, project white boxes
				oam_clear();
				ppu_mask(0x16); // BG off, won't happen till NEXT frame

				ppu_wait_nmi(); // wait till the top of the next frame
				// this frame will display no BG and a white box

				oam_clear();		// clear the NEXT frame
				draw_circle();	// draw a star on the NEXT frame
				ppu_mask(0x1e); // bg on, won't happen till NEXT frame

				hit_detected = zap_read(1); // look for light in zapper, port 2

				// if hit failed, it should have already ran into the next nmi
			}
		}
		else if (circle_wait)
		{
			--circle_wait;
		}
	}
}

void initialize(void)
{
	game_mode = MODE_GAME;
	circle_color = (circle_color + 1) & 1; // 0 or 1
	temp1 = rand8();
	circle_x = (temp1 << 7) + 0x4000; // should give 0x4000-0xbf80
	circle_y = 0x7000;								// int
	temp1 = rand8();
	circle_x_speed = ((temp1 & 0x1f) - 0x0f) << 4;
	circle_y_speed = 0xff00;
}

void move_circle(void)
{

	if (circle_x >= 0xB500)
	{
		// start movign in other direction
		circle_x_direction = 1;
	}
	if (circle_x <= 0x0100)
	{
		circle_x_direction = 0;
	}

	if (circle_x_direction)
	{
		circle_x += circle_x_speed;
	}
	else
	{
		circle_x -= circle_x_speed;
	}

	// circle_y movement
	if (circle_y >= 0x9000)
	{
		// start moving in other direction
		circle_y_direction = 1;
	}
	if (circle_y <= 0x0100)
	{
		circle_y_direction = 0;
	}

	if (circle_y_direction)
	{
		circle_y += circle_y_speed;
	}
	else
	{
		circle_y -= circle_y_speed;
	}
}

void draw_circle(void)
{
	temp1 = high_byte(circle_x);
	temp2 = high_byte(circle_y);
	oam_meta_spr(temp1, temp2, GiantWhiteCircle);
}
