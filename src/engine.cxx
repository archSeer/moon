#include "engine.hxx"

namespace Moon {
  Engine::Engine() {
    glfwInit(); // TODO: check if lib was inited properly
    load_mrb();
  }

  Engine::~Engine() {
    glfwTerminate();
    mrb_close(mrb);
    mrbc_context_free(mrb, mrb_context);
  }

  void Engine::run() {
    glfwDefaultWindowHints();
    glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);
    // Use OpenGL Core v2.1
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1);
    //glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);

    GLFWwindow* window;
    window = glfwCreateWindow(640, 480, "Hello World", NULL, NULL);
    glfwMakeContextCurrent(window);

    std::cout << "OpenGL v" << glfwGetWindowAttrib(window, GLFW_CONTEXT_VERSION_MAJOR) << "." << glfwGetWindowAttrib(window, GLFW_CONTEXT_VERSION_MINOR) << std::endl;

    // Setup OpenGL
    GLint viewport[4];
    glGetIntegerv(GL_VIEWPORT, viewport);
    glMatrixMode(GL_PROJECTION);
    glPushMatrix();
    glLoadIdentity();
    glOrtho(0, viewport[2], viewport[3], 0, -1, 1); // This sets up the OpenGL window so that (0,0) corresponds to the top left corner, and (640,480) corresponds to the bottom right hand corner.
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.375, 0.375, 0.0); // http://www.opengl.org/archives/resources/faq/technical/transformations.htm#tran0030

    glDisable(GL_LIGHTING);
    glDisable(GL_DITHER);
    // Enable blending (alpha transparency)
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    // Depth testing is useful in 3D OpenGL applications where if you render
    // something and then render something that's behind it, the object that's
    // behind won't raster it's polygons over the object that's in front because
    // the depth is tested first. The reason we disable depth testing is when you
    // mix blending and depth testing you get funky results.
    //glDisable(GL_DEPTH_TEST)
    // UPDATE: depth test can be used, but alpha testing needs to be enabled too,
    // or the alpha background will be black.
    glEnable (GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);
    glEnable(GL_ALPHA_TEST);
    glAlphaFunc(GL_GREATER, 0);

    glEnable(GL_TEXTURE_2D); // Use 2D textures
    // end setup OpenGL

    //load_game_object();
    while (!glfwWindowShouldClose(window))
    {
      float ratio;
      int width, height;
      glfwGetFramebufferSize(window, &width, &height);
      ratio = width / (float) height;
      glViewport(0, 0, width, height);
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
      glMatrixMode(GL_PROJECTION);
      glLoadIdentity();
      glOrtho(-ratio, ratio, -1.f, 1.f, 1.f, -1.f);
      glMatrixMode(GL_MODELVIEW);
      glLoadIdentity();
      glRotatef((float) glfwGetTime() * 50.f, 0.f, 0.f, 1.f);
      glBegin(GL_TRIANGLES);
      glColor3f(1.f, 0.f, 0.f);
      glVertex3f(-0.6f, -0.4f, 0.f);
      glColor3f(0.f, 1.f, 0.f);
      glVertex3f(0.6f, -0.4f, 0.f);
      glColor3f(0.f, 0.f, 1.f);
      glVertex3f(0.f, 0.6f, 0.f);
      glEnd();

      //mrb_funcall(mrb, game_object, "update", 0);

      glfwSwapBuffers(window);
      /* Poll for and process events */
      glfwPollEvents();
    }
  }

  void Engine::load_mrb() {
    mrb = mrb_open();
    // mrb_context: Debugger context
    mrb_context = mrbc_context_new(mrb);
    mrb_context->capture_errors = 0;
    mrb_context->dump_result = 0;
    mrb_context->no_exec = 0;
    
    load_core_classes();
    load_user_scripts();
  }

  void Engine::load_user_scripts() {
    load_mrb_files_from_dir("./script/");
  }
  
  void Engine::load_core_classes() {
    load_mrb_files_from_dir("./core/");
  }
  
  void Engine::load_mrb_files_from_dir(const char *directory) {
    DIR *dir;
    struct dirent *ent;
    dir = opendir(directory);
    
    if (dir != NULL) {
      while ((ent = readdir(dir)) != NULL) {
        if (strstr(ent->d_name, ".rb")) {
          load_mrb_file(directory, ent->d_name);
        } else if (ent->d_type == DT_DIR) {
          if (strcmp(ent->d_name, ".") != 0 && strcmp(ent->d_name, "..") != 0) {
            std::string path;
            path += directory;
            path += ent->d_name;
            path += "/";
            load_mrb_files_from_dir(path.c_str());
          }
        }
      }
    }
  }
  
  void Engine::load_mrb_file(const char *file_path, const char *filename) {
    char path[1024];
    
    strcpy(path, file_path);
    strcat(path, filename);
    
    FILE *file;
    
    file = fopen((const char*)path, "r");
    mrb_load_file_cxt(mrb, file, mrb_context);
    std::cout << path << " loaded." << std::endl;
    fclose(file);
  }
}