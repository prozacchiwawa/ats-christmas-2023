fn m1 (): int = (0 - 1)

val nvert = 325
val ntri = 391

val vert =
    (arrszref)$arrpsz{struct_vertex}(
        vertex(0,0,0),
        vertex(14000,m1() * 0,10000),
        vertex(14000,1678,4000),
        vertex(14000,1678,10000),
        vertex(14000,m1() * 0,4000),
        vertex(11600,m1() * 0,3800),
        vertex(12400,m1() * 0,4000),
        vertex(11600,m1() * 0,4000),
        vertex(12400,m1() * 0,3800),
        vertex(11600,m1() * 0,10000),
        vertex(10000,m1() * 0,10000),
        vertex(12400,m1() * 0,10000),
        vertex(10000,m1() * 0,4000),
        vertex(12400,m1() * 0,10200),
        vertex(11600,m1() * 0,10200),
        vertex(10000,1678,10000),
        vertex(10000,1678,4000),
        vertex(11600,1399,4000),
        vertex(10080,1597,4000),
        vertex(13919,1597,4000),
        vertex(12400,1399,4000),
        vertex(12000,3517,4000),
        vertex(12000,3517,10000),
        vertex(12400,1399,10000),
        vertex(13919,1597,10000),
        vertex(11600,1399,10000),
        vertex(10080,1597,10000),
        vertex(9797,1880,3500),
        vertex(12000,3517,3500),
        vertex(10080,1597,3500),
        vertex(11800,3882,3500),
        vertex(14202,1880,3500),
        vertex(13919,1597,3500),
        vertex(12200,3882,3500),
        vertex(12200,4100,3500),
        vertex(11800,4100,3500),
        vertex(14202,1880,10500),
        vertex(12200,3882,10500),
        vertex(13919,1597,10500),
        vertex(12000,3517,10500),
        vertex(11800,3882,10500),
        vertex(12200,4099,10500),
        vertex(11800,4099,10500),
        vertex(9797,1880,10500),
        vertex(10080,1597,10500),
        vertex(12400,1399,3800),
        vertex(11600,1399,3800),
        vertex(12400,1399,10200),
        vertex(11600,1399,10200),
        vertex(m1() * 84291,m1() * 209,m1() * 107126),
        vertex(m1() * 88000,209,7000),
        vertex(m1() * 76000,m1() * 210,7000),
        vertex(m1() * 97708,m1() * 210,77534),
        vertex(m1() * 84291,m1() * 210,121126),
        vertex(m1() * 97708,m1() * 209,m1() * 63534),
        vertex(0,5100,m1() * 111),
        vertex(182,4966,0),
        vertex(750,5100,0),
        vertex(182,5232,0),
        vertex(0,5100,112),
        vertex(231,5812,0),
        vertex(m1() * 69,5312,0),
        vertex(m1() * 606,5539,0),
        vertex(m1() * 224,5100,0),
        vertex(m1() * 606,4659,0),
        vertex(m1() * 69,4886,0),
        vertex(231,4386,0),
        vertex(0,4500,0),
        vertex(336,3739,590),
        vertex(m1() * 403,3620,690),
        vertex(m1() * 679,3739,m1() * 2),
        vertex(m1() * 396,3620,m1() * 694),
        vertex(343,3739,m1() * 585),
        vertex(799,3620,4),
        vertex(905,2759,m1() * 468),
        vertex(1186,2579,179),
        vertex(726,2759,716),
        vertex(196,2579,1183),
        vertex(m1() * 455,2759,912),
        vertex(m1() * 1065,2579,552),
        vertex(m1() * 1008,2759,m1() * 151),
        vertex(m1() * 853,2579,m1() * 841),
        vertex(m1() * 166,2759,m1() * 1005),
        vertex(537,2579,m1() * 1072),
        vertex(1782,1005,m1() * 87),
        vertex(1934,689,817),
        vertex(1179,1004,1338),
        vertex(566,689,2021),
        vertex(m1() * 311,1004,1757),
        vertex(m1() * 1227,689,1702),
        vertex(m1() * 1567,1005,852),
        vertex(m1() * 2096,690,102),
        vertex(m1() * 1644,1005,m1() * 694),
        vertex(m1() * 1387,690,m1() * 1575),
        vertex(m1() * 480,1005,m1() * 1718),
        vertex(366,690,m1() * 2067),
        vertex(1042,1005,m1() * 1448),
        vertex(1844,690,m1() * 1002),
        vertex(550,0,0),
        vertex(275,0,476),
        vertex(m1() * 274,0,476),
        vertex(m1() * 549,0,0),
        vertex(m1() * 275,0,m1() * 476),
        vertex(274,0,m1() * 476),
        vertex(m1() * 399,1005,m1() * 42),
        vertex(m1() * 212,1004,m1() * 367),
        vertex(424,1004,0),
        vertex(211,1004,m1() * 367),
        vertex(211,1004,m1() * 367),
        vertex(m1() * 423,1005,0),
        vertex(m1() * 399,1005,m1() * 42),
        vertex(m1() * 399,1005,m1() * 42),
        vertex(m1() * 212,1004,m1() * 367),
        vertex(m1() * 394,1005,50),
        vertex(m1() * 423,1005,0),
        vertex(101,3739,100),
        vertex(m1() * 217,2759,10),
        vertex(m1() * 197,2759,m1() * 83),
        vertex(38,2759,m1() * 214),
        vertex(m1() * 144,2759,m1() * 163),
        vertex(424,1004,0),
        vertex(212,1004,367),
        vertex(212,1004,367),
        vertex(m1() * 423,1005,0),
        vertex(m1() * 211,1004,367),
        vertex(m1() * 211,1004,367),
        vertex(m1() * 394,1005,50),
        vertex(m1() * 394,1005,50),
        vertex(m1() * 141,3739,m1() * 21),
        vertex(m1() * 141,3739,m1() * 21),
        vertex(m1() * 129,3739,66),
        vertex(m1() * 129,3739,66),
        vertex(23,3739,143),
        vertex(23,3739,143),
        vertex(101,3739,100),
        vertex(m1() * 64,3739,128),
        vertex(m1() * 64,3739,128),
        vertex(143,3739,21),
        vertex(143,3739,21),
        vertex(127,3739,m1() * 65),
        vertex(127,3739,m1() * 65),
        vertex(65,3739,m1() * 130),
        vertex(65,3739,m1() * 130),
        vertex(m1() * 23,3739,m1() * 141),
        vertex(m1() * 23,3739,m1() * 141),
        vertex(m1() * 103,3739,m1() * 102),
        vertex(m1() * 103,3739,m1() * 102),
        vertex(200,2759,84),
        vertex(200,2759,84),
        vertex(214,2759,m1() * 10),
        vertex(214,2759,m1() * 10),
        vertex(m1() * 217,2759,10),
        vertex(m1() * 188,2759,102),
        vertex(m1() * 188,2759,102),
        vertex(58,2759,210),
        vertex(58,2759,210),
        vertex(141,2759,161),
        vertex(141,2759,161),
        vertex(m1() * 127,2759,176),
        vertex(m1() * 127,2759,176),
        vertex(191,2759,m1() * 104),
        vertex(125,2759,m1() * 174),
        vertex(m1() * 57,2759,m1() * 206),
        vertex(m1() * 37,2759,211),
        vertex(m1() * 37,2759,211),
        vertex(m1() * 197,2759,m1() * 83),
        vertex(m1() * 144,2759,m1() * 163),
        vertex(12334,5417,m1() * 50989),
        vertex(11429,15316,m1() * 49901),
        vertex(16740,15496,m1() * 47116),
        vertex(16262,11011,m1() * 48070),
        vertex(15855,15466,m1() * 47581),
        vertex(16353,10021,m1() * 48179),
        vertex(17646,5597,m1() * 48204),
        vertex(16760,5567,m1() * 48668),
        vertex(12812,9902,m1() * 50036),
        vertex(12721,10892,m1() * 49927),
        vertex(12314,15346,m1() * 49437),
        vertex(13219,5447,m1() * 50525),
        vertex(17197,15634,m1() * 47995),
        vertex(16311,15604,m1() * 48460),
        vertex(18480,5923,m1() * 47720),
        vertex(19358,5695,m1() * 47300),
        vertex(19859,15309,m1() * 45527),
        vertex(19853,15269,m1() * 45536),
        vertex(20012,10145,m1() * 46260),
        vertex(20159,11143,m1() * 46027),
        vertex(20296,15459,m1() * 45277),
        vertex(19896,15562,m1() * 45468),
        vertex(20770,15300,m1() * 45056),
        vertex(20486,13372,m1() * 45506),
        vertex(20756,15340,m1() * 45056),
        vertex(20673,15588,m1() * 45060),
        vertex(21218,11179,m1() * 45471),
        vertex(21546,10197,m1() * 45456),
        vertex(23839,6104,m1() * 44910),
        vertex(23007,5819,m1() * 45386),
        vertex(29914,15427,m1() * 40290),
        vertex(27343,16073,m1() * 41522),
        vertex(31112,13698,m1() * 39940),
        vertex(30236,11899,m1() * 40677),
        vertex(27799,11084,m1() * 42071),
        vertex(29361,12172,m1() * 41089),
        vertex(27734,11801,m1() * 41992),
        vertex(30227,13668,m1() * 40404),
        vertex(27060,11778,m1() * 42345),
        vertex(25144,10994,m1() * 43463),
        vertex(25078,11711,m1() * 43384),
        vertex(27147,11734,m1() * 42307),
        vertex(27433,11791,m1() * 42150),
        vertex(23802,15953,m1() * 43379),
        vertex(24753,15266,m1() * 42994),
        vertex(26735,15333,m1() * 41955),
        vertex(26814,15383,m1() * 41906),
        vertex(27108,15346,m1() * 41759),
        vertex(27409,15356,m1() * 41601),
        vertex(29093,15097,m1() * 40768),
        vertex(24658,6598,m1() * 44407),
        vertex(25543,6628,m1() * 43943),
        vertex(37438,15682,m1() * 36344),
        vertex(34868,16328,m1() * 37577),
        vertex(38637,13953,m1() * 35994),
        vertex(37761,12154,m1() * 36732),
        vertex(35324,11338,m1() * 38125),
        vertex(36885,12426,m1() * 37144),
        vertex(35258,12056,m1() * 38046),
        vertex(37752,13923,m1() * 36458),
        vertex(34584,12033,m1() * 38400),
        vertex(32668,11249,m1() * 39518),
        vertex(32603,11966,m1() * 39439),
        vertex(34672,11989,m1() * 38361),
        vertex(34957,12045,m1() * 38204),
        vertex(31327,16208,m1() * 39434),
        vertex(32278,15521,m1() * 39048),
        vertex(34259,15588,m1() * 38009),
        vertex(34338,15637,m1() * 37960),
        vertex(34632,15600,m1() * 37813),
        vertex(36618,15352,m1() * 36822),
        vertex(32182,6853,m1() * 40462),
        vertex(33067,6883,m1() * 39997),
        vertex(42432,6435,m1() * 35207),
        vertex(41527,16334,m1() * 34119),
        vertex(46838,16514,m1() * 31334),
        vertex(46661,8739,m1() * 32650),
        vertex(45953,16484,m1() * 31799),
        vertex(47744,6615,m1() * 32422),
        vertex(46847,6710,m1() * 32873),
        vertex(42476,16272,m1() * 33637),
        vertex(42609,14210,m1() * 33892),
        vertex(42424,16239,m1() * 33669),
        vertex(46795,6677,m1() * 32905),
        vertex(43317,6465,m1() * 34743),
        vertex(52026,12221,m1() * 29317),
        vertex(48708,11116,m1() * 31213),
        vertex(48618,12106,m1() * 31104),
        vertex(52117,11231,m1() * 29426),
        vertex(47636,16045,m1() * 30994),
        vertex(48346,15076,m1() * 30778),
        vertex(52903,16223,m1() * 28232),
        vertex(52994,15233,m1() * 28341),
        vertex(48451,7135,m1() * 31973),
        vertex(48980,8146,m1() * 31540),
        vertex(53718,7313,m1() * 29211),
        vertex(53627,8303,m1() * 29103),
        vertex(55444,15604,m1() * 27011),
        vertex(57100,15976,m1() * 26093),
        vertex(54810,14301,m1() * 27545),
        vertex(55677,13050,m1() * 27292),
        vertex(58532,15138,m1() * 25482),
        vertex(56471,12930,m1() * 26899),
        vertex(58622,14157,m1() * 25589),
        vertex(59818,14198,m1() * 24962),
        vertex(57298,17048,m1() * 25821),
        vertex(54538,16427,m1() * 27352),
        vertex(53483,14256,m1() * 28241),
        vertex(54927,12170,m1() * 27820),
        vertex(59685,15651,m1() * 24802),
        vertex(56357,11955,m1() * 27111),
        vertex(56563,11924,m1() * 27009),
        vertex(57784,11740,m1() * 26405),
        vertex(57796,13228,m1() * 26164),
        vertex(58017,11911,m1() * 26257),
        vertex(59507,11039,m1() * 25621),
        vertex(60660,11552,m1() * 24941),
        vertex(59680,9149,m1() * 25828),
        vertex(54914,9390,m1() * 28264),
        vertex(54950,7375,m1() * 28562),
        vertex(53587,9345,m1() * 28960),
        vertex(55700,8254,m1() * 28034),
        vertex(58378,6858,m1() * 26864),
        vertex(57986,7910,m1() * 26903),
        vertex(60919,8717,m1() * 25253),
        vertex(61376,8855,m1() * 26132),
        vertex(62968,15858,m1() * 23066),
        vertex(64624,16231,m1() * 22148),
        vertex(62335,14556,m1() * 23599),
        vertex(63202,13304,m1() * 23346),
        vertex(66057,15393,m1() * 21536),
        vertex(63996,13185,m1() * 22953),
        vertex(66146,14412,m1() * 21644),
        vertex(67343,14452,m1() * 21017),
        vertex(64823,17302,m1() * 21876),
        vertex(62062,16682,m1() * 23406),
        vertex(61007,14511,m1() * 24296),
        vertex(62452,12425,m1() * 23874),
        vertex(67210,15906,m1() * 20857),
        vertex(63882,12209,m1() * 23166),
        vertex(64088,12178,m1() * 23064),
        vertex(65308,11994,m1() * 22459),
        vertex(65320,13482,m1() * 22219),
        vertex(65542,12165,m1() * 22311),
        vertex(67031,11293,m1() * 21675),
        vertex(68185,11806,m1() * 20996),
        vertex(67204,9404,m1() * 21883),
        vertex(62439,9644,m1() * 24318),
        vertex(62475,7629,m1() * 24617),
        vertex(61111,9599,m1() * 25015),
        vertex(63225,8509,m1() * 24089),
        vertex(65903,7113,m1() * 22919),
        vertex(65510,8164,m1() * 22957),
        vertex(68444,8972,m1() * 21307),
        vertex(40219,6360,m1() * 36368),
        vertex(39314,16260,m1() * 35280),
        vertex(40199,16290,m1() * 34816),
        vertex(41104,6390,m1() * 35904)
    )

val tri =
    (arrszref)$arrpsz{struct_triangle}(
        tri(5,6,7,2),
        tri(6,5,8,2),
        tri(7,9,10,2),
        tri(9,7,11,2),
        tri(7,10,12,2),
        tri(6,11,7,2),
        tri(11,6,1,2),
        tri(1,6,4,2),
        tri(9,13,14,2),
        tri(13,9,11,2),
        tri(4,19,2,2),
        tri(10,26,15,2),
        tri(27,28,29,2),
        tri(28,27,30,2),
        tri(28,31,32,2),
        tri(31,28,33,2),
        tri(30,33,28,2),
        tri(33,30,34,2),
        tri(34,30,35,2),
        tri(36,3,31,2),
        tri(38,3,36,2),
        tri(3,38,24,2),
        tri(2,31,3,2),
        tri(32,2,19,2),
        tri(2,32,31,2),
        tri(19,28,32,2),
        tri(22,38,39,2),
        tri(38,22,24,2),
        tri(40,37,41,2),
        tri(40,41,42,2),
        tri(37,40,39,2),
        tri(43,39,40,2),
        tri(39,43,44,2),
        tri(39,36,37,2),
        tri(36,39,38,2),
        tri(37,34,41,2),
        tri(34,37,33,2),
        tri(34,42,41,2),
        tri(42,34,35,2),
        tri(30,42,35,2),
        tri(42,30,40,2),
        tri(27,16,43,2),
        tri(29,16,27,2),
        tri(16,29,18,2),
        tri(15,43,16,2),
        tri(44,15,26,2),
        tri(15,44,43,2),
        tri(29,21,18,2),
        tri(21,29,28,2),
        tri(26,39,44,2),
        tri(39,26,22,2),
        tri(6,45,20,2),
        tri(45,6,8,2),
        tri(45,17,20,2),
        tri(17,45,46,2),
        tri(5,17,46,2),
        tri(17,5,7,2),
        tri(5,45,8,2),
        tri(45,5,46,2),
        tri(13,23,47,2),
        tri(23,13,11,2),
        tri(23,48,47,2),
        tri(48,23,25,2),
        tri(9,48,25,2),
        tri(48,9,14,2),
        tri(48,13,47,2),
        tri(13,48,14,2),
        tri(52,51,53,2),
        tri(54,51,52,2),
        tri(51,54,49,2),
        tri(36,33,37,6),
        tri(33,36,31,6),
        tri(27,40,30,6),
        tri(40,27,43,6),
        tri(12,17,7,3),
        tri(17,12,18,3),
        tri(18,12,16,3),
        tri(20,4,6,3),
        tri(4,20,19,3),
        tri(20,21,19,3),
        tri(17,21,20,3),
        tri(21,17,18,3),
        tri(22,23,24,3),
        tri(22,25,23,3),
        tri(26,25,22,3),
        tri(10,25,26,3),
        tri(25,10,9,3),
        tri(24,1,3,3),
        tri(23,1,24,3),
        tri(1,23,11,3),
        tri(28,19,21,3),
        tri(49,50,51,3),
        tri(50,52,53,3),
        tri(51,50,53,3),
        tri(54,52,50,3),
        tri(49,54,50,3),
        tri(1,2,3,7),
        tri(2,1,4,7),
        tri(12,15,16,7),
        tri(15,12,10,7),
        tri(55,57,56,3),
        tri(59,57,58,3),
        tri(55,60,58,3),
        tri(59,60,61,3),
        tri(55,62,61,3),
        tri(59,62,63,3),
        tri(55,64,63,3),
        tri(59,63,64,3),
        tri(55,66,65,3),
        tri(59,65,66,3),
        tri(55,58,57,4),
        tri(59,56,57,4),
        tri(55,61,60,4),
        tri(59,58,60,4),
        tri(55,63,62,4),
        tri(59,61,62,4),
        tri(55,65,64,4),
        tri(59,64,65,4),
        tri(55,56,66,4),
        tri(59,66,56,4),
        tri(127,114,110,3),
        tri(67,70,69,1),
        tri(67,72,71,1),
        tri(67,68,73,1),
        tri(116,90,153,1),
        tri(74,139,138,1),
        tri(159,88,164,1),
        tri(145,80,128,1),
        tri(141,82,143,1),
        tri(132,76,115,1),
        tri(84,149,148,1),
        tri(155,86,156,1),
        tri(118,94,162,1),
        tri(135,130,79,1),
        tri(96,161,160,1),
        tri(166,92,165,1),
        tri(116,91,90,1),
        tri(159,89,88,1),
        tri(145,81,80,1),
        tri(141,83,82,1),
        tri(132,77,76,1),
        tri(155,87,86,1),
        tri(118,95,94,1),
        tri(166,93,92,1),
        tri(84,148,85,1),
        tri(96,160,97,1),
        tri(74,138,75,1),
        tri(104,102,101,2),
        tri(106,99,98,2),
        tri(106,103,107,2),
        tri(112,103,102,2),
        tri(122,100,99,2),
        tri(113,101,100,2),
        tri(101,123,104,2),
        tri(104,112,102,2),
        tri(106,122,99,2),
        tri(106,98,103,2),
        tri(112,107,103,2),
        tri(122,125,100,2),
        tri(100,125,113,2),
        tri(113,123,101,2),
        tri(67,69,68,5),
        tri(67,71,70,5),
        tri(67,73,72,5),
        tri(70,71,72,5),
        tri(136,133,68,5),
        tri(69,70,68,5),
        tri(68,72,73,5),
        tri(74,82,83,5),
        tri(81,82,80,5),
        tri(80,78,79,5),
        tri(154,157,78,5),
        tri(78,74,76,5),
        tri(76,74,75,5),
        tri(77,78,76,5),
        tri(80,82,74,5),
        tri(94,95,96,5),
        tri(93,94,92,5),
        tri(88,124,121,5),
        tri(96,84,94,5),
        tri(94,90,92,5),
        tri(91,92,90,5),
        tri(84,86,94,5),
        tri(94,109,90,5),
        tri(85,86,84,5),
        tri(89,90,88,5),
        tri(88,86,87,5),
        tri(84,96,97,5),
        tri(108,94,120,5),
        tri(90,126,88,5),
        tri(159,90,89,5),
        tri(138,76,75,5),
        tri(142,144,72,5),
        tri(130,80,79,5),
        tri(155,88,87,5),
        tri(116,92,91,5),
        tri(132,78,77,5),
        tri(141,74,83,5),
        tri(119,117,80,5),
        tri(160,84,97,5),
        tri(145,82,81,5),
        tri(166,94,93,5),
        tri(148,86,85,5),
        tri(118,96,95,5),
        tri(70,129,131,5),
        tri(70,131,136,5),
        tri(134,137,68,5),
        tri(133,134,68,5),
        tri(68,70,136,5),
        tri(78,80,152,5),
        tri(80,151,152,5),
        tri(147,150,74,5),
        tri(157,147,74,5),
        tri(78,152,158,5),
        tri(78,158,163,5),
        tri(157,74,78,5),
        tri(78,163,154,5),
        tri(120,86,121,5),
        tri(86,88,121,5),
        tri(88,126,124,5),
        tri(94,111,109,5),
        tri(105,111,94,5),
        tri(94,86,120,5),
        tri(108,105,94,5),
        tri(90,109,126,5),
        tri(159,153,90,5),
        tri(138,115,76,5),
        tri(72,68,137,5),
        tri(72,137,140,5),
        tri(146,129,70,5),
        tri(144,146,72,5),
        tri(146,70,72,5),
        tri(72,140,142,5),
        tri(130,128,80,5),
        tri(155,164,88,5),
        tri(116,165,92,5),
        tri(132,135,78,5),
        tri(141,139,74,5),
        tri(74,150,119,5),
        tri(117,151,80,5),
        tri(80,74,119,5),
        tri(160,149,84,5),
        tri(145,143,82,5),
        tri(166,162,94,5),
        tri(148,156,86,5),
        tri(118,161,96,5),
        tri(169,171,170,1),
        tri(170,172,169,1),
        tri(173,169,172,1),
        tri(172,174,173,1),
        tri(170,176,175,1),
        tri(175,172,170,1),
        tri(176,177,168,1),
        tri(168,167,176,1),
        tri(175,176,167,1),
        tri(167,178,175,1),
        tri(180,171,169,1),
        tri(169,179,180,1),
        tri(181,182,185,1),
        tri(184,181,185,1),
        tri(185,186,184,1),
        tri(187,183,184,1),
        tri(187,188,183,1),
        tri(184,189,187,1),
        tri(184,186,190,1),
        tri(191,192,187,1),
        tri(189,191,187,1),
        tri(184,190,189,1),
        tri(189,190,193,1),
        tri(189,193,194,1),
        tri(195,189,194,1),
        tri(194,196,195,1),
        tri(193,186,185,1),
        tri(185,194,193,1),
        tri(203,201,202,1),
        tri(202,201,200,1),
        tri(204,202,200,1),
        tri(200,199,204,1),
        tri(205,207,206,1),
        tri(201,208,205,1),
        tri(201,209,208,1),
        tri(201,203,209,1),
        tri(205,206,201,1),
        tri(207,211,210,1),
        tri(198,210,211,1),
        tri(211,212,198,1),
        tri(212,213,198,1),
        tri(213,214,198,1),
        tri(198,214,215,1),
        tri(216,198,215,1),
        tri(197,198,216,1),
        tri(197,216,204,1),
        tri(204,199,197,1),
        tri(210,217,207,1),
        tri(206,207,217,1),
        tri(217,218,206,1),
        tri(237,220,236,1),
        tri(225,223,224,1),
        tri(224,223,222,1),
        tri(226,224,222,1),
        tri(222,221,226,1),
        tri(227,229,228,1),
        tri(223,230,227,1),
        tri(223,231,230,1),
        tri(223,225,231,1),
        tri(227,228,223,1),
        tri(229,233,232,1),
        tri(220,232,233,1),
        tri(233,234,220,1),
        tri(234,235,220,1),
        tri(235,236,220,1),
        tri(219,220,237,1),
        tri(219,237,226,1),
        tri(226,221,219,1),
        tri(232,238,229,1),
        tri(228,229,238,1),
        tri(238,239,228,1),
        tri(242,244,243,1),
        tri(245,242,243,1),
        tri(243,246,245,1),
        tri(247,249,248,1),
        tri(243,247,248,1),
        tri(248,250,243,1),
        tri(250,246,243,1),
        tri(248,249,241,1),
        tri(241,240,248,1),
        tri(240,251,248,1),
        tri(252,254,253,1),
        tri(253,255,252,1),
        tri(254,257,256,1),
        tri(258,256,257,1),
        tri(257,259,258,1),
        tri(256,260,254,1),
        tri(253,254,260,1),
        tri(261,253,260,1),
        tri(262,263,261,1),
        tri(261,260,262,1),
        tri(266,273,274,1),
        tri(274,275,266,1),
        tri(273,266,264,1),
        tri(272,273,264,1),
        tri(264,265,272,1),
        tri(272,265,268,1),
        tri(276,272,268,1),
        tri(271,276,268,1),
        tri(268,270,271,1),
        tri(267,266,275,1),
        tri(267,275,277,1),
        tri(269,267,277,1),
        tri(278,269,277,1),
        tri(269,278,279,1),
        tri(280,269,279,1),
        tri(280,279,281,1),
        tri(280,281,282,1),
        tri(282,284,283,1),
        tri(283,280,282,1),
        tri(285,287,286,1),
        tri(288,285,286,1),
        tri(289,290,288,1),
        tri(288,286,289,1),
        tri(284,290,289,1),
        tri(284,289,291,1),
        tri(291,283,284,1),
        tri(295,302,303,1),
        tri(303,304,295,1),
        tri(302,295,293,1),
        tri(301,302,293,1),
        tri(293,294,301,1),
        tri(301,294,297,1),
        tri(305,301,297,1),
        tri(300,305,297,1),
        tri(297,299,300,1),
        tri(296,295,304,1),
        tri(296,304,306,1),
        tri(298,296,306,1),
        tri(307,298,306,1),
        tri(298,307,308,1),
        tri(309,298,308,1),
        tri(309,308,310,1),
        tri(309,310,311,1),
        tri(311,313,312,1),
        tri(312,309,311,1),
        tri(314,316,315,1),
        tri(317,314,315,1),
        tri(318,319,317,1),
        tri(317,315,318,1),
        tri(313,319,318,1),
        tri(313,318,320,1),
        tri(320,312,313,1),
        tri(323,322,321,1),
        tri(321,324,323,1)
    )
