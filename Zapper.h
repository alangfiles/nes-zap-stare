//variables

#define MAX_SPEED 0x0F00

#pragma bss-name(push, "ZEROPAGE")
unsigned char pad1_zapper;
unsigned char pad2_zapper;
unsigned char zapper1_on_target;
unsigned char zapper2_on_target;
unsigned char winner;


unsigned char game_mode;

enum{
  MODE_TITLE,
  MODE_COUNTDOWN,
  MODE_GAME,
  MODE_END
};

unsigned char circle_y_direction;
unsigned char circle_x_direction;
unsigned int circle_x;
unsigned int circle_y;
unsigned int circle_x_speed;
unsigned int circle_y_speed;
unsigned char circle_wait;

unsigned char frame_counter;

unsigned char temp1;
unsigned char temp2;

#pragma bss-name(push, "BSS")


// PROTOTYPES
void move_circle(void);
void draw_circle(void);
void read_light(void);
void check_for_winner(void);
void initialize_variables(void);
void initialize_mode_end(void);
void initialize_mode_countdown(void);
void initialize_mode_game(void);
