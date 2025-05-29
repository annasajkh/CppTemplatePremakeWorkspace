My c++ premake template

# Perquisites
#### Windows
you need visual studio build tools installed

#### Linux
you need gcc installed

# Perquisites Vcpkg
### Windows
```
cd your/preferred/install/dir
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg; .\bootstrap-vcpkg.bat
```

Configure the VCPKG_ROOT environment variable
 
```powerShell
$env:VCPKG_ROOT = "your/preferred/install/dir/vcpkg"
$env:PATH = "$env:VCPKG_ROOT;$env:PATH"
```

#### Linux

```
cd your/preferred/install/dir
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg; ./bootstrap-vcpkg.sh
```

Configure the VCPKG_ROOT environment variable

```bash
export VCPKG_ROOT=your/preferred/install/dir/vcpkg
export PATH=$VCPKG_ROOT:$PATH
```

# Build
### Windows
```
vcpkg install
./premake5 vs2022
```

open and build it in visual studio<br>

### Linux
```
vcpkg install
./premake5 gmake
make
```

# Add New Package
first you add the package<br>
```
vcpkg add port fmt
```

and then you can install the package locally<br>
```
vcpkg install
```

add the lib to a project build script<br>
```
local libraries = { "fmt" }
```

you can configure more of the build script afterward<br>