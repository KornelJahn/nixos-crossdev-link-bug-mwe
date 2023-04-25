# Minimal Working Example for the "Invalid cross-device link" bug

When installing NixOS one may encounter a cryptic "Invalid cross-device link"
bug. This is a minimal working example flake for reproducing such a bug.

## Steps to reproduce

1. Boot a NixOS ISO image in a QEMU VM using BIOS boot and using a VirtIO virtual
   hard disk. Optionally set a password using `passwd` for the `nixos` user so
   the process can be continued over SSH.

2. Enter a Nix shell with Git and with the new Nix command syntax & Flakes
   enabled:

        NIX_CONFIG='experimental-features = nix-command flakes' nix-shell -p git

3. Clone this flake as

        git clone https://github.com/KornelJahn/nixos-crossdev-link-bug-mwe.git

4. Enter the repo directory as

        cd nixos-crossdev-link-bug-mwe

5. First, try to enter a Nix shell with the default package as

        nix shell .#

   It should fail with the following ShellCheck error:

   ```
   error: builder for '/nix/store/n7mkzq126vljwpvm5cy9kj9skzg8q47w-my-script.drv' failed with exit code 1;
       last 7 log lines:
       >
       > In /nix/store/d585g86virsxax1msalmx5z8wb0mvk81-my-script/bin/my-script line 7:
       > unused=
       > ^----^ SC2034 (warning): unused appears unused. Verify use (or export if used externally).
       >
       > For more information:
       >   https://www.shellcheck.net/wiki/SC2034 -- unused appears unused. Verify use...
       For full logs, run 'nix log /nix/store/n7mkzq126vljwpvm5cy9kj9skzg8q47w-my-script.drv'.
   ```

   This is what we expect: a meaningful error message.

6. Now try to install NixOS with the configuration named `nixos` (:warning: ALL
   DATA ON THE TARGET VIRTUAL HARD DISK WILL BE WIPED! :warning:):

        ./install.bash

   Toward the end of the process, it should also fail with the following error:

   ```
   ```

Note that correcting the error in the script results in a successful
installation.




