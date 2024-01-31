## Bootstrapping a box

```
sh <(curl -L https://nixos.org/nix/install) --daemon
# relogin

# Setup Nix with Flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# Install profile
nix-shell -p home-manager
git clone https://github.com/mnaser/nix-config.git
home-manager switch --flake nix-config
```
