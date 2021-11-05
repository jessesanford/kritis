#!/bin/bash

# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
set -e

# Create a project inside Grafeas.
#curl -k --cert grafeas.pem -X POST \
#  https://grafeas-server:443/v1beta1/projects \
#  -H "Content-Type: application/json" \
#  --data '{"name":"projects/kritis"}'

curl -k --cert grafeas.pem -X POST \
  http://grafeas-server:32164/v1beta1/projects \
  -H "Content-Type: application/json" \
  --data '{"name":"projects/kritis"}'

# Now, create an attestation for the image.
export GODEBUG=x509ignoreCN=0
go run create_attestation.go

# The pod should now be admitted.
kubectl apply -f pod.yaml
