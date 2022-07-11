cmake_minimum_required(VERSION 3.15)
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimum OS X deployment target")
set(CMAKE_CXX_STANDARD 17)
project(wammy_template VERSION 0.0.1)

add_subdirectory(modules)

# Variables.
set(PLUGIN_NAME "wammy_template" CACHE INTERNAL "")
set(MANUFACTURER_NAME "wammy" CACHE INTERNAL "")

# Set up plugin project.
# juce_set_vst2_sdk_path(C:/SDKs/VST_SDK/VST2_SDK/)
# juce_set_aax_sdk_path(NONE)
# include_directories(ASIO_SDK)

# Build LV2 only on Linux
if (UNIX AND NOT APPLE)
    message(STATUS "Building LV2 plugin format")
    list(APPEND JUCE_FORMATS LV2)
endif ()

# Build VST2 if SDK target exists
if (TARGET juce_vst2_sdk)
    message(STATUS "Building VST2 plugin format")
    list(APPEND JUCE_FORMATS VST)
endif ()

# Build AAX if SDK target exists
if (TARGET juce_aax_sdk)
    message(STATUS "Building AAX plugin format")
    list(APPEND JUCE_FORMATS AAX)
endif ()

juce_add_plugin(
        ${PLUGIN_NAME}
        COMPANY_NAME ${MANUFACTURER_NAME}
        PLUGIN_MANUFACTURER_CODE wamy
        PLUGIN_CODE wamy
        FORMATS ${JUCE_FORMATS}
        ProductName "${PLUGIN_NAME}"

        LV2URI https://github.com/wammy19/wammy-plugin-template

        MICROPHONE_PERMISSION_ENABLED TRUE
        NEEDS_STORE_KIT TRUE

        #        VST3_CATEGORIES Fx Distortion
        #        AU_MAIN_TYPE kAudioUnitType_Effect
        #        AAX_CATEGORY AAX_ePlugInCategory_Harmonic

        #        ICON_BIG src/GUI/Assets/logo.png
)

juce_generate_juce_header(${PLUGIN_NAME})

target_compile_definitions(
        ${PLUGIN_NAME}

        PUBLIC
        JUCE_DISPLAY_SPLASH_SCREEN=0
        JUCE_REPORT_APP_USAGE=0
        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0
        JUCE_VST3_CAN_REPLACE_VST2=0
        JUCE_JACK=1
        JUCE_ALSA=1
)

target_link_libraries(
        ${PLUGIN_NAME}

        PUBLIC
        juce_plugin_modules
)

target_include_directories(
        ${PLUGIN_NAME}

        PUBLIC
        include
)

target_sources(
        ${PLUGIN_NAME}

        PRIVATE
        src/PluginProcessor.cpp
        src/PluginEditor.cpp
)


# We need these flags for notarization on MacOS.
option(MACOS_RELEASE "Set build flags for MacOS Release" OFF)

if (MACOS_RELEASE)
    message(STATUS "Setting MacOS release flags...")
    set_target_properties(${PLUGIN_NAME}_standalone PROPERTIES XCODE_ATTRIBUTE_ENABLE_HARDENED_RUNTIME YES)
endif ()
