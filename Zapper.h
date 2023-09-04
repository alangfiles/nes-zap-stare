//variables

#pragma bss-name(push, "ZEROPAGE")
unsigned char pad2_zapper;
unsigned char zapper_ready; //wait till it's 0
unsigned char hit_detected;


unsigned char game_mode;

enum{
  MODE_TITLE,
  MODE_GAME,
  MODE_END
};

unsigned char circle_y_direction;
unsigned char circle_x_direction;
unsigned char circle_color;
unsigned int circle_x;
unsigned int circle_y;
unsigned int circle_x_speed;
unsigned int circle_y_speed;
unsigned char circle_wait;

unsigned char temp1;
unsigned char temp2;

#pragma bss-name(push, "BSS")


// PROTOTYPES
void move_circle(void);
void draw_circle(void);
void initialize(void);

