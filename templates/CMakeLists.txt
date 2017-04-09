cmake_minimum_required (VERSION 3.0.0)
project (%PROJ_NAME%)

set(CMAKE_CXX_STANDARD %CPP_STD%)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Includes
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include
                    ${CMAKE_CURRENT_SOURCE_DIR}/tests/include)

# Source
file(GLOB SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
file(GLOB UT_SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/tests/*.cpp)

# Boost
set(Boost_USE_STATIC_LIBS ON)
find_package(Boost)
include_directories(${Boost_INCLUDE_DIRS})

# Tests
add_subdirectory(modules/googletest-release-1.8.0)
include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR} ${gmock_SOURCE_DIR}/include)

# Main executable
add_executable(%PROJ_NAME% ${SOURCE_FILES})
target_link_libraries(%PROJ_NAME% ${BOOST_LIBRARIES})

# UT executable
add_executable(%PROJ_NAME%_ut ${UT_SOURCE_FILES})
target_link_libraries(%PROJ_NAME%_ut gtest gtest_main gmock)

install(TARGETS %PROJ_NAME% %PROJ_NAME%_ut DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/artifacts) 
