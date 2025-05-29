local libraries = { "fmt" }
local is_static = true

project "CppTemplatePremake"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"
    files { "src/**.hpp", "src/**.cpp" }

    local os_config = nil
    local arch_config = nil
    local lib_extension = nil

    if os.host() == "windows" then
        os_config = "windows"
        lib_extension = "dll"
    elseif os.host() == "linux" then
        os_config = "linux"
        lib_extension = "so"
    elseif os.host() == "macosx" then
        os_config = "osx"
        lib_extension = "dylib"
    end

    if os.hostarch() == "x86" and not os.is64bit() then
        arch_config = "x86"
    elseif (os.hostarch() == "x86" or os.hostarch() == "x86_64") and os.is64bit() then
        arch_config = "x64"
    elseif os.hostarch() == "ARM" then
        arch_config = "arm"
    elseif os.hostarch() == "ARM64" then
        arch_config = "arm64"
    end

    local target_os = arch_config .. "-" .. os_config

    print("Target OS: " .. target_os)
    
    includedirs {
        "../vcpkg_installed/" .. target_os .. "/include"
    }
    
    libdirs {
        "../vcpkg_installed/" .. target_os .. "/lib"
    }

    links(libraries)

    if is_static then
        -- fmt spesific
        defines { "FMT_HEADER_ONLY=0" }
    else
         for _, lib in ipairs(libraries) do
            postbuildcommands {
                "{COPY} ../vcpkg_installed/".. target_os .. "/bin/" .. lib .. "." .. lib_extension .. " %{cfg.buildtarget.directory}"
            }
        end
    end

    filter "action:vs*"
        buildoptions { "/utf-8" }
        staticruntime(is_static and "On" or "Off")

    filter "system:windows"
        systemversion "latest"
        defines { }

    filter "configurations:Debug"
        libdirs {
            "../vcpkg_installed/" .. target_os .. "/debug/lib"
        }

        defines { "DEBUG" }
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        defines { "RELEASE" }
        runtime "Release"
        optimize "On"
        symbols "On"
    
    filter "configurations:Distribute"
        defines { "DISTRIBUTE" }
        runtime "Release"
        optimize "On"
        symbols "Off"