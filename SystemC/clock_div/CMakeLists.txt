cmake_minimum_required(VERSION 3.5.0)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(clock_div)

#include_directories(include)

file(GLOB SOURCES "*.cpp")
add_executable(${PROJECT_NAME} ${SOURCES})

set(SYSTEMC_HOME "/usr/local/include/systemc-3.0.1")
target_include_directories(${PROJECT_NAME} PUBLIC ${SYSTEMC_HOME}/include)
target_link_directories(${PROJECT_NAME} PUBLIC ${SYSTEMC_HOME}/lib-linux64)
target_link_libraries(${PROJECT_NAME} systemc)

#file(VCD_FILES "*.vcd")
#set_target_properties("${PROJECT_NAME}"
#    PROPERTIES ADDITIONAL_CLEAN_FILES "${VCD_FILES}")
