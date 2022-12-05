#CMake minimum requirement 
cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

#Project name 
set(project_name "VS_OMP")#<TODO> change this to the name of your project 
project(${project_name} LANGUAGES CXX C)  

#toggle between building a shared or static library
option(MY_BUILD_SHARED_LIBS "Build as shared library" OFF)

#default build type is Release
if (CMAKE_BUILD_TYPE STREQUAL "")
    set(CMAKE_BUILD_TYPE Release)
endif ()

# Direct all output to /bin directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)


# CUDA and C++ compiler flags
set(cxx_flags 
	$<$<CXX_COMPILER_ID:MSVC>:-D_SCL_SECURE_NO_WARNINGS /openmp /std:c++17> #<TODO> Add MSVC-specific compiler flags here
	$<$<CXX_COMPILER_ID:GNU>:-Wall -m64 -fopenmp -O3 -std=c++17>            #<TODO> Add GCC compiler flags here
	$<$<CXX_COMPILER_ID:Clang>:-Wall -m64 -fopenmp -O3 -std=c++17>          #<TODO> Add Clang compiler flags here
	)

add_library(developer_flags INTERFACE)
target_compile_options(developer_flags INTERFACE
    ${cxx_flags}    
)

target_compile_features(developer_flags INTERFACE cxx_std_17)

#OpenMP
find_package(OpenMP)
if(OpenMP_CXX_FOUND)
    target_link_libraries(developer_flags INTERFACE OpenMP::OpenMP_CXX)
endif()

add_subdirectory(VS_OMP)