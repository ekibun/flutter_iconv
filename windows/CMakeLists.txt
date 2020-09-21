cmake_minimum_required(VERSION 3.15)
set(PROJECT_NAME "flutter_iconv")
project(${PROJECT_NAME} LANGUAGES CXX)

set(PLUGIN_NAME "${PROJECT_NAME}_plugin")

set(CXX_LIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../cxx)

add_library(${PLUGIN_NAME} SHARED
  "${PLUGIN_NAME}.cpp"
  ${CXX_LIB_DIR}/ffi.cpp
)

#iconv
add_subdirectory(${CXX_LIB_DIR} libiconv.out)

apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin libiconv)

# List of absolute paths to libraries that should be bundled with the plugin
set(flutter_iconv_bundled_libraries
  ""
  PARENT_SCOPE
)
