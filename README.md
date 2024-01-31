## Bootstrapping a box

```
# Install Nix and re-login
sh <(curl -L https://nixos.org/nix/install) --daemon

# Setup Nix with Flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# Install profile
nix-shell -p home-manager
git clone https://github.com/mnaser/nix-config.git
home-manager switch --flake nix-config
usermod -s /home/ubuntu/.nix-profile/bin/zsh $USER
```

Voila!  You now have a fully configured environment.
