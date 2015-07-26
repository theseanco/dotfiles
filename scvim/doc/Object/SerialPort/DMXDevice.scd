
	
	
	
	
	SuperCollider helpfile: DMXDevice
	

    
    
    

	

DMXDevice
Base class for DMXDevices
Inherits from:: Object : SerialPort 

This class is a base class for DMX devices. It is a subclass of SerialPort, assuming that the hardware will show up as a SerialPort in the operating system. Currently there is only one subclass: EnttecDMXUSBPro.You should only need to create an instance of this class and set it as the device to an instance of DMX. No further direct interaction is needed from your code.

Creation / Class Methods




Accessing Instance and Class Variables


sendDMX(cue)
Send out a cue with the device. The cue should be an instance of DMXCue. This method is called from the DMX class, you should not need to set it directly.
cue
An instance of DMXCue




createFooter
Should be implemented by the subclass, and provide any bytes that the device needs at the end of the message.

createSendHeader(data_size)
Should be implemented by the subclass, and provide any bytes that the device needs at the beginning of the message. This method is called from sendDMX.
data_size
The Enttec sends the datasize in the header. This method is called from sendDMX.






This helpfile was created with the class HelpFile2
 
