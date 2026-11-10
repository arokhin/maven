# Mirrors GHA maven.yml job "integration-tests".
# -Pmimir is kept: that profile (its/core-it-suite/pom.xml) only seeds a
# Mimir config into the ITs' own prepared user home under target/, so it stays
# inside this build. It needs MIMIR_VERSION in the environment. The outer-build
# Mimir setup GHA does (writing ~/.m2/extensions.xml) is deliberately NOT
# reproduced: on shared agents it would leak into other projects' builds.
mvn install -Prun-its,mimir "${MF_MVN_COMMON[@]}"
