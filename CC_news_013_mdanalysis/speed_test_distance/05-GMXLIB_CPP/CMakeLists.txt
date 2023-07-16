cmake_minimum_required(VERSION 3.10)

# Change this to your project name
project(dist)

# Specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Find the necessary packages
find_package(Gromacs REQUIRED)

# Specify the source files
set(SOURCE_FILES distance.cpp)

# Add the executable
add_executable(${PROJECT_NAME} ${SOURCE_FILES})

# Link against the GROMACS libraries
target_link_libraries(${PROJECT_NAME} PRIVATE Gromacs::libgromacs)

# Include the GROMACS headers
set(GROMACS_SRC_DIR ${GROMACS_SRC_DIR})
target_include_directories(${PROJECT_NAME} PRIVATE 
    ${GROMACS_SRC_DIR}/src/ 
    ${GROMACS_SRC_DIR}/api/legacy/include/
    )

