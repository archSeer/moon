#ifndef MOON_ENGINE_H
#define MOON_ENGINE_H

#include "moon.hxx"

#include "window.hxx"
#include "input.hxx"
#include "texture.hxx"
#include "sprite.hxx"
#include "spritesheet.hxx"
#include "audio.hxx"
#include "music.hxx"
#include "sound.hxx"

void moon_init_mrb_core(mrb_state *mrb); // core side
void moon_init_mrb_ext(mrb_state *mrb);

namespace Moon {
  class Engine {
  public:
    Engine();
    ~Engine();
    void run();

    int window_width();
    int window_height();
    
  private:
    mrb_state *mrb;

    Window window;

    void load_mrb();
    bool load_mrb_file(const char* path);
    void load_core_classes();
    void load_user_scripts();

    void setup_opengl();
  };
};

int moon_main(Moon::Engine *engine); // user entry point

#endif