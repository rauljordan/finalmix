defmodule Ethereum.Eth.V1alpha1.PeerDirection do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3
  @type t :: integer | :UNKNOWN | :INBOUND | :OUTBOUND

  field :UNKNOWN, 0

  field :INBOUND, 1

  field :OUTBOUND, 2
end

defmodule Ethereum.Eth.V1alpha1.ConnectionState do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3
  @type t :: integer | :DISCONNECTED | :DISCONNECTING | :CONNECTED | :CONNECTING

  field :DISCONNECTED, 0

  field :DISCONNECTING, 1

  field :CONNECTED, 2

  field :CONNECTING, 3
end

defmodule Ethereum.Eth.V1alpha1.SyncStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          syncing: boolean
        }

  defstruct [:syncing]

  field :syncing, 1, type: :bool
end

defmodule Ethereum.Eth.V1alpha1.Genesis do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          genesis_time: Google.Protobuf.Timestamp.t() | nil,
          deposit_contract_address: binary,
          genesis_validators_root: binary
        }

  defstruct [:genesis_time, :deposit_contract_address, :genesis_validators_root]

  field :genesis_time, 1, type: Google.Protobuf.Timestamp
  field :deposit_contract_address, 2, type: :bytes
  field :genesis_validators_root, 3, type: :bytes
end

defmodule Ethereum.Eth.V1alpha1.Version do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          version: String.t(),
          metadata: String.t()
        }

  defstruct [:version, :metadata]

  field :version, 1, type: :string
  field :metadata, 2, type: :string
end

defmodule Ethereum.Eth.V1alpha1.ImplementedServices do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          services: [String.t()]
        }

  defstruct [:services]

  field :services, 1, repeated: true, type: :string
end

defmodule Ethereum.Eth.V1alpha1.PeerRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          peer_id: String.t()
        }

  defstruct [:peer_id]

  field :peer_id, 1, type: :string
end

defmodule Ethereum.Eth.V1alpha1.Peers do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          peers: [Ethereum.Eth.V1alpha1.Peer.t()]
        }

  defstruct [:peers]

  field :peers, 1, repeated: true, type: Ethereum.Eth.V1alpha1.Peer
end

defmodule Ethereum.Eth.V1alpha1.Peer do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          direction: Ethereum.Eth.V1alpha1.PeerDirection.t(),
          connection_state: Ethereum.Eth.V1alpha1.ConnectionState.t(),
          peer_id: String.t(),
          enr: String.t()
        }

  defstruct [:address, :direction, :connection_state, :peer_id, :enr]

  field :address, 1, type: :string
  field :direction, 2, type: Ethereum.Eth.V1alpha1.PeerDirection, enum: true
  field :connection_state, 3, type: Ethereum.Eth.V1alpha1.ConnectionState, enum: true
  field :peer_id, 4, type: :string
  field :enr, 5, type: :string
end

defmodule Ethereum.Eth.V1alpha1.HostData do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          addresses: [String.t()],
          peer_id: String.t(),
          enr: String.t()
        }

  defstruct [:addresses, :peer_id, :enr]

  field :addresses, 1, repeated: true, type: :string
  field :peer_id, 2, type: :string
  field :enr, 3, type: :string
end

defmodule Ethereum.Eth.V1alpha1.Node.Service do
  @moduledoc false
  use GRPC.Service, name: "ethereum.eth.v1alpha1.Node"

  rpc :GetSyncStatus, Google.Protobuf.Empty, Ethereum.Eth.V1alpha1.SyncStatus

  rpc :GetGenesis, Google.Protobuf.Empty, Ethereum.Eth.V1alpha1.Genesis

  rpc :GetVersion, Google.Protobuf.Empty, Ethereum.Eth.V1alpha1.Version

  rpc :ListImplementedServices, Google.Protobuf.Empty, Ethereum.Eth.V1alpha1.ImplementedServices

  rpc :GetHost, Google.Protobuf.Empty, Ethereum.Eth.V1alpha1.HostData

  rpc :GetPeer, Ethereum.Eth.V1alpha1.PeerRequest, Ethereum.Eth.V1alpha1.Peer

  rpc :ListPeers, Google.Protobuf.Empty, Ethereum.Eth.V1alpha1.Peers
end

defmodule Ethereum.Eth.V1alpha1.Node.Stub do
  @moduledoc false
  use GRPC.Stub, service: Ethereum.Eth.V1alpha1.Node.Service
end
