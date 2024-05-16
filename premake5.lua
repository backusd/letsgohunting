workspace "letsgohunting"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

startproject "letsgohunting"

project "letsgohunting"
	location "letsgohunting"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++latest"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")	
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "pch.h"
	pchsource "letsgohunting/src/pch.cpp"

	files {	"%{prj.name}/src/**.h", "%{prj.name}/src/**.cpp" }
	includedirs { "%{prj.name}/src" }

	defines
	{
		"LGH_CORE",
		"BOOST_DATE_TIME_NO_LIB", 
		"BOOST_REGEX_NO_LIB"
	}

	filter "system:windows"
		systemversion "latest"
		defines { "PLATFORM_WINDOWS" }
		includedirs { "C:/dev/boost_1_85_0" }

	filter "configurations:Debug"
		defines 
		{
			"LGH_DEBUG",
			"LGH_ENABLE_ASSERTS"
		}
		symbols "on"

	filter "configurations:Release"
		defines "LGH_RELEASE"
		optimize "on"

	filter "configurations:Dist"
		defines "LGH_DIST"
		optimize "on"


project "graphics"
	location "graphics"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++latest"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")	
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "pch.h"
	pchsource "graphics/src/pch.cpp"

	files {	"%{prj.name}/src/**.h", "%{prj.name}/src/**.cpp" }
	includedirs 
	{ 
		"%{prj.name}/src",
		"%{prj.name}/vendor/webgpu",
	}

	defines
	{
		"GRAPHICS_CORE"
	}

	prebuildcommands 
	{ 
		"{COPYFILE} vendor/webgpu/webgpu.lib .",
		"{COPYFILE} vendor/webgpu/webgpu.dll ." 
	}

	filter "system:windows"
		systemversion "latest"
		defines { "PLATFORM_WINDOWS" }

	filter "configurations:Debug"
		defines 
		{
			"GRAPHICS_DEBUG",
			"GRAPHICS_ENABLE_ASSERTS"
		}
		symbols "on"

	filter "configurations:Release"
		defines "GRAPHICS_RELEASE"
		optimize "on"

	filter "configurations:Dist"
		defines "GRAPHICS_DIST"
		optimize "on"