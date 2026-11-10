# Mirrors GHA "Extract Maven distribution": put the Maven built by
# InitialBuild (fetched by the artifact dependency into maven-dist/) on PATH.
ls -la maven-dist
rm -rf maven-local && mkdir -p maven-local
if [ "$MF_OS" = "Windows" ]; then
  zip_file=$(ls maven-dist/apache-maven-*-bin.zip)
  if command -v unzip >/dev/null 2>&1; then
    unzip -q "$zip_file" -d maven-local
  else
    # Windows' own bsdtar reads zip files
    /c/Windows/System32/tar.exe -xf "$(mf_path "$zip_file")" -C maven-local
  fi
  inner=$(ls maven-local)
  mv "maven-local/$inner"/* maven-local/
  rm -r "maven-local/$inner"
else
  tar xzf maven-dist/apache-maven-*-bin.tar.gz -C maven-local --strip-components 1
fi
export MAVEN_HOME="$MF_WORK/maven-local"
export PATH="$PWD/maven-local/bin:$PATH"
command -v mvn
