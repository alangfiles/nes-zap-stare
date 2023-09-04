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

	while (1)
	{
		// infinite loop
		ppu_wait_nmi(); // wait till beginning of the frame

		oam_clear();

		zapper_ready = pad2_zapper ^ 1; // XOR last frame, make sure not held down still

		// is trigger pulled?
		pad2_zapper = zap_shoot(1); // controller slot 2

		if (circle_active)
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

				if (hit_detected)
				{
					// delete object, set wait
					circle_active = 0;
					circle_wait = 20; // to time the next spawn
				}
				// if hit failed, it should have already ran into the next nmi
			}
		}
		else if (circle_wait)
		{
			--circle_wait;
		}
	}
}

void move_circle(void)
{
	// gravity, circle_y_speed = 16 bit, upper 8 bits = pixel, lower = subpixel
	circle_y_speed += 0x0010;
	if ((circle_y_speed < 0x8000) && (circle_y_speed > 0x0400))
		circle_y_speed = 0x0400;

	circle_x += circle_x_speed;
	if (circle_x >= 0xf000)
		circle_active = 0;

	circle_y += circle_y_speed;
	if (circle_y >= 0xe000)
		circle_active = 0;
}

void draw_circle(void)
{
	temp1 = high_byte(circle_x);
	temp2 = high_byte(circle_y);
	if (circle_color == 0)
	{
		oam_meta_spr(temp1, temp2, GiantWhiteCircle);
	}
	else
	{
		oam_meta_spr(temp1, temp2, GiantWhiteCircle);
	}
}
