local original_ngx = ngx
local function reset_ngx()
  _G.ngx = original_ngx
end

local function mock_ngx(mock)
  local _ngx = mock
  setmetatable(_ngx, { __index = ngx })
  _G.ngx = _ngx
end

describe("lua_ngx_var", function()
  local util = require("util")

  before_each(function()
    mock_ngx({ var = { remote_addr = "192.168.1.1", [1] = "nginx/regexp/1/group/capturing" } })
  end)

  after_each(function()
    reset_ngx()
    package.loaded["monitor"] = nil
  end)

  it("returns value of nginx var by key", function()
    assert.equal("192.168.1.1", util.lua_ngx_var("$remote_addr"))
  end)

  it("returns value of nginx var when key is number", function()
    assert.equal("nginx/regexp/1/group/capturing", util.lua_ngx_var("$1"))
  end)

  it("returns nil when variable is not defined", function()
    assert.equal(nil, util.lua_ngx_var("$foo_bar"))
  end)
end)

describe("shuffle_nodes", function()
  local util = require("util")
  local endpoints = {
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
    }

  it("should change the order of endpoints", function()
    local nodes = util.get_nodes(endpoints)
    local shuffled = util.shuffle(nodes)
    assert(util.tablelength(shuffled)>0)
    assert.are_not.equal(nodes, shuffled)
  end)

end)
