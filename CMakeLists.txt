cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    fetchcontent
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES NONE
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(fetchcontent_fetchcontent INTERFACE)
add_library(fetchcontent::fetchcontent ALIAS fetchcontent_fetchcontent)

set_property(
    TARGET fetchcontent_fetchcontent PROPERTY
    EXPORT_NAME fetchcontent
)

target_include_directories(
    fetchcontent_fetchcontent ${warning_guard}
    INTERFACE
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_compile_features(fetchcontent_fetchcontent INTERFACE cxx_std_17)

find_package(headeronly REQUIRED)
target_link_libraries(fetchcontent_fetchcontent INTERFACE headeronly::headeronly)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT fetchcontent_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of fetchcontent"
  )
endif()

include(cmake/folders.cmake)

include(CTest)
if(BUILD_TESTING)
  add_subdirectory(test)
endif()

add_folders(Project)
