# (C) Copyright 2011- ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation
# nor does it submit to any jurisdiction.

# Changes for GCHP: Add flags for use with GNU 10
set (ARG_MISMATCH "")
set (INVALID_BOZ "")
if (CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 10)
   set (ARG_MISMATCH "-fallow-argument-mismatch")
   set (INVALID_BOZ "-fallow-invalid-boz")
endif()

set( CMAKE_Fortran_FLAGS_RELEASE        "-O3 -DNDEBUG -funroll-all-loops -finline-functions ${ARG_MISMATCH} ${INVALID_BOZ}"
     CACHE STRING "Fortran compiler flags for Release builds"          FORCE )
set( CMAKE_Fortran_FLAGS_BIT            "-O2 -DNDEBUG -fno-range-check -fconvert=big-endian ${ARG_MISMATCH} ${INVALID_BOZ}"
     CACHE STRING "Fortran compiler flags for Bit-reproducible builds" FORCE )
set( CMAKE_Fortran_FLAGS_DEBUG          "-O0 -g -fcheck=bounds -fbacktrace -finit-real=snan ${ARG_MISMATCH} ${INVALID_BOZ}"
     CACHE STRING "Fortran compiler flags for Debug builds"            FORCE )
set( CMAKE_Fortran_FLAGS_PRODUCTION     "-O2 -g ${ARG_MISMATCH} ${INVALID_BOZ}"
     CACHE STRING "Fortran compiler flags for Production builds."      FORCE )
set( CMAKE_Fortran_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG ${ARG_MISMATCH} ${INVALID_BOZ}"
     CACHE STRING "Fortran compiler flags for RelWithDebInfo builds."  FORCE )

set( Fortran_FLAG_STACK_ARRAYS "-fstack-arrays" )

####################################################################

# Meaning of flags
# ----------------
# -fstack-arrays             : Allocate automatic arrays on the stack
#                              (needs large stacksize!!!)
# -funroll-all-loops         : Unroll all loops
# -fcheck=bounds             : Bounds checking
# -falllow-argument-mismatch : Degrades mismatch between call and procedure
#                              definition error to warning
# -fallow_invalid_boz        : Degrades BOZ literal constant error to warning