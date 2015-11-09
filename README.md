# lifyo-live-map
LiF:YO - Life is feudal : Your Own - live map - PROTOTYPE

--------------------------------------------------------------------------------

!!! Still work in progress here !!!
!!! Still work in progress here !!!
!!! Still work in progress here !!!

Because this is my first repository on github I say sorry for my mistakes!
If somebody has tips for me... shoot.

I think I only used free stuff, published on git and so on... 
My stuff can be used, copied, changed without any limitation.
What licence fits best for this scenario?
But I would be happy if you give me short notice that I see it live on your server ;)
Cheers & Thanks!

!!! Still work in progress here !!!
!!! Still work in progress here !!!
!!! Still work in progress here !!!

Introduction
------------

My previous blog (with screenshots and video) about the map : http://lif-tools.blogspot.de/

LiF:YO - Life is feudal : Your Own is a medieval sandbox game: http://lifeisfeudal.com/

I played this game with some friends and we came up with the idea to make a nice map of our server.
Because I wanted to learn about node.js and some html5 client programming including map technologies I accepted this task.

Currently it is in a very early state. I am no web expert so the code is very very ugly in this prototype.
Unfortunately I have no time to continue the work on this... working on some other stuff ;)

But: Many server administrators asked for this map. So I decided to provide you with what I got so far.
Please be not too hard on me... it is really a prototype which you can take and improve for your needs.

I am sorry that I cannot give a detailled description about the installation (lack of time) but if you try to install and run into problem... just ask here and we will figure it out.

I will also list the further ideas which we had and which we could not finish due to lack of time.


Features
--------
- Zoomable tile-map of the game Life is Feudal : Your own
- Shows active players and there movement LIVE (with sound and animation)
- Several flexible data layers like terrain, buildings, castles, roads, every single tree if you want ... 
- Several heat maps like historical player movement or building activity
- Gives map information like GeoDataId on mouse-click


Architecture
------------
- mysql-db (game database, we added a lot of objects, all in the "lt" (lif-tools) namespace)
- node.js map server (data fetch and push functionality)
- map client (inside node subdir public; using html5, leaflet, heatmaps, moving marker, sounds, speech, ...)


Thanks to / credits
---------------------------------------
- BITBOX Ltd. for the game "Life is Feudal : Your Own", the graphics and the data. Visit the official page or the game forum
- Time paradox allicance for providing a base map of the game
- Maps Icons Collection for their icons and the possibility to customize them
- Ritterspielgaming.de for the partnership, providing example data and being my alpha testers :-)
- Mike Gleason jr. for his tutorial about creating tile maps and his tool to generate the tiles for my first alpha map
- Stefano Cudini for his plugin Leaflet Panel Layers
- Vladimir Agafonkin for his plugin Leaflet.heat
- Ewoken for his plugin Leaflet.MovingMarker


Installation
------------

1) mysql objects
----------------
First of all you need to install the database objects into your mysql game database.
- backup your database
- some stuff you will not need for the map (e.g. durability repair stuff - please refer to my blog or the forest thinner...)
- if you are unsure what you do... don´t... you will break your game database
- a rough sequence to install: first of all the tables, then procedures & functions, then views, then triggers and after all: the two events... look at our file names... think... or ask if you are unsure!

2) node.js server
-----------------
- you will find the node.js installation basics on the web
- install all necessary node modules (npm, express, http, nodemon, socket.io, mysql) -> using npm will make it easier for you
- copy server.js and subdirectories and try to start server
- open the ports for node.js (listening port for web server) and port to connect to mysql database if it is remote

3) client
---------
- no installation needed, because node.js server should provide all files needed
- we all used Chrome or iexplorer and I am not sure if the map runs on other browsers

4) additional map grafics
-------------------------
- because of the big size my upload of the map tiles to github always broke
- if you want to see the colored game map, you will need this additional files
- download here : https://drive.google.com/folderview?id=0Bxx7uYuWxpcLaGdtSHpiTEE3TG8&usp=sharing
- unpack to public folder from node.js server

Further Ideas
-------------
- one map-server handles several game-servers / roles
- enable server to handle multiple mysql pools
- New Heat-Layer Building (hm_b)
- New Heat-Layer Deaths (hm_d)
- New Heat-Layer Fight (hm_f)
- New Data-Layer Trails (cp)
- New fun-layer (fun+event)
- New flexible Datalayer (flex)
- New Server-Datalayer (predefined landmarks)
- Map-server prerendering
- map-server statistics /layer / performance
- player layer should only show players of own guild
- checkbox in map client to disable sounds



