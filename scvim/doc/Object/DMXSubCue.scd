
	
	
	
	
	SuperCollider helpfile: DMXSubCue
	

    
    
    

	

DMXSubCue
Settings for a subset of DMX channels
Inherits from:: Object 

DMXSubCue allows you to define settings for a subset of DMX channels, e.g. that make up a part of the light scene, that is used in combinations with different other parts of light scenes, or settings for a specific device, e.g. a strobe. Different DMXSubCues can be merged into one complete DMXCue, or faded in or set directly to the instance of DMX, which will then merge the subcue into the whole cue.

Creation / Class Methods


*new
Create a new DMXSubCue.



Accessing Instance and Class Variables


data
Data of the subcue. This is an instance of Order, so we can sparsely index the array.

put(id,val)
Put a channel value into the data
val
Value of the channel
id
DMX channel number




at(id)
Get a value at the specified channel.
id
DMX channel number






This helpfile was created with the class HelpFile2
 
