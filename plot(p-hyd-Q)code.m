% تعریف داده ها با تاکید موکد اینکه واحد ها SI هستد و داده های دیتاست ها هم
% دستی در اکسل SI شده اند
Density = 997 %kg/m^3
g = 9.81
Q = [0.004233418 0.003800076 0.003283399 0.002716721 0.002950059 0.002583385 0.002116709 0.002150043 0.001650033 0.001250025 0.00083335 0.000450009 0.000033334]   %m^3/s
P_suction = [-8000 -7000 -5000 -4000 -5000 -4000 -3000 -3000 -2000 -2000 -2000 -1000 -1000]
P_discharge = [6000 11000 18000 25000 21000 25000 29000 29000 32000 34000 35000 36000 36000]
delta_P = P_discharge - P_suction
% تعریف فرمول هد پمپ
H = (delta_P) ./ ((Density).*(g))
% تعریف فرمول توان هیدرولیکی
P_hyd = Density .* g .* Q .* H
% مثل نمودار هد- دبی برای اینجا هم باید سورت کنیم فراخوانی دبی رو از دیتاست
[Q_sorted, idx] = sort(Q)
P_sorted = P_hyd(idx)
% رسم نمودار
plot(Q_sorted,P_sorted)