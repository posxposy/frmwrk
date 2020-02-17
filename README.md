# frmwrk

assimp:
`cmake -G "Visual Studio 16 2019" -A Win32 -S ./ -B "build" -DBUILD_SHARED_LIBS=ON`

glfw:
` cmake -G "Visual Studio 16 2019" -A Win32 -S ./ -B "build" -DUSE_MSVC_RUNTIME_LIBRARY_DLL=OFF -DGLFW_BUILD_EXAMPLES=OFF -DGLFW_BUILD_DOCS=OFF -DGLFW_BUILD_TESTS=OFF`