{ pkgs ? import <nixpkgs> { }
, pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

let
  baseImage = pkgs.dockerTools.pullImage {
    imageName = "alpine";
    imageDigest = "sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978";
    sha256 = "1krq8v5bpdsdvd3zisii1wr45zzp6q3b2wwhbq32inagb8alll87";
    finalImageName = "alpine";
    finalImageTag = "3.18";
  };
in

pkgs.dockerTools.buildImage {
  name = "sandbox-container";
  tag = "latest";
  fromImage = baseImage;
  contents = [ pkgs.nodejs ];
  config = {
    Cmd = [ "node" ];
  };
}
