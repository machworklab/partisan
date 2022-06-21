%% -------------------------------------------------------------------
%%
%% Copyright (c) 2016 Christopher Meiklejohn.  All Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

-module(partisan_peer_service_manager).
-author("Christopher S. Meiklejohn <christopher.meiklejohn@gmail.com>").

-include("partisan_logger.hrl").
-include("partisan.hrl").


-export([myself/0]).
-export([mynode/0]).


%% =============================================================================
%% BEHAVIOUR CALLBACKS
%% =============================================================================



-callback start_link() -> {ok, pid()} | ignore | {error, term()}.

-callback members() -> [node()]. %% TODO: Deprecate me.
-callback members_for_orchestration() -> [node_spec()].
-callback myself() -> node_spec().

-callback get_local_state() -> term().

-callback join(node_spec()) -> ok.
-callback sync_join(node_spec()) -> ok | {error, not_implemented}.
-callback leave() -> ok.
-callback leave(node_spec()) -> ok.

-callback update_members([node()]) -> ok | {error, not_implemented}.

-callback send_message(node(), message()) -> ok.

-callback receive_message(node(), message()) -> ok.

-callback cast_message(node(), pid(), message()) -> ok.
-callback cast_message(node(), channel(), pid(), message()) -> ok.
-callback cast_message(node(), channel(), pid(), message(), options()) -> ok.

-callback forward_message(
    partisan_remote_ref:p() | partisan_remote_ref:n() | pid() | atom(),
    message()) -> ok.
-callback forward_message(node(), pid(), message()) -> ok.
-callback forward_message(node(), channel(), pid(), message()) -> ok.
-callback forward_message(node(), channel(), pid(), message(), options()) -> ok.

-callback on_down(node(), function()) -> ok | {error, not_implemented}.

-callback on_up(node(), function()) -> ok | {error, not_implemented}.

-callback decode(term()) -> term().

-callback reserve(atom()) -> ok | {error, no_available_slots}.

-callback partitions() -> {ok, partitions()} | {error, not_implemented}.

-callback inject_partition(node_spec(), ttl()) ->
    {ok, reference()} | {error, not_implemented}.

-callback resolve_partition(reference()) -> ok | {error, not_implemented}.



%% =============================================================================
%% API
%% =============================================================================


%% @deprecated use partisan:node_spec/0 instead.
-spec myself() -> node_spec().

myself() ->
    partisan:node_spec().


%% @deprecated use partisan:node/0 instead.
-spec mynode() -> atom().

mynode() ->
    partisan:node().

