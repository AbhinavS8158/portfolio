import os
import wave
import struct
import math

os.makedirs('assets/sounds', exist_ok=True)

sample_rate = 44100.0
duration = 0.05
frequency = 800.0

obj = wave.open('assets/sounds/click.wav','w')
obj.setnchannels(1)
obj.setsampwidth(2)
obj.setframerate(sample_rate)

for i in range(int(duration * sample_rate)):
    value = int(20000.0 * math.cos(2.0 * math.pi * frequency * i / sample_rate) * math.exp(-i/(sample_rate*0.01)))
    data = struct.pack('<h', value)
    obj.writeframesraw(data)

obj.close()
print("Sound generated successfully!")
