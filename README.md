My c++ premake template

# Perquisites
#### Windows
You need visual studio build tools installed.

#### Linux
You need gcc installed.

# Perquisites Vcpkg
### Windows
```
cd your/preferred/install/dir
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg; .\bootstrap-vcpkg.bat
```

Configure the VCPKG_ROOT environment variable.
 
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

Configure the VCPKG_ROOT environment variable.

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

Open and build it in visual studio.<br>

### Linux
```
vcpkg install
./premake5 gmake
make
```

# Add New Library
Add the library.<br>
```
vcpkg add port fmt
```

Install the library locally.<br>
```
vcpkg install
```

Add the library to a project build script.<br>
```
local libraries = { "fmt" }
```

You can configure the library in the build script afterward<br>