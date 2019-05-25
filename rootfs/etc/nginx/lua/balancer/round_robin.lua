local balancer_resty = require("balancer.resty")
local resty_roundrobin = require("resty.roundrobin")
local util = require("util")

local _M = balancer_resty:new({ factory = resty_roundrobin, name = "round_robin" })

function _M.new(self, backend)
  -- TODO need to shuffle nodes here as it's passed to sync_backend
  local nodes = util.get_nodes(backend.endpoints)
  local shuffled = _M.shuffle_nodes(self, nodes)
  local o = {
    instance = self.factory:new(shuffled),
    traffic_shaping_policy = backend.trafficShapingPolicy,
    alternative_backends = backend.alternativeBackends,
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function _M.balance(self)
  return self.instance:find()
end

-- Fisher-Yates shuffle on table
-- https://gist.github.com/Uradamus/10323382#gistcomment-2754684
function _M.shuffle_nodes(self, nodes)
    local shuffled = {}
    for i = #nodes, 2, -1 do
        local j = math.random(i)
        shuffled[i], shuffled[j] = nodes[j], nodes[i]
    end
    return shuffled
end

return _M
