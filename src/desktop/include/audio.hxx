#ifndef MOON_AUDIO_H
#define MOON_AUDIO_H

#include "moon.hxx"
/* Gorilla Audio */
#include <gorilla/ga.h>
#include <gorilla/gau.h>

namespace Moon {
  class Audio {
  public:
    static void initialize();
    static void update();
    static void terminate();
  protected:
    static gau_Manager* mgr;
    static ga_Mixer* mixer;
    static ga_StreamManager* streamMgr;
  };
};

#endif