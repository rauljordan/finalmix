defmodule Ethereum.Eth.V1alpha1.Attestation do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          aggregation_bits: binary,
          data: Ethereum.Eth.V1alpha1.AttestationData.t() | nil,
          signature: binary
        }

  defstruct [:aggregation_bits, :data, :signature]

  field :aggregation_bits, 1, type: :bytes
  field :data, 2, type: Ethereum.Eth.V1alpha1.AttestationData
  field :signature, 3, type: :bytes
end

defmodule Ethereum.Eth.V1alpha1.AggregateAttestationAndProof do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          aggregator_index: non_neg_integer,
          aggregate: Ethereum.Eth.V1alpha1.Attestation.t() | nil,
          selection_proof: binary
        }

  defstruct [:aggregator_index, :aggregate, :selection_proof]

  field :aggregator_index, 1, type: :uint64
  field :aggregate, 3, type: Ethereum.Eth.V1alpha1.Attestation
  field :selection_proof, 2, type: :bytes
end

defmodule Ethereum.Eth.V1alpha1.SignedAggregateAttestationAndProof do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          message: Ethereum.Eth.V1alpha1.AggregateAttestationAndProof.t() | nil,
          signature: binary
        }

  defstruct [:message, :signature]

  field :message, 1, type: Ethereum.Eth.V1alpha1.AggregateAttestationAndProof
  field :signature, 2, type: :bytes
end

defmodule Ethereum.Eth.V1alpha1.AttestationData do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          slot: non_neg_integer,
          committee_index: non_neg_integer,
          beacon_block_root: binary,
          source: Ethereum.Eth.V1alpha1.Checkpoint.t() | nil,
          target: Ethereum.Eth.V1alpha1.Checkpoint.t() | nil
        }

  defstruct [:slot, :committee_index, :beacon_block_root, :source, :target]

  field :slot, 1, type: :uint64
  field :committee_index, 2, type: :uint64
  field :beacon_block_root, 3, type: :bytes
  field :source, 4, type: Ethereum.Eth.V1alpha1.Checkpoint
  field :target, 5, type: Ethereum.Eth.V1alpha1.Checkpoint
end

defmodule Ethereum.Eth.V1alpha1.Checkpoint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          root: binary
        }

  defstruct [:epoch, :root]

  field :epoch, 1, type: :uint64
  field :root, 2, type: :bytes
end
