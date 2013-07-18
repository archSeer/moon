#include "moon.hxx"

namespace Moon {
  void moon_mrb_input_init(mrb_state *mrb);
  void moon_mrb_sprite_init(mrb_state *mrb);
  void moon_mrb_spritesheet_init(mrb_state *mrb);
  void moon_mrb_sound_init(mrb_state *mrb);
  void moon_mrb_music_init(mrb_state *mrb);
}

void moon_init_mrb_core(mrb_state *mrb) {
  //Moon::moon_mrb_input_init(mrb);
  Moon::moon_mrb_sprite_init(mrb);
  Moon::moon_mrb_spritesheet_init(mrb);
  Moon::moon_mrb_sound_init(mrb);
  Moon::moon_mrb_music_init(mrb);
};