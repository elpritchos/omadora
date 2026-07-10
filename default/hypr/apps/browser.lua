-- Browser tags and styling
local function any_exact(patterns)
  return "^(" .. table.concat(patterns, "|") .. ")$"
end

local browser_patterns = {
  chromium_based = {
    "(google-)?[cC]hrom(e|ium)(-browser)?",
    "[bB]rave-browser",
    "[mM]icrosoft-edge",
    "[vV]ivaldi(-stable)?",
    "[hH]elium",
    "com\\.google\\.Chrome",
    "org\\.chromium\\.Chromium",
    "com\\.brave\\.Browser",
    "com\\.microsoft\\.Edge",
    "com\\.vivaldi\\.Vivaldi",
  },

  firefox_based = {
    "[fF]irefox",
    "[zZ]en",
    "[lL]ibre[Ww]olf",
    "org\\.mozilla\\.firefox",
    "app\\.zen_browser\\.zen",
    "io\\.gitlab\\.librewolf-community",
  },
}

for tag, patterns in pairs({
  ["+chromium-based-browser"] = browser_patterns.chromium_based,
  ["+firefox-based-browser"] = browser_patterns.firefox_based,
}) do
  o.window(any_exact(patterns), {
    tag = tag,
  })
end

o.window(
  { tag = "chromium-based-browser" },
  { tag = "-default-opacity", tile = true, opacity = "1.0 0.97" }
)
o.window({ tag = "firefox-based-browser" }, { tag = "-default-opacity", opacity = "1.0 0.97" })

-- Video apps: remove chromium browser tag so they don't get opacity applied.
o.window(
  "(chrome-youtube.com__-Default|chrome-app.zoom.us__wc_home-Default)",
  { tag = "-chromium-based-browser" }
)
o.window(
  "(chrome-youtube.com__-Default|chrome-app.zoom.us__wc_home-Default)",
  { tag = "-default-opacity" }
)

-- Hide screen sharing notification windows.
o.window({ title = ".*is sharing.*" }, { workspace = "special silent" })
