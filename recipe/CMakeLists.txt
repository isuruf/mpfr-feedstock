cmake_minimum_required(VERSION 3.3.0)

project(MPFR LANGUAGES C)

# Find GMP (or MPIR)
find_library(GMP_LIBRARY NAMES gmp mpir)
find_path(GMP_INCLUDE_DIR "gmp.h")

# Sources
file(GLOB SRCS src/*.c)
list(SORT SRCS)

configure_file("src/mparam_h.in" "mparam.h")

# Create and configure the target
add_library(mpfr ${SRCS})

target_compile_definitions(mpfr PRIVATE __MPFR_WITHIN_MPFR)
target_compile_definitions(mpfr PRIVATE MPFR_USE_THREAD_SAFE)
target_compile_definitions(mpfr PRIVATE HAVE_STDINT_H)
target_compile_definitions(mpfr PRIVATE HAVE_STDARG)
target_compile_definitions(mpfr PRIVATE HAVE_LONG_LONG)
target_compile_definitions(mpfr PRIVATE __tune_core2__)
target_compile_definitions(mpfr PRIVATE MPFR_HAVE_GMP_IMPL)
target_compile_definitions(mpfr PRIVATE HAVE_CONFIG_H)

if(BUILD_SHARED_LIBS)
    target_compile_definitions(mpfr PRIVATE __GMP_LIBGMP_DLL)
endif()

target_link_libraries(mpfr ${GMP_LIBRARY})

target_include_directories(mpfr PUBLIC ${GMP_INCLUDE_DIR})
target_include_directories(mpfr PRIVATE ${CMAKE_BINARY_DIR})
target_include_directories(mpfr PRIVATE ${PROJECT_SOURCE_DIR})
target_include_directories(mpfr PRIVATE ${PROJECT_SOURCE_DIR}/src)

# Install
install(
  TARGETS mpfr
  EXPORT MPFRExports
  RUNTIME DESTINATION "bin"
  LIBRARY DESTINATION "lib"
  ARCHIVE DESTINATION "lib"
  )

install(
  FILES   src/mpfr.h
  DESTINATION "include"
)
