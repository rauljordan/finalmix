defmodule Ethereum.Eth.V1alpha1.BeaconBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          slot: non_neg_integer,
          proposer_index: non_neg_integer,
          parent_root: binary,
          state_root: binary,
          body: Ethereum.Eth.V1alpha1.BeaconBlockBody.t() | nil
        }

  defstruct [:slot, :proposer_index, :parent_root, :state_root, :body]

  field(:slot, 1, type: :uint64)
  field(:proposer_index, 2, type: :uint64)
  field(:parent_root, 3, type: :bytes)
  field(:state_root, 4, type: :bytes)
  field(:body, 5, type: Ethereum.Eth.V1alpha1.BeaconBlockBody)
end

defmodule Ethereum.Eth.V1alpha1.SignedBeaconBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block: Ethereum.Eth.V1alpha1.BeaconBlock.t() | nil,
          signature: binary
        }

  defstruct [:block, :signature]

  field(:block, 1, type: Ethereum.Eth.V1alpha1.BeaconBlock)
  field(:signature, 2, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.BeaconBlockBody do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          randao_reveal: binary,
          eth1_data: Ethereum.Eth.V1alpha1.Eth1Data.t() | nil,
          graffiti: binary,
          proposer_slashings: [Ethereum.Eth.V1alpha1.ProposerSlashing.t()],
          attester_slashings: [Ethereum.Eth.V1alpha1.AttesterSlashing.t()],
          attestations: [Ethereum.Eth.V1alpha1.Attestation.t()],
          deposits: [Ethereum.Eth.V1alpha1.Deposit.t()],
          voluntary_exits: [Ethereum.Eth.V1alpha1.SignedVoluntaryExit.t()]
        }

  defstruct [
    :randao_reveal,
    :eth1_data,
    :graffiti,
    :proposer_slashings,
    :attester_slashings,
    :attestations,
    :deposits,
    :voluntary_exits
  ]

  field(:randao_reveal, 1, type: :bytes)
  field(:eth1_data, 2, type: Ethereum.Eth.V1alpha1.Eth1Data)
  field(:graffiti, 3, type: :bytes)
  field(:proposer_slashings, 4, repeated: true, type: Ethereum.Eth.V1alpha1.ProposerSlashing)
  field(:attester_slashings, 5, repeated: true, type: Ethereum.Eth.V1alpha1.AttesterSlashing)
  field(:attestations, 6, repeated: true, type: Ethereum.Eth.V1alpha1.Attestation)
  field(:deposits, 7, repeated: true, type: Ethereum.Eth.V1alpha1.Deposit)
  field(:voluntary_exits, 8, repeated: true, type: Ethereum.Eth.V1alpha1.SignedVoluntaryExit)
end

defmodule Ethereum.Eth.V1alpha1.ProposerSlashing do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          header_1: Ethereum.Eth.V1alpha1.SignedBeaconBlockHeader.t() | nil,
          header_2: Ethereum.Eth.V1alpha1.SignedBeaconBlockHeader.t() | nil
        }

  defstruct [:header_1, :header_2]

  field(:header_1, 2, type: Ethereum.Eth.V1alpha1.SignedBeaconBlockHeader)
  field(:header_2, 3, type: Ethereum.Eth.V1alpha1.SignedBeaconBlockHeader)
end

defmodule Ethereum.Eth.V1alpha1.AttesterSlashing do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          attestation_1: Ethereum.Eth.V1alpha1.IndexedAttestation.t() | nil,
          attestation_2: Ethereum.Eth.V1alpha1.IndexedAttestation.t() | nil
        }

  defstruct [:attestation_1, :attestation_2]

  field(:attestation_1, 1, type: Ethereum.Eth.V1alpha1.IndexedAttestation)
  field(:attestation_2, 2, type: Ethereum.Eth.V1alpha1.IndexedAttestation)
end

defmodule Ethereum.Eth.V1alpha1.Deposit.Data do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          public_key: binary,
          withdrawal_credentials: binary,
          amount: non_neg_integer,
          signature: binary
        }

  defstruct [:public_key, :withdrawal_credentials, :amount, :signature]

  field(:public_key, 1, type: :bytes)
  field(:withdrawal_credentials, 2, type: :bytes)
  field(:amount, 3, type: :uint64)
  field(:signature, 4, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.Deposit do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          proof: [binary],
          data: Ethereum.Eth.V1alpha1.Deposit.Data.t() | nil
        }

  defstruct [:proof, :data]

  field(:proof, 1, repeated: true, type: :bytes)
  field(:data, 2, type: Ethereum.Eth.V1alpha1.Deposit.Data)
end

defmodule Ethereum.Eth.V1alpha1.VoluntaryExit do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          epoch: non_neg_integer,
          validator_index: non_neg_integer
        }

  defstruct [:epoch, :validator_index]

  field(:epoch, 1, type: :uint64)
  field(:validator_index, 2, type: :uint64)
end

defmodule Ethereum.Eth.V1alpha1.SignedVoluntaryExit do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          exit: Ethereum.Eth.V1alpha1.VoluntaryExit.t() | nil,
          signature: binary
        }

  defstruct [:exit, :signature]

  field(:exit, 1, type: Ethereum.Eth.V1alpha1.VoluntaryExit)
  field(:signature, 2, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.Eth1Data do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          deposit_root: binary,
          deposit_count: non_neg_integer,
          block_hash: binary
        }

  defstruct [:deposit_root, :deposit_count, :block_hash]

  field(:deposit_root, 1, type: :bytes)
  field(:deposit_count, 2, type: :uint64)
  field(:block_hash, 3, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.BeaconBlockHeader do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          slot: non_neg_integer,
          proposer_index: non_neg_integer,
          parent_root: binary,
          state_root: binary,
          body_root: binary
        }

  defstruct [:slot, :proposer_index, :parent_root, :state_root, :body_root]

  field(:slot, 1, type: :uint64)
  field(:proposer_index, 2, type: :uint64)
  field(:parent_root, 3, type: :bytes)
  field(:state_root, 4, type: :bytes)
  field(:body_root, 5, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.SignedBeaconBlockHeader do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          header: Ethereum.Eth.V1alpha1.BeaconBlockHeader.t() | nil,
          signature: binary
        }

  defstruct [:header, :signature]

  field(:header, 1, type: Ethereum.Eth.V1alpha1.BeaconBlockHeader)
  field(:signature, 2, type: :bytes)
end

defmodule Ethereum.Eth.V1alpha1.IndexedAttestation do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          attesting_indices: [non_neg_integer],
          data: Ethereum.Eth.V1alpha1.AttestationData.t() | nil,
          signature: binary
        }

  defstruct [:attesting_indices, :data, :signature]

  field(:attesting_indices, 1, repeated: true, type: :uint64)
  field(:data, 2, type: Ethereum.Eth.V1alpha1.AttestationData)
  field(:signature, 3, type: :bytes)
end
