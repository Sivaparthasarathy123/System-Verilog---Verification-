 Generator Class 
[0] Randomized Inputs: Write Enable = 1| Read Enable = 0| Data In = 40
[0] Randomized Inputs: Write Enable = 1| Read Enable = 0| Data In = 223
[0] Randomized Inputs: Write Enable = 1| Read Enable = 0| Data In = 184
[0] Randomized Inputs: Write Enable = 0| Read Enable = 1| Data In = 17
[0] Randomized Inputs: Write Enable = 0| Read Enable = 1| Data In = 92
[0] Randomized Inputs: Write Enable = 0| Read Enable = 1| Data In = 34
[0] Randomized Inputs: Write Enable = 1| Read Enable = 1| Data In = 71
[0] Randomized Inputs: Write Enable = 1| Read Enable = 1| Data In = 25
[0] Randomized Inputs: Write Enable = 1| Read Enable = 1| Data In = 194
 Driver Class 
Time = 5| Write Enable = 1| Read Enable = 0| Data In = 40| Data Out = 0| Full = 0| Empty = 0
  Monitor Class  
Time = 5| Write Enable = 0| Read Enable = 0| Data In = 0| Data Out = 0| Full = 0| Empty = 1
--- Scoreboard Check at 5 ---
 Driver Class 
Time = 15| Write Enable = 1| Read Enable = 0| Data In = 223| Data Out = 0| Full = 0| Empty = 0
  Monitor Class  
Time = 15| Write Enable = 1| Read Enable = 0| Data In = 40| Data Out = 0| Full = 0| Empty = 0
--- Scoreboard Check at 15 ---
[15] [Scoreboard] Stored: 40
 Driver Class 
Time = 25| Write Enable = 1| Read Enable = 0| Data In = 184| Data Out = 0| Full = 0| Empty = 0
  Monitor Class  
Time = 25| Write Enable = 1| Read Enable = 0| Data In = 223| Data Out = 0| Full = 0| Empty = 0
--- Scoreboard Check at 25 ---
[25] [Scoreboard] Stored: 223
 Driver Class 
Time = 35| Write Enable = 0| Read Enable = 1| Data In = 17| Data Out = 0| Full = 0| Empty = 0
  Monitor Class  
Time = 35| Write Enable = 1| Read Enable = 0| Data In = 184| Data Out = 0| Full = 0| Empty = 0
--- Scoreboard Check at 35 ---
[35] [Scoreboard] Stored: 184
 Driver Class 
Time = 45| Write Enable = 0| Read Enable = 1| Data In = 92| Data Out = 0| Full = 0| Empty = 0
  Monitor Class  
Time = 45| Write Enable = 0| Read Enable = 1| Data In = 17| Data Out = 0| Full = 0| Empty = 0
--- Scoreboard Check at 45 ---
[45] [Scoreboard] Popped: 40
 Driver Class 
Time = 55| Write Enable = 0| Read Enable = 1| Data In = 34| Data Out = 0| Full = 0| Empty = 0
  Monitor Class  
Time = 55| Write Enable = 0| Read Enable = 1| Data In = 92| Data Out = 40| Full = 0| Empty = 0
--- Scoreboard Check at 55 ---
[55] [PASS] Exp: 40, Act: 40
[55] [Scoreboard] Popped: 223
 Driver Class 
Time = 65| Write Enable = 1| Read Enable = 1| Data In = 71| Data Out = 0| Full = 0| Empty = 0
  Monitor Class  
Time = 65| Write Enable = 0| Read Enable = 1| Data In = 34| Data Out = 223| Full = 0| Empty = 1
--- Scoreboard Check at 65 ---
[65] [PASS] Exp: 223, Act: 223
 Driver Class 
Time = 75| Write Enable = 1| Read Enable = 1| Data In = 25| Data Out = 0| Full = 0| Empty = 0
  Monitor Class  
Time = 75| Write Enable = 1| Read Enable = 1| Data In = 71| Data Out = 184| Full = 0| Empty = 0
--- Scoreboard Check at 75 ---
[75] [Scoreboard] Stored: 71
[75] [Scoreboard] Popped: 184
 Driver Class 
Time = 85| Write Enable = 1| Read Enable = 1| Data In = 194| Data Out = 0| Full = 0| Empty = 0
  Monitor Class  
Time = 85| Write Enable = 1| Read Enable = 1| Data In = 25| Data Out = 184| Full = 0| Empty = 0
--- Scoreboard Check at 85 ---
[85] [PASS] Exp: 184, Act: 184
[85] [Scoreboard] Stored: 25
[85] [Scoreboard] Popped: 71
$finish called from file "testbench.sv", line 41.
$finish at simulation time                 1000
