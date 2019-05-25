_G._TEST = true

local util = require("util")
local rr, endpoints

local function reset_balancer()
    package.loaded["balancer.round_robin"] = nil
    rr = require("balancer.round_robin")
end

local function reset_endpoints()
    endpoints = {
        { address = "10.101.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.111.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.121.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.131.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.141.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.151.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.161.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.171.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.181.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.191.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.201.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.211.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.221.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.231.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.241.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
        { address = "10.251.1.1", port = "8080", maxFails = 0, failTimeout = 0 },
    }
end

describe("RoundRobin", function()
    before_each(function()
        reset_balancer()
        reset_endpoints()
    end)

    describe("shuffle_nodes()", function()
        it("should change the order of endpoints", function()
            local nodes = util.get_nodes(endpoints)
            local shuffled_nodes = rr:shuffle_nodes(nodes)
            assert.are_not.equal(nodes, shuffled_nodes)
        end)
    end)

end)

