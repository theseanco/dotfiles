
	
	
	
	
	SuperCollider helpfile: DMXCue
	

    
    
    

	

DMXCue
set of DMX settings which make up one scene
Inherits from:: Object 

A DMXCue is a complete set of DMX channel settings, making up one moment/light situation in a performance. Values of the channels should be between 0 and 1; they are converted to the standard 8bit range when sent to the device.

Creation / Class Methods


*new(offset,maxch)
Create a new DMXCue. The arguments should be the same as the offset and maxChannels in the instance of DMX that you are using
offset
Index of the first channel (default 0)
maxch
Maximum index of channels (default 512)






Accessing Instance and Class Variables


merge(subcue)
Merge in a subcue into this cue.
subcue
An instance of DMXSubCue






put(id,val)
Put a value at a specific channel
val
Value
id
Channel id




at(id)
Get the value within the cue at the given DMX channel
id
The dmx channel requested





size
Returns the actual number of channels of the cue



asInt8
This method converts the settings to values between 0 and 255 which can be sent out as bytes to the device. Called by DMXDevice:sendDMX.

maxchannels_
  

maxchannels
Maximum index of channels (default 512)

channeloffset_
  


channeloffset
Index of the first channel (default 0)


data_
  

data
An Array with the data of the cue.




This helpfile was created with the class HelpFile2
 
