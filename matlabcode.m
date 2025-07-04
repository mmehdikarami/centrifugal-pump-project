Q_in = input('please give me a number for Flow rate from 3 to 100 (m^3/h): ')
H_in = input('please give me a number for Head from 10 to 75 (m): ')
if Q_in<3 || Q_in>100 || H_in<10 || H_in>75
    error('please give me another number: ')
end
pump_models = {'32-125','32-160','32-200','40-125','40-160','40-200','50-125','50-160','50-200'}
folder_model = 'C:\Users\Lenovo\Desktop\نمودار هد-دبی کل'
found = false
for pump = pump_models
    model = pump{1}
    model_file = [folder_model '\' model '.txt']
    H_Q_model_plot = readtable(model_file)
    Q = H_Q_model_plot{:,1}
    H = H_Q_model_plot{:,2}
    in_the_pump_range = inpolygon(Q_in,H_in,Q,H)
    if in_the_pump_range
        disp(['Suitable pump for you is: ' model])
        sutable_pump = model
        found = true
        break
    end
end
if ~found
    fprintf('sutable pump not found')
end

total_folder = 'C:\Users\Lenovo\Desktop\each_pump_folders'
sutable_pump_folder = [total_folder '\' 'pump ' sutable_pump]
..................................................................................................................
if strcmp(sutable_pump, '32-125')
    % کد برای یافتن قطر
    constant_diameter_lines = [110, 115, 120, 125, 130, 139]
    file_path = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 32-125'
    % مرحله 2: بررسی فاصله هر منحنی از نقطه ورودی
    for i = 1:length(constant_diameter_lines)
        D = constant_diameter_lines(i)
        file_name = sprintf('%s\\32-125_diametr_%d.txt', file_path, D)
        data = load(file_name)   % خوندن دیتاهای ستونی دیجیت شده
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)   % با دستور interp1 مقدار هد رو برای دبی Q_in پیدا می‌کنه.
        diff(i) = abs(H_interp(i) - H_in)
    end
    % مرحله 3: پیدا کردن دو منحنی نزدیک
    [~, idx] = sort(diff)   %idx یعنی: «فقط شماره (index) اون‌هایی که کوچیک‌ترن رو بده»
    d1 = constant_diameter_lines(idx(1))   % نزدیک‌ترین منحنی
    d2 = constant_diameter_lines(idx(2))   % دومی نزدیک‌ترین منحنی
    h1 = H_interp(idx(1))    % هد متناظر با اولی
    h2 = H_interp(idx(2))    % هد متناظر با دومی
    % مرحله 4: میان‌یابی قطر
    diff1 = abs(h1 - H_in)   
    diff2 = abs(h2 - H_in)
    D_interpolation = (d1 * diff2 + d2 * diff1) / (diff1 + diff2)
    fprintf('impeller diameter: %.2f mm\n', D_interpolation)
    % کد برای بازده
    constant_etha_curves = [50, 55, 59, 60, 62, 63, 63.5]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 32-125'
    for i = 1:length(constant_etha_curves)
        E = constant_etha_curves(i);
        if mod(E,1)==0
            filename = sprintf('%s\\32-125_etha_%d.txt', folder, E);   % برای اعداد صحیح
        else
            filename = sprintf('%s\\32-125_etha_%.1f.txt', folder, E); % برای 63.5 و اعشاری‌ها
        end
        data = load(filename);
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)
        diff(i) = abs(H_interp(i) - H_in)
    end
    [~, idx] = sort(diff)
    e1 = constant_etha_curves(idx(1))
    e2 = constant_etha_curves(idx(2))
    h1 = H_interp(idx(1))
    h2 = H_interp(idx(2))
    diff1 = abs(h1 - H_in);
    diff2 = abs(h2 - H_in);
    E_interpolation = (e1 * diff2 + e2 * diff1) / (diff1 + diff2)
    fprintf('efficiency: %.2f %%\n', E_interpolation)
    % کد برای توان
    % فرض: Q_in و D_interpolation از مراحل قبل موجودن

    power_diameters = [110, 115, 120, 125, 130, 139];
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 32-125'
    [~, idx] = sort(abs(power_diameters - D_interpolation))
    d1 = power_diameters(idx(1))
    d2 = power_diameters(idx(2))
    file1 = sprintf('%s\\32-125_power_%d.txt', folder, d1)
    file2 = sprintf('%s\\32-125_power_%d.txt', folder, d2)
    data1 = load(file1)
    data2 = load(file2)
    Q1 = data1(:,1)
    P1 = data1(:,2)
    Q2 = data2(:,1) 
    P2 = data2(:,2)
    P_1 = interp1(Q1, P1, Q_in)
    P_2 = interp1(Q2, P2, Q_in)
    P_interpolation = (P_1 * (d2 - D_interpolation) + P_2 * (D_interpolation - d1)) / (d2 - d1)    %میان یابی خطی
    fprintf('Power: %.2f kW\n', P_interpolation)
end



if strcmp(sutable_pump, '32-160')
    % کد برای یافتن قطر
    constant_diameter_lines_2 = [130, 140, 150, 160, 169]
    file_path_2 = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 32-160'
    % مرحله 2: بررسی فاصله هر منحنی از نقطه ورودی
    for i = 1:length(constant_diameter_lines_2)
        D = constant_diameter_lines_2(i)
        file_name_2 = sprintf('%s\\32-160_diametr_%d.txt', file_path_2, D)
        data = load(file_name_2)   % خوندن دیتاهای ستونی دیجیت شده
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)   % با دستور interp1 مقدار هد رو برای دبی Q_in پیدا می‌کنه.
        diff(i) = abs(H_interp(i) - H_in)
    end
    % پیدا کردن دو منحنی نزدیک
    [~, idx] = sort(diff)   
    d1 = constant_diameter_lines_2(idx(1))   % نزدیک‌ترین منحنی
    d2 = constant_diameter_lines_2(idx(2))   % دومی نزدیک‌ترین منحنی
    h1 = H_interp(idx(1))                    % هد متناظر با اولی
    h2 = H_interp(idx(2))                    % هد متناظر با دومی
    % میان یابی قطرها
    diff1 = abs(h1 - H_in)   
    diff2 = abs(h2 - H_in)
    D_interpolation = (d1 * diff2 + d2 * diff1) / (diff1 + diff2)
    fprintf('impeller diameter: %.2f mm\n', D_interpolation)
    % کد برای بازده
    constant_etha_curves_2 = [45, 50, 55, 58, 60, 62, 63.5]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 32-160'
    for i = 1:length(constant_etha_curves_2)
        E = constant_etha_curves_2(i);
        if mod(E,1)==0
            filename = sprintf('%s\\32-160_etha_%d.txt', folder, E);   % برای اعداد صحیح
        else
            filename = sprintf('%s\\32-160_etha_%.1f.txt', folder, E); % برای 63.5 و اعشاری‌ها
        end
        data = load(filename);
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)
        diff(i) = abs(H_interp(i) - H_in)
    end
    [~, idx] = sort(diff)
    e1 = constant_etha_curves(idx(1))
    e2 = constant_etha_curves(idx(2))
    h1 = H_interp(idx(1))
    h2 = H_interp(idx(2))
    diff1 = abs(h1 - H_in);
    diff2 = abs(h2 - H_in);
    E_interpolation = (e1 * diff2 + e2 * diff1) / (diff1 + diff2)
    fprintf('efficiency: %.2f %%\n', E_interpolation)
    % کد برای توان
    power_diameters_2 = [130, 140, 150, 160, 169];
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 32-160'
    [~, idx] = sort(abs(power_diameters_2 - D_interpolation))
    d1 = power_diameters_2(idx(1))
    d2 = power_diameters_2(idx(2))
    file1 = sprintf('%s\\32-160_power_%d.txt', folder, d1)
    file2 = sprintf('%s\\32-160_power_%d.txt', folder, d2)
    data1 = load(file1)
    data2 = load(file2)
    Q1 = data1(:,1)
    P1 = data1(:,2)
    Q2 = data2(:,1) 
    P2 = data2(:,2)
    P_1 = interp1(Q1, P1, Q_in)
    P_2 = interp1(Q2, P2, Q_in)
    P_interpolation = (P_1 * (d2 - D_interpolation) + P_2 * (D_interpolation - d1)) / (d2 - d1)    %میان یابی خطی
    fprintf('Power: %.2f kW\n', P_interpolation)
end


if strcmp(sutable_pump, '32-200')
    % کد برای یافتن قطر
    constant_diameter_lines_3 = [170, 180, 190, 200, 209]
    file_path_3 = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 32-200'
    % مرحله 2: بررسی فاصله هر منحنی از نقطه ورودی
    for i = 1:length(constant_diameter_lines_3)
        D = constant_diameter_lines_3(i)
        file_name_3 = sprintf('%s\\32-200_diametr_%d.txt', file_path_3, D)
        data = load(file_name_3)   % خوندن دیتاهای ستونی دیجیت شده
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)   % با دستور interp1 مقدار هد رو برای دبی Q_in پیدا می‌کنه.
        diff(i) = abs(H_interp(i) - H_in)
    end
    % پیدا کردن دو منحنی نزدیک
    [~, idx] = sort(diff)   
    d1 = constant_diameter_lines_3(idx(1))   % نزدیک‌ترین منحنی
    d2 = constant_diameter_lines_3(idx(2))   % دومی نزدیک‌ترین منحنی
    h1 = H_interp(idx(1))                    % هد متناظر با اولی
    h2 = H_interp(idx(2))                    % هد متناظر با دومی
    % میان یابی قطرها
    diff1 = abs(h1 - H_in)   
    diff2 = abs(h2 - H_in)
    D_interpolation = (d1 * diff2 + d2 * diff1) / (diff1 + diff2)
    fprintf('impeller diameter: %.2f mm\n', D_interpolation)
    % کد برای بازده
    constant_etha_curves_3 = [20, 25, 30, 35, 40, 42, 44, 45]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 32-200'
    for i = 1:length(constant_etha_curves_3)
        E = constant_etha_curves_3(i);
        if mod(E,1)==0
            filename = sprintf('%s\\32-200_etha_%d.txt', folder, E);   % برای اعداد صحیح
        else
            filename = sprintf('%s\\32-200_etha_%.1f.txt', folder, E); % برای 63.5 و اعشاری‌ها
        end
        data = load(filename);
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)
        diff(i) = abs(H_interp(i) - H_in)
    end
    [~, idx] = sort(diff)
    e1 = constant_etha_curves_3(idx(1))
    e2 = constant_etha_curves_3(idx(2))
    h1 = H_interp(idx(1))
    h2 = H_interp(idx(2))
    diff1 = abs(h1 - H_in);
    diff2 = abs(h2 - H_in);
    E_interpolation = (e1 * diff2 + e2 * diff1) / (diff1 + diff2)
    fprintf('efficiency: %.2f %%\n', E_interpolation)
    % کد برای توان
    power_diameters_3 = [170, 180, 190, 200, 209];
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 32-200'
    [~, idx] = sort(abs(power_diameters_3 - D_interpolation))
    d1 = power_diameters_3(idx(1))
    d2 = power_diameters_3(idx(2))
    file1 = sprintf('%s\\32-200_power_%d.txt', folder, d1)
    file2 = sprintf('%s\\32-200_power_%d.txt', folder, d2)
    data1 = load(file1)
    data2 = load(file2)
    Q1 = data1(:,1)
    P1 = data1(:,2)
    Q2 = data2(:,1) 
    P2 = data2(:,2)
    P_1 = interp1(Q1, P1, Q_in)
    P_2 = interp1(Q2, P2, Q_in)
    P_interpolation = (P_1 * (d2 - D_interpolation) + P_2 * (D_interpolation - d1)) / (d2 - d1)    %میان یابی خطی
    fprintf('Power: %.2f kW\n', P_interpolation)    
end



if strcmp(sutable_pump, '40-125')
    % کد برای یافتن قطر
    constant_diameter_lines_4 = [110, 115, 120, 125, 130, 135, 139]
    file_path_4 = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 40-125'
    % مرحله 2: بررسی فاصله هر منحنی از نقطه ورودی
    for i = 1:length(constant_diameter_lines_4)
        D = constant_diameter_lines_4(i)
        file_name_4 = sprintf('%s\\40-125_diametr_%d.txt', file_path_4, D)
        data = load(file_name_4)   % خوندن دیتاهای ستونی دیجیت شده
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)   % با دستور interp1 مقدار هد رو برای دبی Q_in پیدا می‌کنه.
        diff(i) = abs(H_interp(i) - H_in)
    end
    % پیدا کردن دو منحنی نزدیک
    [~, idx] = sort(diff)   
    d1 = constant_diameter_lines_4(idx(1))   % نزدیک‌ترین منحنی
    d2 = constant_diameter_lines_4(idx(2))   % دومی نزدیک‌ترین منحنی
    h1 = H_interp(idx(1))                    % هد متناظر با اولی
    h2 = H_interp(idx(2))                    % هد متناظر با دومی
    % میان یابی قطرها
    diff1 = abs(h1 - H_in)   
    diff2 = abs(h2 - H_in)
    D_interpolation = (d1 * diff2 + d2 * diff1) / (diff1 + diff2)
    fprintf('impeller diameter: %.2f mm\n', D_interpolation)    
    % کد برای بازده
    constant_etha_curves_4 = [50, 55, 60, 65, 68, 70]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 40-125'
    for i = 1:length(constant_etha_curves_4)
        E = constant_etha_curves_4(i);
        if mod(E,1)==0
            filename = sprintf('%s\\40-125_etha_%d.txt', folder, E);   % برای اعداد صحیح
        else
            filename = sprintf('%s\\40-125_etha_%.1f.txt', folder, E); % برای 63.5 و اعشاری‌ها
        end
        data = load(filename);
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)
        diff(i) = abs(H_interp(i) - H_in)
    end
    [~, idx] = sort(diff)
    e1 = constant_etha_curves_4(idx(1))
    e2 = constant_etha_curves_4(idx(2))
    h1 = H_interp(idx(1))
    h2 = H_interp(idx(2))
    diff1 = abs(h1 - H_in);
    diff2 = abs(h2 - H_in);
    E_interpolation = (e1 * diff2 + e2 * diff1) / (diff1 + diff2)
    fprintf('efficiency: %.2f %%\n', E_interpolation)
    % کد برای توان
    power_diameters_4 = [110, 115, 120, 125, 130, 135, 139];
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 40-125'
    [~, idx] = sort(abs(power_diameters_4 - D_interpolation))
    d1 = power_diameters_4(idx(1))
    d2 = power_diameters_4(idx(2))
    file1 = sprintf('%s\\40-125_power_%d.txt', folder, d1)
    file2 = sprintf('%s\\40-125_power_%d.txt', folder, d2)
    data1 = load(file1)
    data2 = load(file2)
    Q1 = data1(:,1)
    P1 = data1(:,2)
    Q2 = data2(:,1) 
    P2 = data2(:,2)
    P_1 = interp1(Q1, P1, Q_in)
    P_2 = interp1(Q2, P2, Q_in)
    P_interpolation = (P_1 * (d2 - D_interpolation) + P_2 * (D_interpolation - d1)) / (d2 - d1)    %میان یابی خطی
    fprintf('Power: %.2f kW\n', P_interpolation)
end



if strcmp(sutable_pump, '40-160')
    % کد برای یافتن قطر
    constant_diameter_lines_5 = [130, 140, 150, 160, 169]
    file_path_5 = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 40-160'
    % مرحله 2: بررسی فاصله هر منحنی از نقطه ورودی
    for i = 1:length(constant_diameter_lines_5)
        D = constant_diameter_lines_5(i)
        file_name_5 = sprintf('%s\\40-160_diametr_%d.txt', file_path_5, D)
        data = load(file_name_5)   % خوندن دیتاهای ستونی دیجیت شده
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)   % با دستور interp1 مقدار هد رو برای دبی Q_in پیدا می‌کنه.
        diff(i) = abs(H_interp(i) - H_in)
    end
    % پیدا کردن دو منحنی نزدیک
    [~, idx] = sort(diff)   
    d1 = constant_diameter_lines_5(idx(1))   % نزدیک‌ترین منحنی
    d2 = constant_diameter_lines_5(idx(2))   % دومی نزدیک‌ترین منحنی
    h1 = H_interp(idx(1))                    % هد متناظر با اولی
    h2 = H_interp(idx(2))                    % هد متناظر با دومی
    % میان یابی قطرها
    diff1 = abs(h1 - H_in)   
    diff2 = abs(h2 - H_in)
    D_interpolation = (d1 * diff2 + d2 * diff1) / (diff1 + diff2)
    fprintf('impeller diameter: %.2f mm\n', D_interpolation)
    % کد برای بازده
    constant_etha_curves_5 = [45, 50, 55, 60, 64, 66, 67.5]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 40-160'
    for i = 1:length(constant_etha_curves_5)
        E = constant_etha_curves_5(i);
        if mod(E,1)==0
            filename = sprintf('%s\\40-160_etha_%d.txt', folder, E);   % برای اعداد صحیح
        else
            filename = sprintf('%s\\40-160_etha_%.1f.txt', folder, E); % برای 63.5 و اعشاری‌ها
        end
        data = load(filename);
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)
        diff(i) = abs(H_interp(i) - H_in)
    end
    [~, idx] = sort(diff)
    e1 = constant_etha_curves_5(idx(1))
    e2 = constant_etha_curves_5(idx(2))
    h1 = H_interp(idx(1))
    h2 = H_interp(idx(2))
    diff1 = abs(h1 - H_in);
    diff2 = abs(h2 - H_in);
    E_interpolation = (e1 * diff2 + e2 * diff1) / (diff1 + diff2)
    fprintf('efficiency: %.2f %%\n', E_interpolation)
    % کد برای توان
    power_diameters_5 = [130, 140, 150, 160, 169]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 40-160'
    [~, idx] = sort(abs(power_diameters_5 - D_interpolation))
    d1 = power_diameters_5(idx(1))
    d2 = power_diameters_5(idx(2))
    file1 = sprintf('%s\\40-160_power_%d.txt', folder, d1)
    file2 = sprintf('%s\\40-160_power_%d.txt', folder, d2)
    data1 = load(file1)
    data2 = load(file2)
    Q1 = data1(:,1)
    P1 = data1(:,2)
    Q2 = data2(:,1) 
    P2 = data2(:,2)
    P_1 = interp1(Q1, P1, Q_in)
    P_2 = interp1(Q2, P2, Q_in)
    P_interpolation = (P_1 * (d2 - D_interpolation) + P_2 * (D_interpolation - d1)) / (d2 - d1)    %میان یابی خطی
    fprintf('Power: %.2f kW\n', P_interpolation)
end


if strcmp(sutable_pump, '40-200')
    % کد برای یافتن قطر
    constant_diameter_lines_6 = [170, 180, 190, 200, 209]
    file_path_6 = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 40-200'
    % مرحله 2: بررسی فاصله هر منحنی از نقطه ورودی
    for i = 1:length(constant_diameter_lines_6)
        D = constant_diameter_lines_6(i)
        file_name_6 = sprintf('%s\\40-200_diametr_%d.txt', file_path_6, D)
        data = load(file_name_6)   % خوندن دیتاهای ستونی دیجیت شده
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)   % با دستور interp1 مقدار هد رو برای دبی Q_in پیدا می‌کنه.
        diff(i) = abs(H_interp(i) - H_in)
    end
    % پیدا کردن دو منحنی نزدیک
    [~, idx] = sort(diff)   
    d1 = constant_diameter_lines_6(idx(1))   % نزدیک‌ترین منحنی
    d2 = constant_diameter_lines_6(idx(2))   % دومی نزدیک‌ترین منحنی
    h1 = H_interp(idx(1))                    % هد متناظر با اولی
    h2 = H_interp(idx(2))                    % هد متناظر با دومی
    % میان یابی قطرها
    diff1 = abs(h1 - H_in)   
    diff2 = abs(h2 - H_in)
    D_interpolation = (d1 * diff2 + d2 * diff1) / (diff1 + diff2)
    fprintf('impeller diameter: %.2f mm\n', D_interpolation)
    % کد برای بازده
    constant_etha_curves_6 = [35, 40, 45, 50, 54, 57, 59, 60]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 40-200'
    for i = 1:length(constant_etha_curves_6)
        E = constant_etha_curves_6(i);
        if mod(E,1)==0
            filename = sprintf('%s\\40-200_etha_%d.txt', folder, E);   % برای اعداد صحیح
        else
            filename = sprintf('%s\\40-200_etha_%.1f.txt', folder, E); % برای 63.5 و اعشاری‌ها
        end
        data = load(filename);
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)
        diff(i) = abs(H_interp(i) - H_in)
    end
    [~, idx] = sort(diff)
    e1 = constant_etha_curves_6(idx(1))
    e2 = constant_etha_curves_6(idx(2))
    h1 = H_interp(idx(1))
    h2 = H_interp(idx(2))
    diff1 = abs(h1 - H_in);
    diff2 = abs(h2 - H_in);
    E_interpolation = (e1 * diff2 + e2 * diff1) / (diff1 + diff2)
    fprintf('efficiency: %.2f %%\n', E_interpolation)
    % کد برای توان
    power_diameters_6 = [170, 180, 190, 200, 209]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 40-200'
    [~, idx] = sort(abs(power_diameters_6 - D_interpolation))
    d1 = power_diameters_6(idx(1))
    d2 = power_diameters_6(idx(2))
    file1 = sprintf('%s\\40-200_power_%d.txt', folder, d1)
    file2 = sprintf('%s\\40-200_power_%d.txt', folder, d2)
    data1 = load(file1)
    data2 = load(file2)
    Q1 = data1(:,1)
    P1 = data1(:,2)
    Q2 = data2(:,1) 
    P2 = data2(:,2)
    P_1 = interp1(Q1, P1, Q_in)
    P_2 = interp1(Q2, P2, Q_in)
    P_interpolation = (P_1 * (d2 - D_interpolation) + P_2 * (D_interpolation - d1)) / (d2 - d1)    %میان یابی خطی
    fprintf('Power: %.2f kW\n', P_interpolation)
end


if strcmp(sutable_pump, '50-125')
    % کد برای یافتن قطر
    constant_diameter_lines_7 = [110, 115, 120, 125, 130, 139]
    file_path_7 = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 50-125'
    % مرحله 2: بررسی فاصله هر منحنی از نقطه ورودی
    for i = 1:length(constant_diameter_lines_7)
        D = constant_diameter_lines_7(i)
        file_name_7 = sprintf('%s\\50-125_diametr_%d.txt', file_path_7, D)
        data = load(file_name_7)   % خوندن دیتاهای ستونی دیجیت شده
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)   % با دستور interp1 مقدار هد رو برای دبی Q_in پیدا می‌کنه.
        diff(i) = abs(H_interp(i) - H_in)
    end
    % پیدا کردن دو منحنی نزدیک
    [~, idx] = sort(diff)   
    d1 = constant_diameter_lines_7(idx(1))   % نزدیک‌ترین منحنی
    d2 = constant_diameter_lines_7(idx(2))   % دومی نزدیک‌ترین منحنی
    h1 = H_interp(idx(1))                    % هد متناظر با اولی
    h2 = H_interp(idx(2))                    % هد متناظر با دومی
    % میان یابی قطرها
    diff1 = abs(h1 - H_in)   
    diff2 = abs(h2 - H_in)
    D_interpolation = (d1 * diff2 + d2 * diff1) / (diff1 + diff2)
    fprintf('impeller diameter: %.2f mm\n', D_interpolation)
    % کد برای بازده
    constant_etha_curves_7 = [60, 70, 75, 77, 78]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 50-125'
    for i = 1:length(constant_etha_curves_7)
        E = constant_etha_curves_7(i);
        if mod(E,1)==0
            filename = sprintf('%s\\50-125_etha_%d.txt', folder, E);   % برای اعداد صحیح
        else
            filename = sprintf('%s\\50-125_etha_%.1f.txt', folder, E); % برای 63.5 و اعشاری‌ها
        end
        data = load(filename);
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)
        diff(i) = abs(H_interp(i) - H_in)
    end
    [~, idx] = sort(diff)
    e1 = constant_etha_curves_7(idx(1))
    e2 = constant_etha_curves_7(idx(2))
    h1 = H_interp(idx(1))
    h2 = H_interp(idx(2))
    diff1 = abs(h1 - H_in);
    diff2 = abs(h2 - H_in);
    E_interpolation = (e1 * diff2 + e2 * diff1) / (diff1 + diff2)
    fprintf('efficiency: %.2f %%\n', E_interpolation)
    % کد برای توان
    power_diameters_7 = [110, 115, 120, 125, 130, 139]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 50-125'
    [~, idx] = sort(abs(power_diameters_7 - D_interpolation))
    d1 = power_diameters_7(idx(1))
    d2 = power_diameters_7(idx(2))
    file1 = sprintf('%s\\50-125_power_%d.txt', folder, d1)
    file2 = sprintf('%s\\50-125_power_%d.txt', folder, d2)
    data1 = load(file1)
    data2 = load(file2)
    Q1 = data1(:,1)
    P1 = data1(:,2)
    Q2 = data2(:,1) 
    P2 = data2(:,2)
    P_1 = interp1(Q1, P1, Q_in)
    P_2 = interp1(Q2, P2, Q_in)
    P_interpolation = (P_1 * (d2 - D_interpolation) + P_2 * (D_interpolation - d1)) / (d2 - d1)    %میان یابی خطی
    fprintf('Power: %.2f kW\n', P_interpolation)
end

if strcmp(sutable_pump, '50-160')
    % کد برای یافتن قطر
    constant_diameter_lines_8 = [130, 140, 150, 160, 169]
    file_path_8 = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 50-160'
    % مرحله 2: بررسی فاصله هر منحنی از نقطه ورودی
    for i = 1:length(constant_diameter_lines_8)
        D = constant_diameter_lines_8(i)
        file_name_8 = sprintf('%s\\50-160_diametr_%d.txt', file_path_8, D)
        data = load(file_name_8)   % خوندن دیتاهای ستونی دیجیت شده
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)   % با دستور interp1 مقدار هد رو برای دبی Q_in پیدا می‌کنه.
        diff(i) = abs(H_interp(i) - H_in)
    end
    % پیدا کردن دو منحنی نزدیک
    [~, idx] = sort(diff)   
    d1 = constant_diameter_lines_8(idx(1))   % نزدیک‌ترین منحنی
    d2 = constant_diameter_lines_8(idx(2))   % دومی نزدیک‌ترین منحنی
    h1 = H_interp(idx(1))                    % هد متناظر با اولی
    h2 = H_interp(idx(2))                    % هد متناظر با دومی
    % میان یابی قطرها
    diff1 = abs(h1 - H_in)   
    diff2 = abs(h2 - H_in)
    D_interpolation = (d1 * diff2 + d2 * diff1) / (diff1 + diff2)
    fprintf('impeller diameter: %.2f mm\n', D_interpolation)
    % کد برای بازده
    constant_etha_curves_8 = [55, 60, 65, 70, 73, 75, 76]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 50-160'
    for i = 1:length(constant_etha_curves_8)
        E = constant_etha_curves_8(i);
        if mod(E,1)==0
            filename = sprintf('%s\\50-160_etha_%d.txt', folder, E);   % برای اعداد صحیح
        else
            filename = sprintf('%s\\50-160_etha_%.1f.txt', folder, E); % برای 63.5 و اعشاری‌ها
        end
        data = load(filename);
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)
        diff(i) = abs(H_interp(i) - H_in)
    end
    [~, idx] = sort(diff)
    e1 = constant_etha_curves_8(idx(1))
    e2 = constant_etha_curves_8(idx(2))
    h1 = H_interp(idx(1))
    h2 = H_interp(idx(2))
    diff1 = abs(h1 - H_in);
    diff2 = abs(h2 - H_in);
    E_interpolation = (e1 * diff2 + e2 * diff1) / (diff1 + diff2)
    fprintf('efficiency: %.2f %%\n', E_interpolation)
    % کد برای توان
    power_diameters_8 = [130, 140, 150, 160, 169]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 50-160'
    [~, idx] = sort(abs(power_diameters_8 - D_interpolation))
    d1 = power_diameters_8(idx(1))
    d2 = power_diameters_8(idx(2))
    file1 = sprintf('%s\\50-160_power_%d.txt', folder, d1)
    file2 = sprintf('%s\\50-160_power_%d.txt', folder, d2)
    data1 = load(file1)
    data2 = load(file2)
    Q1 = data1(:,1)
    P1 = data1(:,2)
    Q2 = data2(:,1) 
    P2 = data2(:,2)
    P_1 = interp1(Q1, P1, Q_in)
    P_2 = interp1(Q2, P2, Q_in)
    P_interpolation = (P_1 * (d2 - D_interpolation) + P_2 * (D_interpolation - d1)) / (d2 - d1)    %میان یابی خطی
    fprintf('Power: %.2f kW\n', P_interpolation)
end


if strcmp(sutable_pump, '50-200')
    % کد برای یافتن قطر
    constant_diameter_lines_9 = [170, 180, 190, 200, 209]
    file_path_9 = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 50-200'
    % مرحله 2: بررسی فاصله هر منحنی از نقطه ورودی
    for i = 1:length(constant_diameter_lines_9)
        D = constant_diameter_lines_9(i)
        file_name_9 = sprintf('%s\\50-200_diametr_%d.txt', file_path_9, D)
        data = load(file_name_9)   % خوندن دیتاهای ستونی دیجیت شده
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)   % با دستور interp1 مقدار هد رو برای دبی Q_in پیدا می‌کنه.
        diff(i) = abs(H_interp(i) - H_in)
    end
    % پیدا کردن دو منحنی نزدیک
    [~, idx] = sort(diff)   
    d1 = constant_diameter_lines_9(idx(1))   % نزدیک‌ترین منحنی
    d2 = constant_diameter_lines_9(idx(2))   % دومی نزدیک‌ترین منحنی
    h1 = H_interp(idx(1))                    % هد متناظر با اولی
    h2 = H_interp(idx(2))                    % هد متناظر با دومی
    % میان یابی قطرها
    diff1 = abs(h1 - H_in)   
    diff2 = abs(h2 - H_in)
    D_interpolation = (d1 * diff2 + d2 * diff1) / (diff1 + diff2)
    fprintf('impeller diameter: %.2f mm\n', D_interpolation)
    % کد برای بازده
    constant_etha_curves_9 = [50, 55, 60, 65, 68, 70, 72, 73]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 50-200'
    for i = 1:length(constant_etha_curves_9)
        E = constant_etha_curves_9(i);
        if mod(E,1)==0
            filename = sprintf('%s\\50-200_etha_%d.txt', folder, E);   % برای اعداد صحیح
        else
            filename = sprintf('%s\\50-200_etha_%.1f.txt', folder, E); % برای 63.5 و اعشاری‌ها
        end
        data = load(filename);
        Q = data(:,1)
        H = data(:,2)
        H_interp(i) = interp1(Q, H, Q_in)
        diff(i) = abs(H_interp(i) - H_in)
    end
    [~, idx] = sort(diff)
    e1 = constant_etha_curves_9(idx(1))
    e2 = constant_etha_curves_9(idx(2))
    h1 = H_interp(idx(1))
    h2 = H_interp(idx(2))
    diff1 = abs(h1 - H_in);
    diff2 = abs(h2 - H_in);
    E_interpolation = (e1 * diff2 + e2 * diff1) / (diff1 + diff2)
    fprintf('efficiency: %.2f %%\n', E_interpolation)
    % کد برای توان
    power_diameters_9 = [170, 180, 190, 200, 209]
    folder = 'C:\Users\Lenovo\Desktop\each_pump_folders\pump 50-200'
    [~, idx] = sort(abs(power_diameters_9 - D_interpolation))
    d1 = power_diameters_9(idx(1))
    d2 = power_diameters_9(idx(2))
    file1 = sprintf('%s\\50-200_power_%d.txt', folder, d1)
    file2 = sprintf('%s\\50-200_power_%d.txt', folder, d2)
    data1 = load(file1)
    data2 = load(file2)
    Q1 = data1(:,1)
    P1 = data1(:,2)
    Q2 = data2(:,1) 
    P2 = data2(:,2)
    P_1 = interp1(Q1, P1, Q_in)
    P_2 = interp1(Q2, P2, Q_in)
    P_interpolation = (P_1 * (d2 - D_interpolation) + P_2 * (D_interpolation - d1)) / (d2 - d1)    %میان یابی خطی
    fprintf('Power: %.2f kW\n', P_interpolation)
end