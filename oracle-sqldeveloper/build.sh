#!/bin/sh

# Copyright (c) 2023 Oracle and/or its affiliates. 
#
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

echo "Building SQLDeveloper 23 on Oracle Linux 8"
docker build --file Dockerfile --tag oracle/sqldeveloper:23-ol8 .
