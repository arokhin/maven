# Inlined ahead of every step body by settings.kts. Runs under bash -eo pipefail
# (Linux: native bash; Windows: Git Bash, C:\Program Files\Git\bin\bash.exe).

# Java on Windows needs C:/... paths, not Git Bash's /c/... form.
mf_path() {
  if command -v cygpath >/dev/null 2>&1; then cygpath -m "$1"; else echo "$1"; fi
}

# Stateless by default (DESIGN Lesson 7): this build's own Maven local repo and
# wrapper home live inside the checkout dir. That way nothing is read from, or
# leaked into, the shared agent's ~/.m2, which other projects on the Default
# pool also use. Pass 2 may swap in a proven TeamCity build cache instead.
MF_WORK="$(mf_path "$PWD")"
export MAVEN_USER_HOME="$MF_WORK/.mf-home/m2"
MF_REPO_LOCAL="$MF_WORK/.mf-home/repository"
mkdir -p "$MAVEN_USER_HOME" "$MF_REPO_LOCAL"
MF_MVN_COMMON=(-e -B -V "-Dmaven.repo.local=$MF_REPO_LOCAL")

echo "JAVA_HOME=$JAVA_HOME"
"$JAVA_HOME/bin/java" -version
