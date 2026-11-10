# Mirrors ASF Jenkinsfile isDeployedBranch() deploy:
#   ./mvnw clean deploy -DdeployAtEnd=true -B -V   (MAVEN_OPTS -Xms4G -Xmx4G)
# Credentials: ASF Nexus deploy credentials come from the secure params
# MF_ASF_NEXUS_USER / MF_ASF_NEXUS_PASSWORD (env), written into a throwaway
# settings.xml under .mf-home that is never published as an artifact.
: "${MF_ASF_NEXUS_USER:?set the ASF Nexus deploy credentials as secure params first}"
: "${MF_ASF_NEXUS_PASSWORD:?set the ASF Nexus deploy credentials as secure params first}"
mf_settings="$MF_WORK/.mf-home/deploy-settings.xml"
cat > "$mf_settings" <<'XML'
<settings><servers><server><id>apache.snapshots.https</id>
<username>${env.MF_ASF_NEXUS_USER}</username><password>${env.MF_ASF_NEXUS_PASSWORD}</password>
</server></servers></settings>
XML
mvn "${MF_MVN_COMMON[@]}" \
  org.apache.maven.plugins:maven-wrapper-plugin:3.3.4:wrapper "-Dmaven=3.9.12"
./mvnw clean deploy -DdeployAtEnd=true -s "$mf_settings" "${MF_MVN_COMMON[@]}"
