# /!\ Attention /!\

This repository showcases a form of vendoring. Vendoring is a bad practice of
pulling in source code of other projects into your own and building those
projects in the same build as your own. This makes packaging a project
potentially very difficult or otherwise requires unnecessary patches to be
maintained by the package manager that remove the vendoring.

You can't realistically vendor any project. They must be architected in a way
that allows them to be consumed like this. The [dependency][1] that is used as
an example in this repository was generated by [cmake-init][2], which produces
projects that are by default easy to vendor.

Even if something is easy to vendor, because everything happens in a single
build, the vendored project will inherit your flags, which could cause errors
in sources compiled from the vendored project if you are using a
warnings-as-errors flag.

## fetchcontent

This project was generated by [cmake-init][2].  
It's heavily stripped down to focus on showing how to optionally make
dependencies available using [FetchContent][3] via find modules.

If you look at the [build script](CMakeLists.txt#L34), you will see that the
dependency is imported using the `find_package` command like normal. **This is
very important!** The point of this example is to showcase vendoring that is
done completely transparently.

You will also notice that the [linking](CMakeLists.txt#L35) is done using the
target that contains a double colon. If you were using an `IMPORTED` target
that was created by a CMake package's config file, then you would have the
exact same target name. The target name in this case comes from the `ALIAS`
target from the [dependency's build script][4].

The opt-in is done by setting the `CMAKE_MODULE_PATH` variable in the [dev
preset](CMakePresets.json#L24-L39), which enables the `find_package` command to
find the [`Findheaderonly.cmake`](cmake/find/Findheaderonly.cmake) file in
module mode. We know that `find_package` will use module mode first before
config mode, because the [basic signature][5] of the command is used and
[`CMAKE_FIND_PACKAGE_PREFER_CONFIG`][6] isn't enabled.

The rest of the logic is explained in the find module.

[1]: https://github.com/friendlyanon/cmake-init-header-only
[2]: https://github.com/friendlyanon/cmake-init
[3]: https://cmake.org/cmake/help/latest/module/FetchContent.html
[4]: https://github.com/friendlyanon/cmake-init-header-only/blob/v0.20.6/CMakeLists.txt#L21
[5]: https://cmake.org/cmake/help/latest/command/find_package.html#basic-signature
[6]: https://cmake.org/cmake/help/latest/variable/CMAKE_FIND_PACKAGE_PREFER_CONFIG.html
