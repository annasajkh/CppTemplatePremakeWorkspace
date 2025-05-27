local libraries = { "fmt" }
local is_static = true

project "CppTemplatePremake"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"
    files { "include/**.hpp", "src/**.cpp" }
    platforms { "x64", "x86", "ARM64" }

    filter "action:vs*"
    buildoptions { "/utf-8" }

    staticruntime(is_static and "On" or "Off")

    filter {}

    local os_config = nil
    local arch_config = nil
    local lib_extension = nil    
    
    if os.target() == "windows" then
        os_config = "windows"
        lib_extension = "dll"
    elseif os.target() == "linux" then
        os_config = "linux"
        lib_extension = "so"
    elseif os.target() == "macosx" then
        os_config = "osx"
        lib_extension = "dylib"
    end
    
    if os.targetarch() == "x86_64" then
        arch_config = "x64"
    elseif os.targetarch() == "x86" then
        arch_config = "x86"
    elseif os.targetarch() == "ARM64" then
        arch_config = "arm64"
    elseif os.targetarch() == "ARM" then
        arch_config = "arm"
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

    filter "configurations:Debug"
        libdirs {
            "../vcpkg_installed/" .. target_os .. "/debug/lib"
        }

        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"