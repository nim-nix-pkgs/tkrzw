{
  description = ''Wrapper of the Tkrzw key-value database library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-tkrzw-trunk.flake = false;
  inputs.src-tkrzw-trunk.ref   = "refs/heads/trunk";
  inputs.src-tkrzw-trunk.owner = "~ehmry";
  inputs.src-tkrzw-trunk.repo  = "nim-tkrzw";
  inputs.src-tkrzw-trunk.type  = "sourcehut";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-tkrzw-trunk"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-tkrzw-trunk";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}