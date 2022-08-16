-- MIT License
-- 
-- Copyright (c) 2022 JabDoesThings
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local ____lualib = require("lualib_bundle")
local __TS__StringReplaceAll = ____lualib.__TS__StringReplaceAll
local __TS__StringSplit = ____lualib.__TS__StringSplit

local SyncCallback = function()
    local o = {}
    o.callbacks = {}
    o.add = function(callback) table.insert(o.callbacks, callback) end
    o.tick = function()
        if #o.callbacks > 0 then
            for i = 1, #o.callbacks, 1 do o.callbacks[i]() end
            o.callbacks = {}
        end
    end
    Events.OnFETick.Add(o.tick)
    Events.OnTickEvenPaused.Add(o.tick)
    return o
end

---@param target string The target method fullpath
---@param hook function The hook function to apply to that method
local hookInto = function(target, hook)
  if type(target) ~= "string" then error("Hook 'target' param must be a string."); end
  if type(hook) ~= "function" then error("Hook 'hook' param must be a function."); end
  print(("Hooking into " .. target) .. "...")
  target = __TS__StringReplaceAll(target, ":", ".")
  local splits = __TS__StringSplit(target, ".")
  local original = _G[splits[1]]
  do
      local i = 1
      while i < #splits do
            if original and original[splits[i + 1]] then
                if i == #splits - 1 then
                    if type(original[splits[i + 1]]) ~= "function" then
                        error(("Invalid hook target '" .. target) .. "' is not a function!")
                    end
                    local originalFunc = original[splits[i + 1]]
                    original[splits[i + 1]] = function(____self, ...)
                        return hook(originalFunc, ____self, ...)
                    end
                    print("Hooked into " .. target)
                end
                original = original[splits[i + 1]]
            else
                error(("Invalid hook target '" .. target) .. "' is not found!")
            end
            i = i + 1
      end
  end
end

---@param target string The target object/method fullpath
local getGlobal = function(target)
    target = __TS__StringReplaceAll(target, ":", ".")
    local splits = __TS__StringSplit(target, ".")
    local original = _G[splits[1]]
    do
        local i = 1
        while i < #splits do
            if original and original[splits[i + 1]] then
                original = original[splits[i + 1]]
            else
                return original
            end
            i = i + 1
        end
    end
    return original
end

---@param module string The lua file to require
local requireLua = function(module)
    return require(module)
end

local Exports = {}
Exports.syncCallback = SyncCallback()
Exports.hookInto = hookInto
Exports.getGlobal = getGlobal
Exports.requireLua = requireLua
function Exports.isPipeWrenchLoaded() return _G.PIPEWRENCH_READY ~= nil end
return Exports
