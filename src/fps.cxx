#include "fps.hxx"

namespace Moon {
  FPS::FPS() {
    OldTime     = 0.0f;
    LastTime    = 0.0f;
    SpeedFactor = 0;
    Frames      = 0;
    NumFrames   = 0;
  }

  void FPS::update() {
    if(OldTime + 1.0f < glfwGetTime()) {
      OldTime = glfwGetTime();
      NumFrames = Frames;
      Frames = 0;
    }
    Delta = glfwGetTime() - LastTime;
    SpeedFactor = (Delta / 1.0f) * 32.0f; // 32 is number of pixels per second
    LastTime = glfwGetTime();
    Frames++;
  }

  float FPS::getDelta() {
    return Delta;
  };

  int FPS::getFPS() {
    return NumFrames;
  }

  float FPS::getSpeedFactor() {
    return SpeedFactor;
  }
}