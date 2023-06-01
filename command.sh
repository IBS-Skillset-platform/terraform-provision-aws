#!/bin/bash
OIDC_ID=$(aws eks describe-cluster --name happystays-eks-cluster --region ap-south-1 --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
jq -n --arg oidc_id "$OIDC_ID" \
      '{"oidc_id":$oidc_id}'