cmake_minimum_required(VERSION 2.4.6)
project(dvo)

set( CMAKE_CXX_STANDARD 11 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_EXTENSIONS OFF )

find_package(OpenCV REQUIRED)
find_package(Eigen3 3.3 REQUIRED)
find_package(Boost REQUIRED)
find_package(Sophus REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})
include_directories(${Boost_INCLUDE_DIRS})
include_directories(${Sophus_INCLUDE_DIRS})

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif(NOT CMAKE_BUILD_TYPE)
set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-msse2 -msse3")

# Retrieve all cpp files.
# Usage of GLOB means you need to run cmake every time a file is added/removed.
File(GLOB_RECURSE src_core src/core/*.cpp)
set(src_files ${src_core} src/dense_tracking.cpp src/dense_tracking_config.cpp src/util/histogram.cpp)

# Compile to shared library.
add_library(dvo_core SHARED ${src_files} )
target_include_directories(dvo_core PUBLIC include)
target_link_libraries(dvo_core ${OpenCV_LIBS} tbb Eigen3::Eigen)
