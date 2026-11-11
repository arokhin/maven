# Mirrors GHA maven.yml job "integration-tests", minus the `mimir` profile.
# That profile points the ITs at a Mimir daemon with autostart=false, and expects
# the outer build to have started one (GHA does this via .mvn/extensions.xml and
# ~/.mimir). We don't reproduce that outer setup: it would leak state onto
# shared agents (Lesson 7). Without the daemon, builds 29098/29099/29100/29122
# each had ~1057 failures ("Mimir daemon does not run and autostart is disabled").
# Mimir is only a download cache, so dropping it leaves the test scope unchanged.
mvn install -Prun-its "${MF_MVN_COMMON[@]}"
