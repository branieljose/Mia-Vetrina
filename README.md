# impulso
Impulso project repo. 

RCB Group Project 2<br>

#Impulso
		

##Type of App:
**Web App** 

Later port it to Mobile/Tablet App <br>
(Attempt to keep this in mind may require converting it Apache Cordova(Wrapper type app) or using another app or attempting to making it responsive without compromising any of the features)

##Our Prototype/inspiration

** WallApp**
- http://www.ohmyprints.com/index/455/de/WallApp

##Purpose of the App:
Provide the user the ability to preview what a picture would look 

like on awall or in a room by giving the user the ability to drag 

and drop objects on a wall or in an area of a room, to 

color the wall.


##App Features and Requirements
**App Requirements**

- give the user the ability to move objects on a wall in a room.  Move Furniture around in different rooms (Frank has existing images--rooms, conference rooms and artwork)

- provide users with a choice of images in the system (stored on our mySQL db)

- provide user with ability to add a different wall color

- provide users with frame options. (Frame will default to canvas user will have ability to add a frame)

- want to use the artwork/photos and add framing

- give user the ability to change wall colors using a colorpicker(Benj Moore)

- give user the ability to drag and drop their own image(background, wall, room)



**DB Requirements** mySQL DB will store:<br>
**User Login/Authentication Data**<br>
**Images**<br>
- walls
- furniture
- rooms (conference rooms etc)
- artwork

**color charts**<br>
- Color charts to change wall color


##Establish system limits:
- user file types (acceptable image files types that user can upload to app)

- user file size limits.

- frame dimensions


##Minimum Technologies needed:
- API for colors picker

- npm masking may be used to to create smart objects

- **Multimedia technologies to use**
- Hovering drag and drop object (moving objects e.g. artwork)

- Technology for Creating the Layers (like in photoshop)

- Provide canned stuff such as Room (conference room, den)

- Need to find what to use in order to give user ability to add their own image and use it

- User will take a Take picture of wall

- technology that will give us the ability to make a background and a separate object to identify the wall and make that an editable object. 

- ability to Highlight their own wall change color of background

## Possibilities....
**npm packages to research**<br>
- https://www.npmjs.com/package/psd
psd (a general purpose Photoshop file parser. will convert a psd file (or layer) to png and vice versa) 

- https://www.npmjs.com/package/psd2html
psd2html - what it says (expect no npm doc just npm install psd2html)

- https://www.npmjs.com/package/html2pdf
html2psd - ditto 

-https://www.npmjs.com/package/react-dragula 
react-dragula this is a simple drag and drop element into a container.
see how it works-->> https://bevacqua.github.io/dragula/ 


**Non npm tech**
- https://i-like-robots.github.io/EasyZoom/  
easyzoom… it’s an IMAGE RESIZING/MOVING plugin for jquery.  Wallapp uses it. 

- http://automattic.github.io/Iris/ 
COLOR PICKER API for JQuery - it does require JQuery and JQueryUI.  You can find it here: 

- http://bgrins.github.io/spectrum/ 
Another more comprehensive COLOR PICKER is SPECTRUM. 

- http://bseth99.github.io/projects/canvas/3-html5-canvas-layers-blending.html
  http://codepen.io/adobe/pen/ryfzt
HTML5 CANVAS example
- CANVAS Hackathon --> https://www.youtube.com/watch?v=oiGo9sIi2E4&list=PLQHSrcR-RsBQSCvXWSUjEDOx3xmChPISp&index=7&t=3394s

- https://developer.mozilla.org/en-US/docs/Using_files_from_web_applications 
Using the FILE API, which was added to the DOM in HTML5, it's now possible for web content to ask the user to select local files and then read the contents of those files. This selection can be done by either using an HTML <input> element or by drag and drop.



If you want to use the DOM File API from extensions or other browser chrome code, you can; however, note there are some additional features to be aware of. See Using the DOM File API in chrome code for details. 
	

##Later
- Convert the web app to a mobile/tablet app 

- Ability to purchase item via this app but using a link to online storefront(Lowes). Shopping cart!


##Group Members: 
	Frank Villafane		Vincent Visconti
	Braniel Pichardo	Ivonne Komis
