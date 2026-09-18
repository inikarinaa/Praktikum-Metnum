%% ========================================================
%% SUB BAB: LOOPING
%% (for loop, for loop step, while loop, continue, break)
%% ========================================================

%% --- 1. For Loop (kondisi dasar) ---
disp('--- For Loop Dasar ---')
for k = 1:5
    p = k^3
end

%% --- 2. For Loop dengan Step ---
disp('--- For Loop dengan Step ---')
for j = 2:0.5:4
    q = j / 2
end

%% --- 3. While Loop ---
disp('--- While Loop ---')
p = 2;
while (p <= 6)
    q = p^2 + 3
    p = p + 1;
end

%% --- 4. Continue ---
disp('--- Continue ---')
for i = 1:5
    if (i == 3)
        continue
    end
    p = i^2
end

%% --- 5. Break ---
disp('--- Break ---')
for i = 1:5
    if (i == 4)
        break
    end
    p = i^3
end
