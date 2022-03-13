cmake_minimum_required(VERSION 3.14)

project(fetchcontentTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

if(PROJECT_IS_TOP_LEVEL)
  find_package(fetchcontent REQUIRED)
  enable_testing()
endif()

add_executable(fetchcontent_test source/fetchcontent_test.cpp)
target_link_libraries(fetchcontent_test PRIVATE fetchcontent::fetchcontent)
target_compile_features(fetchcontent_test PRIVATE cxx_std_17)

add_test(NAME fetchcontent_test COMMAND fetchcontent_test)

add_folders(Test)
