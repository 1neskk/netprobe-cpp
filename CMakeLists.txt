cmake_minimum_required(VERSION 3.15)
project(NetProbe)

set(GLOBAL PROPERTY CMAKE_CXX_STANDARD 20)
set(GLOBAL PROPERTY CMAKE_CXX_STANDARD_REQUIRED ON)
set(GLOBAL PROPERTY USE_FOLDERS ON)

file(GLOB SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/*/*.cpp
)

file(GLOB HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/include/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/include/*/*.h
)

add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})

target_include_directories(${PROJECT_NAME} PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

find_package(PCAP QUIET)
if (PCAP_FOUND)
    message(STATUS "[NetProbe] libpcap found via CMake module!")
    target_include_directories(${PROJECT_NAME} PRIVATE ${PCAP_INCLUDE_DIRS})
    target_link_libraries(${PROJECT_NAME} PRIVATE ${PCAP_LIBRARIES})
else()
    find_package(PkgConfig QUIET)
    if (PkgConfig_FOUND)
        pkg_check_modules(PCAP IMPORTED_TARGET libpcap)
    endif()
    if (TARGET PkgConfig::PCAP)
        message(STATUS "[NetProbe] libpcap found via PkgConfig!")
        target_link_libraries(${PROJECT_NAME} PRIVATE PkgConfig::PCAP)
    else()
        message(FATAL_ERROR "[NetProbe] libpcap not found! Please install libpcap development package.")
    endif()
endif()

set(CMAKE_CONFIGURATION_TYPES "Debug;Release;Test" CACHE STRING "" FORCE)
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
message(STATUS "[NetProbe] Debug build")
target_compile_definitions(${PROJECT_NAME} PRIVATE DEBUG)
target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -pedantic -Werror)
elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
    message(STATUS "[NetProbe] Release build")
    target_compile_definitions(${PROJECT_NAME} PRIVATE NDEBUG)
    target_compile_options(${PROJECT_NAME} PRIVATE -O3)
elseif (CMAKE_BUILD_TYPE STREQUAL "Test")
    message(STATUS "[NetProbe] Test build")
    target_compile_definitions(${PROJECT_NAME} PRIVATE TEST)
    target_compile_options(${PROJECT_NAME} PRIVATE -O3)
else()
    message(FATAL_ERROR "[NetProbe] unknown build type: ${CMAKE_BUILD_TYPE}")
endif()

