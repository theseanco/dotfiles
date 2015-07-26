
	
	
	
	
	SuperCollider helpfile: DMX
	

    
    
    

	

DMX
Class to manage DMX control from SC
Inherits from:: Object 

DMX is a standard theatre lightning protocol. This class provides methods to send out DMX via a DMXDevice.

Creation / Class Methods


*new
Create a new instance



Accessing Instance and Class Variables


device_
Set the DMXDevice to use for this instance of DMX.

device
The DMXDevice used.

setCue
Send the current cue to the DMXDevice


currentCue_
Set the current DMX settings for this moment. This should be an instance of DMXCue or DMXSubCue.

currentCue
The current DMX settings for this moment.

cues
An Array of possible cues.


fade(to,time,curve,timestep)
Fade from the current cue to a new cue.
time
Time of the fade
to
The target cue
curve
Curve of the fade (default linear)
timestep
Timestep to use (minimum is 40 milliseconds)




blackout(time,curve)
Do a blackout (turn all lights off)
time
Amount of time to fade out.
curve
Curve of the fade out.





channeloffset_
  

channeloffset
Starting channel for this set of DMX channels (default is channel 0)

maxchannels_
  

maxchannels
Maximum number of channels used. Defaults to 512 which is the maximum number of channels in one DMX universe.

fadeval
Current fading value.



This helpfile was created with the class HelpFile2
 
