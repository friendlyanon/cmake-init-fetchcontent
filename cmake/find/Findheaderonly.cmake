# Read the documentation of FetchContent first!
# https://cmake.org/cmake/help/latest/module/FetchContent.html

include(FetchContent)

FetchContent_Declare(
    headeronly
    GIT_REPOSITORY https://github.com/friendlyanon/cmake-init-header-only.git
    GIT_TAG v0.20.6
    GIT_SHALLOW YES
)

# Note that here we manually do what FetchContent_MakeAvailable() would do,
# except to ensure that the dependency can also get what it needs, we add
# custom logic between the FetchContent_Populate() and add_subdirectory()
# calls.
FetchContent_GetProperties(headeronly)
if(NOT headeronly_POPULATED)
  FetchContent_Populate(headeronly)

  # If the dependency uses a similar opt-in vendoring strategy to this project,
  # then we can make its find modules available for it to use. Note that this
  # isn't good enough to handle a diamond hierarchy in the dependency graph,
  # there are dependency managers (like Conan and vcpkg) for that.
  # This command here does nothing, because the dependency has no dependencies,
  # so this is just for show. In such cases, you can just use the
  # FetchContent_MakeAvailable() command.
  list(APPEND CMAKE_MODULE_PATH "${headeronly_SOURCE_DIR}/cmake/find")

  add_subdirectory("${headeronly_SOURCE_DIR}" "${headeronly_BINARY_DIR}")
endif()

# Because we are in a find module, we are solely responsible for resolution.
# Setting this *_FOUND variable to a truthy value will signal to the calling
# find_package() command that we were successful.
# More relevant info regarding find modules and what variables they use can be
# found in the documentation of find_package() and
# https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html
set(headeronly_FOUND 1)
