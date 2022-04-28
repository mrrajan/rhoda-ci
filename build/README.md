# RHODA-CI Container Image

A [Dockerfile](Dockerfile) is available for running tests in a container.
The latest build can be downloaded from: https://quay.io/rhodaci/rhoda-ci:latest

eg: podman pull quay.io/rhodaci/rhoda-ci:latest

```bash
# Build the container (optional if you dont want to use the latest from quay.io/rhodaci)
$ podman build -t rhoda-ci:master -f build/Dockerfile .

# Mount a file volume to provide a test-variables.yaml file at runtime
# Mount a volume to preserve the test run artifacts
$ podman run --rm -v $PWD/test-variables.yaml:/tmp/rhoda-ci/test-variables.yaml:Z -v $PWD/test-output:/tmp/rhoda-ci/test-output:Z rhoda-ci:master
```

### Running the rhoda-ci container image in OpenShift

After building the container, you can deploy the container in a pod running on OpenShift. You can use [this](./rhoda-ci.pod.yaml) PersistentVolumeClaim and Pod definition to deploy the rhoda-ci container.  NOTE: This example pod attaches a PVC to preserve the test artifacts directory between runs and mounts the test-variables.yaml file from a Secret.

```
# Creates a Secret with test variables that can be mounted in RHODA-CI container
oc create secret generic rhoda-ci-test-variables --from-file test-variables.yaml
```
