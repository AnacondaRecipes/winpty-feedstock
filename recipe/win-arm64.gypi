# ARM64 counterpart of winpty's upstream src/configurations.gypi (MIT).
# Upstream only defines Win32/x64 configurations; this file supplies the ARM64
# one. winpty.gyp remains the owner of sources, defines and libraries.
{
    'target_defaults': {
        'default_configuration': 'Release_ARM64',
        'configurations': {
            'Release_ARM64': {
                'msvs_configuration_platform': 'ARM64',
            },
        },
        'msvs_configuration_attributes': {
            'OutputDirectory': '$(SolutionDir)$(ConfigurationName)\\$(Platform)',
            'IntermediateDirectory': '$(ConfigurationName)\\$(Platform)\\obj\\$(ProjectName)',
        },
        'msvs_settings': {
            'VCLinkerTool': {
                'SubSystem': '1',  # /SUBSYSTEM:CONSOLE
            },
            'VCCLCompilerTool': {
                'RuntimeLibrary': '2',  # /MD, matches the conda CRT
            },
        },
        'msbuild_toolset': 'v143',
    },
}
