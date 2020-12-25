defmodule Google.Protobuf.Empty do
  @moduledoc false
  use Protobuf, syntax: :proto3
end

defmodule Ethereum.Eth.V1alpha1.SetAction do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3
  @type t :: integer | :ADD_VALIDATOR_KEYS | :REMOVE_VALIDATOR_KEYS | :SET_VALIDATOR_KEYS

  field(:ADD_VALIDATOR_KEYS, 0)

  field(:REMOVE_VALIDATOR_KEYS, 1)

  field(:SET_VALIDATOR_KEYS, 2)
end

defmodule Ethereum.Eth.V1alpha1.ValidatorChangeSet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          action: Ethereum.Eth.V1alpha1.SetAction.t(),
          public_keys: [binary]
        }

  defstruct [:action, :public_keys]

  field(:action, 1, type: Ethereum.Eth.V1alpha1.SetAction, enum: true)
  field(:public_keys, 2, repeated: true, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.ListIndexedAttestationsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any},
          page_size: integer,
          page_token: String.t()
        }

  defstruct [:query_filter, :page_size, :page_token]

  oneof(:query_filter, 0)
  field(:epoch, 1, type: :uint64, oneof: 0)
  field(:genesis_epoch, 2, type: :bool, oneof: 0)
  field(:page_size, 3, type: :int32)
  field(:page_token, 4, type: :string)
end

defmodule Ethereum.Eth.V1alpha1.ListAttestationsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any},
          page_size: integer,
          page_token: String.t()
        }

  defstruct [:query_filter, :page_size, :page_token]

  oneof(:query_filter, 0)
  field(:epoch, 1, type: :uint64, oneof: 0)
  field(:genesis_epoch, 2, type: :bool, oneof: 0)
  field(:page_size, 3, type: :int32)
  field(:page_token, 4, type: :string)
end

defmodule Ethereum.Eth.V1alpha1.ListAttestationsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          attestations: [Ethereum.Eth.V1alpha1.Attestation.t()],
          next_page_token: String.t(),
          total_size: integer
        }

  defstruct [:attestations, :next_page_token, :total_size]

  field(:attestations, 1, repeated: true, type: Ethereum.Eth.V1alpha1.Attestation)
  field(:next_page_token, 2, type: :string)
  field(:total_size, 3, type: :int32)
end

defmodule Ethereum.Eth.V1alpha1.ListIndexedAttestationsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          indexed_attestations: [Ethereum.Eth.V1alpha1.IndexedAttestation.t()],
          next_page_token: String.t(),
          total_size: integer
        }

  defstruct [:indexed_attestations, :next_page_token, :total_size]

  field(:indexed_attestations, 1, repeated: true, type: Ethereum.Eth.V1alpha1.IndexedAttestation)
  field(:next_page_token, 2, type: :string)
  field(:total_size, 3, type: :int32)
end

defmodule Ethereum.Eth.V1alpha1.ListBlocksRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any},
          page_size: integer,
          page_token: String.t()
        }

  defstruct [:query_filter, :page_size, :page_token]

  oneof(:query_filter, 0)
  field(:root, 1, type: :bytes, oneof: 0)
  field(:slot, 2, type: :uint64, oneof: 0)
  field(:epoch, 3, type: :uint64, oneof: 0)
  field(:genesis, 4, type: :bool, oneof: 0)
  field(:page_size, 5, type: :int32)
  field(:page_token, 6, type: :string)
end

defmodule Ethereum.Eth.V1alpha1.ListBlocksResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          blockContainers: [Ethereum.Eth.V1alpha1.BeaconBlockContainer.t()],
          next_page_token: String.t(),
          total_size: integer
        }

  defstruct [:blockContainers, :next_page_token, :total_size]

  field(:blockContainers, 1, repeated: true, type: Ethereum.Eth.V1alpha1.BeaconBlockContainer)
  field(:next_page_token, 2, type: :string)
  field(:total_size, 3, type: :int32)
end

defmodule Ethereum.Eth.V1alpha1.BeaconBlockContainer do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block: Ethereum.Eth.V1alpha1.SignedBeaconBlock.t() | nil,
          block_root: binary
        }

  defstruct [:block, :block_root]

  field(:block, 1, type: Ethereum.Eth.V1alpha1.SignedBeaconBlock)
  field(:block_root, 2, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.ChainHead do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          head_slot: non_neg_integer,
          head_epoch: non_neg_integer,
          head_block_root: binary,
          finalized_slot: non_neg_integer,
          finalized_epoch: non_neg_integer,
          finalized_block_root: binary,
          justified_slot: non_neg_integer,
          justified_epoch: non_neg_integer,
          justified_block_root: binary,
          previous_justified_slot: non_neg_integer,
          previous_justified_epoch: non_neg_integer,
          previous_justified_block_root: binary
        }

  defstruct [
    :head_slot,
    :head_epoch,
    :head_block_root,
    :finalized_slot,
    :finalized_epoch,
    :finalized_block_root,
    :justified_slot,
    :justified_epoch,
    :justified_block_root,
    :previous_justified_slot,
    :previous_justified_epoch,
    :previous_justified_block_root
  ]

  field(:head_slot, 1, type: :uint64)
  field(:head_epoch, 2, type: :uint64)
  field(:head_block_root, 3, type: :bytes)
  field(:finalized_slot, 4, type: :uint64)
  field(:finalized_epoch, 5, type: :uint64)
  field(:finalized_block_root, 6, type: :bytes)
  field(:justified_slot, 7, type: :uint64)
  field(:justified_epoch, 8, type: :uint64)
  field(:justified_block_root, 9, type: :bytes)
  field(:previous_justified_slot, 10, type: :uint64)
  field(:previous_justified_epoch, 11, type: :uint64)
  field(:previous_justified_block_root, 12, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.ListCommitteesRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any}
        }

  defstruct [:query_filter]

  oneof(:query_filter, 0)
  field(:epoch, 1, type: :uint64, oneof: 0)
  field(:genesis, 2, type: :bool, oneof: 0)
end

defmodule Ethereum.Eth.V1alpha1.BeaconCommittees.CommitteeItem do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          validator_indices: [non_neg_integer]
        }

  defstruct [:validator_indices]

  field(:validator_indices, 1, repeated: true, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.BeaconCommittees.CommitteesList do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          committees: [Ethereum.Eth.V1alpha1.BeaconCommittees.CommitteeItem.t()]
        }

  defstruct [:committees]

  field(:committees, 1, repeated: true, type: Ethereum.Eth.V1alpha1.BeaconCommittees.CommitteeItem)
end

defmodule Ethereum.Eth.V1alpha1.BeaconCommittees.CommitteesEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: non_neg_integer,
          value: Ethereum.Eth.V1alpha1.BeaconCommittees.CommitteesList.t() | nil
        }

  defstruct [:key, :value]

  field(:key, 1, type: :uint64)
  field(:value, 2, type: Ethereum.Eth.V1alpha1.BeaconCommittees.CommitteesList)
end

defmodule Ethereum.Eth.V1alpha1.BeaconCommittees do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          committees: %{
            non_neg_integer => Ethereum.Eth.V1alpha1.BeaconCommittees.CommitteesList.t() | nil
          },
          active_validator_count: non_neg_integer
        }

  defstruct [:epoch, :committees, :active_validator_count]

  field(:epoch, 1, type: :uint64)

  field(:committees, 2,
    repeated: true,
    type: Ethereum.Eth.V1alpha1.BeaconCommittees.CommitteesEntry,
    map: true
  )

  field(:active_validator_count, 3, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.ListValidatorBalancesRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any},
          public_keys: [binary],
          indices: [non_neg_integer],
          page_size: integer,
          page_token: String.t()
        }

  defstruct [:query_filter, :public_keys, :indices, :page_size, :page_token]

  oneof(:query_filter, 0)
  field(:epoch, 1, type: :uint64, oneof: 0)
  field(:genesis, 2, type: :bool, oneof: 0)
  field(:public_keys, 3, repeated: true, type: :bytes)
  field(:indices, 4, repeated: true, type: :uint64)
  field(:page_size, 5, type: :int32)
  field(:page_token, 6, type: :string)
end

defmodule Ethereum.Eth.V1alpha1.ValidatorBalances.Balance do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          public_key: binary,
          index: non_neg_integer,
          balance: non_neg_integer,
          status: String.t()
        }

  defstruct [:public_key, :index, :balance, :status]

  field(:public_key, 1, type: :bytes)
  field(:index, 2, type: :uint64)
  field(:balance, 3, type: :uint64)
  field(:status, 4, type: :string)
end

defmodule Ethereum.Eth.V1alpha1.ValidatorBalances do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          balances: [Ethereum.Eth.V1alpha1.ValidatorBalances.Balance.t()],
          next_page_token: String.t(),
          total_size: integer
        }

  defstruct [:epoch, :balances, :next_page_token, :total_size]

  field(:epoch, 1, type: :uint64)
  field(:balances, 2, repeated: true, type: Ethereum.Eth.V1alpha1.ValidatorBalances.Balance)
  field(:next_page_token, 3, type: :string)
  field(:total_size, 4, type: :int32)
end

defmodule Ethereum.Eth.V1alpha1.ListValidatorsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any},
          active: boolean,
          page_size: integer,
          page_token: String.t(),
          public_keys: [binary],
          indices: [non_neg_integer]
        }

  defstruct [:query_filter, :active, :page_size, :page_token, :public_keys, :indices]

  oneof(:query_filter, 0)
  field(:epoch, 1, type: :uint64, oneof: 0)
  field(:genesis, 2, type: :bool, oneof: 0)
  field(:active, 3, type: :bool)
  field(:page_size, 4, type: :int32)
  field(:page_token, 5, type: :string)
  field(:public_keys, 6, repeated: true, type: :bytes)
  field(:indices, 7, repeated: true, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.GetValidatorRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any}
        }

  defstruct [:query_filter]

  oneof(:query_filter, 0)
  field(:index, 1, type: :uint64, oneof: 0)
  field(:public_key, 2, type: :bytes, oneof: 0)
end

defmodule Ethereum.Eth.V1alpha1.Validators.ValidatorContainer do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          index: non_neg_integer,
          validator: Ethereum.Eth.V1alpha1.Validator.t() | nil
        }

  defstruct [:index, :validator]

  field(:index, 1, type: :uint64)
  field(:validator, 2, type: Ethereum.Eth.V1alpha1.Validator)
end

defmodule Ethereum.Eth.V1alpha1.Validators do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          validator_list: [Ethereum.Eth.V1alpha1.Validators.ValidatorContainer.t()],
          next_page_token: String.t(),
          total_size: integer
        }

  defstruct [:epoch, :validator_list, :next_page_token, :total_size]

  field(:epoch, 1, type: :uint64)

  field(:validator_list, 2,
    repeated: true,
    type: Ethereum.Eth.V1alpha1.Validators.ValidatorContainer
  )

  field(:next_page_token, 3, type: :string)
  field(:total_size, 4, type: :int32)
end

defmodule Ethereum.Eth.V1alpha1.GetValidatorActiveSetChangesRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any}
        }

  defstruct [:query_filter]

  oneof(:query_filter, 0)
  field(:epoch, 1, type: :uint64, oneof: 0)
  field(:genesis, 2, type: :bool, oneof: 0)
end

defmodule Ethereum.Eth.V1alpha1.ActiveSetChanges do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          activated_public_keys: [binary],
          activated_indices: [non_neg_integer],
          exited_public_keys: [binary],
          exited_indices: [non_neg_integer],
          slashed_public_keys: [binary],
          slashed_indices: [non_neg_integer],
          ejected_public_keys: [binary],
          ejected_indices: [non_neg_integer]
        }

  defstruct [
    :epoch,
    :activated_public_keys,
    :activated_indices,
    :exited_public_keys,
    :exited_indices,
    :slashed_public_keys,
    :slashed_indices,
    :ejected_public_keys,
    :ejected_indices
  ]

  field(:epoch, 1, type: :uint64)
  field(:activated_public_keys, 2, repeated: true, type: :bytes)
  field(:activated_indices, 3, repeated: true, type: :uint64)
  field(:exited_public_keys, 4, repeated: true, type: :bytes)
  field(:exited_indices, 5, repeated: true, type: :uint64)
  field(:slashed_public_keys, 6, repeated: true, type: :bytes)
  field(:slashed_indices, 7, repeated: true, type: :uint64)
  field(:ejected_public_keys, 8, repeated: true, type: :bytes)
  field(:ejected_indices, 9, repeated: true, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.ValidatorPerformanceRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          public_keys: [binary],
          indices: [non_neg_integer]
        }

  defstruct [:public_keys, :indices]

  field(:public_keys, 1, repeated: true, type: :bytes, deprecated: true)
  field(:indices, 2, repeated: true, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.ValidatorPerformanceResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          current_effective_balances: [non_neg_integer],
          inclusion_slots: [non_neg_integer],
          inclusion_distances: [non_neg_integer],
          correctly_voted_source: [boolean],
          correctly_voted_target: [boolean],
          correctly_voted_head: [boolean],
          balances_before_epoch_transition: [non_neg_integer],
          balances_after_epoch_transition: [non_neg_integer],
          missing_validators: [binary],
          average_active_validator_balance: float | :infinity | :negative_infinity | :nan,
          public_keys: [binary]
        }

  defstruct [
    :current_effective_balances,
    :inclusion_slots,
    :inclusion_distances,
    :correctly_voted_source,
    :correctly_voted_target,
    :correctly_voted_head,
    :balances_before_epoch_transition,
    :balances_after_epoch_transition,
    :missing_validators,
    :average_active_validator_balance,
    :public_keys
  ]

  field(:current_effective_balances, 1, repeated: true, type: :uint64)
  field(:inclusion_slots, 2, repeated: true, type: :uint64)
  field(:inclusion_distances, 3, repeated: true, type: :uint64)
  field(:correctly_voted_source, 4, repeated: true, type: :bool)
  field(:correctly_voted_target, 5, repeated: true, type: :bool)
  field(:correctly_voted_head, 6, repeated: true, type: :bool)
  field(:balances_before_epoch_transition, 7, repeated: true, type: :uint64)
  field(:balances_after_epoch_transition, 8, repeated: true, type: :uint64)
  field(:missing_validators, 9, repeated: true, type: :bytes)
  field(:average_active_validator_balance, 10, type: :float)
  field(:public_keys, 11, repeated: true, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.ValidatorQueue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          churn_limit: non_neg_integer,
          activation_public_keys: [binary],
          exit_public_keys: [binary],
          activation_validator_indices: [non_neg_integer],
          exit_validator_indices: [non_neg_integer]
        }

  defstruct [
    :churn_limit,
    :activation_public_keys,
    :exit_public_keys,
    :activation_validator_indices,
    :exit_validator_indices
  ]

  field(:churn_limit, 1, type: :uint64)
  field(:activation_public_keys, 2, repeated: true, type: :bytes, deprecated: true)
  field(:exit_public_keys, 3, repeated: true, type: :bytes, deprecated: true)
  field(:activation_validator_indices, 4, repeated: true, type: :uint64)
  field(:exit_validator_indices, 5, repeated: true, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.ListValidatorAssignmentsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any},
          public_keys: [binary],
          indices: [non_neg_integer],
          page_size: integer,
          page_token: String.t()
        }

  defstruct [:query_filter, :public_keys, :indices, :page_size, :page_token]

  oneof(:query_filter, 0)
  field(:epoch, 1, type: :uint64, oneof: 0)
  field(:genesis, 2, type: :bool, oneof: 0)
  field(:public_keys, 3, repeated: true, type: :bytes)
  field(:indices, 4, repeated: true, type: :uint64)
  field(:page_size, 5, type: :int32)
  field(:page_token, 6, type: :string)
end

defmodule Ethereum.Eth.V1alpha1.ValidatorAssignments.CommitteeAssignment do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          beacon_committees: [non_neg_integer],
          committee_index: non_neg_integer,
          attester_slot: non_neg_integer,
          proposer_slots: [non_neg_integer],
          public_key: binary,
          validator_index: non_neg_integer
        }

  defstruct [
    :beacon_committees,
    :committee_index,
    :attester_slot,
    :proposer_slots,
    :public_key,
    :validator_index
  ]

  field(:beacon_committees, 1, repeated: true, type: :uint64)
  field(:committee_index, 2, type: :uint64)
  field(:attester_slot, 3, type: :uint64)
  field(:proposer_slots, 4, repeated: true, type: :uint64)
  field(:public_key, 5, type: :bytes, deprecated: true)
  field(:validator_index, 6, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.ValidatorAssignments do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          assignments: [Ethereum.Eth.V1alpha1.ValidatorAssignments.CommitteeAssignment.t()],
          next_page_token: String.t(),
          total_size: integer
        }

  defstruct [:epoch, :assignments, :next_page_token, :total_size]

  field(:epoch, 1, type: :uint64)

  field(:assignments, 2,
    repeated: true,
    type: Ethereum.Eth.V1alpha1.ValidatorAssignments.CommitteeAssignment
  )

  field(:next_page_token, 3, type: :string)
  field(:total_size, 4, type: :int32)
end

defmodule Ethereum.Eth.V1alpha1.GetValidatorParticipationRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_filter: {atom, any}
        }

  defstruct [:query_filter]

  oneof(:query_filter, 0)
  field(:epoch, 1, type: :uint64, oneof: 0)
  field(:genesis, 2, type: :bool, oneof: 0)
end

defmodule Ethereum.Eth.V1alpha1.ValidatorParticipationResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          finalized: boolean,
          participation: Ethereum.Eth.V1alpha1.ValidatorParticipation.t() | nil
        }

  defstruct [:epoch, :finalized, :participation]

  field(:epoch, 1, type: :uint64)
  field(:finalized, 2, type: :bool)
  field(:participation, 3, type: Ethereum.Eth.V1alpha1.ValidatorParticipation)
end

defmodule Ethereum.Eth.V1alpha1.AttestationPoolRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          page_size: integer,
          page_token: String.t()
        }

  defstruct [:page_size, :page_token]

  field(:page_size, 1, type: :int32)
  field(:page_token, 2, type: :string)
end

defmodule Ethereum.Eth.V1alpha1.AttestationPoolResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          attestations: [Ethereum.Eth.V1alpha1.Attestation.t()],
          next_page_token: String.t(),
          total_size: integer
        }

  defstruct [:attestations, :next_page_token, :total_size]

  field(:attestations, 1, repeated: true, type: Ethereum.Eth.V1alpha1.Attestation)
  field(:next_page_token, 2, type: :string)
  field(:total_size, 3, type: :int32)
end

defmodule Ethereum.Eth.V1alpha1.BeaconConfig.ConfigEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }

  defstruct [:key, :value]

  field(:key, 1, type: :string)
  field(:value, 2, type: :string)
end

defmodule Ethereum.Eth.V1alpha1.BeaconConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          config: %{String.t() => String.t()}
        }

  defstruct [:config]

  field(:config, 1,
    repeated: true,
    type: Ethereum.Eth.V1alpha1.BeaconConfig.ConfigEntry,
    map: true
  )
end

defmodule Ethereum.Eth.V1alpha1.SubmitSlashingResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          slashed_indices: [non_neg_integer]
        }

  defstruct [:slashed_indices]

  field(:slashed_indices, 1, repeated: true, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.IndividualVotesRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          public_keys: [binary],
          indices: [non_neg_integer]
        }

  defstruct [:epoch, :public_keys, :indices]

  field(:epoch, 1, type: :uint64)
  field(:public_keys, 2, repeated: true, type: :bytes)
  field(:indices, 3, repeated: true, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.IndividualVotesRespond.IndividualVote do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          public_key: binary,
          validator_index: non_neg_integer,
          is_slashed: boolean,
          is_withdrawable_in_current_epoch: boolean,
          is_active_in_current_epoch: boolean,
          is_active_in_previous_epoch: boolean,
          is_current_epoch_attester: boolean,
          is_current_epoch_target_attester: boolean,
          is_previous_epoch_attester: boolean,
          is_previous_epoch_target_attester: boolean,
          is_previous_epoch_head_attester: boolean,
          current_epoch_effective_balance_gwei: non_neg_integer,
          inclusion_slot: non_neg_integer,
          inclusion_distance: non_neg_integer
        }

  defstruct [
    :epoch,
    :public_key,
    :validator_index,
    :is_slashed,
    :is_withdrawable_in_current_epoch,
    :is_active_in_current_epoch,
    :is_active_in_previous_epoch,
    :is_current_epoch_attester,
    :is_current_epoch_target_attester,
    :is_previous_epoch_attester,
    :is_previous_epoch_target_attester,
    :is_previous_epoch_head_attester,
    :current_epoch_effective_balance_gwei,
    :inclusion_slot,
    :inclusion_distance
  ]

  field(:epoch, 1, type: :uint64)
  field(:public_key, 2, type: :bytes)
  field(:validator_index, 3, type: :uint64)
  field(:is_slashed, 4, type: :bool)
  field(:is_withdrawable_in_current_epoch, 5, type: :bool)
  field(:is_active_in_current_epoch, 6, type: :bool)
  field(:is_active_in_previous_epoch, 7, type: :bool)
  field(:is_current_epoch_attester, 8, type: :bool)
  field(:is_current_epoch_target_attester, 9, type: :bool)
  field(:is_previous_epoch_attester, 10, type: :bool)
  field(:is_previous_epoch_target_attester, 11, type: :bool)
  field(:is_previous_epoch_head_attester, 12, type: :bool)
  field(:current_epoch_effective_balance_gwei, 13, type: :uint64)
  field(:inclusion_slot, 14, type: :uint64)
  field(:inclusion_distance, 15, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.IndividualVotesRespond do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          individual_votes: [Ethereum.Eth.V1alpha1.IndividualVotesRespond.IndividualVote.t()]
        }

  defstruct [:individual_votes]

  field(:individual_votes, 1,
    repeated: true,
    type: Ethereum.Eth.V1alpha1.IndividualVotesRespond.IndividualVote
  )
end

defmodule Ethereum.Eth.V1alpha1.WeakSubjectivityCheckpoint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_root: binary,
          state_root: binary,
          epoch: non_neg_integer
        }

  defstruct [:block_root, :state_root, :epoch]

  field(:block_root, 1, type: :bytes)
  field(:state_root, 2, type: :bytes)
  field(:epoch, 3, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.BeaconChain.Service do
  @moduledoc false
  use GRPC.Service, name: "ethereum.eth.v1alpha1.BeaconChain"

  rpc(
    :ListAttestations,
    Ethereum.Eth.V1alpha1.ListAttestationsRequest,
    Ethereum.Eth.V1alpha1.ListAttestationsResponse
  )

  rpc(
    :ListIndexedAttestations,
    Ethereum.Eth.V1alpha1.ListIndexedAttestationsRequest,
    Ethereum.Eth.V1alpha1.ListIndexedAttestationsResponse
  )

  rpc(:StreamAttestations, Google.Protobuf.Empty, stream(Ethereum.Eth.V1alpha1.Attestation))

  rpc(
    :StreamIndexedAttestations,
    Google.Protobuf.Empty,
    stream(Ethereum.Eth.V1alpha1.IndexedAttestation)
  )

  rpc(
    :AttestationPool,
    Ethereum.Eth.V1alpha1.AttestationPoolRequest,
    Ethereum.Eth.V1alpha1.AttestationPoolResponse
  )

  rpc(
    :ListBlocks,
    Ethereum.Eth.V1alpha1.ListBlocksRequest,
    Ethereum.Eth.V1alpha1.ListBlocksResponse
  )

  rpc(:StreamBlocks, Google.Protobuf.Empty, stream(Ethereum.Eth.V1alpha1.SignedBeaconBlock))

  rpc(:StreamChainHead, Google.Protobuf.Empty, stream(Ethereum.Eth.V1alpha1.ChainHead))

  rpc(:GetChainHead, Google.Protobuf.Empty, Ethereum.Eth.V1alpha1.ChainHead)

  rpc(
    :GetWeakSubjectivityCheckpoint,
    Google.Protobuf.Empty,
    Ethereum.Eth.V1alpha1.WeakSubjectivityCheckpoint
  )

  rpc(
    :ListBeaconCommittees,
    Ethereum.Eth.V1alpha1.ListCommitteesRequest,
    Ethereum.Eth.V1alpha1.BeaconCommittees
  )

  rpc(
    :ListValidatorBalances,
    Ethereum.Eth.V1alpha1.ListValidatorBalancesRequest,
    Ethereum.Eth.V1alpha1.ValidatorBalances
  )

  rpc(
    :ListValidators,
    Ethereum.Eth.V1alpha1.ListValidatorsRequest,
    Ethereum.Eth.V1alpha1.Validators
  )

  rpc(:GetValidator, Ethereum.Eth.V1alpha1.GetValidatorRequest, Ethereum.Eth.V1alpha1.Validator)

  rpc(
    :GetValidatorActiveSetChanges,
    Ethereum.Eth.V1alpha1.GetValidatorActiveSetChangesRequest,
    Ethereum.Eth.V1alpha1.ActiveSetChanges
  )

  rpc(:GetValidatorQueue, Google.Protobuf.Empty, Ethereum.Eth.V1alpha1.ValidatorQueue)

  rpc(
    :GetValidatorPerformance,
    Ethereum.Eth.V1alpha1.ValidatorPerformanceRequest,
    Ethereum.Eth.V1alpha1.ValidatorPerformanceResponse
  )

  rpc(
    :ListValidatorAssignments,
    Ethereum.Eth.V1alpha1.ListValidatorAssignmentsRequest,
    Ethereum.Eth.V1alpha1.ValidatorAssignments
  )

  rpc(
    :GetValidatorParticipation,
    Ethereum.Eth.V1alpha1.GetValidatorParticipationRequest,
    Ethereum.Eth.V1alpha1.ValidatorParticipationResponse
  )

  rpc(:GetBeaconConfig, Google.Protobuf.Empty, Ethereum.Eth.V1alpha1.BeaconConfig)

  rpc(
    :StreamValidatorsInfo,
    stream(Ethereum.Eth.V1alpha1.ValidatorChangeSet),
    stream(Ethereum.Eth.V1alpha1.ValidatorInfo)
  )

  rpc(
    :SubmitAttesterSlashing,
    Ethereum.Eth.V1alpha1.AttesterSlashing,
    Ethereum.Eth.V1alpha1.SubmitSlashingResponse
  )

  rpc(
    :SubmitProposerSlashing,
    Ethereum.Eth.V1alpha1.ProposerSlashing,
    Ethereum.Eth.V1alpha1.SubmitSlashingResponse
  )

  rpc(
    :GetIndividualVotes,
    Ethereum.Eth.V1alpha1.IndividualVotesRequest,
    Ethereum.Eth.V1alpha1.IndividualVotesRespond
  )
end

defmodule Ethereum.Eth.V1alpha1.BeaconChain.Stub do
  @moduledoc false
  use GRPC.Stub, service: Ethereum.Eth.V1alpha1.BeaconChain.Service
end
