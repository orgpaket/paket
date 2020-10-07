#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
add_executable(paket.b paket.b.cpp)
target_link_libraries(paket.b PUBLIC ${BENCHLIBNAME})
file(MAKE_DIRECTORY ${OUTPUT_DATA_ABSPATH}/bench/paket)
add_test(
  NAME paket.b
  COMMAND paket.b
    --benchmark_format=json
    --benchmark_out=${OUTPUT_DATA_ABSPATH}/bench/paket/info.json
    --input-data ${INPUT_DATA_ABSPATH}
    --output-data ${OUTPUT_DATA_ABSPATH}
  )
set_property(TEST paket.b PROPERTY LABELS UnitBenchmark)
add_subdirectory(paket)
