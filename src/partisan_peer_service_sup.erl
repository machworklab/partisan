%% -------------------------------------------------------------------
%%
%% Copyright (c) 2016 Christopher Meiklejohn. All Rights Reserved.
%% Copyright (c) 2022 Alejandro M. Ramallo. All Rights Reserved.
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
-module(partisan_peer_service_sup).

-behaviour(supervisor).

-include("partisan_logger.hrl").
-include("partisan.hrl").


-define(CHILD(I, Type, Timeout),
        {I, {I, start_link, []}, permanent, Timeout, Type, [I]}).
-define(CHILD(I, Type), ?CHILD(I, Type, 5000)).

-export([start_link/0]).

-export([init/1]).


start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).


init([]) ->
    Manager = partisan_peer_service:manager(),

    Children = [
        ?CHILD(Manager, worker),
        ?CHILD(partisan_peer_service_events, worker),
        ?CHILD(partisan_monitor, worker)
    ],
    RestartStrategy = {rest_for_one, 10, 10},
    {ok, {RestartStrategy, Children}}.