return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.5",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 16,
  tilewidth = 8,
  tileheight = 8,
  nextobjectid = 7,
  properties = {},
  tilesets = {
    {
      name = "woodInteriorTiles",
      firstgid = 1,
      filename = "../../res/maps/woodInteriorTiles.tsx",
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      image = "../../res/tiles/woodInteriorTiles.png",
      imagewidth = 80,
      imageheight = 64,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
      },
      properties = {},
      terrains = {},
      tilecount = 80,
      tiles = {
        {
          id = 10,
          properties = {
            ["solid"] = false
          }
        },
        {
          id = 11,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 12,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 13,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 14,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 15,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 16,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 17,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 20,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 27,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 30,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 37,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 40,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 41,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 42,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 43,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 44,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 45,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 46,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 47,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 50,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 51,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 52,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 53,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 54,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 55,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 56,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 57,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 60,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 61,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 62,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 63,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 64,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 65,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 66,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 67,
          properties = {
            ["solid"] = true
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Background",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        11, 16, 17, 16, 17, 16, 17, 16, 17, 16, 17, 16, 17, 16, 17, 18,
        21, 51, 52, 53, 54, 55, 56, 57, 52, 53, 54, 55, 56, 57, 58, 28,
        31, 61, 62, 63, 64, 65, 66, 67, 62, 63, 64, 65, 66, 67, 68, 38,
        21, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 38,
        31, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 28,
        21, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 38,
        31, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 28,
        21, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 38,
        31, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 28,
        21, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 38,
        31, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 28,
        21, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 38,
        31, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 72, 73, 28,
        31, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 71, 72, 38,
        41, 42, 43, 42, 43, 42, 43, 42, 43, 42, 43, 42, 43, 42, 43, 48,
        51, 52, 53, 54, 55, 56, 57, 58, 51, 52, 53, 54, 55, 56, 57, 58
      }
    },
    {
      type = "tilelayer",
      name = "Damage",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 70, 0, 0, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 70, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 69, 0, 79, 0, 79, 0, 0, 0, 0, 0, 0,
        0, 0, 80, 0, 69, 0, 0, 0, 0, 0, 0, 0, 0, 80, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 79, 0, 0, 49, 0, 0, 0, 49, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "Spawners",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 5,
          name = "Player",
          type = "",
          shape = "rectangle",
          x = 24,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
