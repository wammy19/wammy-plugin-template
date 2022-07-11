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
