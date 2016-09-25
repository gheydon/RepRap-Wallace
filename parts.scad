
// bearing types
// [ description, size, length ]

LM6UU = [ "LL6UU", 12.5, 19.5 ];
LM8SUU = [ "LL8SUU", 15.5, 17.5 ];
LM8UU = [ "LL8UU", 15.5, 24.5 ];
LM10UU = [ "LL10UU", 19, 29 ];

// rod types
// [ description, rod size, recommend bearing ]

6mm_smooth_rod = [ "6mm Smooth Rod", 6, LM6UU ];
8mm_smooth_rod = [ "8mm Smooth Rod", 8, LM8UU ];
10mm_smooth_rod = [ "10mm Smooth Rod", 10, LM10UU ];

// nut type
// [ desxcription, nut size ]
M6_nut = [ "M6 Nut", 12 ];
M8_nut = [ "M8 Nut", 15 ];
M10_nut = [ "M10 Nut", 18 ];

// threaded rod
// [ description, rod size, rod nut size ]
M6_threaded_rod = [ "6mm Threaded Rod", 6, M6_nut ];
M8_threaded_rod = [ "8mm Threaded Rod", 8, M8_nut ];
M10_threaded_rod = [ "10mm Threaded Rod", 10, M10_nut ];

// motor type
// [ description, screw spacing, casing, height (add additional 4mm), motor shaft ]

NEMA14 = [ "NEMA14", 26, 31, 40, 5 ];
NEMA17 = [ "NEMA17", 38, 45, 55, 5 ];

// nut/bolt types
// [ description, thread size, nut size ]

m3 = [ "m3", 3, 6 ];
m4 = [ "m4", 4, 7.5 ];