-- Shared helpers for Hyprland Lua configuration.

o = o or {}

local function shell_quote(value)
  return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

local function omadora_root()
  return os.getenv("OMADORA_PATH") or (os.getenv("HOME") .. "/.local/share/omadora")
end

local function valid_libexec_name(name)
  return name ~= ""
    and name ~= ".."
    and not name:match("^/")
    and not name:match("^%.%./")
    and not name:match("/%.%./")
    and not name:match("/%.%.$")
end

local function command_from(value, description)
  if type(value) ~= "table" then
    return value
  end

  if value.omadora then
    return "omadora-exec omadora-launch-" .. value.omadora
  elseif value.focus and value.launch then
    return o.launch_sole(value.focus, value.launch)
  elseif value.launch then
    return o.launch(value.launch)
  elseif value.webapp then
    if value.focus then
      return o.launch_webapp_sole(description, value.webapp)
    else
      return o.launch_webapp(value.webapp)
    end
  elseif value.tui then
    if value.focus then
      return "omadora-exec omadora-launch-or-focus-tui " .. shell_quote(value.tui)
    else
      return "omadora-exec omadora-launch-tui " .. shell_quote(value.tui)
    end
  end

  return value
end

function o.bind(keys, description, dispatcher, options)
  local opts = options or {}

  if description then
    opts.description = description
  end

  dispatcher = command_from(dispatcher, description)

  if type(dispatcher) == "string" then
    dispatcher = hl.dsp.exec_cmd(dispatcher)
  end

  hl.bind(keys, dispatcher, opts)
end

function o.launch(command)
  return "uwsm-app -- " .. command
end

function o.libexec(command)
  local script, args = tostring(command):match("^(%S+)%s*(.*)$")

  if not script or not valid_libexec_name(script) then
    error("invalid libexec script name: " .. tostring(script or command))
  end

  local path = omadora_root() .. "/libexec/" .. script
  return shell_quote(path) .. (args ~= "" and (" " .. args) or "")
end

function o.exec_on_start(command)
  hl.on("hyprland.start", function()
    hl.exec_cmd(command)
  end)
end

function o.launch_on_start(command)
  o.exec_on_start(o.launch(command))
end

function o.launch_webapp(url)
  return "omadora-exec omadora-launch-webapp " .. shell_quote(url)
end

function o.launch_webapp_sole(name, url)
  return "omadora-exec omadora-launch-or-focus-webapp "
    .. shell_quote(name)
    .. " "
    .. shell_quote(url)
end

function o.launch_sole(match, command)
  return "omadora-exec omadora-launch-or-focus "
    .. shell_quote(match)
    .. " "
    .. shell_quote(o.launch(command))
end

function o.bind_menu(keys, description, menu, options)
  o.bind(
    keys,
    description,
    menu and ("omaodra-exec omadora-menu " .. menu) or "omadora-exec omadora-menu",
    options
  )
end

function o.bind_toggle(keys, description, toggle, options)
  o.bind(keys, description, "omadora-exec omadora-toggle-" .. toggle, options)
end

function o.notify(message)
  return "notify-send -u low " .. shell_quote(message)
end

function o.window(match, rules)
  rules.match = rules.match or {}

  if type(match) == "string" then
    rules.match.class = match
  else
    for key, value in pairs(match) do
      rules.match[key] = value
    end
  end

  hl.window_rule(rules)
end
