alias FinalMix.Detector.Helpers
alias Ethereum.Eth.V1alpha1.IndexedAttestation

attestations = [
  %IndexedAttestation{attesting_indices: [0]},
  %IndexedAttestation{attesting_indices: [1]},
  %IndexedAttestation{attesting_indices: [16]},
  %IndexedAttestation{attesting_indices: [17]}
]

Benchee.run(%{
  "group_by_validator_index"    => fn -> Helpers.advanced_group_by_validator_index(attestations) end
})
