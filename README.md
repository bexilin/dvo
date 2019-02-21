# DVO core (without ROS dependency)

This repository is a stripped version
of the [original DVO algorithm][dvo].
It only contains `dvo_core`, without the visualization (VTK) and ROS dependencies.

Very few modifications have been done,
appart from removing a lot of code.
They are all visible in the commits history,
but here are a few explanations of them:

- Remove everything except `dvo_core`.
- Update sophus usage to the recent templated version (3ed62aee).
- Re-orthogonalization of the rotation found before feeding it to Sophus::SE3 (adfa21ce),
  to avoid crashes due to verification of orthogonal matrix.
- Change `CMakeLists.txt` to mirror the simpler dependencies (96ce0e7).
- Add a Dockerfile for Docker users (700f5812).
  It provides a container config ready to compile the code.
  Reading it is useful for figuring out exact dependencies
  from a fresh Ubuntu 18.10 system.

All this was done to make testability easier on recent systems.
Check out [mpizenberg/rgbd-tracking-evaluation][eval] if interested.

[dvo]: https://github.com/tum-vision/dvo
[eval]: https://github.com/mpizenberg/rgbd-tracking-evaluation

## Dependencies

- cmake
- OpenCV
- Eigen 3
- Boost
- Sophus

Exact dependencies from a fresh Ubuntu 18.10 install are visible in the Dockerfile.

## Usage

This project builds a shared library named `dvo_core`.
To build it, do as usual:

```sh
mkdir build
cd build
cmake ..
make
```

To use the library in another project,
simply use these three cmake commands in your `CMakeLists.txt`:

- `include_directories( path/to/this/include )`
- `link_directories( path/to/this/build )`
- `target_link_libraries( your_executable dvo_core other_linked_libs )`

An example usage is provided in [mpizenberg/rgbd-tracking-evaluation][eval].
