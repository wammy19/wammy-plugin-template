target_sources(
        ${PLUGIN_NAME}

        PRIVATE
        PluginProcessor.cpp
        PluginEditor.cpp
)

# Add any binary data here.
#juce_add_binary_data()

# Need to build BinaryData with -fPIC flag on Linux

#set_target_properties(BinaryData PROPERTIES
#        POSITION_INDEPENDENT_CODE TRUE)

if (${BUILD_HEADLESS})
    message(STATUS "Configuring wammy_template Headless")
    add_subdirectory(Headless)
endif ()
