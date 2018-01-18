spack find -l | cut -d ' ' -f 1 | grep -i -e [0-9][a-z] |xargs -I hash spack spec -y /hash >> ~/spack_installed.yaml
