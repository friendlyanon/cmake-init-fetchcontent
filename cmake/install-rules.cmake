if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_INCLUDEDIR include/fetchcontent CACHE PATH "")
endif()

# Project is configured with no languages, so tell GNUInstallDirs the lib dir
set(CMAKE_INSTALL_LIBDIR lib CACHE PATH "")

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package fetchcontent)

install(
    DIRECTORY include/
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT fetchcontent_Development
)

install(
    TARGETS fetchcontent_fetchcontent
    EXPORT fetchcontentTargets
    INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

configure_file(
    cmake/install-config.cmake.in "${package}Config.cmake"
    @ONLY
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
    ARCH_INDEPENDENT
)

# Allow package maintainers to freely override the path for the configs
set(
    fetchcontent_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(fetchcontent_INSTALL_CMAKEDIR)

install(
    FILES
    "${PROJECT_BINARY_DIR}/${package}Config.cmake"
    "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${fetchcontent_INSTALL_CMAKEDIR}"
    COMPONENT fetchcontent_Development
)

install(
    EXPORT fetchcontentTargets
    NAMESPACE fetchcontent::
    DESTINATION "${fetchcontent_INSTALL_CMAKEDIR}"
    COMPONENT fetchcontent_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
