---
title: NS3 network simulator for Course Assignments
math: true
---

https://www.nsnam.org/docs/release/3.45/installation/ns-3-installation.pdf

`./ns3 configure --enable-examples --enable-tests`

```bash
 [~/Downloads]
 kh4rg0sh  cd ns-allinone-3.45 
               
 [~/Downloads/ns-allinone-3.45]
 kh4rg0sh  ls
constants.py  LICENSE  MANIFEST.md  ns-3.45  README.md  util.py
               
 [~/Downloads/ns-allinone-3.45]
 kh4rg0sh  cd ns-3.45         
               
 [~/Downloads/ns-allinone-3.45/ns-3.45]
 kh4rg0sh  ls
AUTHORS        CHANGES.md          contrib          examples  ns3             RELEASE_NOTES.md  setup.py  utils
bindings       CMakeLists.txt      CONTRIBUTING.md  LICENSE   pyproject.toml  scratch           src       utils.py
build-support  CODE_OF_CONDUCT.md  doc              LICENSES  README.md       setup.cfg         test.py   VERSION
               
 [~/Downloads/ns-allinone-3.45/ns-3.45]
 kh4rg0sh  ./ns3 configure --enable-examples --enable-tests
Warn about uninitialized values.
-- The CXX compiler identification is GNU 13.3.0
-- The C compiler identification is GNU 13.3.0
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Using default output directory /home/kh4rg0sh/Downloads/ns-allinone-3.45/ns-3.45/build
-- Performing Test GCC_WORKING_PEDANTIC_SEMICOLON
-- Performing Test GCC_WORKING_PEDANTIC_SEMICOLON - Success
-- Proceeding without cmake-format
-- Found Git: /usr/bin/git (found version "2.43.0") 
-- find_external_library: SQLite3 was found.
-- Found GTK3_GTK: /usr/lib/x86_64-linux-gnu/libgtk-3.so  
-- GSL was found.
-- docs: doxygen documentation not enabled due to missing dependencies: doxygen dia
-- Found Sphinx: /usr/bin/sphinx-build  
-- docs: sphinx documentation not enabled due to missing dependencies: dia
-- Performing Test HAVE_UINT128_T
-- Performing Test HAVE_UINT128_T - Failed
-- Performing Test HAVE___UINT128_T
-- Performing Test HAVE___UINT128_T - Success
-- Looking for stdint.h
-- Looking for stdint.h - found
-- Looking for inttypes.h
-- Looking for inttypes.h - found
-- Looking for sys/types.h
-- Looking for sys/types.h - found
-- Looking for sys/stat.h
-- Looking for sys/stat.h - found
-- Looking for dirent.h
-- Looking for dirent.h - found
-- Looking for stdlib.h
-- Looking for stdlib.h - found
-- Looking for signal.h
-- Looking for signal.h - found
-- Looking for netpacket/packet.h
-- Looking for netpacket/packet.h - found
-- Looking for getenv
-- Looking for getenv - found
-- Processing contrib/aqm-eval-suite
-- Processing contrib/lorawan
-- Processing contrib/netsimulyzer
-- Processing contrib/nr
CMake Warning at build-support/3rd-party/colored-messages.cmake:84 (_message):
  nr MIMO features require the eigen3 library, but it was not found
Call Stack (most recent call first):
  contrib/nr/CMakeLists.txt:14 (message)


-- Search-free PMI selection requires pyttb and pybind11, and only works on Unix
CMake Warning at build-support/3rd-party/colored-messages.cmake:84 (_message):
  cttc-nr-3gpp-calibration and cttc-3gpp-indoor-calibration require
  sqlite and eigen
Call Stack (most recent call first):
  contrib/nr/examples/CMakeLists.txt:137 (message)


-- Processing contrib/oran
-- find_external_library: Torch was not found. Missing headers: "torch/script.h" and missing libraries: "torch".
-- find_external_library: OnnxRuntime was not found. Missing headers: "cpu_provider_factory.h" and missing libraries: "onnxruntime".
-- Processing contrib/quantum
CMake Warning (dev) at contrib/quantum/CMakeLists.txt:1 (include_directories):
  uninitialized variable 'QPP_INCLUDE_DIR'
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at contrib/quantum/CMakeLists.txt:2 (message):
  uninitialized variable 'QPP_INCLUDE_DIR'
This warning is for project developers.  Use -Wno-dev to suppress it.

-- Quantum++ include dir: 
CMake Warning (dev) at contrib/quantum/CMakeLists.txt:4 (include_directories):
  uninitialized variable 'CryptoPP_INCLUDE_DIRS'
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at contrib/quantum/CMakeLists.txt:5 (message):
  uninitialized variable 'CryptoPP_INCLUDE_DIRS'
This warning is for project developers.  Use -Wno-dev to suppress it.

-- Crypto++ include dir: 
CMake Warning (dev) at contrib/quantum/CMakeLists.txt:37 (if):
  uninitialized variable 'NS3_QPP'
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at contrib/quantum/CMakeLists.txt:74 (if):
  uninitialized variable 'NS3_CRYPTOPP'
This warning is for project developers.  Use -Wno-dev to suppress it.

-- Processing contrib/sip
-- Processing contrib/uart-net-device
-- Looking for include file boost/asio.hpp
-- Looking for include file boost/asio.hpp - found
-- Boost Asynchronous IO (ASIO) have been found.
CMake Warning (dev) at contrib/uart-net-device/CMakeLists.txt:20 (build_lib):
  uninitialized variable 'libboost'
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at contrib/uart-net-device/CMakeLists.txt:20 (build_lib):
  uninitialized variable 'liblrwpan'
This warning is for project developers.  Use -Wno-dev to suppress it.

-- Processing contrib/wban
-- Processing src/antenna
-- Performing Test HAVE_STD_BESSEL_FUNC
-- Performing Test HAVE_STD_BESSEL_FUNC - Success
-- Standard library Bessel function has been found
-- Processing src/aodv
-- Processing src/applications
-- Processing src/bridge
-- Processing src/brite
-- Skipping src/brite
-- Processing src/buildings
-- Processing src/click
-- Skipping src/click
-- Processing src/config-store
-- Processing src/core
-- Looking for include files boost/units/quantity.hpp, boost/units/systems/si.hpp
-- Looking for include files boost/units/quantity.hpp, boost/units/systems/si.hpp - found
-- Boost Units have been found.
-- Processing src/csma
-- Processing src/csma-layout
-- Processing src/dsdv
-- Processing src/dsr
-- Processing src/energy
-- Processing src/fd-net-device
-- Looking for net/ethernet.h
-- Looking for net/ethernet.h - found
-- Looking for netpacket/packet.h
-- Looking for netpacket/packet.h - found
-- Looking for net/if.h
-- Looking for net/if.h - found
-- Looking for linux/if_tun.h
-- Looking for linux/if_tun.h - found
-- Looking for net/netmap_user.h
-- Looking for net/netmap_user.h - not found
-- Looking for sys/ioctl.h
-- Looking for sys/ioctl.h - found
-- Found PkgConfig: /usr/bin/pkg-config (found version "1.8.1") 
-- Checking for module 'libdpdk'
--   Package 'libdpdk', required by 'virtual:world', not found
-- Processing src/flow-monitor
-- Processing src/internet
-- Performing Test COMPILER_HAS_HIDDEN_VISIBILITY
-- Performing Test COMPILER_HAS_HIDDEN_VISIBILITY - Success
-- Performing Test COMPILER_HAS_HIDDEN_INLINE_VISIBILITY
-- Performing Test COMPILER_HAS_HIDDEN_INLINE_VISIBILITY - Success
-- Performing Test COMPILER_HAS_DEPRECATED_ATTR
-- Performing Test COMPILER_HAS_DEPRECATED_ATTR - Success
-- Processing src/internet-apps
-- Processing src/lr-wpan
-- Processing src/lte
-- Processing src/mesh
-- Processing src/mobility
-- Processing src/netanim
-- Processing src/network
-- Processing src/nix-vector-routing
-- Processing src/olsr
-- Processing src/openflow
-- Skipping src/openflow
-- Processing src/point-to-point
-- Processing src/point-to-point-layout
-- Processing src/propagation
-- Processing src/sixlowpan
-- Processing src/spectrum
-- Processing src/stats
-- Processing src/tap-bridge
-- Processing src/test
-- Processing src/topology-read
-- Processing src/traffic-control
-- Processing src/uan
-- Processing src/virtual-net-device
-- Processing src/wifi
-- Processing src/wimax
-- Processing src/zigbee
-- ---- Summary of ns-3 settings:
Build profile                 : default
Build directory               : /home/kh4rg0sh/Downloads/ns-allinone-3.45/ns-3.45/build
Build with runtime asserts    : ON
Build with runtime logging    : ON
Build version embedding       : OFF (not requested)
BRITE Integration             : OFF (Missing headers: "Brite.h" and missing libraries: "brite")
DES Metrics event collection  : OFF (not requested)
DPDK NetDevice                : OFF (not requested)
Emulation FdNetDevice         : ON
Examples                      : ON
File descriptor NetDevice     : ON
GNU Scientific Library (GSL)  : ON
GtkConfigStore                : ON
LibXml2 support               : ON
MPI Support                   : OFF (not requested)
ns-3 Click Integration        : OFF (Missing headers: "simclick.h" and missing libraries: "nsclick click")
ns-3 OpenFlow Integration     : OFF (Missing headers: "openflow.h" and missing libraries: "openflow")
Netmap emulation FdNetDevice  : OFF (missing dependency)
PyViz visualizer              : OFF (Python Bindings are disabled)
Python Bindings               : OFF (not requested)
SQLite support                : ON
Eigen3 support                : OFF (Eigen was not found)
Tap Bridge                    : ON
Tap FdNetDevice               : ON
Tests                         : ON


Modules configured to be built:
antenna                   aodv                      applications              
aqm-eval-suite            bridge                    buildings                 
config-store              core                      csma                      
csma-layout               dsdv                      dsr                       
energy                    fd-net-device             flow-monitor              
internet                  internet-apps             lorawan                   
lr-wpan                   lte                       mesh                      
mobility                  netanim                   netsimulyzer              
network                   nix-vector-routing        nr                        
olsr                      oran                      point-to-point            
point-to-point-layout     propagation               sip                       
sixlowpan                 spectrum                  stats                     
tap-bridge                test                      topology-read             
traffic-control           uan                       uart-net-device           
virtual-net-device        wban                      wifi                      
wimax                     zigbee                    

Modules that cannot be built:
brite                     click                     mpi                       
openflow                  quantum                   visualizer                



-- Configuring done (12.6s)
-- Generating done (0.8s)
-- Build files have been written to: /home/kh4rg0sh/Downloads/ns-allinone-3.45/ns-3.45/cmake-cache
Finished executing the following commands:
mkdir cmake-cache
/usr/bin/cmake -S /home/kh4rg0sh/Downloads/ns-allinone-3.45/ns-3.45 -B /home/kh4rg0sh/Downloads/ns-allinone-3.45/ns-3.45/cmake-cache -DCMAKE_BUILD_TYPE=default -DNS3_ASSERT=ON -DNS3_LOG=ON -DNS3_WARNINGS_AS_ERRORS=OFF -DNS3_NATIVE_OPTIMIZATIONS=OFF -DNS3_EXAMPLES=ON -DNS3_TESTS=ON -G Ninja --warn-uninitialized
               
 [~/Downloads/ns-allinone-3.45/ns-3.45]
 kh4rg0sh  
 ```

`./ns3 build`

https://www.nsnam.org/docs/release/3.45/manual/ns-3-manual.pdf



