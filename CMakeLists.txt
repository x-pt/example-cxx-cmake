# Specify the minimum version of CMake required
cmake_minimum_required(VERSION 3.25)

# Define the project
project(example-cxx-cmake
        VERSION 0.0.1
        DESCRIPTION "A nice example project"
        HOMEPAGE_URL "https://github.com/x-pt/example-cxx-cmake"
        LANGUAGES CXX
)

# ===================== Build Settings =====================

# Set C++ standards
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Set compile options
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)  # Enable compile commands for clangd

# Set architecture for macOS (if applicable)
if(APPLE)
    set(CMAKE_OSX_ARCHITECTURES "arm64")
endif()

# ===================== Output Directories =====================

# Use generator expressions for output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "$<1:${CMAKE_BINARY_DIR}/bin>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "$<1:${CMAKE_BINARY_DIR}/lib>")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "$<1:${CMAKE_BINARY_DIR}/lib>")

# ===================== Source Files =====================

# Collect source files
file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS
        ${CMAKE_SOURCE_DIR}/src/*.cpp
)
file(GLOB_RECURSE HEADERS CONFIGURE_DEPENDS
        ${CMAKE_SOURCE_DIR}/include/*.h
)

# ===================== Library Target =====================

# Create library target
add_library(example_cxx_cmake_lib ${SOURCES} ${HEADERS})

# Set include directories for the library
target_include_directories(example_cxx_cmake_lib
        PUBLIC
        ${CMAKE_SOURCE_DIR}/include
)

# ===================== Executable Target =====================

# Create executable target
add_executable(example-cxx-cmake ${CMAKE_SOURCE_DIR}/src/main.cpp)

# Link library and CUDA libraries to the executable
target_link_libraries(example-cxx-cmake
        PRIVATE
        example_cxx_cmake_lib
)

# ===================== Tests =====================

# Add tests subdirectory
add_subdirectory(tests)
