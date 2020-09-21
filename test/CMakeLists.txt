cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(flutter_iconv LANGUAGES CXX)
set(CXX_LIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../cxx)

add_library(flutter_iconv SHARED ${CXX_LIB_DIR}/ffi.cpp)

#iconv
add_subdirectory(${CXX_LIB_DIR} libiconv.out)

target_link_libraries(flutter_iconv PRIVATE libiconv)
