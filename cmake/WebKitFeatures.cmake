# The settings in this file are the WebKit project default values, and
# are recommended for most ports. Ports can override these settings in
# Options*.cmake, but should do so only if there is strong reason to
# deviate from the defaults of the WebKit project (e.g. if the feature
# requires platform-specific implementation that does not exist).
#
# Most defaults in this file affect end users but not developers.
# Defaults for development builds are set in FeatureList.pm. Most all
# features enabled here should also be enabled in FeatureList.pm.

set(_WEBKIT_AVAILABLE_OPTIONS "")

set(PUBLIC YES)
set(PRIVATE NO)

macro(_ENSURE_OPTION_MODIFICATION_IS_ALLOWED)
    if (NOT _SETTING_WEBKIT_OPTIONS)
        message(FATAL_ERROR "Options must be set between WEBKIT_OPTION_BEGIN and WEBKIT_OPTION_END")
    endif ()
endmacro()

macro(_ENSURE_IS_WEBKIT_OPTION _name)
    list(FIND _WEBKIT_AVAILABLE_OPTIONS ${_name} ${_name}_OPTION_INDEX)
    if (${_name}_OPTION_INDEX EQUAL -1)
        message(FATAL_ERROR "${_name} is not a valid WebKit option")
    endif ()
endmacro()

macro(WEBKIT_OPTION_DEFINE _name _description _public _initial_value)
    _ENSURE_OPTION_MODIFICATION_IS_ALLOWED()

    set(_WEBKIT_AVAILABLE_OPTIONS_DESCRIPTION_${_name} ${_description})
    set(_WEBKIT_AVAILABLE_OPTIONS_IS_PUBLIC_${_name} ${_public})
    set(_WEBKIT_AVAILABLE_OPTIONS_INITIAL_VALUE_${_name} ${_initial_value})
    set(_WEBKIT_AVAILABLE_OPTIONS_${_name}_CONFLICTS "")
    set(_WEBKIT_AVAILABLE_OPTIONS_${_name}_DEPENDENCIES "")
    list(APPEND _WEBKIT_AVAILABLE_OPTIONS ${_name})

    EXPOSE_VARIABLE_TO_BUILD(${_name})
endmacro()

macro(WEBKIT_OPTION_DEFAULT_PORT_VALUE _name _public _value)
    _ENSURE_OPTION_MODIFICATION_IS_ALLOWED()
    _ENSURE_IS_WEBKIT_OPTION(${_name})

    set(_WEBKIT_AVAILABLE_OPTIONS_IS_PUBLIC_${_name} ${_public})
    set(_WEBKIT_AVAILABLE_OPTIONS_INITIAL_VALUE_${_name} ${_value})
endmacro()

macro(WEBKIT_OPTION_CONFLICT _name _conflict)
    _ENSURE_OPTION_MODIFICATION_IS_ALLOWED()
    _ENSURE_IS_WEBKIT_OPTION(${_name})
    _ENSURE_IS_WEBKIT_OPTION(${_conflict})

    list(APPEND _WEBKIT_AVAILABLE_OPTIONS_${_name}_CONFLICTS ${_conflict})
endmacro()

macro(WEBKIT_OPTION_DEPEND _name _depend)
    _ENSURE_OPTION_MODIFICATION_IS_ALLOWED()
    _ENSURE_IS_WEBKIT_OPTION(${_name})
    _ENSURE_IS_WEBKIT_OPTION(${_depend})

    list(APPEND _WEBKIT_AVAILABLE_OPTIONS_${_name}_DEPENDENCIES ${_depend})
endmacro()

macro(WEBKIT_OPTION_BEGIN)
    set(_SETTING_WEBKIT_OPTIONS TRUE)

    if (WTF_CPU_X86_64)
        set(ENABLE_FTL_DEFAULT ON)
    else ()
        set(ENABLE_FTL_DEFAULT OFF)
    endif ()

    WEBKIT_OPTION_DEFINE(ENABLE_3D_TRANSFORMS "Toggle 3D transforms support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_ACCELERATED_2D_CANVAS "Toggle accelerated 2D canvas support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_ACCELERATED_OVERFLOW_SCROLLING "Toggle accelerated scrolling support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_ACCESSIBILITY "Toggle accessibility support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_ALLINONE_BUILD "Toggle all-in-one build" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_API_TESTS "Enable public API unit tests" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_ASYNC_SCROLLING "Enable asynchronouse scrolling" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_ATTACHMENT_ELEMENT "Toggle attachment element support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_AVF_CAPTIONS "Toggle AVFoundation caption support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CACHE_PARTITIONING "Toggle cache partitioning support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CANVAS_PATH "Toggle Canvas Path support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_CANVAS_PROXY "Toggle CanvasProxy support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CHANNEL_MESSAGING "Toggle MessageChannel and MessagePort support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_CONTENT_FILTERING "Toggle content filtering support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CONTEXT_MENUS "Toggle Context Menu support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_CSS3_TEXT "Toggle CSS3 Text support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CSS_BOX_DECORATION_BREAK "Toggle Box Decoration break (CSS Backgrounds and Borders) support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_CSS_COMPOSITING "Toggle CSS COMPOSITING support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CSS_DEVICE_ADAPTATION "Toggle CSS Device Adaptation support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CSS_IMAGE_ORIENTATION "Toggle CSS image-orientation support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CSS_IMAGE_RESOLUTION "Toggle CSS image-resolution support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CSS_REGIONS "Toggle CSS regions support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CSS_SCROLL_SNAP "Toggle CSS snap scroll support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CSS_SELECTORS_LEVEL4 "Toggle CSS Selectors Level 4 support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CURSOR_VISIBILITY "Toggle cursor visibility support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_CUSTOM_SCHEME_HANDLER "Toggle Custom Scheme Handler support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_DASHBOARD_SUPPORT "Toggle dashboard support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_DATABASE_PROCESS "Toggle database process support in WebKit2" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_DATACUE_VALUE "Toggle datacue value support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_DATALIST_ELEMENT "Toggle HTML5 datalist support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_DATA_TRANSFER_ITEMS "Toggle HTML5 data transfer items support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_DEVICE_ORIENTATION "Toggle DeviceOrientation support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_DFG_JIT "Toggle data flow graph JIT tier" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_DOWNLOAD_ATTRIBUTE "Toggle download attribute support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_DRAG_SUPPORT "Toggle Drag Support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_ENCRYPTED_MEDIA "Toggle EME support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_FETCH_API "Toggle Fetch API support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_FILTERS_LEVEL_2 "Toggle Filters Module Level 2" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_FONT_LOAD_EVENTS "Toggle Font Load Events support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_FTPDIR "Toggle FTP directory support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_FTL_JIT "Toggle FTL support for JSC" PRIVATE ${ENABLE_FTL_DEFAULT})
    WEBKIT_OPTION_DEFINE(ENABLE_FULLSCREEN_API "Toggle Fullscreen API support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_GAMEPAD "Toggle Gamepad support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_GAMEPAD_DEPRECATED "Toggle deprecated Gamepad support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_GEOLOCATION "Toggle Geolocation support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_ICONDATABASE "Toggle Icon database support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_IMAGE_DECODER_DOWN_SAMPLING "Toggle image decoder down sampling support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INDEXED_DATABASE "Toggle Indexed Database API support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INDEXED_DATABASE_IN_WORKERS "Toggle support for indexed database in workers" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INDIE_UI "Toggle Indie UI support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INPUT_TYPE_COLOR "Toggle Color Input support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INPUT_TYPE_COLOR_POPOVER "Toggle popover color input support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INPUT_TYPE_DATE "Toggle date type <input> support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INPUT_TYPE_DATETIME_INCOMPLETE "Toggle broken datetime type <input> support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INPUT_TYPE_DATETIMELOCAL "Toggle datetime-local type <input> support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INPUT_TYPE_MONTH "Toggle month type <input> support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INPUT_TYPE_TIME "Toggle time type <input> support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INPUT_TYPE_WEEK "Toggle week type <input> support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_INTERSECTION_OBSERVER "Enable Intersection Observer support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_INTL "Toggle Intl support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_IOS_AIRPLAY "Toggle iOS airplay support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_JIT "Enable JustInTime javascript support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_LEGACY_CSS_VENDOR_PREFIXES "Toggle legacy css vendor prefix support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_LEGACY_ENCRYPTED_MEDIA "Support legacy EME" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_LEGACY_NOTIFICATIONS "Toggle Legacy Desktop Notifications Support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_LEGACY_VENDOR_PREFIXES "Toggle Legacy Vendor Prefix Support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_LETTERPRESS "Toggle letterpress support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_LINK_PREFETCH "Toggle pre fetching support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_MAC_LONG_PRESS "Toggle mac long press support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_MATHML "Toggle MathML support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_MEDIA_CAPTURE "Toggle Media Capture support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_MEDIA_CONTROLS_SCRIPT "Toggle definition of media controls in Javascript" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_MEDIA_SOURCE "Toggle Media Source support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_MEDIA_STREAM "Toggle Media Stream support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_MEDIA_STATISTICS "Toggle Media Statistics support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_MEMORY_SAMPLER "Toggle Memory Sampler support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_METER_ELEMENT "Toggle Meter Tag support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_MHTML "Toggle MHTML support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_MINIBROWSER "Whether to enable MiniBrowser compilation." PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_MOUSE_CURSOR_SCALE "Toggle Scaled mouse cursor support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_NAVIGATOR_CONTENT_UTILS "Toggle Navigator Content Utils support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_NAVIGATOR_HWCONCURRENCY "Toggle Navigator hardware concurrency support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_NOSNIFF "Toggle support for 'X-Content-Type-Options: nosniff'" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_NETSCAPE_PLUGIN_API "Toggle Netscape Plugin support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_NOTIFICATIONS "Toggle Desktop Notifications Support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_ORIENTATION_EVENTS "Toggle Orientation Events support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_PDFKIT_PLUGIN "Toggle PDFKit plugin support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_POINTER_LOCK "Toggle pointer lock support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_PROXIMITY_EVENTS "Toggle Proximity Events support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_PUBLIC_SUFFIX_LIST "Toggle public suffix list support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_QUOTA "Toggle Quota support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_READABLE_STREAM_API "Toggle ReadableStream API support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_READABLE_BYTE_STREAM_API "Toggle support of ReadableStream API byte stream part" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_REMOTE_INSPECTOR "Toggle remote inspector support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_RESOLUTION_MEDIA_QUERY "Toggle resolution media query support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_RESOURCE_USAGE "Toggle resource usage support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_RUBBER_BANDING "Toggle rubber banding support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_SAMPLING_PROFILER "Toggle sampling profiler support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_SERVICE_CONTROLS "Toggle service controls support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_SMOOTH_SCROLLING "Toggle smooth scrolling" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_SPEECH_SYNTHESIS "Toggle Speech Synthesis API support)" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_SPELLCHECK "Toggle Spellchecking support (requires Enchant)" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_SUBTLE_CRYPTO "Toggle subtle crypto support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_SVG_FONTS "Toggle SVG fonts support (imples SVG support)" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_TELEPHONE_NUMBER_DETECTION "Toggle telephone number detection support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_TEXT_AUTOSIZING "Toggle automatic text size adjustment support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_TOUCH_EVENTS "Toggle Touch Events support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_TOUCH_SLIDER "Toggle Touch Slider support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_TOUCH_ICON_LOADING "Toggle Touch Icon Loading Support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_USERSELECT_ALL "Toggle user-select:all support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_USER_MESSAGE_HANDLERS "Toggle user script message handler support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_VIBRATION "Toggle Vibration API support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_VIDEO "Toggle Video support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_VIDEO_TRACK "Toggle Track support for HTML5 video" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_VIEW_MODE_CSS_MEDIA "Toggle Track support for the view-mode media Feature" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_WEBASSEMBLY "Toggle WebAssembly support" PRIVATE ${ENABLE_FTL_DEFAULT})
    WEBKIT_OPTION_DEFINE(ENABLE_WEBGL "Toggle WebGL support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_WEBGL2 "Toggle WebGL 2.0 support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_WEBGPU "Toggle WebGPU support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_WEBVTT_REGIONS "Toggle webvtt region support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_WEB_ANIMATIONS "Toggle Web Animations support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_WEB_AUDIO "Toggle Web Audio support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_WEB_REPLAY "Toggle Web Replay support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_WEB_RTC "Toggle WebRTC API support" PRIVATE OFF)
    WEBKIT_OPTION_DEFINE(ENABLE_WEB_SOCKETS "Toggle Web Sockets support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_WEB_TIMING "Toggle Web Timing support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_WRITABLE_STREAM_API "Toggle WritableStream API support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(ENABLE_XSLT "Toggle XSLT support" PRIVATE ON)
    WEBKIT_OPTION_DEFINE(USE_SYSTEM_MALLOC "Toggle system allocator instead of WebKit's custom allocator" PRIVATE ON)

    WEBKIT_OPTION_DEPEND(ENABLE_WEB_RTC ENABLE_MEDIA_STREAM)
    WEBKIT_OPTION_DEPEND(ENABLE_LEGACY_ENCRYPTED_MEDIA ENABLE_VIDEO)
    WEBKIT_OPTION_DEPEND(ENABLE_DFG_JIT ENABLE_JIT)
    WEBKIT_OPTION_DEPEND(ENABLE_FTL_JIT ENABLE_DFG_JIT)
    WEBKIT_OPTION_DEPEND(ENABLE_WEBASSEMBLY ENABLE_FTL_JIT)
    WEBKIT_OPTION_DEPEND(ENABLE_SAMPLING_PROFILER ENABLE_JIT)
    WEBKIT_OPTION_DEPEND(ENABLE_INDEXED_DATABASE_IN_WORKERS ENABLE_INDEXED_DATABASE)
    WEBKIT_OPTION_DEPEND(ENABLE_MEDIA_CONTROLS_SCRIPT ENABLE_VIDEO)
    WEBKIT_OPTION_DEPEND(ENABLE_MEDIA_SOURCE ENABLE_VIDEO)
    WEBKIT_OPTION_DEPEND(ENABLE_VIDEO_TRACK ENABLE_VIDEO)
    WEBKIT_OPTION_DEPEND(ENABLE_TOUCH_SLIDER ENABLE_TOUCH_EVENTS)
endmacro()

macro(_WEBKIT_OPTION_ENFORCE_DEPENDS _name)
    foreach (_dependency ${_WEBKIT_AVAILABLE_OPTIONS_${_name}_DEPENDENCIES})
        if (NOT ${_dependency})
            message(STATUS "Disabling ${_name} since ${_dependency} is disabled.")
            set(${_name} OFF)
            set(_OPTION_CHANGED TRUE)
            break ()
        endif ()
    endforeach ()
endmacro()

macro(_WEBKIT_OPTION_ENFORCE_ALL_DEPENDS)
    set(_OPTION_CHANGED TRUE)
    while (${_OPTION_CHANGED})
        set(_OPTION_CHANGED FALSE)
        foreach (_name ${_WEBKIT_AVAILABLE_OPTIONS})
            if (${_name})
                _WEBKIT_OPTION_ENFORCE_DEPENDS(${_name})
            endif ()
        endforeach ()
    endwhile ()
endmacro()

macro(_WEBKIT_OPTION_ENFORCE_CONFLICTS _name)
    foreach (_conflict ${_WEBKIT_AVAILABLE_OPTIONS_${_name}_CONFLICTS})
        if (${_conflict})
            message(FATAL_ERROR "${_name} conflicts with ${_conflict}. You must disable one or the other.")
        endif ()
    endforeach ()
endmacro()

macro(_WEBKIT_OPTION_ENFORCE_ALL_CONFLICTS)
    foreach (_name ${_WEBKIT_AVAILABLE_OPTIONS})
        if (${_name})
            _WEBKIT_OPTION_ENFORCE_CONFLICTS(${_name})
        endif ()
    endforeach ()
endmacro()

macro(WEBKIT_OPTION_END)
    set(_SETTING_WEBKIT_OPTIONS FALSE)

    list(SORT _WEBKIT_AVAILABLE_OPTIONS)
    set(_MAX_FEATURE_LENGTH 0)
    foreach (_name ${_WEBKIT_AVAILABLE_OPTIONS})
        string(LENGTH ${_name} _name_length)
        if (_name_length GREATER _MAX_FEATURE_LENGTH)
            set(_MAX_FEATURE_LENGTH ${_name_length})
        endif ()

        option(${_name} "${_WEBKIT_AVAILABLE_OPTIONS_DESCRIPTION_${_name}}" ${_WEBKIT_AVAILABLE_OPTIONS_INITIAL_VALUE_${_name}})
        if (NOT ${_WEBKIT_AVAILABLE_OPTIONS_IS_PUBLIC_${_name}})
            mark_as_advanced(FORCE ${_name})
        endif ()
    endforeach ()

    # Run through every possible depends to make sure we have disabled anything
    # that could cause an unnecessary conflict before processing conflicts.
    _WEBKIT_OPTION_ENFORCE_ALL_DEPENDS()
    _WEBKIT_OPTION_ENFORCE_ALL_CONFLICTS()

    foreach (_name ${_WEBKIT_AVAILABLE_OPTIONS})
        if (${_name})
            list(APPEND FEATURE_DEFINES ${_name})
            set(FEATURE_DEFINES_WITH_SPACE_SEPARATOR "${FEATURE_DEFINES_WITH_SPACE_SEPARATOR} ${_name}")
        endif ()
    endforeach ()
endmacro()

macro(PRINT_WEBKIT_OPTIONS)
    message(STATUS "Enabled features:")

    set(_should_print_dots ON)
    foreach (_name ${_WEBKIT_AVAILABLE_OPTIONS})
        if (${_WEBKIT_AVAILABLE_OPTIONS_IS_PUBLIC_${_name}})
            string(LENGTH ${_name} _name_length)
            set(_message " ${_name} ")

            # Print dots on every other row, for readability.
            foreach (IGNORE RANGE ${_name_length} ${_MAX_FEATURE_LENGTH})
                if (${_should_print_dots})
                    set(_message "${_message}.")
                else ()
                    set(_message "${_message} ")
                endif ()
            endforeach ()

            set(_should_print_dots (NOT ${_should_print_dots}))

            set(_message "${_message} ${${_name}}")
            message(STATUS "${_message}")
        endif ()
    endforeach ()
endmacro()

set(_WEBKIT_CONFIG_FILE_VARIABLES "")

macro(EXPOSE_VARIABLE_TO_BUILD _variable_name)
    list(APPEND _WEBKIT_CONFIG_FILE_VARIABLES ${_variable_name})
endmacro()

macro(SET_AND_EXPOSE_TO_BUILD _variable_name)
    # It's important to handle the case where the value isn't passed, because often
    # during configuration an empty variable is the result of a failed package search.
    if (${ARGC} GREATER 1)
        set(_variable_value ${ARGV1})
    else ()
        set(_variable_value OFF)
    endif ()

    set(${_variable_name} ${_variable_value})
    EXPOSE_VARIABLE_TO_BUILD(${_variable_name})
endmacro()

macro(_ADD_CONFIGURATION_LINE_TO_HEADER_STRING _string _variable_name _output_variable_name)
    if (${${_variable_name}})
        set(${_string} "${_file_contents}#define ${_output_variable_name} 1\n")
    else ()
        set(${_string} "${_file_contents}#define ${_output_variable_name} 0\n")
    endif ()
endmacro()

macro(CREATE_CONFIGURATION_HEADER)
    list(SORT _WEBKIT_CONFIG_FILE_VARIABLES)
    set(_file_contents "#ifndef CMAKECONFIG_H\n")
    set(_file_contents "${_file_contents}#define CMAKECONFIG_H\n\n")

    foreach (_variable_name ${_WEBKIT_CONFIG_FILE_VARIABLES})
        _ADD_CONFIGURATION_LINE_TO_HEADER_STRING(_file_contents ${_variable_name} ${_variable_name})
    endforeach ()
    set(_file_contents "${_file_contents}\n#endif /* CMAKECONFIG_H */\n")

    file(WRITE "${CMAKE_BINARY_DIR}/cmakeconfig.h.tmp" "${_file_contents}")
    execute_process(COMMAND ${CMAKE_COMMAND}
        -E copy_if_different
        "${CMAKE_BINARY_DIR}/cmakeconfig.h.tmp"
        "${CMAKE_BINARY_DIR}/cmakeconfig.h"
    )
    file(REMOVE "${CMAKE_BINARY_DIR}/cmakeconfig.h.tmp")
endmacro()
