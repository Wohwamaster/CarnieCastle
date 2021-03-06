pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
--[[
player=0
enemies=0's and 100's
walls=200's
hazards=400's
items=500's
doors=700's
stairs=800's
bosses = 900's
]]

--temp boolean for win screen
win=false
--global directions
north=0
east=1
south=3
west=2

--variable used to simulate turn based movement
pturn=true

initialfloor=2
initialroom=8
initialx=9
initialy=3
initialdirection=0.25
--directions:
--left:0.25
--rigth:0.75
--up:0
--down:0.50

--used to skip enemy animations
skipanim=false


truefloor={
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025",
	"025,025,025,025,025,025,025,025,025,025,025,025,025,025,025,025"
}
--rooms

--generic room
--[[
{--roomx
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210"
}
]]

gameboard={
	{--floor1
		{--room1
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,211,nil,211,nil,212,212,212,212,210,210,210,210,210,210",
		"210,nil,nil,nil,010,nil,nil,nil,nil,nil,210,210,210,210,210,210",
		"712,nil,nil,010,nil,nil,nil,nil,nil,nil,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,nil,nil,nil,nil,210",
		"210,210,210,210,210,210,210,210,210,210,210,nil,nil,nil,nil,210",
		"210,210,210,210,210,210,210,210,210,210,210,nil,nil,nil,nil,210",
		"210,210,nil,nil,210,210,210,210,210,210,210,nil,nil,nil,nil,210",
		"210,210,nil,nil,210,210,210,210,210,210,210,nil,nil,nil,nil,210",
		"210,210,nil,nil,720,210,210,210,210,210,210,nil,nil,501,nil,210",
		"210,210,nil,nil,210,210,210,210,210,210,210,nil,nil,nil,nil,210",
		"210,210,nil,nil,210,210,210,210,210,210,210,nil,nil,nil,nil,210",
		"210,210,nil,nil,210,210,210,210,210,210,210,210,nil,nil,nil,210",
		"210,210,nil,nil,210,210,210,210,210,210,210,210,nil,nil,210,210",
		"210,210,715,210,210,210,210,210,210,210,210,210,210,715,210,210"
		},
		{--room2
		"210,210,210,210,210,210,210,210,821,210,210,210,210,210,210,210",
		"210,nil,210,nil,010,nil,210,nil,nil,nil,210,nil,nil,nil,210,210",
		"210,nil,nil,nil,210,nil,010,nil,210,nil,nil,nil,210,nil,nil,210",
		"210,nil,210,nil,010,nil,210,nil,nil,nil,210,nil,nil,nil,nil,711",
		"210,nil,nil,nil,210,nil,010,nil,210,nil,nil,nil,210,nil,nil,210",
		"210,nil,210,nil,010,nil,210,nil,nil,nil,210,nil,nil,nil,210,210",
		"210,nil,nil,nil,210,nil,010,nil,210,nil,nil,nil,210,nil,nil,210",
		"713,nil,210,nil,010,nil,210,nil,nil,nil,210,nil,nil,nil,210,210",
		"210,nil,nil,nil,210,nil,010,nil,210,nil,nil,nil,210,nil,nil,210",
		"210,nil,210,nil,010,nil,210,nil,nil,nil,210,nil,nil,nil,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
  "210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
  "210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,210,210,210,210,210,210,210,714,210,210,210,210,210,210,210"
		},
	 	{--room3
	 	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	 	"210,210,210,010,210,210,nil,nil,nil,210,210,210,210,210,nil,210",
	 	"210,210,210,nil,210,210,nil,210,nil,210,210,210,210,210,nil,210",
	 	"210,210,210,nil,210,210,nil,210,nil,210,210,210,210,210,nil,210",
	 	"210,210,210,nil,210,210,nil,210,nil,210,210,210,210,210,nil,210",
	 	"210,210,210,nil,210,nil,nil,210,nil,210,210,210,210,210,nil,210",
	 	"210,210,210,nil,nil,nil,210,210,nil,210,210,210,210,210,nil,210",
	 	"210,210,210,nil,210,210,210,210,nil,210,210,210,210,210,nil,712",
	 	"210,210,210,nil,210,210,210,210,nil,210,210,210,210,210,nil,210",
	 	"210,210,210,nil,210,210,210,210,nil,210,210,210,210,210,nil,210",
	 	"210,210,210,nil,210,210,210,210,nil,210,210,210,210,210,nil,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,nil,210",
	 	"210,nil,021,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
	 	"210,nil,210,210,210,210,210,210,210,210,210,210,210,210,nil,210",
	 	"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
	 	"210,210,210,210,210,210,210,716,210,210,210,210,210,210,210,210"
	  },
	  {--room4
	 	"210,210,210,210,210,210,210,210,712,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
		 "210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
		 "210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,nil,nil,nil,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,nil,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,nil,210,210,210,210",
	 	"210,nil,020,nil,nil,nil,nil,nil,nil,210,nil,nil,210,210,210,210",
	 	"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,717,210,210,210,210,210,210,210"
	  },
	  {--room5
	 	"210,210,711,210,210,210,210,210,210,210,210,210,210,711,210,210",
	 	"210,nil,nil,nil,nil,nil,nil,nil,010,nil,nil,nil,nil,nil,nil,210",
	 	"210,nil,nil,nil,nil,nil,nil,nil,010,nil,nil,nil,nil,nil,nil,210",
	 	"210,nil,nil,nil,nil,nil,nil,nil,010,nil,nil,nil,nil,nil,nil,210",
	 	"210,nil,nil,nil,nil,210,210,210,210,210,210,210,210,210,nil,210",
	 	"210,nil,nil,nil,nil,210,210,210,210,210,210,210,210,210,nil,210",
		 "210,nil,nil,nil,nil,210,210,210,210,210,210,210,210,210,nil,210",
	 	"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,010,022,nil,210",
	 	"210,nil,nil,nil,nil,210,210,210,210,210,210,210,210,210,nil,210",
	 	"210,nil,nil,nil,nil,210,210,210,210,210,210,210,210,210,nil,210",
	 	"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,010,022,nil,210",
	 	"210,nil,nil,nil,nil,210,210,210,210,210,210,210,210,210,nil,210",
	 	"210,nil,nil,nil,nil,210,210,210,210,210,210,210,210,210,nil,210",
	 	"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,010,022,nil,210",
	 	"210,nil,nil,nil,nil,210,210,210,210,210,210,210,210,210,210,210",
	 	"210,210,210,718,210,210,210,210,210,210,210,210,210,210,210,210"
		},
		{--room6
		"210,210,210,210,210,210,210,713,210,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,nil,nil,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,nil,nil,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,nil,nil,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,nil,nil,210,210,210,210,210,210,210",
		"210,nil,nil,010,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,210,210,210,210,210,210,nil,nil,210,210,210,210,210,nil,210",
		"210,210,210,210,210,210,210,nil,nil,210,210,210,210,210,nil,210",
		"210,210,210,210,210,210,210,nil,nil,210,210,210,210,210,nil,210",
		"210,210,210,210,210,210,210,nil,nil,210,210,210,210,210,nil,210",
		"210,210,210,210,210,210,210,nil,nil,210,210,210,210,210,nil,210",
		"210,210,210,210,210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,210,210,210,210,210,210,020,nil,210,210,210,210,nil,210,210",
		"210,210,210,210,210,210,210,nil,501,210,210,210,210,nil,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,010,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210"
		},
		{--room7
		"210,210,210,210,210,210,210,210,714,210,210,210,210,210,210,210",
	 	"210,210,210,210,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,021,nil,nil,nil,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
	 	"210,210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,020,718",
	 	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
	 	"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210"
		},
		{--room8
		"210,210,210,715,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,022,nil,210,210,210",
		"210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210,210,210",
		"210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210,210,210",
		"210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"717,nil,nil,nil,nil,nil,nil,nil,nil,nil,010,022,nil,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210"
		},
		{--specialroom
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"210,nil,210,nil,nil,nil,nil,nil,510,nil,nil,nil,nil,210,210,210",
		"210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"711,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210",
		"210,nil,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210"
		}
	},
	{--floor2
		{--room1
		"210,210,210,210,210,210,210,210,717,210,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,031,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,210,nil,nil,nil,210,nil,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,210,nil,nil,nil,210,nil,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,210,nil,nil,nil,210,nil,nil,210,nil,210,nil,210",
		"712,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210,nil,210",
		"210,nil,nil,nil,210,nil,nil,nil,210,nil,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,210,nil,nil,nil,210,nil,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,210,nil,nil,nil,210,nil,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,nil,nil,032,nil,nil,nil,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,202,210",
		"210,210,210,210,210,210,210,210,714,210,210,210,210,210,210,210"
		},
		{--room2
		"210,210,210,210,210,210,210,210,718,210,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
		"210,nil,210,210,210,210,210,210,nil,210,210,210,210,210,nil,210",
		"210,nil,210,nil,nil,nil,nil,nil,nil,nil,031,nil,nil,210,nil,210",
		"210,nil,210,nil,210,210,210,210,210,210,210,210,nil,210,nil,210",
		"210,nil,210,030,210,210,210,210,210,210,210,210,nil,210,nil,210",
		"210,nil,210,nil,210,210,210,210,210,210,210,210,nil,210,nil,210",
		"713,nil,nil,nil,210,210,nil,nil,nil,nil,210,210,nil,nil,nil,711",
		"210,nil,210,nil,210,210,210,210,210,210,210,210,nil,210,nil,210",
		"210,nil,210,nil,210,210,210,210,210,210,210,210,nil,210,nil,210",
		"210,nil,210,nil,210,210,210,210,210,210,210,210,033,210,nil,210",
		"210,nil,210,nil,210,210,210,210,210,210,210,210,nil,210,nil,210",
		"210,nil,210,nil,nil,032,nil,nil,nil,nil,nil,nil,nil,210,nil,210",
		"210,nil,210,210,210,210,210,210,nil,210,210,210,210,210,nil,210",
		"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
		"210,210,210,210,210,210,210,210,715,210,210,210,210,210,210,210"
		},
	 	{--room3
"210,210,210,210,210,210,210,210,719,210,210,210,210,210,210,210",
"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,nil,nil,210,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,021,nil,nil,nil,nil,210,nil,210,210,210,210,210,210,210",
"210,nil,021,nil,nil,nil,nil,nil,032,nil,nil,nil,nil,nil,nil,712",
"210,nil,021,nil,nil,nil,210,210,nil,210,210,210,210,210,210,210",
"210,nil,021,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,nil,nil,210,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,nil,nil,nil,nil,nil,nil,210,nil,210,nil,nil,nil,nil,nil,210",
"210,210,210,210,210,210,210,210,716,210,210,210,210,210,210,210"
},
	  {--room4
		"210,210,210,210,210,210,210,210,711,210,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,032,022,210,210,210,210,210,210",
		"210,210,nil,nil,210,020,020,020,020,210,210,210,210,210,210,210",
		"210,nil,nil,nil,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,nil,nil,210,210,210,210,210,210,210,210,210,210,210,210",
		"715,nil,nil,nil,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,nil,nil,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,nil,nil,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,nil,nil,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,210,nil,nil,210,023,023,023,023,210,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,031,022,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210"
	  },
	  {--room5
		"210,210,210,210,210,210,210,210,712,210,210,210,210,210,210,210",
		"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
		"210,210,210,210,210,031,nil,nil,nil,nil,nil,nil,210,210,210,210",
		"210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
		"210,210,033,210,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210,210",
		"210,210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210,210",
		"210,210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210,210",
		"716,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,714",
		"210,210,nil,210,nil,nil,nil,040,nil,nil,nil,nil,210,nil,210,210",
		"210,210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,210,nil,210,210",
		"210,210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,210,030,210,210",
		"210,210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210,210",
		"210,210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210,210",
		"210,210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210,210",
		"210,210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,210,210,210,210",
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210"
		},
		{--room 6
			"210,210,210,210,210,210,210,210,713,210,210,210,210,210,210,210",
 	 "210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
	  "210,210,210,210,210,210,210,210,nil,210,210,210,210,210,210,210",
 	 "210,210,031,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
 	 "210,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
 	 "210,210,031,nil,nil,nil,010,nil,010,nil,nil,nil,nil,nil,nil,210",
 	 "210,210,nil,nil,210,210,210,nil,210,nil,210,nil,210,nil,nil,210",
 	 "210,210,031,nil,nil,nil,nil,010,nil,nil,nil,010,nil,nil,nil,715",
 	 "210,210,nil,nil,210,nil,210,nil,210,nil,210,nil,210,nil,210,210",
 	 "210,210,210,020,nil,nil,210,501,210,nil,nil,nil,210,020,210,210",
 	 "210,210,210,nil,210,210,210,210,210,210,210,210,210,nil,210,210",
 	 "210,210,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210,210",
 	 "210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
 	 "210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
 	 "210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
 	 "210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210"
		},
		{--room7
		"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,nil,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,nil,210,nil,nil,nil,nil,nil,nil,031,nil,nil,210,210,210",
		"210,nil,nil,210,nil,210,210,210,210,210,210,210,nil,210,210,210",
		"210,nil,nil,210,nil,210,010,010,010,010,010,210,nil,210,210,210",
		"210,nil,nil,210,nil,210,010,010,010,010,010,nil,nil,210,210,210",
		"210,nil,nil,210,030,210,010,010,010,010,010,210,033,210,210,210",
		"718,nil,nil,nil,nil,210,210,210,210,210,210,210,nil,210,210,210",
		"210,nil,nil,210,nil,nil,nil,nil,032,nil,nil,nil,nil,210,210,210",
		"210,nil,nil,210,210,210,210,210,210,210,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,210,210,210,210,210,210,210,711,210,210,210,210,210,210,210"
		},
		{--room8
		"210,210,210,210,210,210,210,210,831,210,210,210,210,210,210,210",
		"210,nil,nil,nil,nil,nil,nil,031,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,033,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"719,nil,nil,nil,nil,nil,nil,040,nil,nil,nil,nil,nil,nil,nil,717",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,030,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,nil,nil,nil,032,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
		"210,210,210,210,210,210,210,210,712,210,210,210,210,210,210,210"
		},
		{--room9
"210,210,210,210,210,210,210,210,210,210,210,210,210,210,210,210",
"210,210,210,210,040,nil,nil,210,210,210,210,210,210,210,210,210",
"210,210,nil,nil,nil,nil,nil,210,210,210,210,210,210,210,210,210",
"210,nil,nil,210,210,nil,nil,210,210,210,210,210,210,210,210,210",
"210,nil,210,210,210,nil,nil,210,nil,nil,nil,210,210,210,210,210",
"210,nil,210,nil,nil,nil,nil,031,nil,210,nil,210,210,210,210,210",
"210,nil,210,nil,210,nil,nil,210,nil,210,nil,210,210,210,210,210",
"210,nil,210,nil,210,nil,nil,210,nil,210,nil,210,210,210,nil,718",
"210,nil,210,nil,210,nil,nil,210,nil,210,nil,210,210,210,nil,210",
"210,nil,210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
"210,nil,210,210,210,nil,nil,210,210,210,210,210,210,210,nil,210",
"210,nil,210,210,210,020,nil,210,210,210,210,210,210,210,nil,210",
"210,nil,nil,nil,nil,nil,501,210,210,210,210,210,210,210,nil,210",
"210,210,210,210,210,210,210,210,210,210,210,210,210,210,nil,210",
"210,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,210",
"210,210,210,210,210,210,210,210,713,210,210,210,210,210,210,210"
}
	}
}

flags={
	{--floor1
		{--room1
			key=1,
			tutorial=1,
		},
		{--room2
			key=0,
			tutorial=0,
		},
		{--room3
			key=0,
			tutorial=0,
		},
		{--room4
			key=0,
			tutorial=0,
		},
		{--room5
			key=0,
			tutorial=0,
		},
		{--room6
			key=1,
			tutorial=0,
		},
		{--room7
			key=0,
			tutorial=0,
		},
		{--room8
			key=0,
			tutorial=0,
		},
		{--specialroom
			key=0,
			tutorial=0,
		}
	},
	{--floor2
		{--room1
			key=0,
			tutorial=1,
		},
		{--room2
			key=0,
			tutorial=0,
		},
		{--room3
			key=0,
			tutorial=0,
		},
		{--room4
			key=0,
			tutorial=0,
		},
		{--room5
			key=0,
			tutorial=0,
		},
		{--room6
			key=0, --key here
			tutorial=0,
		},
		{--room7
			key=0,
			tutorial=0,
		},
		{--room8
			key=0,
			tutorial=0,
		},
		{--room9
			key=0, --key here
			tutorial=0,
		}
	}
}
--dialogue
dialoguetf=true --boolean variable for dialogue
dialogue={
	--27 characters (including spaces) currently fit on one line.
	t_dialogue={ --tutorial level dialogue
		"\"finally made it inside\nthe castle...!\"",
		"\"third stall from the left;\njust as i remembered.\"",
		"\"i need to get out of the\ndungeon and make my way\nto the throne room!\"",
		"use the arrow keys to move.",
		"hold x and press\n � or � to turn.",
		"Ë turns you clockwise,\nand � turns you\ncounterclockwise.",
		"touching enemies with your\nsword will kill them.",
		"stuck? press \"tab\" to reset\nthe current room.",
		"plan your movements, and\nyou shall succeed.\ngood luck!"
		},
	doors={ --dialogue for interacting with doors
		"\"i don't need to go back\nthere...\"",
		"\"this door won't open\nwithout all the keys.\"",
		"\"i shouldn't leave any\ncarnies alive.\"",
	},
	enemies={
		--lesserclown intro
		"\"it seems like these lesser\nclowns will walk into my\nsword...\"",
		"\"maybe i can use that\nto my advantage.\"",
		--juggler intro
		"\"uh-oh, a juggler. i better\nstay out of his line\nof sight.\"",
		"jugglers will kill you with\na ball if you enter their\ndirect line of sight.",
		"each jugglers line of sight\nis shown by the white\narrow on their body.",
		--firestarters intro
		"\"those people setting fires\nlook familiar...oh no!\nthey're my families\"",
		"\"servants! they must be\nunder the carnies control.\ni better not hurt them.\"",
		"firestarters leave a trail\nof fire behind them as\nthey move across a room",
		"in a straight line, turning\nright when they hit an\nobstacle.",
		"a firestarters current\ndirection is shown by the\nwhite line on its body.",
		"firestarters cannot be\nkilled, but do not stop\nyou from leaving rooms.",
		"arrows won't hurt\nfirestarters, and are\nburned when shot at fire",
		--clown car
		"\"a clown car! i better\ndestory it before a bunch\nof clowns get out.\"",
		"clown cars will run from\nyou if you get too close and\nspawn lesser clowns every 10 turns.",
		"the clown cars color scheme will\nflash the turn before spawning\na set of lesser clowns."
	},
	misc={
		--arrow explanation
		"\"an arrow! this will come\nin handy with killing\nenemies!\"",
		"press s�to fire an arrow\nin the direction you are\nfacing.",
		"your number of arrows are\ndisplayed in the top left\ncorner of the screen.",
	}
}

--table for player containing direction and sprite
--"0" corresponds to player in gb matrix
player={
	direct =.25,
	x = 9,
	y = 3,
	savedx=9,
	savedy=3,
	saveddirect=.25,
	arrows=1,
	savedarrows=0
}

sword = {
	x = 8,
	y = 14
}

--animation
lclownwalk = {33, 32, 34, 32,33, 32, 34, 32}
jugglerwalk = {49, 50, 51, 52, 53, 54, 55, 48}
jugglerprojectile = 56
fwalk = {37, 38, 39, 36, 37, 38, 39, 36}
clowncarmove={179,179,179,179,179,179,179,179}

--sprite rotation function
--written by mimick on https://www.lexaloffle.com/bbs/?tid=2592
function spra(angle,n,x,y,w,h,flip_x,flip_y)
 w=w*8
 h=h*8
 local diag,w,h=flr(sqrt(w*w+h*h))/2,w/2,h/2
 flip_x,flip_y=flip_x and -1 or 1,flip_y and -1 or 1
 local cosa,sina,nx,ny=cos(angle),sin(angle),n%16*8,flr(n/16)*8
 for i=-diag,diag do
  for j=-diag,diag do
   local ox,oy=(cosa*i + sina*j),(cosa*j - sina*i)
   if ox==mid(-w,ox,w) and oy==mid(-h,oy,h) then
    local col=sget(ox+w+nx,oy+h+ny)
    if col!=0 then
     pset(x+flip_x*i+w,y+flip_y*j+h,col)
    end
   end
  end
 end
end

function playermovement()
		--move player
		for i=1,16 do --iterate through gb to find player
			for j=1,16 do
				if gb[i][j]==0 then
					--shoot arrow
						if btn(0,1) and player.arrows>0 then
							arrowshoot(player.x,player.y,player.direct)
							pturn=false
							break
						elseif btn(3,1) then
							break
						end

					if btn(5) then
						--sword turning
						if btn(0) then
							playeranimate(player.direct+.125,1)
							pturn=false
							sworddirection()
							break
						end
						--sword turning
						if btn(1) then
							playeranimate(player.direct-.125,-1)
							pturn=false
							sworddirection()
							break
						end
					end

					--cardinal player movement
					if (btnp(0) or btnp(1) or btnp(2) or btnp(3)) then
						if btnp(0) then --left
							xmove=-1
							ymove=0
						elseif btnp(1) then --right
							xmove=1
							ymove=0
						elseif btnp(2) then --up
							xmove=0
							ymove=-1
						elseif btnp(3) then --down
							xmove=0
							ymove=1
						end
						if flr(gb[i+xmove][j+ymove]/100)!=2 then
								--move player 1 space
							if gb[i+xmove][j+ymove]!=-1 and ((gb[i+xmove][j+ymove]>=10 and gb[i+xmove][j+ymove]<100) or (gb[i+xmove][j+ymove]>=400 and gb[i+xmove][j+ymove]<500)) then
									gb[i][j]=-1
							elseif gb[i+xmove][j+ymove]!=-1 and gb[i+xmove][j+ymove] > 700 and gb[i+xmove][j+ymove] < 800 then --door interaction
								if not checkforenemies() then
									if flr((gb[i+xmove][j+ymove]-700)/10)==1 then
										nextroom=gb[i+xmove][j+ymove]%10
									elseif flr((gb[i+xmove][j+ymove]-700)/10)==2 then
										nextroom=#gameboard[currentfloor]
									end
									screentransition(currentfloor,currentroom,nextroom)--flr((gb[i+xmove][j+ymove]-700)/10)
									if xmove==-1 then
										player.x=15
										player.direct=.25
										gb[player.x][player.y]=0
									elseif xmove==1 then
										player.x=2
										player.direct=.75
										gb[player.x][player.y]=0
									elseif ymove==-1 then
										player.y=15
										player.direct=0
										gb[player.x][player.y]=0
									elseif ymove==1 then
										player.y=2
										player.direct=.5
										gb[player.x][player.y]=0
									end
										--saves player x and y for reboot
										player.savedx=player.x
										player.savedy=player.y
										player.saveddirect=player.direct
										player.savedarrows=player.arrows

										return
								else
									--plays dialogue if player tries to go through a door
									--without killing all enemies
									load_dialogue(dialogue.doors,3,3)
									pturn=true
									return
								end
							--interacting with key doors
							elseif gb[i+xmove][j+ymove]!=-1 and gb[i+xmove][j+ymove] > 800 and gb[i+xmove][j+ymove] < 900 then --door interaction
								if allkeyscollected() then
									nextfloor=flr((gb[i+xmove][j+ymove]-800)/10)
									
									if nextfloor==2 then
										floortransition(currentfloor,currentroom,nextfloor)
										player.x=15
										player.y=15
										player.direct=0
										gb[player.x][player.y]=0
									elseif nextfloor==3 then
										win=true
										player.x=2
										player.y=15
										player.direct=0.75
										gb[player.x][player.y]=0
									end
									--saves player x,y,direction for reloading rooms
									player.savedx=player.x
									player.savedy=player.y
									player.saveddirect=player.direct

									return
								else
									load_dialogue(dialogue.doors,2,2)
									return
								end
							else
								--picking up keys
								if gb[i+xmove][j+ymove]==501 then --picking up keys
								 sfx(62)
									flags[currentfloor][currentroom].key-=1
								--picking up arrows
								elseif gb[i+xmove][j+ymove]==510 then --picking up arrows
									if arrowdflag==nil then
										load_dialogue(dialogue.misc,1,3)
										arrowdflag=true
									end
									player.arrows+=1
									flags[currentfloor][currentroom].arrow-=1
								end
							 gb[i+xmove][j+ymove]=0
								gb[i][j]=-1
								player.x+=xmove
								player.y+=ymove
								sword.x+=xmove
								sword.y+=ymove
							end

						end
						pturn=false

						sworddirection()
						--breaks loop if the player is found
						return
					end
				end
			end
		end
end

function floortransition(prevfloor,prevroom,nextfloor)
	currentfloor=nextfloor
	screentransition(prevfloor,prevroom,1)
end

--fires arrow from player
--can only shoot up,down,left,right
function arrowshoot(i, j, direction)
		--if in boss room
		if currentfloor==4 then
			load_dialogue(dialogue.misc,4,4)
			return
		end
		
		--set
		if direction == 0 then
			a = 0
			b = -1
			j=player.y-1
			sp=4
		elseif abs(direction)==.5 then
			a = 0
			b = 1
			j=player.y+1
			sp=20
		elseif direction ==.25 or direction==-.75 then
			a = -1
			b = 0
			i=player.x-1
			sp=3
		elseif direction ==.75 or direction==-.25 then
			a = 1
			b = 0
			i=player.x+1
			sp=19
		else
			return
		end
		k = 0
	 player.arrows-=1

		while(player.x*8 != i*8+a*k or player.y*8 != j*8+b*k) do
			k +=2 --controls "speed" of arrow

			x = i*8+a*k-5
			y = j*8+b*k-5

			if gb[flr(x/8)+1][flr(y/8)+1]>=200 then
				return
			end
			--floor
			drawfloor(flr(x/8),flr(y/8),0,0)
			--entity to be killed
			entity = gb[flr(x/8)+1][flr(y/8)+1]

			--if entity is an enemy, kill that enemy
			if flr(entity)>=10 and flr(entity)<100 and not (flr(entity)>=30 and flr(entity)<40) then
				gb[flr(x/8)+1][flr(y/8)+1]=-1
				return
			end

			--player
			spra(player.direct,1,player.x*8-8,player.y*8-12,1,2)

			--cover your tracks
			if (x)%8>=0 and x%8<=7 and (y)%8>=0 and y%8<=7 then
				--floor
				drawfloor(flr((x-a*8)/8)+1,flr((y-b*8)/8)+1)
				--player
				spra(player.direct,1,player.x*8-8,player.y*8-12,1,2)
			end
			--projectile
			if gb[flr(x/8)+1][flr(y/8)+1]>=200 then
				return
			else
				spr(sp, x-3, y-3)
			end
			wait(1)
		end
end

--animates player while turning
function playeranimate(rotateaf,sign)
	angle=0.03125*sign --angle to rotate player by per iteration
	while player.direct<rotateaf or player.direct>rotateaf do
		player.direct+=angle
		
		--drawing everything to screen during rotation
		for i=player.x-1,player.x+1 do
			for j=player.y-1,player.y+1 do
				--floor first
				drawfloor(i,j)
				--enemy things
			if(not(gb[i][j] == -1) and gb[i][j] > 0 and gb[i][j] < 100) then
					if gb[i][j]<20 then
						spr(32,(i-1)*8,(j-1)*8)
					elseif gb[i][j] < 30 then
						spr(60+gb[i][j]%10, i*8-8, j*8-8)
						spr(48,(i-1)*8,(j-1)*8)
					elseif gb[i][j]<40 then
						spr(60+gb[i][j]%10, i*8-8, j*8-8)
				  spr(36,(i-1)*8,(j-1)*8)
					elseif gb[i][j] < 50 then
						spr(179,(i-1)*8,(j-1)*8)
					end

				--wall things
				elseif gb[i][j]==210 then --200=wall
					drawwall(i,j)
				elseif gb[i][j]==211 then
					spr(7, i*8-8, j*8-8)
				elseif gb[i][j]==212 then
					spr(8, i*8-8, j*8-8)

				--door things
				elseif gb[i][j]!=-1 and gb[i][j] > 700 and gb[i][j] < 800 then
					spr(11, i*8-8, j*8-8)
					
				--locked door
    elseif gb[i][j]!=-1 and gb[i][j] > 800 and gb[i][j] < 900 then
					spr(27, i*8-8, j*8-8)
				
				--hazards/fire
				elseif gb[i][j] > 399 and gb[i][j] <500 then
					if(flr((gb[i][j]-400)/10) == 1) then
						spr(41+gb[i][j]%10,i*8-8, j*8-8)
					end
				
				--keys and arrows
				elseif gb[i][j] == 501 then
					spr(28, i*8-8, j*8-8)
				elseif gb[i][j] == 510 then
					spr(3,i*8-8,j*8-8)

				--bosses (just the one, really)
				elseif gb[i][j] >899 and gb[i][j] < 1000 then
					if gb[i][j] < 910 then
						spr(105, i*8-8, j*8-8, 2, 2)

					elseif gb[i][j] == 910 then
						spr(107, i*8-8, j*8-8, 2, 2)
					end

				end

			end
		end
		--draw player
		spra(player.direct,1,player.x*8-8,player.y*8-12,1,2)
		wait(1)--allows turning to be seen by player

	end
end

function screentransition(prevfloor,prevroom,nextroom)
	currentroom=nextroom
	--remove player from map
	gb[player.x][player.y]=-1

	--store the room state for future use
	previousrooms[prevfloor][prevroom]=gb
	if(previousrooms[currentfloor][currentroom]==-1) do
		gb=convertstringstoarray(gameboard[currentfloor][currentroom])
	else
		gb=previousrooms[currentfloor][currentroom]
	end

	--music transitions
	if flags[prevfloor][prevroom].tutorial==1 then
		flags[prevfloor][prevroom].tutorial=0
		if flags[currentfloor][currentroom].tutorial!=1 then
			music(36, 100, 1)
		end
	elseif flags[currentfloor][currentroom].tutorial==1 then
		music(32, 200, 2)
	end

	--dialogue trigger to introduce lesser clowns
	if currentfloor==1 then
		if currentroom==2 and checkforenemies() then
			load_dialogue(dialogue.enemies,1,2)
		elseif (currentroom==4 or currentroom==3) and checkforenemies() and metjuggler==nil then
			load_dialogue(dialogue.enemies,3,5)
			metjuggler=true
		end	
	--dialogue trigger for firebreather intro
	--fsmet= firestarter met
	elseif currentfloor==2 then
		if currentroom==1 and fsmet==nil then
				fsmet=true
				load_dialogue(dialogue.enemies,6,12)
		--dialogue trigger for clown car intro.
		--cmet=clown car met
		elseif (currentroom==5 or currentroom==8 or currentroom==9) and cmet==nil then
				cmet=true
		 	load_dialogue(dialogue.enemies,13,14)
		end
	end
end

--checks current room for enemies
function checkforenemies()
	for i=1,#gb do
		for j=1,#gb[i] do
			if gb[i][j]!=-1 and (gb[i][j]>=10 and gb[i][j]<100) and (gb[i][j]<30 or gb[i][j]>=40) then
				return true
			end
		end
	end
	return false
end

--checks if all keys have been collected
function allkeyscollected()
	for i=1,#flags[currentfloor] do
		if flags[currentfloor][i].key>0 then
			return false
		end
	end
	return true
end

--determines direction of sword based on sprite rotatin
--sd=sword direction
function sworddirection()
	sd=player.direct*8

	if sd==1 or sd==-7 then
		sword.x=player.x-1
		sword.y=player.y-1
	end
	if sd==2 or sd==-6 then
		sword.x=player.x-1
		sword.y=player.y
	end
	if sd==3 or sd==-5 then
		sword.x=player.x-1
		sword.y=player.y+1
	end
	if sd==4 or sd==-4 then
		sword.x=player.x
		sword.y=player.y+1
	end
	if sd==5 or sd==-3 then
		sword.x=player.x+1
		sword.y=player.y+1
	end
	if sd==6 or sd==-2 then
		sword.x=player.x+1
		sword.y=player.y
	end
	if sd==7 or sd==-1 then
		sword.x=player.x+1
		sword.y=player.y-1
	end
	if sd==0 or abs(sd)==8 then
		player.direct = 0
		sword.x=player.x
		sword.y=player.y-1
	end

	--checks if enemy is on the sword after the sword has moved
	for i=1,16 do
		for j=1,16 do
			if gb[i][j]!=-1 and gb[i][j]>=10 and gb[i][j]<100 and not (gb[i][j]>=30 and gb[i][j]<40) then
				if i==sword.x and j==sword.y then
					sfx(63)
					gb[i][j]=-1
				return
				end
			end
		end
	end
end

--juggler throws ball at player
function jugglershoot(i, j, direction)
	delay =1

	a = 1
	b = 1

	if direction == north then
		a = 0
		b = -1
	elseif direction == south then
		a = 0
		b = 1
	elseif direction == west then
		a = -1
		b = 0
	elseif direction == east then
		a = 1
		b = 0
	else
		x = 1/0
	end

	k = 0

	while(player.x*8 != i*8+a*k or player.y*8 != j*8+b*k) do
	k +=2
	x = i*8+a*k-5
	y = j*8+b*k-5

 --floor
	drawfloor(flr(x/8),flr(y/8),0,0)
	--entity
	entity = gb[flr(x/8)+1][flr(y/8)+1]
	if(flr(entity/10)==12) then
		spr(48,flr(x/8)*8,flr(y/8)*8 )
	elseif entity == 210 then
		spr(entity-200,flr(x/8)*8,flr(y/8)*8)
	end

	--player
	spra(player.direct,1,player.x*8-8,player.y*8-12,1,2)

	--cover your tracks
	if (x)%8<=7 or y%8<=7 then
		--floor
		drawfloor(flr((x-a*8)/8),flr((y-b*8)/8),0,0)
		--entity
		entity = gb[flr((x-a*8)/8)+1][flr((y-b*8)/8)+1]

		if(flr(entity/10)==12) then
			spr(48,flr((x-a*8)/8)*8,flr((y-b*8)/8)*8 )
		elseif entity == 210 then
			spr(entity-200,flr((x-a*8)/8)*8,flr((y-b*8)/8)*8)
		end
		--player
		spra(player.direct,1,player.x*8-8,player.y*8-12,1,2)

	end

	--projectile
	spr(jugglerprojectile, x-3, y-3)

	wait(delay)
	end

	wait(2)
end

--animates fire
function update_fire()
	for i = 1,#gb do
		for j = 1,#gb[i] do
			ent = gb[i][j]
				if ent<415 and ent >409 then
					drawfloor(i,j,8,8)
					if(gb[i][j] > 410) then
						gb[i][j] -= 1
						spr(41+gb[i][j]%10, i*8-8, j*8-8)
					else
						gb[i][j] = -1
					end
				end
		end
	end
end

--animation function for enemies
function animation(a, delay, i, j, direction, enemydeath)

	--a is a list of frames for animations
	--delay is how many frames to wait for each frame
	--i, j are the x,y coordinates where the animation starts
	--direction is...the direction.

	--if skipping animations
	if skipanim then
		--print('??????')
		return --then skip
	end

	--checking animation length
	if(#a != 8) then
		return
	end

	--order of drawing:
	--floor
	--entities
	--sword

	q = 0
	while q < #a do
		q += 1
		--checking for skip button
		if btn(4) then
			skipanim = true
			q = #a
		end

		--floor
		drawfloor(i,j)
		if direction == north then
			--floor
			drawfloor(i,j,8,16)
			--entities
			if(gb[i][j-1] < 420 and gb[i][j-1] >409) then
				spr(41 + gb[i][j-1]-410, i*8-8, j*8-16)
			end
			--animation
			spr(a[q], i*8-8, j*8-q-8)
		elseif direction == east then
			--floor
			drawfloor(i,j,0,8)
			--entities
			if(gb[i+1][j] < 420 and gb[i+1][j] >409) then
				spr(41 + gb[i+1][j]-410, i*8, j*8-8)
			end
			--animation
			spr(a[q], i*8+q-8, j*8-8)
		elseif direction == south then
			--floor
			drawfloor(i,j,8,0)
			--entities
			if(gb[i][j+1] < 420 and gb[i][j+1] >409) then
				spr(41 + gb[i][j+1]-410, i*8-8, j*8)
			end
			--animation
			spr(a[q], i*8-8, j*8+q-8)
		elseif direction == west then
			--floor
			drawfloor(i,j,16,8)
			--entities
			if(gb[i-1][j] < 420 and gb[i-1][j] >409) then
				spr(41 + gb[i-1][j]-410, i*8-16, j*8-8)
			end
			--animation
			spr(a[q], i*8-q-8, j*8-8)
		else
			print("problem!!!!")
		end
		spra(player.direct,1,player.x*8-8,player.y*8-12,1,2)
		wait(delay)
	end

	if enemydeath then
 	sfx(63)
		if direction == north then
			--floor
			drawfloor(i,j,8,16)
			--entities
			if(gb[i][j-1] < 420 and gb[i][j-1] >409) then
				spr(41 + gb[i][j-1]-410, i*8-8, j*8-16)
			end

		elseif direction == east then
			--floor
			drawfloor(i,j,0,8)
			--entities
			if(gb[i+1][j] < 420 and gb[i+1][j] >409) then
				spr(41 + gb[i+1][j]-410, i*8, j*8-8)
			end
		elseif direction == south then
			--floor
			drawfloor(i,j,8,0)
			--entities
			if(gb[i][j+1] < 420 and gb[i][j+1] >409) then
				spr(41 + gb[i][j+1]-410, i*8-8, j*8)
			end
		elseif direction == west then
			--floor
			drawfloor(i,j,16,8)
			--entities
			if(gb[i-1][j] < 420 and gb[i-1][j] >409) then
				spr(41 + gb[i-1][j]-410, i*8-16, j*8-8)
			end
		else
			print("problem!!!!")
		end
		--redraw sword/player
		spra(player.direct,1,player.x*8-8,player.y*8-12,1,2)
	end

end

--checks if the player is in the current gameboard (gb). if player is absent, then they are dead
function checkdeath(gb)
	for i=1,16 do
		for j=1,16 do
			if gb[i][j]==0 then
				return false
			end
		end
	end
	return true
end

function reloadroom()
 poke(0x5f40,0)
	player.x=player.savedx
	player.y=player.savedy
	player.direct=player.saveddirect
	player.arrows=player.savedarrows
	gb=convertstringstoarray(gameboard[currentfloor][currentroom])
	gb[player.x][player.y]=0
end

--returns whether it moves or not
function lclownhorizontal(xoff, yoff, i, j)
 enemydeath = false
 a = xoff/abs(xoff)
	spot = gb[i+a][j]
	if(spot == -1 or spot == 0 or (spot < 500 and spot > 399)) then
		--mechanics of movement
		if ((i+a)==sword.x and j==sword.y) or (gb[i+a][j]>399 and gb[i+a][j]<500) then
			enemydeath = true
			--print("walking to my death")
			gb[i][j]=-1
			--gb[i+a][j]=nil should be unnecessary
		else

			--ec1,wc1 = enemycount()

			--[[

			if(target == -1) then
				print("taret is nil")
			else
				print("target = "..gb[i+a][j])
			end

			]]
			gb[i+a][j] = entity+100
			gb[i][j] = -1

	 	--[[ec2,wc2 = enemycount()

			if ec1!=ec2 then
				print("a="..a)
				print("i="..i)
				print("j="..j)
				wait(120)
			end
			]]

			--print("clown ("..i..","..j..") to ("..i+a..","..j..")")
	 end

		--animation
		if a == -1 then
			direction = west
		elseif a == 1 then
			direction = east
		else
			print("problem: a="..a)
		end
		animation(lclownwalk,standarddelay,i,j,direction, enemydeath)
		return true
	end
	return false
end

--returns whether it moves or not
function lclownvertical(xoff, yoff, i, j)

 enemydeath = false
 b = yoff/abs(yoff)
 spot = gb[i][j+b]
 if(spot== -1 or spot == 0or (spot < 500 and spot > 399)) then
 	if (i==sword.x and (j+b)==sword.y) or (gb[i][j+b]>399 and gb[i][j+b]<500) then
	 	enemydeath = true
	 	--print("walking to my death")
	 	gb[i][j]=-1
	 	--gb[i][j+b]=nil should be unnecsesary
	 else

			gb[i][j+b] = entity+100
			gb[i][j] = -1
	 	--print("clown ("..i..","..j..") to ("..i..","..j+b..")")
 	end

 	--animation
 	if b == -1 then
 		direction = north
  elseif b == 1 then
 		direction = south
 	end
 	animation(lclownwalk,standarddelay,i,j,direction, enemydeath)
 	return true
 end
 return false
end

--sets fire on previoius spot when moving
--turns right when blocked

function firestarter_action(i, j)
	entity = gb[i][j]
	direction = entity%10

	if(direction == north) then
		a = 0
		b = -1

	elseif direction == south then
		a = 0
		b = 1

	elseif direction == east then
		a = 1
		b = 0

	else
		a = -1
		b = 0
	end

	move = gb[i+a][j+b] < 1 or (gb[i+a][j+b] <500 and gb[i+a][j+b] > 399)
	--fdeath = (i+a==sword.x and j+b == sword.y) or (gb[i+a][j+b] <500 and gb[i+a][j+b] > 399)
	fdeath = false
	if(move) then
		--set fire
		gb[i][j] = 414
		--animation
		animation(fwalk, 1, i, j, direction, fdeath)
		spr(41+gb[i][j]%10, i*8-8, j*8-8)
		--if still alive
		if(not(fdeath)) then
			gb[i+a][j+b] = 10*flr(entity/10)+direction+100
		end

	else
		if direction == north then
			direction = east
		elseif direction == east then
			direction = south
		elseif direction == south then
			direction = west
		else
			direction = north
		end
	gb[i][j] = 10*flr(entity/10)+direction+100
	end

end

function ai(i, j)
	entity = gb[i][j]
	xoff = player.x - i
	yoff = player.y - j

	standarddelay = 1

	if(checkdeath(gb) or entity == 0 or entity == -1 or entity > 200) then
		return
	end

	--lesser clown
	if(flr(entity/10) == 1) then

		if (abs(yoff) >= abs(xoff)) then
			if not(lclownvertical(xoff, yoff, i, j)) and xoff != 0 then
				lclownhorizontal(xoff, yoff, i, j)
			end
		else
			if not(lclownhorizontal(xoff, yoff, i, j)) and yoff != 0 then
				lclownvertical(xoff, yoff, i, j)
			end
		end

	--firestarter
	elseif(flr(entity/10) == 3) then
		firestarter_action(i, j)

	--juggler
	elseif (flr(entity/10) ==2) then
		death = false
		gb[i][j] += 100
		direction = entity%10

		--juggler north
		if direction == north then
			if(xoff==0 and yoff < 0) then
				if los(i, j, direction) then

					jugglershoot(i, j, direction)
					gb[player.x][player.y] = -1
				end
			elseif xoff!=0 then
				c = xoff/abs(xoff)
				spot = gb[i+c][j]
				if(spot == o or spot == -1 or (spot>399 and spot<500)) then
					gb[i][j] = -1

					if (sword.x == i+c and sword.y == j) or (gb[i+c][j] >399 and gb[i+c][j] < 500) then
						death = true
					else
						gb[i+c][j] = entity+100
					end

					if c<0 then
						newdir = west
					else
						newdir = east
					end

					animation(jugglerwalk, standarddelay, i, j, newdir, death)
				end
			end

		--juggler south
		elseif direction == south then
			if(xoff==0 and yoff > 0) then
				if los(i, j, direction) then

					jugglershoot(i, j, direction)
					gb[player.x][player.y] = -1
				end
			elseif xoff!=0 then
				c = xoff/abs(xoff)
				spot = gb[i+c][j]
				if(spot == o or spot == -1 or (spot>399 and spot<500)) then
					gb[i][j] = -1

					if (sword.x == i+c and sword.y == j) or (gb[i+c][j] >399 and gb[i+c][j] < 500) then
						death = true
					else
				  gb[i+c][j] = entity+100
					end

					if c<0 then
						newdir = west
					else
						newdir = east
					end

					animation(jugglerwalk, standarddelay, i, j, newdir, death)
				end
			end

		--juggler east
		elseif direction == east then
			if(xoff>0 and yoff == 0) then
				if los(i, j, direction) then

					jugglershoot(i, j, direction)

					gb[player.x][player.y] = -1
				end
			elseif(yoff!=0) then
				c = yoff/abs(yoff)
				spot = gb[i][j+c]
				if(spot == o or spot == -1 or (spot>399 and spot<500)) then
					gb[i][j] = -1

					if (sword.x == i and sword.y == j+c) or (gb[i][j+c] >399 and gb[i][j+c] < 500) then
						death = true
					else
						gb[i][j+c] = entity+100
					end
					if c<0 then
						newdir = north
					else
						newdir = south
					end

					animation(jugglerwalk, standarddelay, i, j, newdir, death)
				end
			end

		--juggler west
		elseif direction == west then
			if(xoff<0 and yoff == 0) then
				if los(i, j, direction) then
					jugglershoot(i, j, direction)

					gb[player.x][player.y] = -1
				end
			elseif(y0ff!=0) then
				c = yoff/abs(yoff)

				--west-facing jugglers can spaz out if you sneak up on them
				if(c==nil or abs(c) !=1) then
					return
				end
				--print("c= "..c)
				spot = gb[i][j+c]
				if(spot == o or spot == -1 or (spot>399 and spot<500)) then
					gb[i][j] = -1

					if (sword.x == i and sword.y == j+c) or (gb[i][j+c] >399 and gb[c][j+c] < 500) then
						death = true
					else
						gb[i][j+c] = entity+100
					end

					if c<0 then
						newdir = north
					else
						newdir = south
					end

					animation(jugglerwalk, standarddelay, i, j, newdir, death)
				end
			end
		end
		--don't forget to add 100

	--clown car
	elseif flr(entity/10)==4 then
		enemydeath = false
 	a=xoff/abs(xoff)
 	b=yoff/abs(yoff)

 	--40 to 49
 	--on 48,flash colors
 	--on 49, spawn new clowns
 	--reset to 40

		--adds 1 to entity code
		gb[i][j]=entity+1
		--if entity=48, signal spawning
 	if entity==48 then
 		for g=1,6 do
 			for h=179,182 do
 				spr(h,(i-1)*8,(j-1)*8)
 				wait(1)
 			end
 		end
 	--if entity=49, spawn, reset entity to 40
 	elseif	entity==49 then
 		gb[i][j]=40
 		for l=i-1,i+1 do
 			for k=j-1,j+1 do
 				if gb[l][k]==-1 and (l!=sword.x or k!=sword.y) then
 					--spawned lesser clowns designated 011
 					--erases them on reload
 					gb[l][k]=011+100
 				end
 			end
 		end
 	end

		if abs(xoff)<=3 and abs(yoff)<=3 then
 	 if a!=(0/0) and gb[i-a][j]==-1 and i!=sword.x then
 	 	gb[i-a][j]=entity+101
 	 	gb[i][j]=-1

 	 	if a==1 then
 	 		direction=west
 	 	elseif a==-1 then
 	 		direction=east
 	 	end
 	 	animation(clowncarmove, standarddelay, i, j,direction, death)
 	 elseif gb[i][j-b]==-1 and gb[i][j-b]!=sword.y then
 	 	gb[i][j-b]=entity+101
 	 	gb[i][j]=-1

 	 	if b==1 then
 	 		direction=north
 	 	elseif b==-1 then
 	 		direction=south
 	 	end
 	 	animation(clowncarmove, standarddelay, i, j,direction, death)

 	 elseif b==(0/0) and gb[i][j+1]==-1 then
				gb[i][j+1]=entity+101
 	 	gb[i][j]=-1
 	 	animation(clowncarmove, standarddelay, i, j,south, death)
 	 elseif a==(0/0) and gb[i+1][j]==-1 then
				gb[i+1][j]=entity+101
 	 	gb[i][j]=-1
 	 	animation(clowncarmove, standarddelay, i, j,east, death)
 	 end
		end
	end
end

function bossai(i, j)

	ent = gb[i][j]
	d = abs(player.x-i) + abs(player.y-j)--manhattan distance

	if(ent < 910) then
		code = gb[i][j]%10
		die = (sword.x == i and (sword.y == j or sword.y == j+1))
		if(d < code) then
			code -= 1
			load_dialogue({"code: "..code},1,1)
			if (code <= #(dialogue.boss)) then
				--load_dialogue(dialog.boss[code])
			end
			gb[i][j] -= 1
		elseif die then
			gb[i][j] = 910
			spr(floor[i][j], i*8-8, j*8-8)
			spr(floor[i+1][j], i*8, j*8-8)
			spr(floor[i][j+1], i*8-8, j*8)
			spr(floor[i+1][j+1], i*8, j*8)
			spr(107, 14*8-8, 7*8-8, 2, 2)
			spra(player.direct,1,player.x*8-8,player.y*8-12,1,2)
			wait(30)
			gb[i][j] = 520
			gb[i+1][j] = -1
			gb[i][j+1] = -1
			gb[i+1][j+1] = -1
		end
	end
end

function enemymovement()

	skipanim = false

	for j = 1,16 do
		for i = 1, 16 do
				if gb[i][j] != -1 and gb[i][j] > 0 and gb[i][j] < 100 then
					ai(i, j)
				elseif gb[i][j] >899 then
					bossai(i,j)
				end
		end
	end

	for j = 1,16 do
		for i = 1, 16 do
				if gb[i][j] != -1 and gb[i][j] > 99 and gb[i][j] < 200 then
					gb[i][j] -= 100
				end
		end
	end

	pturn = true
end

--pauses game engine
--useful for playing animations
function wait(i)
 for j = 1, i do
 	flip()
 end
end

function convertstringstoarray(room)
	board={}
	i=1
	for x in all(room) do
		board[i]=mysplit(x)
		i+=1
	end
	return transpose(board)
end

function mysplit(inputstr)
    outputarray={}
		for x=1,16 do
			outputarray[x]=sub(inputstr,1+(x-1)*4,3+(x-1)*4)
			if(outputarray[x]=='nil') then
				outputarray[x]=-1
			else
				outputarray[x]=outputarray[x]+0
			end
		end
		return outputarray
end

function transpose(inputarray)
	outputarray={}
	for i=1,16 do
		outputarray[i]={}
		for j=1,16 do
			outputarray[i][j]=inputarray[j][i]
		end
	end
	return outputarray
end

--call this to load specific dialogue
function load_dialogue(t,dn,de)
	--t is dialogue table ex. dialogue.lvl1dialogue
	--dn: specific dialogue message number
	--de:dialogue you want to end on. ex(dialogue,2,2) plays 2nd string in table dialogue
	--dn and de are optional, the whole table will be displayed if omitted
	dtable=t
	dialoguetf=true
	if de!=nil then
		d_nume=de
	else
		d_nume=#t
	end
	if dn!=nil then
		d_num=dn
	end
	if d_num==nil then
		d_num=1
	end
end

--updates the dialogue shown
function update_dialogue()
	if d_num==d_nume and btnp(4)  then
		dialoguetf=false
		return
	end

	if btnp(4) then
		d_num+=1
	end
end

--draws dialogue box and dialogue statement
function draw_dialogue()
	rectfill(8,100,120,122,0)
	rect(8,100,120,122,7)
	print(dtable[d_num],10,102,7)
	print("z->",108,116,7 )
end

function _init()
	titleinit()
end

function titleinit()
	music(0, 10, 2)
	mode=0
end

function gameinit()
	mode=1
	music(32, 200, 2)
	--sets up gameboard
	currentfloor=initialfloor
	currentroom=initialroom
	gb=convertstringstoarray(gameboard[currentfloor][currentroom])
	floor = convertstringstoarray(truefloor)
	player.x=initialx
	player.y=initialy
	gb[player.x][player.y]=0
	player.direct=initialdirection
	--set up array of previous rooms
	previousrooms={}
	for i=1,#gameboard do
		previousrooms[i]={}
		for j=1,#gameboard[i] do
			previousrooms[i][j]=-1
		end
	end
	--load with tutorial level (floor 1, room1)
	load_dialogue(dialogue.t_dialogue)
end

function _update()

	if mode<1 then
		titleupdate()
	else
		gameupdate()
	end
end

function titleupdate()
	if btnp(4) then
		mode+=.5
	end
	if mode==1 then
		gameinit()
	end
end

function gameupdate()

	if dialoguetf then
		update_dialogue()
	else
		--press tab to reset room
		if btnp(4,1) then
			rectfill(0,0,128,128,0)
			wait(10)
			reloadroom()
		end

		if pturn and not(checkdeath(gb)) then
			playermovement()
		elseif not checkdeath(gb) then
			update_fire()
			enemymovement()
			--afterenemyenemycount, afterenemywallcount = enemycount()
			wait(2)
		end
	end
end

function _draw()
	if mode==0 then
		titledraw()
	elseif mode==.5 then
		lorescreen()
	else
			gamedraw()
	end
end

function titledraw()
	cls()
	pal() --resets color palette
	generateballoons()
	for i=1,8 do
	--generates clouds
		circfill(i*8,0,9,5)
		circfill(i*8+50,0,9,5)
	end
	--generates hill
	circfill(42,136,24,3)
	circfill(42,130,20,3)
	rectfill(42,110,82,150,3)
	circfill(82,130,20,3)
	circfill(82,136,24,3)
	--draws castle and title text
 sspr(40,32,32,32,40,54,64,64)
	sspr(0,34,32,38,0,0,128,128)

	--cycles colors 7-16
	if x==nil or flr(x+1)==16 then
		x=7
	end
	print("press z to start",31,119,flr(x))
	x+=.33
end

--creates balloons on title screen
balloons={}
function generateballoons()
	rand=flr(rnd(120))
	i=flr(rnd(3))+1
		if i==1 and ((rand>0 and rand<32) or (rand>80 and rand<128)) then
			temp={
				x=rand,
				y=127,
				s=78
			}
			add(balloons,temp)
		end

	for obj in all(balloons) do
		obj.y-=1
		if obj.y<-8 then
			del(balloons,obj)
		end
		spr(obj.s,obj.x,obj.y,2,2)
	end
end

--black screen with lore ascending
--skipable
--mode=.5 is lorescreen
function lorescreen()
	cls()
	if ly==nil then
		ly=122
	elseif ly<=0 then
		ly=0
	end

	lore="many years ago, you narrowly\nescaped your family's castle\nwith the help of your butler\nafter it was overrun by a\ndastardly carnival bandit\nlord and his carnie minions.\n\nnow, you must fufill the last\ndying wish of your butler;\ntake back the castle and\navenge your family.\n\narmed only with your trusty\nclaymore, minimal combat\nexperience, and knowledge\nof a secret entrance, you\nmust fight your way through\nthe castle and drive the\ncarnies from your home."

	print(lore,10,ly,7)
	rectfill(0,118,128,128,0)
	print("press z to continue",50,120,7)
	ly-=10/30
end

function gamedraw()
	cls()
	pal() --resets color palette for gameplay
	if win then
		cls()
		pal()

		print("you got the deed and\nreclaimed your castle!",25,40,7)
		print("thanks for playing!",25,60,7)
		print("created by:\nperry gordon\ntyler jones\nalex proctor\nharrison ratcliffe",25,70,7)
		print("press x to return to main menu",8,120,7)
		if btnp(5) then
			win=false
			titleinit()
		end
	else

	if not checkdeath(gb) then

		for i=1,16 do
			for j=1,16 do
				--floor first
				drawfloor(i,j)
				--player things
				if gb[i][j]==0 then
					spra(player.direct,1,i*8-8,j*8-12,1,2)

				--enemy things
			elseif(not(gb[i][j] == -1) and gb[i][j] > 0 and gb[i][j] < 100) then
					if gb[i][j]<20 then
						spr(32,(i-1)*8,(j-1)*8)
					elseif gb[i][j] < 30 then
						spr(60+gb[i][j]%10, i*8-8, j*8-8)
						spr(48,(i-1)*8,(j-1)*8)
					elseif gb[i][j] < 40 then
						spr(60+gb[i][j]%10, i*8-8, j*8-8)
				  spr(36,(i-1)*8,(j-1)*8)
					elseif gb[i][j]<50 then
						spr(179,(i-1)*8,(j-1)*8)
					end

			--wall things
			elseif gb[i][j]==210 then --200=wall
				drawwall(i,j)
			elseif gb[i][j]==211 then
				spr(7, i*8-8, j*8-8)
			elseif gb[i][j]==212 then
				spr(8, i*8-8, j*8-8)

			--door things
			elseif gb[i][j]!=-1 and gb[i][j] > 700 and gb[i][j] < 800 then
				if flr((gb[i][j]-700)/10)==1 then
					spr(11, i*8-8, j*8-8)
				end

			--hazards
			elseif gb[i][j] > 399 and gb[i][j] <500 then
				if(flr((gb[i][j]-400)/10) == 1) then
					spr(41+gb[i][j]%10,i*8-8, j*8-8)
				end

				--stairway
				elseif gb[i][j] == 202 then
					spr(12, i*8-8, j*8-8)

   	elseif gb[i][j]!=-1 and gb[i][j] > 800 and gb[i][j] < 900 then
					spr(27, i*8-8, j*8-8)

				--items
				elseif gb[i][j] == 501 then
					spr(28, i*8-8, j*8-8)
				elseif gb[i][j]==510 then
					spr(3,i*8-8, j*8-8)
				elseif (gb[i][j] == 520) then
					spr(109 ,i*8-8, j*8-8)

				--debug case
				elseif gb[i][j] != -1 and gb[i][j] < 900 then
					spr(0, i*8-8, j*8-8)
				end
			end
		end

		--bosses (just the one, really)
				if gb[14][7] >899 and gb[14][7] < 1000 then
					if gb[14][7] < 910 then
						spr(floor[14][7], 14*8-8, 7*8-8)
						spr(floor[15][7], 15*8-8, 7*8-8)
						spr(floor[14][8], 14*8-8, 8*8-8)
						spr(floor[15][8], 15*8-8, 8*8-8)
						spr(105, 14*8-8,7*8-8, 2, 2)

					elseif gb[14][7] == 910 then
						spr(floor[14][7], 14*8-8, 7*8-8)
						spr(floor[15][7], 15*8-8, 7*8-8)
						spr(floor[14][8], 14*8-8, 8*8-8)
						spr(floor[15][8], 15*8-8, 8*8-8)
						spr(107, 14*8-8, 7*8-8, 2, 2)
					end
				end

		--puts arrow counter on screen
		if arrowdflag!=nil then
			rectfill(0,0,20,4,9)
			spr(3,0,-1)
			print("x"..player.arrows,10,0,7)
		end
	spra(player.direct,1,player.x*8-8,player.y*8-12,1,2)

	--draws any dialogue to screen
	if dialoguetf then
		draw_dialogue()
	end

	else
		--prints this to screen if player is dead
		cls()
		poke(0x5f40,15)
		print("the carnies got you",26,64,7)
		print("press z to try again",40,120)
		if btn(4) then
			cls()
			reloadroom()
		end
	end

	end--end for win condition if-statement
end

function drawfloor(i,j,a,b)
	if a==nil then
		a=8
	end
	if b==nil then
		b=8
	end
	if currentfloor==1 then
				spr(floor[i][j], i*8-a, j*8-b)
			elseif currentfloor==2 then
				spr(29, i*8-a, j*8-b)
			end
end

function drawwall(i,j)
	if currentfloor==1 then
					spr(10, i*8-8, j*8-8)
				elseif currentfloor==2 then
					spr(10, i*8-8, j*8-8)
				end
end

function los(i, j, direction)

	if(direction == north) then
		a = 0
		b = -1
	elseif direction == south then
		a = 0
		b = 1
	elseif direction == east then
		a = 1
		b = 0
	elseif direction == west then
		a = -1
		b = 0
	end

		k = 0
		while(i+a*k<16 and i+a*k>1 and j+b*k <16 and j+b*k >1) do
			k += 1
			ent = gb[i+a*k][j+b*k]

			if ent == 0 then
				return true
			elseif ent != -1 then
				return false
			end
		end

	return false

end
__gfx__
00000000000005600000000000000000000500000000000000000000000d0000cccccccc66665666665666660044440060000000aa1aaaaa33333b3322299222
00000000000005600000000000500007005550000000000000000000000dd000cccccccc6666566655555555044444405600000011111111333333b322922222
00700700000005600050070005000070050405000000000000000000000d0d00cccccccc55555555666666564444444466600000bbbbbb1b3b3333b362922226
00077000000005600554400055444440000400000000000000000000766d6667ccccccac6656666655555555444444445556000011111111b3333b3355299255
0007700000000560005007000500007000040000000000000000000076666667cccccccc6656666666566666444444a46666600088188888333b333366522666
0070070000000560000000000050000700040000000000000000000077666677cccccccc555555555555555544444444555556001111111133b333b355522555
00000000000005f0000000000000000000747000000000000000000007777770cccccccc66665666666666564444444466666660cccccc1c333b333b66666656
0000000000000ff0000000000000000007000700000000000000000000000000c000000c66665666555555554444444455555556111111113333333355555555
00000000004444400000000000000000070007000000000000000000000000000000000052115555000000000044440000000000333311110000000055555555
000000000444444000000000000000000074700000000000000000000000000000000000121151110000000004aaaa4000aaaa00333311110000000059922995
0000000004444440aaaaaa00700005000004000000000000000000000000000000000000111111110000000044a00a4400a00a00333311110000000059922995
0000000004444440a0aa0a00070000500004000000000000000000000000000000000000511115550000000044aaaa4400aaaa00333311110000000052222225
0000000000444400aaa000000444445500040000000000000000000000000000000000002211111100000000444aa444000aa000111133330000000052222225
0000000000000000000000000700005005040500000000000000000000000000000000001222111100000000444a4444000a0000111133330000000059922995
0000000000000000000000007000050000555000000000000000000000000000000000001111111100000000444aa444000aa000111133330000000059922995
00000000000000000000000000000000000500000000000000000000000000000000000025111112000000004444444400000000111133330000000055555555
0000000000000000000000000000000000000a9a00000aaa00000a9a000000a00000000000000000000000000000000000000000000000000000000000000000
000ee000000ee000000ee00000000000000ee989000eea89000ee98a000eeaaa0000000000000000000000000000000000000000000090000000000000000000
00077000000770000007700000000000000770400007704000077040000779890000000000000000000000000000900000aa9900000990000000000000000000
00888800008888000088880000000000008888400088884000888840008880400000000000000000000088000009990000a989900009aa000000000000000000
0808808008088080080880800000000008088040080880400808804008088840000000000000000000888800008889000a988890009a9aa00000000000000000
0001100000011000000110000000000000011000000110000001100000011040000000000008a8000889988009898800a9899899098999a00000000000000000
008008000080080000800800000000000080080000800800008008000080080000000000008999880899aa8888aa9890a899aa889889889a0000000000000000
008008000080000000000800000000000080080000000800008008000080000000000000889888980899aaa88aa88980a899aaa88888889a0000000000000000
00c00000000000000000000000c0000000c000c00c000c00000000000c0000000000000000000000000000000000000000700700000007000070000000000000
000ee0000c0ee0c0000ee0c0000ee000000ee000000ee000000ee0c0000ee0000000000000000000000000000000000007000070000000700700000000000000
000770c0000770000007700000077000000770000007700000077000000770000000000000000000000000000000000070000007000000077000000000000000
c0888800008888000088880cc088880cc08888000088880cc088880cc088880c000c000000000000000000000000000000000000000000000000000000000000
0808808008088c8008c8808008088080080880800808808008088080080880800000000000000000000000000000000000000000000000000000000000000000
00011000000110000001100000011000000110000001100000011000000110000000000000000000000000000000000000000000000000077000000070000007
00800800008008000080080000800800008008000080080000800800008008000000000000000000000000000000000000000000000000700700000007000070
00800800008000000080080000000800008008000080000000800800000008000000000000000000000000000000000000000000000007000070000000700700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888000000
00000000000000000000000000000000000000000000000000060e00000000000000000000000000000000000000000000000000000000000000088888800000
0777707777077770700070777770777700000000000000000006e0e0000000000000000000000000000000000000000000000000000000000000888877880000
07000070070700707700700070007000000000000000000000060000000000000000000000000000000000000000000000000000000000000008888887888000
07000070070700707070700070007000000000000000000000404000000000000000000000000000000000000000000000000000000000000008888888888000
07000077770777007007700070007777000000000000000004040400000000000000000000000000000000000000000000000000000000000008888888888000
07000070070700707000700070007000000000000000000040404040000000000000000000000000000000000000000000000000000000000008888888888000
07000070070700707000700070007000000000000000000404040404000000000000000000000000000000000000000000000000000000000008888888888000
077770700707007070007077777077770000000000000000c0c0c0c0000000000000000000000000000000000000000000000000000000000000888888880000
000000000000000000000000000000000000000000000000ccccccc0000000000000000000000000000000000000000000000000000000000000088888800000
000000000000000000000000000000000000000000069090ccc0ccc0000609000000000000000000000000000000000000000000000000000000008888000000
077770777707777077777070000077770000000000060900cc0c0cc0000690900000000000000000000000000000000000000000000000000000000700000000
070000700707000000700070000070000000000000060000c0ccc0c0000600000000000000000000000000000000000000000000000000000000000070000000
070000700707000000700070000070000000000000404000ccc0ccc0004040000000000000000000000000000000000000000000000000000000000070000000
070000777707777000700070000077770000000004040400cc000cc0040404000000000000000000000000000000000000000000000000000000000700000000
070000700700007000700070000070000000000040404040c00c00c0404040400000000000000000000000000000000000000000000000000000000700000000
07000070070000700070007000007000000000000a0a0a00c0ccc0c00a0a0a000000000000000000000000000000000000000000000000000000000000000000
07777070070777700070007777707777000000000aaaaa00ccccccc00aaaaa000000000000000000000000000000000000000000044444400000000000000000
00000000000000000000000000000000000000000aa0aa08c8c8c8c80aa0aa00000000000000000000000000000000000000000000f6f6000000000000000000
00000000000000000000000000000000000000000a0a0a08c8c8c8c80a0a0a000000000000000777700040000000077770004000006f6f000000000000000000
00000000000000000000000000000000000000000aa0aa08888888880aa0aa0000000000000000ce77044000000000ce7704400000f6f6000000000000000000
00000000000000000000000000000000000000000aaaaa08888888880aaaaa0000000000000000eee0449000000000eee0449000006f6f000000000000000000
0000000000000000000000000000000000000000bababab0b8b8b8b0bababab00000000000000009844490000000000984449000044444400000000000000000
0000000000000000000000000000000000000000bababab0b8b8b8b0bababab00000000000000009844490000000002984449000000000000000000000000000
0000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbb00000000000000009844490000000009984449000000000000000000000000000
0000000000000000000000000000000000000000bbbbbbbbbb0b0bbbbbbbbbb0000000000000079984aa40000000000884aa4000000000000000000000000000
0000000000000000000000000000000000000000bb0b0bbbb0bbb0bbbb0b0bb00000000000000888844a400000000888844a4000000000000000000000000000
0000000000000000000000000000000000000000b0b0b0bb0bb0bb0bb0b0b0b00000000000000844448a400000000844448a4000000000000000000000000000
0000000000000000000000000000000000000000bbbbbbb0bb000bb0bbbbbbb0000000000000774aaa8440000000774aaa844000000000000000000000000000
0000000000000000000000000000000000000000bb0b0bbbb00000bbbb0b0bb000000000000444844a449000000444844a449000000000000000000000000000
0000000000000000000000000000000000000000bb0b0bbb0000000bbb0b0bb00000000000044488884499000004448888449900000000000000000000000000
0000000000000000000000000000000000000000bb0b0bbb0000000bbb0b0bb00000000000000800800000900000080080000090000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006080000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006808000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040400000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000404040000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004040404000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040404040400000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007070707000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000680807770777000060800
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000608007707077000068080
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600007077707000060000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004040007770777000404000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040404007700077004040400
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000404040407007007040404040
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070707007077707007070700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777007777777007777700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077077070707070707707700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070707070707070707070700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077077077777777707707700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777077777777707777700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000707070707070707070707070
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000707070707070707070707070
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777777777777777777770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777777707077777777770
000000000000000000000000000cbb000008cc00000e8800000bee00000000000000000000000000000000000000000000000000770707777077707777070770
00000000000000000000000000c5bbe00085ccb000e588c000b5ee80000000000000000000000000000000000000000000000000707070770770770770707070
0000000000000000000000000855bbe00e55ccb00b5588c00c55ee80000000000000000000000000000000000000000000000000777777707700077077777770
00000000000000000000000088ccbbeeee88ccbbbbee88ccccbbee88000000000000000000000000000000000000000000000000770707777000007777070770
000000000000000000000000855cb55ee558c55bb55e855cc55be558000000000000000000000000000000000000000000000000770707770000000777070770
00000000000000000000000005500550055005500550055005500550000000000000000000000000000000000000000000000000770707770000000777070770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010c00001316213152131530710407114071200713007130071300713007130071300713007130071300713007130071300713007130071300713007130071300713007130071300713007130071300713007130
010c000000505005050050500500005000050000500005003c5653b5653a56539565385653b5653a5653956538565375653656535565395653856537565365653556538565375653656535565345653356532565
010c00003655535555345553355532555315553555533555315552f5552d5552c5552b5552a555295552855527555265552555524555235552255521555205551f557215571f557215571f5501f5350737007360
010c002000155001550c1550c15500155001550c1550c15500155001550c1550c15500155001550c1550c15500155001550c1550c15500155001550c1550c15500155001550c1550c15500155001550c1550c155
010c002014763147230f2440f240147531a7731224412240147531472311244112403962039625142441424014763147230f2440f240147531a77312244122401475314723112441124039620396251524415240
010c00000040100401004010040300403004030040000400133301532017320183201a3201c3201d3201a3201c320183201a3201c3201d3201a3201c3201d3201f3201c3201d3201f320213201d3201f32021320
010c0000233201f32021320233202432021320233202432026320233202432026320283202432026320283202a3202b3202d3202f320303203232034320363203732737327373173731737310000000000000000
000300202c6202c6202a6202762025610206101b6101961019610196101d610216102361025610256102561024620206201b62017620156101561015610186101c6101d6101a610176100c610076100361002610
010c00201275300000182541825039620396251b2541b25012753000001a2541a250306203062517254172501275300000182541825039620396251b2541b25012753000001a2541a25030620306251d2541d250
010c00201a75300000117533e53539620396253e535117533e53500000117533e53539620396253e535117533e53511753117533e53539620396253e535117533e5353f705117533e53539620396253d6203d625
0118000024051240522405224052270512705227052270522b0512b0522b0522b0522c0512c0522c0522c0522305123052230522305223052230522c0512c0522b0512b052300523005229052290522f0522f052
010c00000713007130071300713007130071300713007130071200712007120071200712007120071200712007110071100711007110071000710007100071000710007100071000710007100071000710007100
01180000300562b056270562b056300562c056270562c056320562e056290562e056300562d056290562d0563375730757377573075733757307573875730757327572e757357572e757307572d757357572d757
010c000008155081550f1550f15508155081550f1550f15508155081550f1550f15508155081550f1550f15505155051550e1550e15505155051550e1550e15505155051550c1550c15505155051550c1550c155
010c000007155071550b1550b15507155071550c1550c15507155071550e1550e1550715507155111551115500155001550f1550f15500155001550c1550c15500155001550b1550b15500155001550c1550c155
010c00002b0522b0522b0522b0522b0522b052290522705226052260522605226052260522605227052290522605226052260522605226052260522705229052260522605223052230521f0521f0522605226052
010c0000270522705227052270522705227052260522705229052290522905229052290522905227052290522b0522b0522b0522b0522b0522b052290522b0522c0522b0522c0522f05230052320523305235052
010c00003005230052300523005230052300522e0522c0522b0522b0522b0522b0522b0522b0522c0522e0522b0522b0522b0522b0522b0522b0522c0522e052290522905226052260522c0522c0522905229052
010c00002b0522b0522b0522b0522b0522b0522905227052260522605226052260522605226052270522605224052230522105223052240522605227052290522b0522d0522f05230052320522f0523005230055
010c00002c0522c0522c0522c0522c0522c0522b05229052270522705227052270522705227052290522b052270522705227052270522705227052290522b052260522605223052230521f0521f0522605226052
010c000027052270522705227052270522705226052240522305223052230522305223052230522105223052240521f0521d0521f0521b0521e0521f052210522305221052230522405226052270522407224075
010c00201107311043110331102311073110431103311023110731104311033110231107311043110331102311073110431103311023110731104311033110231107311043110331102311073110431103311023
010c002002155021550e1550e15502155021550e1550e15502155021550e1550e15502155021550e1550e15502155021550e1550e15502155021550e1550e1550a1550a1550e1550e15509155091550e1550e155
01600000211542115522154221551f1541f15521154211551d1541d1551c1541c15519154191551a1541a1551d1541d1551f1541f1551c1541c1551d1541d1551a1541a1521c1551615415155191541a1521a155
016000001d7541d7551c7541c7551b7541b7551a7541a75515754157551675416755137541375511754117552d7222d7222f7222f722317223172232722327222e7222d7222b73229732287322b7322973229735
010c000004155041550b1550b15510155101550b1550b155001550015507155071550c1550c155071550715504155041550b1550b15510155101550b1550b15507155071550e1550e15513155131550e1550e155
010c0000021550215509155091550e1550e1550915509155091550915510155101551315513155091550915502155041550515507155091550b1550d1550e1551015512155141551515517155191551a1551c155
010c00001f3551e3551f3552135523355213551f3551e3551b3551a3551b3551d3551e3551d3551e355203551f3551e3551f35521355233551f3551c3551e3551f35521355223552435526355273552635524355
010c000026355213551d355213552635528355293552b3552d3552835524355283552d3552f355303552d355293552835526355283552935528355293552d3552c3552835523355283552c3552f3553235534355
010c00001c7561f756237561f7561c7561f756237561f7561b7561f756247561f7561b7561f756247561f7561c7561f756237561f7561c7561f756237561f7561a7561f756227561f7561a7561f756227561f756
010c00001a7561d756217561d7561a7561d756217561d7561c756187561c756217561c756187561c756217561a7561d756217561d7561a7561d756217561d7561c7562075623756207561c756207562375620756
010c00002b7562775624756207562b7562775624746207462b7362773624726207262b7162771624706207062c7562975626756247562c7562975626746247462c7362973626726247262c716297162670618706
011200200f0530c0030f053000032863028625000030f05300003000030000330620306150c00311053000030f053000030f0530000328630286250c0030f0530000300003000033062030615000031105300000
011200203d5353d5153d5353d5153d5353d5153d5153d5353d5153d5153d5153d5353d5153d5153d5353d5153d5353d5153d5353d5153d5153d5353d5153d5353d5153d5153d5353d5153d5153d5153d5353d515
01120000185561a5461c5361f526185161a5161c5161f516185161a5161c5161f516185161a5161c5161f50616556185461a5361d52616516185161a5161d51616516185161a5161d51616516185161a5161d506
011200000c742107000074500745007000c7400c7050a7400a7400a74509740097450774007745007000374003740037450374003745057400574500700187351b735187351d7311d7311d701007010073000740
011200000c742107000074500745007000c7400c7050a7400a7400a745097400974507740077450070012740127401274513740137451074010745007001b7141d7111b711187121d705000001b7000003000040
011200001a5561854616536115261a5161851616516115161a5161851616516115161a5161851616516115061c5561a54618536135261c5161a51618516135161c5161a51618516135161c5161a5161851613506
0114001a110533f5201b625110533f5253f5251105311023110131b6553f5251b6653f525110531b6253f525110533f5253f525110531c625110531c6553f5251c6653f525000030000300003000030000300003
014100002173221722217222172520732207222072220722207222072220722207251e7241e7221e7221e7221e7221e7221e7221e7251d7241d7221d7221d7221c7321c7221c7221c7251a7241f7212372123722
014100001e0221e0101e0101e0101d0201d0101d0101d0101c0201c0101c0101c0101b0241b0101c0101b0101a0141a0101a0101a0101901419010190101901019012190101901019010170141a0111f0211f022
0114001a0617506135001050615506135001050010506155061350010000100061250614506175061350010506155061350010500105061550613500100001000612506145001000010000100001000010000100
01140012110433f5203f5251b6553f52511023110433f5203f5251b6553f52511023110333f5201b6553f525110233f525110433f5203f5251b6553f52511023110033f505110033f5003f5051b6053f50511003
014100201231212312123151230511312113121131511305093140931209312093120e3110e3120e3120e3150b3140b3120b3120b3120d3140d3120d3120d3130131201312013120131507314073120731207315
013c00000217502155021750215504175041550417504155011750115501175011550217502155021750215502175021550217502155041750415504175041550117501155011750115505175051550517505155
013c00002552425522255222552223521235222352223522285212852228522285222153221522215221e53221532215222152221522205322052225521255221e5321e5221e5221e52219521195221952219522
013c00002172421720217202172020722207202072020720207322072020720207201e7321e7201e7201e72019730197201972019720177311772017720177202373023720217302172020730207202072220722
0114001a110433f5103f515110333f5153f515110231b615110331b6253f5151b6353f515110433f5103f515110333f5153f515110231c615110331c6253f5151c6353f515000000000000000000000000000000
010c00200e0730e0330e0330e0330e0730e0330e0330e0330e0730e0330e0330e0330e0730e0330e0330e0330e0730e0330e0330e0330e0730e0330e0330e0330e0730e0330e0330e0330e0730e0330e0330e033
010c00002f7562c75629756267562f7562c75629746267462f7362c73629726267262f7162c7161d7061a706307562b7562775624756307562b7562774624746307362b7362772624726307162b7161b70618706
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010900002a75434770347650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100002966027660020702666025650040702265021650050701f6401f640070701d6401c640090701a630196300c07017620166200e07014620136101261010613066130e6030c6030b603086000760004600
__music__
00 00010507
00 0b020607
00 03044947
00 03040847
01 0304080a
00 0304080c
00 0d08070f
00 0e080710
00 0d081311
00 0e081412
00 03010507
00 03020607
00 07171815
00 16171809
00 195b1d09
00 1a5c1e09
00 191b1d09
00 1a1c1e09
00 191d1b09
00 1a1e1c09
00 0d1f0109
00 0e310209
00 0d081f09
00 0e083109
00 03040844
02 03040844
01 191d4309
00 1a1e4309
00 0d1f4309
02 0e314309
02 4e424344
00 41424344
00 20214344
00 20214344
01 20212223
02 20212524
01 2f2b2744
01 26272829
00 26272829
02 2a2c2d2e
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

