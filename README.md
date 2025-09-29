# Kotlin Language Server Flake

A Nix flake for easy installation of the official [Kotlin Language Server](https://github.com/Kotlin/kotlin-lsp).

## Quick Start

### Run directly
```bash
nix run github:ohaukeboe/kotlin-lsp-flake
```

## Use in Other Flakes

### NixOS Configuration
```nix
{
  inputs.kotlin-lsp.url = "github:ohaukeboe/kotlin-lsp-flake";

  outputs = { nixpkgs, kotlin-lsp, ... }: {
    nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
      modules = [{
        environment.systemPackages = [
          kotlin-lsp.packages.x86_64-linux.default
        ];
      }];
    };
  };
}
```

### Home Manager
```nix
{
  inputs.kotlin-lsp.url = "github:ohaukeboe/kotlin-lsp-flake";

  outputs = { home-manager, kotlin-lsp, ... }: {
    homeConfigurations.username = home-manager.lib.homeManagerConfiguration {
      modules = [{
        home.packages = [
          kotlin-lsp.packages.x86_64-linux.default
        ];
      }];
    };
  };
}
```

## Supported Systems
- `x86_64-linux`
- `aarch64-linux`
