FILE(GLOB ir_HEADERS *.h)
set(ir_SOURCES
  ExpressionAnalyzer.cpp
  ExpressionManipulator.cpp
  drop.cpp
  eh-utils.cpp
  intrinsics.cpp
  lubs.cpp
  memory-utils.cpp
  module-utils.cpp
  names.cpp
  possible-contents.cpp
  properties.cpp
  LocalGraph.cpp
  LocalStructuralDominance.cpp
  ReFinalize.cpp
  stack-utils.cpp
  table-utils.cpp
  type-updating.cpp
  module-splitting.cpp
  ${ir_HEADERS}
)
add_library(ir OBJECT ${ir_SOURCES})
