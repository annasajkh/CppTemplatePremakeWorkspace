My c++ premake template


# Perquisites
for windows is visual studio build tools and for linux is gcc<br>

# Perquisites Vcpkg
for windows
```
cd your-preferred-install-dir
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg; .\bootstrap-vcpkg.bat
```

Configure the VCPKG_ROOT environment variable.<br>

PowerShell<br>
```
$env:VCPKG_ROOT = "your-preferred-install-dir"
$env:PATH = "$env:VCPKG_ROOT;$env:PATH"
```

for linux<br>
```
cd your-preferred-install-dir
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg; ./bootstrap-vcpkg.sh
```

add VCPKG_ROOT env variable with the value of your-preferred-install-dir/vcpkg and also add your-preferred-install-dir/vcpkg to path<br>

# Build
for windows<br>
`premake5 vs2022`
open and build it in visual studio<br>
for linux<br>
```
premake5 gmake
./Makefile
```

# Add New Package
first you add the package<br>
`vcpkg add port fmt`

and then you can install the package locally<br>
`vcpkg install`

add the lib to a project build script<br>
```
local libraries = { "fmt" }
```

you can configure more of the build script afterward<br>