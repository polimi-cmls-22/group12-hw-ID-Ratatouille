# group12-hw-ID-Ratatouille
Group 12 repository for the ID homework of CMLS 2022
![goku1](https://user-images.githubusercontent.com/63248437/171633422-bb0604ae-4130-49de-bec7-6a8d73cd49df.PNG)

# DragonBall FM

DragonBall FM is an hybrid between an FM synthesizer and a video game, designed for beginners to approach the world of FM synthesis and sound creation.
it exploits seven different presets, all entirely realized with FM alogrithms, to be used together with a MIDI input signal. The sound can be further modified by the user in many different ways, through of the aduino physical sensors.
In particular, DragonBall FM employs an Ambient Light sensor, a Triple axis Accelerometer and an analog potentiometer, to be used to arbitrarily set different sound effects.
These real-time changes, are also displayed in the GUI both in terms of labels and graphica elements (i.e. the color of the sky and the position of Gouku's character on the screen).

## First Run

In order to sart discovering FM synthesis thanks to Dragonball FM, you need to follow the steps below:

- First, connect the **MIDI keyboard**.
- Then, connect the **Arduino UNO board**, then open up **GUI_ino.ino** file with Arduino platform. Then press load button.
- Calibrate the Ambient Light Sensor, exposing it to the maximum and minimum light values within the first 5 sec ( marked by the lighting of the built-in led).
- Close **GUI_ino.ino** file so that the serial port is available.
- Open and run in sequence **main.sc** and **arduino.sc** files in SuperCollider. The connection between the board and the SC code happens in **arduino.sc** together with the OSC communication between SC and Processing, while **main.sc** contains all the infos regarding the final output sounds. 
- **!! IMPORTANT !!** In order not to have troubles concerning the link between SC and Processing, remeber to check and insert the correct **IP address** and the corresponding port, both in the Processing and SC codes.
- Open **GUI_tot.pde** file into **Processing** platform and wait for the GUI to load
- ***Discover FM synthesis having fun, thanks to DragonBall FM!! ***


