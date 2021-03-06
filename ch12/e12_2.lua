--[[
Modify the code in Listing 12.2 so that it uses the syntax ["key"] = value as suggested in Section 12.2.
]]

function serialize(o, indent)
  local function aux(o, indent)
    indent = indent or ""

    if type(o) == "number" then
      io.write(o)
    elseif type(o) == "string" then
      io.write(string.format("%q", o))
    elseif type(o) == "table" then
      io.write("{\n")

      for k, v in pairs(o) do
        io.write(indent .. "  ["); aux(k); io.write("] = ")

        aux(v, indent .. "  ")
        io.write(",\n")
      end

      io.write(indent .. "}")
    else
      error("cannot serialize a " .. type(o))
    end
  end

  --[[
  The original version didn't properly add a newline after numbers or strings.  This change ensures that we always end with a newline and don't put the ',' on a newline for nested tables.
  ]]
  aux(o, indent)
  io.write("\n")
end

serialize{a = 1, ["1b"] = 2, c = 3, ["for"] = 4, [5] = 5}
--[[
{
  ["c"] = 3,
  ["1b"] = 2,
  [5] = 5,
  ["a"] = 1,
  ["for"] = 4,
}
]]
