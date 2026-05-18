{...}: {
  systemd.coredump.enable = false;
  # ➡️ Sets the kernel's resource limit (ulimit -c 0)
  security.pam.loginLimits = [
    {
      domain = "*"; # Applies to all users/sessions
      type = "-"; # Set both soft and hard limits
      item = "core"; # The soft/hard limit item
      value = "0"; # Core dumps size is limited to 0 (effectively disabled)
    }
  ];}
