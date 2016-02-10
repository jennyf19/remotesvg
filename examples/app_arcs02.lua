#!/usr/bin/env luajit 

package.path = "../?.lua;"..package.path;

local SVGInteractor = require("remotesvg.SVGInteractor")
local SVGGeometry = require("remotesvg.SVGGeometry")


local svg = SVGGeometry.SVG;
local group = SVGGeometry.Group;
local rect = SVGGeometry.Rect;
local circle = SVGGeometry.Circle;
local defs = SVGGeometry.Definitions;
local ellipse = SVGGeometry.Ellipse;
local path = SVGGeometry.Path;
local text = SVGGeometry.Text;
local use = SVGGeometry.Use;

local width = 640;
local height = 480;
local ImageStream = size(width, height)


local function draw(ImageStream)
  ImageStream:reset();

  local doc = svg{
    xmlns="http://www.w3.org/2000/svg",
    ['xmlns:xlink'] = "http://www.w3.org/1999/xlink",
    width="12cm", 
    height="5.25cm", 
    viewBox="0 0 1200 525",

    group {
      ['font-family'] = "Verdana",
      
      defs {
        group {id="baseEllipses", ["font-size"]=20;
          ellipse {cx=125, cy=125, rx=100, ry=50, fill="none", stroke="#888888", ["stroke-width"] = 2};
          ellipse {cx=225, cy=75, rx=100, ry=50, fill="none", stroke="#888888", ["stroke-width"] = 2};
          text ({x=35, y=70}, "Arc start");
          text ({x=225, y=145}, "Arc end");
        };
      };

      rect {x=1, y=1, width=1198, height=523, fill="none", stroke="blue", ["stroke-width"] = 1};

      group {['font-size'] = 30,
        group {transform="translate(0,0)",
          use {["xlink:href"] = "#baseEllipses", ["xmlns:xlink"] ="http://www.w3.org/1999/xlink"};
        },

        group {transform="translate(400,0)",
          text ({x=50, y=210}, "large-arc-flag=0");
          text ({x=50, y=250}, "sweep-flag=0");
          use {["xlink:href"] = "#baseEllipses", ["xmlns:xlink"] = "http://www.w3.org/1999/xlink"},
          path {d="M 125,75 a100,50 0 0,0 100,50", fill="none", stroke="red", ["stroke-width"] = 6},
        },

        group {transform="translate(800,0)",
          text ({x=50, y=210}, "large-arc-flag=0");
          text ({x=50, y=250}, "sweep-flag=1");
          use {["xlink:href"]="#baseEllipses", ["xmlns:xlink"] = "http://www.w3.org/1999/xlink"};
          path {d="M 125,75 a100,50 0 0,1 100,50", fill="none", stroke="red", ["stroke-width"] = 6};
        },
        group {transform="translate(400,250)";
          text ({x=50, y=210}, "large-arc-flag=1");
          text ({x=50, y=250}, "sweep-flag=0");
          use {["xlink:href"] ="#baseEllipses", ["xmlns:xlink"] = "http://www.w3.org/1999/xlink"};
          path {d="M 125,75 a100,50 0 1,0 100,50", fill="none", stroke="red", ["stroke-width"] = 6};
        };
        group {transform="translate(800,250)";
          text ({x=50, y=210}, "large-arc-flag=1");
          text ({x=50, y=250}, "sweep-flag=1");
          use {["xlink:href"]="#baseEllipses", ["xmlns:xlink"] = "http://www.w3.org/1999/xlink"};
          path {d="M 125,75 a100,50 0 1,1 100,50", fill="none", stroke="red", ["stroke-width"] = 6};
        };
      };
    };
  };


  doc:write(ImageStream);
end

-- This is a one off
-- we won't be refreshing the image, so just draw
-- into the image stream once, and do NOT implement
-- the 'frame()' function.
draw(ImageStream);

run()