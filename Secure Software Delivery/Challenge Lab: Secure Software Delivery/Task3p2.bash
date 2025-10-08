export PROJECT_ID="qwiklabs-gcp-04-428a1593d3b5"
export KMS_KEY_RING="binauthz-keys"
export KMS_KEY_NAME="lab-key"
export KMS_KEY_PATH="projects/${PROJECT_ID}/locations/global/keyRings/${KMS_KEY_RING}/cryptoKeys/${KMS_KEY_NAME}/cryptoKeyVersions/1"


gcloud beta container binauthz attestors public-keys add \
  --attestor="vulnerability-attestor" \
  --keyversion="${KMS_KEY_PATH}"

cat << EOF > /tmp/policy.yaml
globalPolicyEvaluationMode: ENABLE
defaultAdmissionRule:
  evaluationMode: REQUIRE_ATTESTATION
  enforcementMode: ENFORCED_BLOCK_AND_AUDIT_LOG
  requireAttestationsBy:
    - projects/${PROJECT_ID}/attestors/vulnerability-attestor
name: projects/${PROJECT_ID}/policy
EOF

gcloud container binauthz policy import /tmp/policy
