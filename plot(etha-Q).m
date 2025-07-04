% تعریف داده ها براساس واحد SI
Q = [0 0.031545 0.050472 0.06309 0.069399 0.075708 0.088326 0.094635]  % مترمکعب بر ثانیه
H = [35.7 34.1 32.2 30.1 28.7 26.3 21.5 17.4]  % متر
Density = 997   %kg/m^3
g = 9.81  % m/s^2
etha_motor = 0.9
V = 460  %Voltage
I = [18.0 26.2 31.0 33.9 35.2 36.3 38.0 39.0]   %AMPER
Power_factor = 0.875
% تعریف فرمول ها
P_electricity = etha_motor.*1.732.*V.*I.*Power_factor   %در فایل پروژه جریان در فرمول قید نشده بود!!!
P_hyd = Density.*g.*Q.*H
etha_total = P_hyd./P_electricity 
% رسم پلات برای بازده کل برحسب دبی
grid on
plot(Q,etha_total)

