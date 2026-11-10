# Mirrors GHA maven.yml job "initial-build".
# Bootstrap the wrapper with the agent's preinstalled mvn (apt 3.8.7, per the
# capability probe). Upstream commits no .mvn/wrapper, and GHA does the same step.
mvn "${MF_MVN_COMMON[@]}" \
  org.apache.maven.plugins:maven-wrapper-plugin:3.3.4:wrapper "-Dmaven=$MF_WRAPPER_MAVEN"

./mvnw verify "${MF_MVN_COMMON[@]}"

ls -la apache-maven/target
