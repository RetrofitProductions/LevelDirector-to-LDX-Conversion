# LevelDirector-to-LDX-Conversion

Level Director to Level Director X conversion tool using Lua and CoronaSDK.
Please see the main.lua file for more details as this needs to be modified before use.

Stuff it converts.

LDObjectLevel
Layers
LDObjectLevelPack
LDObjectRectangle 
LDObjectImage
LDObjectEllipse
LDObjectText
LDObjectButton
Any custom attributes any any of these objects.
Physics Settings

---------------
How to use
---------------

1. Simply setup you project the same way you set it up for coronasdk. Folder structure etc (this is important for the new LDP files to work)
For me, I had levels/projectfiles/ for my actual ldf files. and my exported levels were under the levels folder. 

2. Once you have the project setup, change the projectFileNames variable in main.lua to have the names of your ldf files that you want to convert. 
3. Set your projectFilePath to the location of the ldf files.
4. Set your imagePath to be linked from wherever you are going to export your ldx files to. 
5. Just run using coronasdk. The output will print progress and will say finished when its done. The final files are made next to your ldf files. 

