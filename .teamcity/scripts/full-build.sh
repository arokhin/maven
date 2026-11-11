# Mirrors GHA maven.yml job "full-build".
mvn verify -Papache-release -Dgpg.skip=true "${MF_MVN_COMMON[@]}"

# Upstream builds the site on Linux only, but on every JDK, since Javadoc
# changes with the JDK. This gap is intentional (Lesson 17).
if [ "$MF_SITE" = "true" ]; then
  if ! command -v dot >/dev/null 2>&1; then
    # The capability probe could not confirm Graphviz on the AMI (agent properties do not report it), so install on demand. Needs passwordless sudo;
    # -n makes a missing sudo right fail loudly instead of hanging.
    # The AMI ships with empty apt lists, unlike GHA runners: build 29094 failed with "Unable to locate package graphviz".
    sudo -n apt-get update -qq
    sudo -n apt-get install -y graphviz libgvplugin-neato-layout8
  fi
  mvn site -Preporting "${MF_MVN_COMMON[@]}"
fi
