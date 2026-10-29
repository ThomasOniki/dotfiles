local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function prev(index)
  return f(function(args, _, _)
    return args[1]
  end, { index })
end

return {
  s("tp", t("template")),
  s("tsl", t("template <typename Self>")),

  s("dela", {
    i(1, "<class>"),
    t("("),
    prev(1),
    t(" const&) = delete"),
    prev(1),
    t("("),
    prev(1),
    t(" &&) = delete"),

    prev(1),
    t("& operator=(this "),
    prev(1),
    t("& self, "),
    prev(1),
    t(" const&) = delete"),
    prev(1),
    t("& operator=(this "),
    prev(1),
    t("& self, "),
    prev(1),
    t(" &&) = delete"),
  }),

  s("sc", {
    t("static_cast<"),
    i(1, "type"),
    t(">("),
    i(2, "expr"),
    t(")"),
  }),
}
