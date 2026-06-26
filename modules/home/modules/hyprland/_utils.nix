{
  lib,
  ...
}:
rec {
  vimDirections = [
    {
      key = "h";
      direction = "l";
    }
    {
      key = "j";
      direction = "d";
    }
    {
      key = "k";
      direction = "u";
    }
    {
      key = "l";
      direction = "r";
    }
  ];

  arrowDirections = [
    {
      key = "LEFT";
      direction = "l";
    }
    {
      key = "DOWN";
      direction = "d";
    }
    {
      key = "UP";
      direction = "u";
    }
    {
      key = "RIGHT";
      direction = "r";
    }
  ];

  workspaces =
    (lib.range 1 10)
    |> (map (m: {
      key = lib.trivial.mod m 10;
      workspace = m;
    }));

  directions = vimDirections ++ arrowDirections;

  mkBind = dsp: key: args: {
    _args = [
      key
      (lib.generators.mkLuaInline "hl.dsp.${dsp}(${lib.generators.toLua { } args})")
    ];
  };

  mkBindFlags = dsp: key: args: flags: {
    _args = [
      key
      (lib.generators.mkLuaInline "hl.dsp.${dsp}(${lib.generators.toLua { } args})")
      (lib.generators.mkLuaInline (lib.generators.toLua { } flags))
    ];
  };

  addModifier = modifier: input: input // { key = "${modifier} + ${lib.toString input.key}"; };

}
