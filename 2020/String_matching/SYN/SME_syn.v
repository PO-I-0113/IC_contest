/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : S-2021.06-SP2
// Date      : Thu Feb  5 13:58:05 2026
/////////////////////////////////////////////////////////////


module SME ( clk, reset, chardata, isstring, ispattern, valid, match, 
        match_index );
  input [7:0] chardata;
  output [4:0] match_index;
  input clk, reset, isstring, ispattern;
  output valid, match;
  wire   n2018, n2019, n2020, n2021, n2022, n2023, \string_buffer[0][7] ,
         \string_buffer[0][6] , \string_buffer[0][5] , \string_buffer[0][4] ,
         \string_buffer[0][3] , \string_buffer[0][2] , \string_buffer[0][1] ,
         \string_buffer[0][0] , \string_buffer[1][7] , \string_buffer[1][6] ,
         \string_buffer[1][5] , \string_buffer[1][4] , \string_buffer[1][3] ,
         \string_buffer[1][2] , \string_buffer[1][1] , \string_buffer[1][0] ,
         \string_buffer[2][7] , \string_buffer[2][6] , \string_buffer[2][5] ,
         \string_buffer[2][4] , \string_buffer[2][3] , \string_buffer[2][2] ,
         \string_buffer[2][1] , \string_buffer[2][0] , \string_buffer[3][7] ,
         \string_buffer[3][6] , \string_buffer[3][5] , \string_buffer[3][4] ,
         \string_buffer[3][3] , \string_buffer[3][2] , \string_buffer[3][1] ,
         \string_buffer[3][0] , \string_buffer[4][7] , \string_buffer[4][6] ,
         \string_buffer[4][5] , \string_buffer[4][4] , \string_buffer[4][3] ,
         \string_buffer[4][2] , \string_buffer[4][1] , \string_buffer[4][0] ,
         \string_buffer[5][7] , \string_buffer[5][6] , \string_buffer[5][5] ,
         \string_buffer[5][4] , \string_buffer[5][3] , \string_buffer[5][2] ,
         \string_buffer[5][1] , \string_buffer[5][0] , \string_buffer[6][7] ,
         \string_buffer[6][6] , \string_buffer[6][5] , \string_buffer[6][4] ,
         \string_buffer[6][3] , \string_buffer[6][2] , \string_buffer[6][1] ,
         \string_buffer[6][0] , \string_buffer[7][7] , \string_buffer[7][6] ,
         \string_buffer[7][5] , \string_buffer[7][4] , \string_buffer[7][3] ,
         \string_buffer[7][2] , \string_buffer[7][1] , \string_buffer[7][0] ,
         \string_buffer[8][7] , \string_buffer[8][6] , \string_buffer[8][5] ,
         \string_buffer[8][4] , \string_buffer[8][3] , \string_buffer[8][2] ,
         \string_buffer[8][1] , \string_buffer[8][0] , \string_buffer[9][7] ,
         \string_buffer[9][6] , \string_buffer[9][5] , \string_buffer[9][4] ,
         \string_buffer[9][3] , \string_buffer[9][2] , \string_buffer[9][1] ,
         \string_buffer[9][0] , \string_buffer[10][7] , \string_buffer[10][6] ,
         \string_buffer[10][5] , \string_buffer[10][4] ,
         \string_buffer[10][3] , \string_buffer[10][2] ,
         \string_buffer[10][1] , \string_buffer[10][0] ,
         \string_buffer[11][7] , \string_buffer[11][6] ,
         \string_buffer[11][5] , \string_buffer[11][4] ,
         \string_buffer[11][3] , \string_buffer[11][2] ,
         \string_buffer[11][1] , \string_buffer[11][0] ,
         \string_buffer[12][7] , \string_buffer[12][6] ,
         \string_buffer[12][5] , \string_buffer[12][4] ,
         \string_buffer[12][3] , \string_buffer[12][2] ,
         \string_buffer[12][1] , \string_buffer[12][0] ,
         \string_buffer[13][7] , \string_buffer[13][6] ,
         \string_buffer[13][5] , \string_buffer[13][4] ,
         \string_buffer[13][3] , \string_buffer[13][2] ,
         \string_buffer[13][1] , \string_buffer[13][0] ,
         \string_buffer[14][7] , \string_buffer[14][6] ,
         \string_buffer[14][5] , \string_buffer[14][4] ,
         \string_buffer[14][3] , \string_buffer[14][2] ,
         \string_buffer[14][1] , \string_buffer[14][0] ,
         \string_buffer[15][7] , \string_buffer[15][6] ,
         \string_buffer[15][5] , \string_buffer[15][4] ,
         \string_buffer[15][3] , \string_buffer[15][2] ,
         \string_buffer[15][1] , \string_buffer[15][0] ,
         \string_buffer[16][7] , \string_buffer[16][6] ,
         \string_buffer[16][5] , \string_buffer[16][4] ,
         \string_buffer[16][3] , \string_buffer[16][2] ,
         \string_buffer[16][1] , \string_buffer[16][0] ,
         \string_buffer[17][7] , \string_buffer[17][6] ,
         \string_buffer[17][5] , \string_buffer[17][4] ,
         \string_buffer[17][3] , \string_buffer[17][2] ,
         \string_buffer[17][1] , \string_buffer[17][0] ,
         \string_buffer[18][7] , \string_buffer[18][6] ,
         \string_buffer[18][5] , \string_buffer[18][4] ,
         \string_buffer[18][3] , \string_buffer[18][2] ,
         \string_buffer[18][1] , \string_buffer[18][0] ,
         \string_buffer[19][7] , \string_buffer[19][6] ,
         \string_buffer[19][5] , \string_buffer[19][4] ,
         \string_buffer[19][3] , \string_buffer[19][2] ,
         \string_buffer[19][1] , \string_buffer[19][0] ,
         \string_buffer[20][7] , \string_buffer[20][6] ,
         \string_buffer[20][5] , \string_buffer[20][4] ,
         \string_buffer[20][3] , \string_buffer[20][2] ,
         \string_buffer[20][1] , \string_buffer[20][0] ,
         \string_buffer[21][7] , \string_buffer[21][6] ,
         \string_buffer[21][5] , \string_buffer[21][4] ,
         \string_buffer[21][3] , \string_buffer[21][2] ,
         \string_buffer[21][1] , \string_buffer[21][0] ,
         \string_buffer[22][7] , \string_buffer[22][6] ,
         \string_buffer[22][5] , \string_buffer[22][4] ,
         \string_buffer[22][3] , \string_buffer[22][2] ,
         \string_buffer[22][1] , \string_buffer[22][0] ,
         \string_buffer[23][7] , \string_buffer[23][6] ,
         \string_buffer[23][5] , \string_buffer[23][4] ,
         \string_buffer[23][3] , \string_buffer[23][2] ,
         \string_buffer[23][1] , \string_buffer[23][0] ,
         \string_buffer[24][7] , \string_buffer[24][6] ,
         \string_buffer[24][5] , \string_buffer[24][4] ,
         \string_buffer[24][3] , \string_buffer[24][2] ,
         \string_buffer[24][1] , \string_buffer[24][0] ,
         \string_buffer[25][7] , \string_buffer[25][6] ,
         \string_buffer[25][5] , \string_buffer[25][4] ,
         \string_buffer[25][3] , \string_buffer[25][2] ,
         \string_buffer[25][1] , \string_buffer[25][0] ,
         \string_buffer[26][7] , \string_buffer[26][6] ,
         \string_buffer[26][5] , \string_buffer[26][4] ,
         \string_buffer[26][3] , \string_buffer[26][2] ,
         \string_buffer[26][1] , \string_buffer[26][0] ,
         \string_buffer[27][7] , \string_buffer[27][6] ,
         \string_buffer[27][5] , \string_buffer[27][4] ,
         \string_buffer[27][3] , \string_buffer[27][2] ,
         \string_buffer[27][1] , \string_buffer[27][0] ,
         \string_buffer[28][7] , \string_buffer[28][6] ,
         \string_buffer[28][5] , \string_buffer[28][4] ,
         \string_buffer[28][3] , \string_buffer[28][2] ,
         \string_buffer[28][1] , \string_buffer[28][0] ,
         \string_buffer[29][7] , \string_buffer[29][6] ,
         \string_buffer[29][5] , \string_buffer[29][4] ,
         \string_buffer[29][3] , \string_buffer[29][2] ,
         \string_buffer[29][1] , \string_buffer[29][0] ,
         \string_buffer[30][7] , \string_buffer[30][6] ,
         \string_buffer[30][5] , \string_buffer[30][4] ,
         \string_buffer[30][3] , \string_buffer[30][2] ,
         \string_buffer[30][1] , \string_buffer[30][0] ,
         \string_buffer[31][7] , \string_buffer[31][6] ,
         \string_buffer[31][5] , \string_buffer[31][4] ,
         \string_buffer[31][3] , \string_buffer[31][2] ,
         \string_buffer[31][1] , \string_buffer[31][0] ,
         \pattern_buffer[0][7] , \pattern_buffer[0][6] ,
         \pattern_buffer[0][5] , \pattern_buffer[0][4] ,
         \pattern_buffer[0][3] , \pattern_buffer[0][2] ,
         \pattern_buffer[0][1] , \pattern_buffer[0][0] ,
         \pattern_buffer[1][7] , \pattern_buffer[1][6] ,
         \pattern_buffer[1][5] , \pattern_buffer[1][4] ,
         \pattern_buffer[1][3] , \pattern_buffer[1][2] ,
         \pattern_buffer[1][1] , \pattern_buffer[1][0] ,
         \pattern_buffer[2][7] , \pattern_buffer[2][6] ,
         \pattern_buffer[2][5] , \pattern_buffer[2][4] ,
         \pattern_buffer[2][3] , \pattern_buffer[2][2] ,
         \pattern_buffer[2][1] , \pattern_buffer[2][0] ,
         \pattern_buffer[3][7] , \pattern_buffer[3][6] ,
         \pattern_buffer[3][5] , \pattern_buffer[3][4] ,
         \pattern_buffer[3][3] , \pattern_buffer[3][2] ,
         \pattern_buffer[3][1] , \pattern_buffer[3][0] ,
         \pattern_buffer[4][7] , \pattern_buffer[4][6] ,
         \pattern_buffer[4][5] , \pattern_buffer[4][4] ,
         \pattern_buffer[4][3] , \pattern_buffer[4][2] ,
         \pattern_buffer[4][1] , \pattern_buffer[4][0] ,
         \pattern_buffer[5][7] , \pattern_buffer[5][6] ,
         \pattern_buffer[5][5] , \pattern_buffer[5][4] ,
         \pattern_buffer[5][3] , \pattern_buffer[5][2] ,
         \pattern_buffer[5][1] , \pattern_buffer[5][0] ,
         \pattern_buffer[6][7] , \pattern_buffer[6][6] ,
         \pattern_buffer[6][5] , \pattern_buffer[6][4] ,
         \pattern_buffer[6][3] , \pattern_buffer[6][2] ,
         \pattern_buffer[6][1] , \pattern_buffer[6][0] ,
         \pattern_buffer[7][7] , \pattern_buffer[7][6] ,
         \pattern_buffer[7][5] , \pattern_buffer[7][4] ,
         \pattern_buffer[7][3] , \pattern_buffer[7][2] ,
         \pattern_buffer[7][1] , \pattern_buffer[7][0] , \fsm/next_state[0] ,
         \read_chardata/N114 , \read_chardata/N113 , \read_chardata/N112 ,
         \read_chardata/N111 , \read_chardata/N110 , \match_controller/N914 ,
         \match_controller/N913 , \match_controller/N912 ,
         \match_controller/N911 , \match_controller/N910 ,
         \match_controller/N909 , \match_controller/N908 ,
         \match_controller/N907 , \match_controller/N906 ,
         \match_controller/N905 , \match_controller/N904 ,
         \match_controller/N903 , \match_controller/N902 ,
         \match_controller/N901 , \match_controller/N289 ,
         \match_controller/N288 , \match_controller/N287 ,
         \match_controller/N286 , \match_controller/N262 ,
         \match_controller/N261 , \match_controller/N260 ,
         \match_controller/N259 , \match_controller/N258 ,
         \match_controller/N257 , \match_controller/N256 ,
         \match_controller/N255 , \match_controller/N254 ,
         \match_controller/N253 , \match_controller/N252 ,
         \match_controller/N251 , \match_controller/N250 ,
         \match_controller/N249 , \match_controller/N248 ,
         \match_controller/N247 , \match_controller/N246 ,
         \match_controller/N245 , \match_controller/N244 , n120, n121, n122,
         n123, n124, n129, n131, n136, n139, n140, n141, n142, n143, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n161,
         n162, n164, n166, n167, n168, n170, n171, n174, n177, n178, n179,
         n181, n182, n183, n184, n185, n186, n187, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n201, n202, n204, n206,
         n207, n208, n209, n210, n212, n213, n214, n215, n216, n217, n219,
         n220, n221, n222, n224, n225, n226, n227, n228, n230, n231, n232,
         n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244,
         n247, n248, n249, n250, n251, n252, n253, n254, n255, n256, n257,
         n258, n259, n260, n261, n262, n263, n264, n265, n266, n267, n268,
         n269, n270, n271, n272, n273, n275, n276, n277, n278, n279, n280,
         n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302,
         n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313,
         n314, n315, n316, n318, n319, n320, n324, n325, n326, n327, n328,
         n329, n332, n333, n334, n337, n338, n339, n342, n343, n344, n346,
         n350, n351, n352, n355, n356, n357, n360, n361, n362, n365, n366,
         n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, n379,
         n380, n381, n382, n383, n384, n385, n387, n388, n389, n390, n391,
         n392, n393, n394, n395, n396, n397, n398, n400, n401, n402, n403,
         n404, n408, n409, n410, n411, n412, n413, n417, n418, n420, n421,
         n422, n425, n426, n427, n429, n430, n431, n432, n434, n435, n436,
         n438, n439, n440, n442, n443, n444, n446, n447, n448, n452, n453,
         n454, n455, n457, n458, n462, n463, n464, n465, n466, n467, n468,
         n469, n470, n473, n474, n475, n476, n478, n479, n481, n482, n483,
         n484, n485, n486, n488, n489, n491, n492, n494, n495, n497, n498,
         n499, n500, n501, n502, n503, n504, n505, n507, n509, n511, n513,
         n515, n517, n519, n520, n521, n522, n523, n527, n528, n529, n530,
         n531, n532, n534, n536, n539, n541, n543, n545, n546, n547, n548,
         n549, n551, n553, n555, n557, n559, n561, n563, n565, n566, n567,
         n568, n569, n571, n573, n575, n577, n581, n583, n585, n586, n587,
         n588, n589, n591, n593, n595, n597, n599, n601, n603, n605, n606,
         n607, n608, n610, n611, n612, n613, n614, n615, n617, n619, n620,
         n621, n622, n623, n624, n625, n626, n627, n628, n629, n630, n631,
         n632, n633, n634, n635, n636, n637, n638, n639, n640, n641, n642,
         n643, n644, n645, n646, n647, n648, n649, n650, n651, n653, n655,
         n656, n657, n658, n659, n660, n661, n662, n663, n664, n665, n670,
         n674, n678, n682, n686, n690, n694, n698, n699, n700, n701, n702,
         n706, n710, n714, n718, n722, n726, n730, n734, n735, n736, n737,
         n738, n742, n746, n750, n754, n758, n762, n766, n770, n771, n772,
         n773, n774, n778, n782, n786, n790, n794, n798, n799, n800, n801,
         n802, n803, n804, n805, n806, n807, n808, n809, n810, n811, n812,
         n813, n814, n815, n816, n817, n818, n819, n820, n821, n823, n828,
         n829, n830, n831, n832, n833, n836, n837, n838, n839, n840, n841,
         n842, n843, n844, n845, n846, n847, n848, n849, n851, n860, n861,
         n862, n864, n865, n867, n868, n870, n871, n873, n874, n876, n877,
         n879, n880, n882, n883, n885, n886, n888, n890, n892, n894, n896,
         n898, n900, n902, n903, n905, n907, n909, n911, n913, n915, n917,
         n919, n920, n923, n926, n928, n931, n933, n935, n938, n940, n941,
         n943, n945, n947, n949, n951, n952, n953, n954, n955, n956, n957,
         n959, n960, n961, n962, n963, n964, n965, n966, n967, n968, n969,
         n970, n971, n972, n973, n974, n975, n977, n981, n982, n983, n984,
         n985, n986, n987, n992, n996, n997, n998, n999, n1000, n1001, n1002,
         n1003, n1004, n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012,
         n1013, n1014, n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022,
         n1023, n1024, n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032,
         n1033, n1034, n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042,
         n1043, n1044, n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052,
         n1053, n1054, n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062,
         n1063, n1064, n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072,
         n1073, n1074, n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082,
         n1083, n1084, n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092,
         n1093, n1094, n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102,
         n1103, n1104, n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112,
         n1113, n1114, n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122,
         n1123, n1124, n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132,
         n1133, n1134, n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142,
         n1143, n1144, n1145, n1146, n1147, n1148, n1149, n1150, n1151, n1152,
         n1153, n1154, n1155, n1156, n1157, n1158, n1159, n1160, n1161, n1162,
         n1163, n1164, n1165, n1166, n1167, n1168, n1169, n1170, n1171, n1172,
         n1173, n1174, n1175, n1176, n1177, n1178, n1179, n1180, n1181, n1182,
         n1183, n1184, n1185, n1186, n1187, n1188, n1189, n1190, n1191, n1192,
         n1193, n1194, n1195, n1196, n1197, n1198, n1199, n1200, n1201, n1202,
         n1203, n1204, n1205, n1206, n1207, n1208, n1209, n1210, n1211, n1212,
         n1213, n1214, n1215, n1216, n1217, n1218, n1219, n1220, n1221, n1222,
         n1223, n1224, n1225, n1226, n1227, n1228, n1229, n1230, n1231, n1232,
         n1233, n1234, n1235, n1236, n1237, n1238, n1239, n1240, n1241, n1242,
         n1243, n1244, n1245, n1246, n1247, n1248, n1249, n1250, n1251, n1252,
         n1253, n1254, n1255, n1256, n1257, n1258, n1259, n1260, n1261, n1262,
         n1263, n1264, n1265, n1266, n1267, n1268, n1269, n1270, n1271, n1272,
         n1273, n1274, n1275, n1276, n1277, n1278, n1279, n1280, n1281, n1282,
         n1283, n1284, n1285, n1286, n1287, n1288, n1289, n1290, n1291, n1292,
         n1293, n1294, n1295, n1296, n1297, n1298, n1299, n1300, n1301, n1302,
         n1303, n1304, n1305, n1306, n1307, n1308, n1309, n1310, n1311, n1312,
         n1313, n1314, n1315, n1316, n1317, n1318, n1319, n1320, n1321, n1322,
         n1323, n1324, n1325, n1326, n1327, n1328, n1329, n1330, n1331, n1332,
         n1333, n1334, n1335, n1336, n1337, n1338, n1339, n1340, n1341, n1342,
         n1343, n1344, n1345, n1346, n1347, n1348, n1349, n1350, n1351, n1352,
         n1353, n1354, n1355, n1356, n1357, n1358, n1359, n1360, n1361, n1362,
         n1363, n1364, n1365, n1366, n1367, n1368, n1369, n1370, n1371, n1378,
         n1379, n1380, n1381, n1382, n1383, n1384, n1385, n1386, n1387, n1388,
         n1389, n1390, n1391, n1392, n1393, n1394, n1395, n1396, n1397, n1398,
         n1399, n1400, n1401, n1402, n1403, n1404, n1405, n1406, n1407, n1408,
         n1409, n1410, n1411, n1412, n1413, n1414, n1415, n1416, n1417, n1418,
         n1419, n1420, n1421, n1422, n1423, n1424, n1425, n1426, n1427, n1428,
         n1429, n1430, n1431, n1432, n1433, n1434, n1435, n1436, n1437, n1438,
         n1439, n1440, n1441, n1442, n1443, n1444, n1445, n1446, n1447, n1448,
         n1449, n1450, n1451, n1452, n1453, n1454, n1455, n1456, n1457, n1458,
         n1459, n1460, n1461, n1462, n1463, n1464, n1465, n1466, n1467, n1468,
         n1469, n1470, n1471, n1472, n1473, n1474, n1475, n1476, n1477, n1478,
         n1479, n1480, n1481, n1482, n1483, n1484, n1485, n1486, n1487, n1488,
         n1489, n1490, n1491, n1492, n1493, n1494, n1495, n1496, n1497, n1498,
         n1499, n1500, n1501, n1502, n1503, n1504, n1505, n1506, n1507, n1508,
         n1509, n1510, n1511, n1512, n1513, n1514, n1515, n1516, n1517, n1518,
         n1519, n1520, n1521, n1522, n1523, n1524, n1525, n1526, n1527, n1528,
         n1529, n1530, n1531, n1532, n1533, n1534, n1535, n1536, n1537, n1538,
         n1539, n1540, n1541, n1542, n1543, n1544, n1545, n1546, n1547, n1548,
         n1549, n1550, n1551, n1552, n1553, n1554, n1555, n1556, n1557, n1558,
         n1559, n1560, n1561, n1562, n1563, n1564, n1565, n1566, n1567, n1568,
         n1569, n1570, n1571, n1572, n1573, n1574, n1575, n1576, n1577, n1578,
         n1579, n1580, n1581, n1582, n1583, n1584, n1585, n1586, n1587, n1588,
         n1589, n1590, n1591, n1592, n1593, n1594, n1595, n1596, n1597, n1598,
         n1599, n1600, n1601, n1602, n1603, n1604, n1605, n1606, n1607, n1608,
         n1609, n1610, n1611, n1612, n1613, n1614, n1615, n1616, n1617, n1618,
         n1619, n1620, n1621, n1622, n1623, n1624, n1625, n1626, n1627, n1628,
         n1629, n1630, n1631, n1632, n1633, n1634, n1635, n1636, n1637, n1638,
         n1639, n1640, n1641, n1642, n1643, n1644, n1645, n1646, n1647, n1648,
         n1649, n1650, n1651, n1652, n1653, n1654, n1655, n1656, n1657, n1658,
         n1659, n1660, n1661, n1662, n1663, n1664, n1665, n1666, n1667, n1668,
         n1669, n1670, n1671, n1672, n1673, n1674, n1675, n1676, n1677, n1678,
         n1679, n1680, n1681, n1682, n1683, n1684, n1685, n1686, n1687, n1688,
         n1689, n1690, n1691, n1692, n1693, n1694, n1695, n1696, n1697, n1698,
         n1699, n1700, n1701, n1702, n1703, n1704, n1705, n1706, n1707, n1708,
         n1709, n1710, n1711, n1712, n1713, n1714, n1715, n1716, n1717, n1718,
         n1719, n1720, n1721, n1722, n1723, n1724, n1725, n1726, n1727, n1728,
         n1729, n1730, n1731, n1732, n1733, n1734, n1735, n1736, n1737, n1738,
         n1739, n1740, n1741, n1742, n1743, n1744, n1745, n1746, n1747, n1748,
         n1749, n1750, n1751, n1752, n1753, n1754, n1755, n1756, n1757, n1758,
         n1759, n1760, n1761, n1762, n1763, n1764, n1765, n1766, n1767, n1768,
         n1769, n1770, n1771, n1772, n1773, n1774, n1775, n1776, n1777, n1778,
         n1779, n1780, n1781, n1782, n1783, n1784, n1785, n1786, n1787, n1788,
         n1789, n1790, n1791, n1792, n1793, n1794, n1795, n1796, n1797, n1798,
         n1799, n1800, n1801, n1802, n1803, n1804, n1805, n1806, n1807, n1808,
         n1809, n1810, n1811, n1812, n1813, n1814, n1815, n1816, n1817, n1818,
         n1819, n1820, n1821, n1822, n1823, n1824, n1825, n1826, n1827, n1828,
         n1829, n1830, n1831, n1832, n1833, n1834, n1835, n1836, n1837, n1838,
         n1839, n1840, n1841, n1842, n1843, n1844, n1845, n1846, n1847, n1848,
         n1849, n1850, n1851, n1852, n1853, n1854, n1855, n1856, n1857, n1858,
         n1859, n1860, n1861, n1862, n1863, n1864, n1865, n1866, n1867, n1868,
         n1869, n1870, n1871, n1872, n1873, n1874, n1875, n1876, n1877, n1878,
         n1879, n1880, n1881, n1882, n1883, n1884, n1885, n1886, n1887, n1888,
         n1889, n1890, n1891, n1892, n1893, n1894, n1895, n1896, n1897, n1898,
         n1899, n1900, n1901, n1902, n1903, n1904, n1905, n1906, n1907, n1908,
         n1909, n1910, n1911, n1912, n1913, n1914, n1915, n1916, n1917, n1918,
         n1919, n1920, n1921, n1922, n1923, n1924, n1925, n1926, n1927, n1928,
         n1929, n1930, n1931, n1932, n1933, n1934, n1935, n1936, n1937, n1938,
         n1939, n1940, n1941, n1942, n1943, n1944, n1945, n1946, n1947, n1948,
         n1949, n1950, n1951, n1952, n1953, n1954, n1955, n1956, n1957, n1958,
         n1959, n1960, n1961, n1962, n1963, n1964, n1965, n1966, n1967, n1968,
         n1969, n1970, n1971, n1972, n1973, n1974, n1975, n1976, n1977, n1978,
         n1979, n1980, n1981, n1982, n1983, n1984, n1985, n1986, n1987, n1988,
         n1989, n1990, n1991, n1992, n1993, n1994, n1995, n1996, n1997, n1998,
         n1999, n2000, n2001, n2002, n2003, n2004, n2005, n2006, n2007, n2008,
         n2009, n2010, n2011, n2012, n2013, n2014, n2015, n2016, n2017;
  wire   [4:0] read_string_count;
  wire   [2:0] \read_chardata/temp_read_pattern_count ;
  wire   [4:0] \read_chardata/temp_read_string_count ;
  wire   [4:2] \match_controller/add_304/carry ;
  wire   [4:2] \read_chardata/add_192/carry ;

  NOR3X6 U190 ( .A(n249), .B(n1827), .C(n124), .Y(n252) );
  NOR3X6 U191 ( .A(n384), .B(n385), .C(n206), .Y(n217) );
  DFFRX1 \match_controller/star_index_reg[1]  ( .D(n997), .CK(clk), .RN(n1715), 
        .QN(n982) );
  DFFRX1 \match_controller/star_index_reg[0]  ( .D(n998), .CK(clk), .RN(n1714), 
        .QN(n981) );
  DFFRX1 \match_controller/star_index_reg[2]  ( .D(n996), .CK(clk), .RN(n1714), 
        .QN(n983) );
  DFFRX1 \read_chardata/temp_read_pattern_count_reg[1]  ( .D(n1342), .CK(clk), 
        .RN(n1743), .Q(n966) );
  DFFRX1 \read_chardata/string_buffer_reg[0][5]  ( .D(n1019), .CK(clk), .RN(
        n1716), .Q(\string_buffer[0][5] ), .QN(n1987) );
  DFFRX1 \read_chardata/string_buffer_reg[0][1]  ( .D(n1023), .CK(clk), .RN(
        n1716), .Q(\string_buffer[0][1] ) );
  DFFRX1 \read_chardata/string_buffer_reg[0][7]  ( .D(n1017), .CK(clk), .RN(
        n1716), .Q(\string_buffer[0][7] ), .QN(n1989) );
  DFFRX1 \read_chardata/string_buffer_reg[0][3]  ( .D(n1021), .CK(clk), .RN(
        n1716), .Q(\string_buffer[0][3] ), .QN(n1985) );
  DFFRX1 \read_chardata/string_buffer_reg[0][4]  ( .D(n1020), .CK(clk), .RN(
        n1716), .Q(\string_buffer[0][4] ), .QN(n1986) );
  DFFRX1 \read_chardata/string_buffer_reg[0][6]  ( .D(n1018), .CK(clk), .RN(
        n1716), .Q(\string_buffer[0][6] ), .QN(n1988) );
  DFFRX1 \read_chardata/string_buffer_reg[0][2]  ( .D(n1022), .CK(clk), .RN(
        n1716), .Q(\string_buffer[0][2] ) );
  DFFRX1 \read_chardata/string_buffer_reg[0][0]  ( .D(n1024), .CK(clk), .RN(
        n1717), .Q(\string_buffer[0][0] ) );
  DFFRX1 \match_controller/star_flag_temp_reg  ( .D(n1016), .CK(clk), .RN(
        n1715), .QN(n960) );
  DFFRX1 \read_chardata/read_string_count_reg[2]  ( .D(n969), .CK(clk), .RN(
        n1715), .Q(read_string_count[2]) );
  DFFRX1 \read_chardata/read_string_count_reg[1]  ( .D(n970), .CK(clk), .RN(
        n1716), .Q(read_string_count[1]) );
  DFFRX1 \read_chardata/read_string_count_reg[0]  ( .D(n971), .CK(clk), .RN(
        n1716), .Q(read_string_count[0]) );
  DFFRX1 \read_chardata/read_string_count_reg[3]  ( .D(n968), .CK(clk), .RN(
        n1715), .Q(read_string_count[3]) );
  DFFRX1 \read_chardata/read_string_count_reg[4]  ( .D(n967), .CK(clk), .RN(
        n1715), .Q(read_string_count[4]) );
  DFFRX1 \read_chardata/string_buffer_reg[31][1]  ( .D(n1271), .CK(clk), .RN(
        n1737), .Q(\string_buffer[31][1] ), .QN(n1855) );
  DFFRX1 \read_chardata/string_buffer_reg[31][2]  ( .D(n1270), .CK(clk), .RN(
        n1737), .Q(\string_buffer[31][2] ), .QN(n1857) );
  DFFRX1 \read_chardata/string_buffer_reg[31][0]  ( .D(n1272), .CK(clk), .RN(
        n1737), .Q(\string_buffer[31][0] ), .QN(n1853) );
  DFFRX1 \read_chardata/string_buffer_reg[1][1]  ( .D(n1031), .CK(clk), .RN(
        n1717), .Q(\string_buffer[1][1] ), .QN(n1982) );
  DFFRX1 \read_chardata/string_buffer_reg[1][2]  ( .D(n1030), .CK(clk), .RN(
        n1717), .Q(\string_buffer[1][2] ), .QN(n1983) );
  DFFRX1 \read_chardata/string_buffer_reg[1][0]  ( .D(n1032), .CK(clk), .RN(
        n1717), .Q(\string_buffer[1][0] ), .QN(n1981) );
  DFFRX1 \read_chardata/string_buffer_reg[19][5]  ( .D(n1171), .CK(clk), .RN(
        n1729), .Q(\string_buffer[19][5] ), .QN(n1912) );
  DFFRX1 \read_chardata/string_buffer_reg[30][5]  ( .D(n1259), .CK(clk), .RN(
        n1736), .Q(\string_buffer[30][5] ), .QN(n1868) );
  DFFRX1 \read_chardata/string_buffer_reg[21][5]  ( .D(n1187), .CK(clk), .RN(
        n1730), .Q(\string_buffer[21][5] ), .QN(n1904) );
  DFFRX1 \read_chardata/string_buffer_reg[23][5]  ( .D(n1203), .CK(clk), .RN(
        n1731), .Q(\string_buffer[23][5] ), .QN(n1896) );
  DFFRX1 \read_chardata/string_buffer_reg[31][7]  ( .D(n1265), .CK(clk), .RN(
        n1737), .Q(\string_buffer[31][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[9][5]  ( .D(n1091), .CK(clk), .RN(
        n1722), .Q(\string_buffer[9][5] ), .QN(n1952) );
  DFFRX1 \read_chardata/string_buffer_reg[18][5]  ( .D(n1163), .CK(clk), .RN(
        n1728), .Q(\string_buffer[18][5] ), .QN(n1916) );
  DFFRX1 \read_chardata/string_buffer_reg[25][5]  ( .D(n1219), .CK(clk), .RN(
        n1733), .Q(\string_buffer[25][5] ), .QN(n1888) );
  DFFRX1 \read_chardata/string_buffer_reg[31][5]  ( .D(n1267), .CK(clk), .RN(
        n1737), .Q(\string_buffer[31][5] ), .QN(n1861) );
  DFFRX1 \read_chardata/string_buffer_reg[27][5]  ( .D(n1235), .CK(clk), .RN(
        n1734), .Q(\string_buffer[27][5] ), .QN(n1880) );
  DFFRX1 \read_chardata/string_buffer_reg[17][5]  ( .D(n1155), .CK(clk), .RN(
        n1727), .Q(\string_buffer[17][5] ), .QN(n1920) );
  DFFRX1 \read_chardata/string_buffer_reg[20][5]  ( .D(n1179), .CK(clk), .RN(
        n1729), .Q(\string_buffer[20][5] ), .QN(n1908) );
  DFFRX1 \read_chardata/string_buffer_reg[29][5]  ( .D(n1251), .CK(clk), .RN(
        n1735), .Q(\string_buffer[29][5] ), .QN(n1872) );
  DFFRX1 \read_chardata/string_buffer_reg[27][1]  ( .D(n1239), .CK(clk), .RN(
        n1734), .Q(\string_buffer[27][1] ), .QN(n1878) );
  DFFRX1 \read_chardata/string_buffer_reg[26][1]  ( .D(n1231), .CK(clk), .RN(
        n1734), .Q(\string_buffer[26][1] ), .QN(n1882) );
  DFFRX1 \read_chardata/string_buffer_reg[22][5]  ( .D(n1195), .CK(clk), .RN(
        n1731), .Q(\string_buffer[22][5] ), .QN(n1900) );
  DFFRX1 \read_chardata/string_buffer_reg[1][7]  ( .D(n1025), .CK(clk), .RN(
        n1717), .Q(\string_buffer[1][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[24][5]  ( .D(n1211), .CK(clk), .RN(
        n1732), .Q(\string_buffer[24][5] ), .QN(n1892) );
  DFFRX1 \read_chardata/string_buffer_reg[5][5]  ( .D(n1059), .CK(clk), .RN(
        n1719), .Q(\string_buffer[5][5] ), .QN(n1968) );
  DFFRX1 \read_chardata/string_buffer_reg[31][6]  ( .D(n1266), .CK(clk), .RN(
        n1737), .Q(\string_buffer[31][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[27][2]  ( .D(n1238), .CK(clk), .RN(
        n1734), .Q(\string_buffer[27][2] ), .QN(n1879) );
  DFFRX1 \read_chardata/string_buffer_reg[3][5]  ( .D(n1043), .CK(clk), .RN(
        n1718), .Q(\string_buffer[3][5] ), .QN(n1976) );
  DFFRX1 \read_chardata/string_buffer_reg[26][2]  ( .D(n1230), .CK(clk), .RN(
        n1734), .Q(\string_buffer[26][2] ), .QN(n1883) );
  DFFRX1 \read_chardata/string_buffer_reg[30][1]  ( .D(n1263), .CK(clk), .RN(
        n1736), .Q(\string_buffer[30][1] ), .QN(n1866) );
  DFFRX1 \read_chardata/string_buffer_reg[28][5]  ( .D(n1243), .CK(clk), .RN(
        n1735), .Q(\string_buffer[28][5] ), .QN(n1876) );
  DFFRX1 \read_chardata/string_buffer_reg[26][5]  ( .D(n1227), .CK(clk), .RN(
        n1733), .Q(\string_buffer[26][5] ), .QN(n1884) );
  DFFRX1 \read_chardata/string_buffer_reg[27][0]  ( .D(n1240), .CK(clk), .RN(
        n1735), .Q(\string_buffer[27][0] ), .QN(n1877) );
  DFFRX1 \read_chardata/string_buffer_reg[26][0]  ( .D(n1232), .CK(clk), .RN(
        n1734), .Q(\string_buffer[26][0] ), .QN(n1881) );
  DFFRX1 \read_chardata/string_buffer_reg[25][1]  ( .D(n1223), .CK(clk), .RN(
        n1733), .Q(\string_buffer[25][1] ), .QN(n1886) );
  DFFRX1 \read_chardata/string_buffer_reg[29][1]  ( .D(n1255), .CK(clk), .RN(
        n1736), .Q(\string_buffer[29][1] ), .QN(n1870) );
  DFFRX1 \read_chardata/string_buffer_reg[30][2]  ( .D(n1262), .CK(clk), .RN(
        n1736), .Q(\string_buffer[30][2] ), .QN(n1867) );
  DFFRX1 \read_chardata/string_buffer_reg[31][4]  ( .D(n1268), .CK(clk), .RN(
        n1737), .Q(\string_buffer[31][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[28][1]  ( .D(n1247), .CK(clk), .RN(
        n1735), .Q(\string_buffer[28][1] ), .QN(n1874) );
  DFFRX1 \read_chardata/string_buffer_reg[25][2]  ( .D(n1222), .CK(clk), .RN(
        n1733), .Q(\string_buffer[25][2] ), .QN(n1887) );
  DFFRX1 \read_chardata/string_buffer_reg[30][0]  ( .D(n1264), .CK(clk), .RN(
        n1737), .Q(\string_buffer[30][0] ), .QN(n1865) );
  DFFRX1 \read_chardata/string_buffer_reg[29][2]  ( .D(n1254), .CK(clk), .RN(
        n1736), .Q(\string_buffer[29][2] ), .QN(n1871) );
  DFFRX1 \read_chardata/string_buffer_reg[1][6]  ( .D(n1026), .CK(clk), .RN(
        n1717), .Q(\string_buffer[1][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[1][5]  ( .D(n1027), .CK(clk), .RN(
        n1717), .Q(\string_buffer[1][5] ), .QN(n1984) );
  DFFRX1 \read_chardata/string_buffer_reg[25][0]  ( .D(n1224), .CK(clk), .RN(
        n1733), .Q(\string_buffer[25][0] ), .QN(n1885) );
  DFFRX1 \read_chardata/string_buffer_reg[4][5]  ( .D(n1051), .CK(clk), .RN(
        n1719), .Q(\string_buffer[4][5] ), .QN(n1972) );
  DFFRX1 \read_chardata/string_buffer_reg[31][3]  ( .D(n1269), .CK(clk), .RN(
        n1737), .Q(\string_buffer[31][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[29][0]  ( .D(n1256), .CK(clk), .RN(
        n1736), .Q(\string_buffer[29][0] ), .QN(n1869) );
  DFFRX1 \read_chardata/string_buffer_reg[28][2]  ( .D(n1246), .CK(clk), .RN(
        n1735), .Q(\string_buffer[28][2] ), .QN(n1875) );
  DFFRX1 \read_chardata/string_buffer_reg[6][1]  ( .D(n1071), .CK(clk), .RN(
        n1720), .Q(\string_buffer[6][1] ), .QN(n1962) );
  DFFRX1 \read_chardata/string_buffer_reg[28][0]  ( .D(n1248), .CK(clk), .RN(
        n1735), .Q(\string_buffer[28][0] ), .QN(n1873) );
  DFFRX1 \read_chardata/string_buffer_reg[1][4]  ( .D(n1028), .CK(clk), .RN(
        n1717), .Q(\string_buffer[1][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[5][1]  ( .D(n1063), .CK(clk), .RN(
        n1720), .Q(\string_buffer[5][1] ), .QN(n1966) );
  DFFRX1 \read_chardata/string_buffer_reg[4][1]  ( .D(n1055), .CK(clk), .RN(
        n1719), .Q(\string_buffer[4][1] ), .QN(n1970) );
  DFFRX1 \read_chardata/string_buffer_reg[6][2]  ( .D(n1070), .CK(clk), .RN(
        n1720), .Q(\string_buffer[6][2] ), .QN(n1963) );
  DFFRX1 \read_chardata/string_buffer_reg[15][5]  ( .D(n1139), .CK(clk), .RN(
        n1726), .Q(\string_buffer[15][5] ), .QN(n1928) );
  DFFRX1 \read_chardata/string_buffer_reg[3][1]  ( .D(n1047), .CK(clk), .RN(
        n1718), .Q(\string_buffer[3][1] ), .QN(n1974) );
  DFFRX1 \read_chardata/string_buffer_reg[1][3]  ( .D(n1029), .CK(clk), .RN(
        n1717), .Q(\string_buffer[1][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[5][2]  ( .D(n1062), .CK(clk), .RN(
        n1720), .Q(\string_buffer[5][2] ), .QN(n1967) );
  DFFRX1 \read_chardata/string_buffer_reg[6][0]  ( .D(n1072), .CK(clk), .RN(
        n1721), .Q(\string_buffer[6][0] ), .QN(n1961) );
  DFFRX1 \read_chardata/string_buffer_reg[4][2]  ( .D(n1054), .CK(clk), .RN(
        n1719), .Q(\string_buffer[4][2] ), .QN(n1971) );
  DFFRX1 \read_chardata/string_buffer_reg[8][1]  ( .D(n1087), .CK(clk), .RN(
        n1722), .Q(\string_buffer[8][1] ), .QN(n1954) );
  DFFRX1 \read_chardata/string_buffer_reg[5][0]  ( .D(n1064), .CK(clk), .RN(
        n1720), .Q(\string_buffer[5][0] ), .QN(n1965) );
  DFFRX1 \read_chardata/string_buffer_reg[3][2]  ( .D(n1046), .CK(clk), .RN(
        n1718), .Q(\string_buffer[3][2] ), .QN(n1975) );
  DFFRX1 \read_chardata/string_buffer_reg[4][0]  ( .D(n1056), .CK(clk), .RN(
        n1719), .Q(\string_buffer[4][0] ), .QN(n1969) );
  DFFRX1 \read_chardata/string_buffer_reg[8][2]  ( .D(n1086), .CK(clk), .RN(
        n1722), .Q(\string_buffer[8][2] ), .QN(n1955) );
  DFFRX1 \read_chardata/string_buffer_reg[3][0]  ( .D(n1048), .CK(clk), .RN(
        n1719), .Q(\string_buffer[3][0] ), .QN(n1973) );
  DFFRX1 \read_chardata/string_buffer_reg[14][5]  ( .D(n1131), .CK(clk), .RN(
        n1725), .Q(\string_buffer[14][5] ), .QN(n1932) );
  DFFRX1 \read_chardata/string_buffer_reg[27][7]  ( .D(n1233), .CK(clk), .RN(
        n1734), .Q(\string_buffer[27][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[26][7]  ( .D(n1225), .CK(clk), .RN(
        n1733), .Q(\string_buffer[26][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[2][5]  ( .D(n1035), .CK(clk), .RN(
        n1717), .Q(\string_buffer[2][5] ), .QN(n1980) );
  DFFRX1 \read_chardata/string_buffer_reg[8][0]  ( .D(n1088), .CK(clk), .RN(
        n1722), .Q(\string_buffer[8][0] ), .QN(n1953) );
  DFFRX1 \read_chardata/string_buffer_reg[7][1]  ( .D(n1079), .CK(clk), .RN(
        n1721), .Q(\string_buffer[7][1] ), .QN(n1958) );
  DFFRX1 \read_chardata/string_buffer_reg[8][5]  ( .D(n1083), .CK(clk), .RN(
        n1721), .Q(\string_buffer[8][5] ), .QN(n1956) );
  DFFRX1 \read_chardata/string_buffer_reg[16][5]  ( .D(n1147), .CK(clk), .RN(
        n1727), .Q(\string_buffer[16][5] ), .QN(n1924) );
  DFFRX1 \read_chardata/string_buffer_reg[30][7]  ( .D(n1257), .CK(clk), .RN(
        n1736), .Q(\string_buffer[30][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[2][1]  ( .D(n1039), .CK(clk), .RN(
        n1718), .Q(\string_buffer[2][1] ), .QN(n1978) );
  DFFRX1 \read_chardata/string_buffer_reg[7][2]  ( .D(n1078), .CK(clk), .RN(
        n1721), .Q(\string_buffer[7][2] ), .QN(n1959) );
  DFFRX1 \read_chardata/string_buffer_reg[25][7]  ( .D(n1217), .CK(clk), .RN(
        n1733), .Q(\string_buffer[25][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[11][5]  ( .D(n1107), .CK(clk), .RN(
        n1723), .Q(\string_buffer[11][5] ), .QN(n1944) );
  DFFRX1 \read_chardata/string_buffer_reg[29][7]  ( .D(n1249), .CK(clk), .RN(
        n1735), .Q(\string_buffer[29][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[7][0]  ( .D(n1080), .CK(clk), .RN(
        n1721), .Q(\string_buffer[7][0] ), .QN(n1957) );
  DFFRX1 \read_chardata/string_buffer_reg[2][2]  ( .D(n1038), .CK(clk), .RN(
        n1718), .Q(\string_buffer[2][2] ), .QN(n1979) );
  DFFRX1 \read_chardata/string_buffer_reg[27][6]  ( .D(n1234), .CK(clk), .RN(
        n1734), .Q(\string_buffer[27][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[10][5]  ( .D(n1099), .CK(clk), .RN(
        n1723), .Q(\string_buffer[10][5] ), .QN(n1948) );
  DFFRX1 \read_chardata/string_buffer_reg[26][6]  ( .D(n1226), .CK(clk), .RN(
        n1733), .Q(\string_buffer[26][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[28][7]  ( .D(n1241), .CK(clk), .RN(
        n1735), .Q(\string_buffer[28][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[13][5]  ( .D(n1123), .CK(clk), .RN(
        n1725), .Q(\string_buffer[13][5] ), .QN(n1936) );
  DFFRX1 \read_chardata/string_buffer_reg[22][1]  ( .D(n1199), .CK(clk), .RN(
        n1731), .Q(\string_buffer[22][1] ), .QN(n1898) );
  DFFRX1 \read_chardata/string_buffer_reg[2][0]  ( .D(n1040), .CK(clk), .RN(
        n1718), .Q(\string_buffer[2][0] ), .QN(n1977) );
  DFFRX1 \read_chardata/string_buffer_reg[7][5]  ( .D(n1075), .CK(clk), .RN(
        n1721), .Q(\string_buffer[7][5] ), .QN(n1960) );
  DFFRX1 \read_chardata/string_buffer_reg[21][1]  ( .D(n1191), .CK(clk), .RN(
        n1730), .Q(\string_buffer[21][1] ), .QN(n1902) );
  DFFRX1 \read_chardata/string_buffer_reg[12][5]  ( .D(n1115), .CK(clk), .RN(
        n1724), .Q(\string_buffer[12][5] ), .QN(n1940) );
  DFFRX1 \read_chardata/string_buffer_reg[14][1]  ( .D(n1135), .CK(clk), .RN(
        n1726), .Q(\string_buffer[14][1] ), .QN(n1930) );
  DFFRX1 \read_chardata/string_buffer_reg[30][6]  ( .D(n1258), .CK(clk), .RN(
        n1736), .Q(\string_buffer[30][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[22][2]  ( .D(n1198), .CK(clk), .RN(
        n1731), .Q(\string_buffer[22][2] ), .QN(n1899) );
  DFFRX1 \read_chardata/string_buffer_reg[6][7]  ( .D(n1065), .CK(clk), .RN(
        n1720), .Q(\string_buffer[6][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[13][1]  ( .D(n1127), .CK(clk), .RN(
        n1725), .Q(\string_buffer[13][1] ), .QN(n1934) );
  DFFRX1 \read_chardata/string_buffer_reg[27][4]  ( .D(n1236), .CK(clk), .RN(
        n1734), .Q(\string_buffer[27][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[25][6]  ( .D(n1218), .CK(clk), .RN(
        n1733), .Q(\string_buffer[25][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[21][2]  ( .D(n1190), .CK(clk), .RN(
        n1730), .Q(\string_buffer[21][2] ), .QN(n1903) );
  DFFRX1 \read_chardata/string_buffer_reg[26][4]  ( .D(n1228), .CK(clk), .RN(
        n1734), .Q(\string_buffer[26][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[22][0]  ( .D(n1200), .CK(clk), .RN(
        n1731), .Q(\string_buffer[22][0] ), .QN(n1897) );
  DFFRX1 \read_chardata/string_buffer_reg[29][6]  ( .D(n1250), .CK(clk), .RN(
        n1735), .Q(\string_buffer[29][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[14][2]  ( .D(n1134), .CK(clk), .RN(
        n1726), .Q(\string_buffer[14][2] ), .QN(n1931) );
  DFFRX1 \read_chardata/string_buffer_reg[5][7]  ( .D(n1057), .CK(clk), .RN(
        n1719), .Q(\string_buffer[5][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[4][7]  ( .D(n1049), .CK(clk), .RN(
        n1719), .Q(\string_buffer[4][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[21][0]  ( .D(n1192), .CK(clk), .RN(
        n1731), .Q(\string_buffer[21][0] ), .QN(n1901) );
  DFFRX1 \read_chardata/string_buffer_reg[13][2]  ( .D(n1126), .CK(clk), .RN(
        n1725), .Q(\string_buffer[13][2] ), .QN(n1935) );
  DFFRX1 \read_chardata/string_buffer_reg[28][6]  ( .D(n1242), .CK(clk), .RN(
        n1735), .Q(\string_buffer[28][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[14][0]  ( .D(n1136), .CK(clk), .RN(
        n1726), .Q(\string_buffer[14][0] ), .QN(n1929) );
  DFFRX1 \read_chardata/string_buffer_reg[27][3]  ( .D(n1237), .CK(clk), .RN(
        n1734), .Q(\string_buffer[27][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[26][3]  ( .D(n1229), .CK(clk), .RN(
        n1734), .Q(\string_buffer[26][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[20][1]  ( .D(n1183), .CK(clk), .RN(
        n1730), .Q(\string_buffer[20][1] ), .QN(n1906) );
  DFFRX1 \read_chardata/string_buffer_reg[30][4]  ( .D(n1260), .CK(clk), .RN(
        n1736), .Q(\string_buffer[30][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[3][7]  ( .D(n1041), .CK(clk), .RN(
        n1718), .Q(\string_buffer[3][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[13][0]  ( .D(n1128), .CK(clk), .RN(
        n1725), .Q(\string_buffer[13][0] ), .QN(n1933) );
  DFFRX1 \read_chardata/string_buffer_reg[6][5]  ( .D(n1067), .CK(clk), .RN(
        n1720), .Q(\string_buffer[6][5] ), .QN(n1964) );
  DFFRX1 \read_chardata/string_buffer_reg[19][1]  ( .D(n1175), .CK(clk), .RN(
        n1729), .Q(\string_buffer[19][1] ), .QN(n1910) );
  DFFRX1 \read_chardata/string_buffer_reg[12][1]  ( .D(n1119), .CK(clk), .RN(
        n1724), .Q(\string_buffer[12][1] ), .QN(n1938) );
  DFFRX1 \read_chardata/string_buffer_reg[25][4]  ( .D(n1220), .CK(clk), .RN(
        n1733), .Q(\string_buffer[25][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[8][7]  ( .D(n1081), .CK(clk), .RN(
        n1721), .Q(\string_buffer[8][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[29][4]  ( .D(n1252), .CK(clk), .RN(
        n1736), .Q(\string_buffer[29][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[20][2]  ( .D(n1182), .CK(clk), .RN(
        n1730), .Q(\string_buffer[20][2] ), .QN(n1907) );
  DFFRX1 \read_chardata/string_buffer_reg[30][3]  ( .D(n1261), .CK(clk), .RN(
        n1736), .Q(\string_buffer[30][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[6][6]  ( .D(n1066), .CK(clk), .RN(
        n1720), .Q(\string_buffer[6][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[11][1]  ( .D(n1111), .CK(clk), .RN(
        n1724), .Q(\string_buffer[11][1] ), .QN(n1942) );
  DFFRX1 \read_chardata/string_buffer_reg[19][2]  ( .D(n1174), .CK(clk), .RN(
        n1729), .Q(\string_buffer[19][2] ), .QN(n1911) );
  DFFRX1 \read_chardata/string_buffer_reg[20][0]  ( .D(n1184), .CK(clk), .RN(
        n1730), .Q(\string_buffer[20][0] ), .QN(n1905) );
  DFFRX1 \read_chardata/string_buffer_reg[28][4]  ( .D(n1244), .CK(clk), .RN(
        n1735), .Q(\string_buffer[28][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[12][2]  ( .D(n1118), .CK(clk), .RN(
        n1724), .Q(\string_buffer[12][2] ), .QN(n1939) );
  DFFRX1 \read_chardata/string_buffer_reg[25][3]  ( .D(n1221), .CK(clk), .RN(
        n1733), .Q(\string_buffer[25][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[18][1]  ( .D(n1167), .CK(clk), .RN(
        n1728), .Q(\string_buffer[18][1] ), .QN(n1914) );
  DFFRX1 \read_chardata/string_buffer_reg[29][3]  ( .D(n1253), .CK(clk), .RN(
        n1736), .Q(\string_buffer[29][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[5][6]  ( .D(n1058), .CK(clk), .RN(
        n1719), .Q(\string_buffer[5][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[4][6]  ( .D(n1050), .CK(clk), .RN(
        n1719), .Q(\string_buffer[4][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[19][0]  ( .D(n1176), .CK(clk), .RN(
        n1729), .Q(\string_buffer[19][0] ), .QN(n1909) );
  DFFRX1 \read_chardata/string_buffer_reg[11][2]  ( .D(n1110), .CK(clk), .RN(
        n1724), .Q(\string_buffer[11][2] ), .QN(n1943) );
  DFFRX1 \read_chardata/string_buffer_reg[12][0]  ( .D(n1120), .CK(clk), .RN(
        n1725), .Q(\string_buffer[12][0] ), .QN(n1937) );
  DFFRX1 \read_chardata/string_buffer_reg[17][1]  ( .D(n1159), .CK(clk), .RN(
        n1728), .Q(\string_buffer[17][1] ), .QN(n1918) );
  DFFRX1 \read_chardata/string_buffer_reg[10][1]  ( .D(n1103), .CK(clk), .RN(
        n1723), .Q(\string_buffer[10][1] ), .QN(n1946) );
  DFFRX1 \read_chardata/string_buffer_reg[28][3]  ( .D(n1245), .CK(clk), .RN(
        n1735), .Q(\string_buffer[28][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[7][7]  ( .D(n1073), .CK(clk), .RN(
        n1721), .Q(\string_buffer[7][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[18][2]  ( .D(n1166), .CK(clk), .RN(
        n1728), .Q(\string_buffer[18][2] ), .QN(n1915) );
  DFFRX1 \read_chardata/string_buffer_reg[3][6]  ( .D(n1042), .CK(clk), .RN(
        n1718), .Q(\string_buffer[3][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[24][1]  ( .D(n1215), .CK(clk), .RN(
        n1732), .Q(\string_buffer[24][1] ), .QN(n1890) );
  DFFRX1 \read_chardata/string_buffer_reg[11][0]  ( .D(n1112), .CK(clk), .RN(
        n1724), .Q(\string_buffer[11][0] ), .QN(n1941) );
  DFFRX1 \read_chardata/string_buffer_reg[6][4]  ( .D(n1068), .CK(clk), .RN(
        n1720), .Q(\string_buffer[6][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[9][1]  ( .D(n1095), .CK(clk), .RN(
        n1722), .Q(\string_buffer[9][1] ), .QN(n1950) );
  DFFRX1 \read_chardata/string_buffer_reg[17][2]  ( .D(n1158), .CK(clk), .RN(
        n1728), .Q(\string_buffer[17][2] ), .QN(n1919) );
  DFFRX1 \read_chardata/string_buffer_reg[23][1]  ( .D(n1207), .CK(clk), .RN(
        n1732), .Q(\string_buffer[23][1] ), .QN(n1894) );
  DFFRX1 \read_chardata/string_buffer_reg[8][6]  ( .D(n1082), .CK(clk), .RN(
        n1721), .Q(\string_buffer[8][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[18][0]  ( .D(n1168), .CK(clk), .RN(
        n1729), .Q(\string_buffer[18][0] ), .QN(n1913) );
  DFFRX1 \read_chardata/string_buffer_reg[10][2]  ( .D(n1102), .CK(clk), .RN(
        n1723), .Q(\string_buffer[10][2] ), .QN(n1947) );
  DFFRX1 \read_chardata/string_buffer_reg[2][7]  ( .D(n1033), .CK(clk), .RN(
        n1717), .Q(\string_buffer[2][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[16][1]  ( .D(n1151), .CK(clk), .RN(
        n1727), .Q(\string_buffer[16][1] ), .QN(n1922) );
  DFFRX1 \read_chardata/string_buffer_reg[5][4]  ( .D(n1060), .CK(clk), .RN(
        n1720), .Q(\string_buffer[5][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[24][2]  ( .D(n1214), .CK(clk), .RN(
        n1732), .Q(\string_buffer[24][2] ), .QN(n1891) );
  DFFRX1 \read_chardata/string_buffer_reg[4][4]  ( .D(n1052), .CK(clk), .RN(
        n1719), .Q(\string_buffer[4][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[17][0]  ( .D(n1160), .CK(clk), .RN(
        n1728), .Q(\string_buffer[17][0] ), .QN(n1917) );
  DFFRX1 \read_chardata/string_buffer_reg[9][2]  ( .D(n1094), .CK(clk), .RN(
        n1722), .Q(\string_buffer[9][2] ), .QN(n1951) );
  DFFRX1 \read_chardata/string_buffer_reg[6][3]  ( .D(n1069), .CK(clk), .RN(
        n1720), .Q(\string_buffer[6][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[15][1]  ( .D(n1143), .CK(clk), .RN(
        n1726), .Q(\string_buffer[15][1] ), .QN(n1926) );
  DFFRX1 \read_chardata/string_buffer_reg[10][0]  ( .D(n1104), .CK(clk), .RN(
        n1723), .Q(\string_buffer[10][0] ), .QN(n1945) );
  DFFRX1 \read_chardata/string_buffer_reg[23][2]  ( .D(n1206), .CK(clk), .RN(
        n1732), .Q(\string_buffer[23][2] ), .QN(n1895) );
  DFFRX1 \read_chardata/string_buffer_reg[24][0]  ( .D(n1216), .CK(clk), .RN(
        n1733), .Q(\string_buffer[24][0] ), .QN(n1889) );
  DFFRX1 \read_chardata/string_buffer_reg[16][2]  ( .D(n1150), .CK(clk), .RN(
        n1727), .Q(\string_buffer[16][2] ), .QN(n1923) );
  DFFRX1 \read_chardata/string_buffer_reg[3][4]  ( .D(n1044), .CK(clk), .RN(
        n1718), .Q(\string_buffer[3][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[5][3]  ( .D(n1061), .CK(clk), .RN(
        n1720), .Q(\string_buffer[5][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[9][0]  ( .D(n1096), .CK(clk), .RN(
        n1723), .Q(\string_buffer[9][0] ), .QN(n1949) );
  DFFRX1 \read_chardata/string_buffer_reg[4][3]  ( .D(n1053), .CK(clk), .RN(
        n1719), .Q(\string_buffer[4][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[23][0]  ( .D(n1208), .CK(clk), .RN(
        n1732), .Q(\string_buffer[23][0] ), .QN(n1893) );
  DFFRX1 \read_chardata/string_buffer_reg[15][2]  ( .D(n1142), .CK(clk), .RN(
        n1726), .Q(\string_buffer[15][2] ), .QN(n1927) );
  DFFRX1 \read_chardata/string_buffer_reg[22][7]  ( .D(n1193), .CK(clk), .RN(
        n1731), .Q(\string_buffer[22][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[7][6]  ( .D(n1074), .CK(clk), .RN(
        n1721), .Q(\string_buffer[7][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[16][0]  ( .D(n1152), .CK(clk), .RN(
        n1727), .Q(\string_buffer[16][0] ), .QN(n1921) );
  DFFRX1 \read_chardata/string_buffer_reg[8][4]  ( .D(n1084), .CK(clk), .RN(
        n1722), .Q(\string_buffer[8][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[3][3]  ( .D(n1045), .CK(clk), .RN(
        n1718), .Q(\string_buffer[3][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[21][7]  ( .D(n1185), .CK(clk), .RN(
        n1730), .Q(\string_buffer[21][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[15][0]  ( .D(n1144), .CK(clk), .RN(
        n1727), .Q(\string_buffer[15][0] ), .QN(n1925) );
  DFFRX1 \read_chardata/string_buffer_reg[14][7]  ( .D(n1129), .CK(clk), .RN(
        n1725), .Q(\string_buffer[14][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[2][6]  ( .D(n1034), .CK(clk), .RN(
        n1717), .Q(\string_buffer[2][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[8][3]  ( .D(n1085), .CK(clk), .RN(
        n1722), .Q(\string_buffer[8][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[13][7]  ( .D(n1121), .CK(clk), .RN(
        n1725), .Q(\string_buffer[13][7] ) );
  DFFRX1 \fsm/cur_state_reg[1]  ( .D(n975), .CK(clk), .RN(n1743), .Q(n1371), 
        .QN(n977) );
  DFFRX1 \read_chardata/string_buffer_reg[7][4]  ( .D(n1076), .CK(clk), .RN(
        n1721), .Q(\string_buffer[7][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[20][7]  ( .D(n1177), .CK(clk), .RN(
        n1729), .Q(\string_buffer[20][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[22][6]  ( .D(n1194), .CK(clk), .RN(
        n1731), .Q(\string_buffer[22][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[2][4]  ( .D(n1036), .CK(clk), .RN(
        n1718), .Q(\string_buffer[2][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[7][3]  ( .D(n1077), .CK(clk), .RN(
        n1721), .Q(\string_buffer[7][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[21][6]  ( .D(n1186), .CK(clk), .RN(
        n1730), .Q(\string_buffer[21][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[19][7]  ( .D(n1169), .CK(clk), .RN(
        n1729), .Q(\string_buffer[19][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[14][6]  ( .D(n1130), .CK(clk), .RN(
        n1725), .Q(\string_buffer[14][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[12][7]  ( .D(n1113), .CK(clk), .RN(
        n1724), .Q(\string_buffer[12][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[2][3]  ( .D(n1037), .CK(clk), .RN(
        n1718), .Q(\string_buffer[2][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[13][6]  ( .D(n1122), .CK(clk), .RN(
        n1725), .Q(\string_buffer[13][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[11][7]  ( .D(n1105), .CK(clk), .RN(
        n1723), .Q(\string_buffer[11][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[22][4]  ( .D(n1196), .CK(clk), .RN(
        n1731), .Q(\string_buffer[22][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[18][7]  ( .D(n1161), .CK(clk), .RN(
        n1728), .Q(\string_buffer[18][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[21][4]  ( .D(n1188), .CK(clk), .RN(
        n1730), .Q(\string_buffer[21][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[17][7]  ( .D(n1153), .CK(clk), .RN(
        n1727), .Q(\string_buffer[17][7] ) );
  DFFRX1 \fsm/cur_state_reg[0]  ( .D(\fsm/next_state[0] ), .CK(clk), .RN(n1743), .Q(n1351), .QN(n959) );
  DFFRX1 \read_chardata/string_buffer_reg[20][6]  ( .D(n1178), .CK(clk), .RN(
        n1729), .Q(\string_buffer[20][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[14][4]  ( .D(n1132), .CK(clk), .RN(
        n1726), .Q(\string_buffer[14][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[10][7]  ( .D(n1097), .CK(clk), .RN(
        n1723), .Q(\string_buffer[10][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[22][3]  ( .D(n1197), .CK(clk), .RN(
        n1731), .Q(\string_buffer[22][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[24][7]  ( .D(n1209), .CK(clk), .RN(
        n1732), .Q(\string_buffer[24][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[19][6]  ( .D(n1170), .CK(clk), .RN(
        n1729), .Q(\string_buffer[19][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[13][4]  ( .D(n1124), .CK(clk), .RN(
        n1725), .Q(\string_buffer[13][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[9][7]  ( .D(n1089), .CK(clk), .RN(
        n1722), .Q(\string_buffer[9][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[12][6]  ( .D(n1114), .CK(clk), .RN(
        n1724), .Q(\string_buffer[12][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[21][3]  ( .D(n1189), .CK(clk), .RN(
        n1730), .Q(\string_buffer[21][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[23][7]  ( .D(n1201), .CK(clk), .RN(
        n1731), .Q(\string_buffer[23][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[14][3]  ( .D(n1133), .CK(clk), .RN(
        n1726), .Q(\string_buffer[14][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[16][7]  ( .D(n1145), .CK(clk), .RN(
        n1727), .Q(\string_buffer[16][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[11][6]  ( .D(n1106), .CK(clk), .RN(
        n1723), .Q(\string_buffer[11][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[13][3]  ( .D(n1125), .CK(clk), .RN(
        n1725), .Q(\string_buffer[13][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[15][7]  ( .D(n1137), .CK(clk), .RN(
        n1726), .Q(\string_buffer[15][7] ) );
  DFFRX1 \read_chardata/string_buffer_reg[18][6]  ( .D(n1162), .CK(clk), .RN(
        n1728), .Q(\string_buffer[18][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[20][4]  ( .D(n1180), .CK(clk), .RN(
        n1730), .Q(\string_buffer[20][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[19][4]  ( .D(n1172), .CK(clk), .RN(
        n1729), .Q(\string_buffer[19][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[17][6]  ( .D(n1154), .CK(clk), .RN(
        n1727), .Q(\string_buffer[17][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[10][6]  ( .D(n1098), .CK(clk), .RN(
        n1723), .Q(\string_buffer[10][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[12][4]  ( .D(n1116), .CK(clk), .RN(
        n1724), .Q(\string_buffer[12][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[24][6]  ( .D(n1210), .CK(clk), .RN(
        n1732), .Q(\string_buffer[24][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[20][3]  ( .D(n1181), .CK(clk), .RN(
        n1730), .Q(\string_buffer[20][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[9][6]  ( .D(n1090), .CK(clk), .RN(
        n1722), .Q(\string_buffer[9][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[11][4]  ( .D(n1108), .CK(clk), .RN(
        n1724), .Q(\string_buffer[11][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[23][6]  ( .D(n1202), .CK(clk), .RN(
        n1731), .Q(\string_buffer[23][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[19][3]  ( .D(n1173), .CK(clk), .RN(
        n1729), .Q(\string_buffer[19][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[12][3]  ( .D(n1117), .CK(clk), .RN(
        n1724), .Q(\string_buffer[12][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[16][6]  ( .D(n1146), .CK(clk), .RN(
        n1727), .Q(\string_buffer[16][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[18][4]  ( .D(n1164), .CK(clk), .RN(
        n1728), .Q(\string_buffer[18][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[15][6]  ( .D(n1138), .CK(clk), .RN(
        n1726), .Q(\string_buffer[15][6] ) );
  DFFRX1 \read_chardata/string_buffer_reg[11][3]  ( .D(n1109), .CK(clk), .RN(
        n1724), .Q(\string_buffer[11][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[17][4]  ( .D(n1156), .CK(clk), .RN(
        n1728), .Q(\string_buffer[17][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[10][4]  ( .D(n1100), .CK(clk), .RN(
        n1723), .Q(\string_buffer[10][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[24][4]  ( .D(n1212), .CK(clk), .RN(
        n1732), .Q(\string_buffer[24][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[18][3]  ( .D(n1165), .CK(clk), .RN(
        n1728), .Q(\string_buffer[18][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[9][4]  ( .D(n1092), .CK(clk), .RN(
        n1722), .Q(\string_buffer[9][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[23][4]  ( .D(n1204), .CK(clk), .RN(
        n1732), .Q(\string_buffer[23][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[17][3]  ( .D(n1157), .CK(clk), .RN(
        n1728), .Q(\string_buffer[17][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[16][4]  ( .D(n1148), .CK(clk), .RN(
        n1727), .Q(\string_buffer[16][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[10][3]  ( .D(n1101), .CK(clk), .RN(
        n1723), .Q(\string_buffer[10][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[24][3]  ( .D(n1213), .CK(clk), .RN(
        n1732), .Q(\string_buffer[24][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[15][4]  ( .D(n1140), .CK(clk), .RN(
        n1726), .Q(\string_buffer[15][4] ) );
  DFFRX1 \read_chardata/string_buffer_reg[9][3]  ( .D(n1093), .CK(clk), .RN(
        n1722), .Q(\string_buffer[9][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[23][3]  ( .D(n1205), .CK(clk), .RN(
        n1732), .Q(\string_buffer[23][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[16][3]  ( .D(n1149), .CK(clk), .RN(
        n1727), .Q(\string_buffer[16][3] ) );
  DFFRX1 \read_chardata/string_buffer_reg[15][3]  ( .D(n1141), .CK(clk), .RN(
        n1726), .Q(\string_buffer[15][3] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[7][7]  ( .D(n1329), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[7][7] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[5][7]  ( .D(n1313), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[5][7] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[7][6]  ( .D(n1330), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[7][6] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[5][6]  ( .D(n1314), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[5][6] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[6][7]  ( .D(n1321), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[6][7] ), .QN(n1358) );
  DFFRX1 \read_chardata/pattern_buffer_reg[4][7]  ( .D(n1305), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[4][7] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[6][6]  ( .D(n1322), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[6][6] ), .QN(n1356) );
  DFFRX1 \read_chardata/pattern_buffer_reg[4][6]  ( .D(n1306), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[4][6] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[3][7]  ( .D(n1297), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[3][7] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[3][6]  ( .D(n1298), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[3][6] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[1][7]  ( .D(n1281), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[1][7] ), .QN(n1845) );
  DFFRX1 \read_chardata/pattern_buffer_reg[1][6]  ( .D(n1282), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[1][6] ), .QN(n1844) );
  DFFRX1 \read_chardata/pattern_buffer_reg[0][6]  ( .D(n1274), .CK(clk), .RN(
        n1737), .Q(\pattern_buffer[0][6] ), .QN(n1849) );
  DFFRX1 \read_chardata/pattern_buffer_reg[2][7]  ( .D(n1289), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[2][7] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[2][6]  ( .D(n1290), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[2][6] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[0][7]  ( .D(n1273), .CK(clk), .RN(
        n1737), .Q(\pattern_buffer[0][7] ), .QN(n1850) );
  DFFRX1 \read_chardata/pattern_buffer_reg[7][4]  ( .D(n1332), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[7][4] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[7][5]  ( .D(n1331), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[7][5] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[7][3]  ( .D(n1333), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[7][3] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[5][4]  ( .D(n1316), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[5][4] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[7][1]  ( .D(n1335), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[7][1] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[5][5]  ( .D(n1315), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[5][5] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[5][3]  ( .D(n1317), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[5][3] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[5][1]  ( .D(n1319), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[5][1] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[7][0]  ( .D(n1336), .CK(clk), .RN(
        n1743), .Q(\pattern_buffer[7][0] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[5][0]  ( .D(n1320), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[5][0] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[4][5]  ( .D(n1307), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[4][5] ), .QN(n1361) );
  DFFRX1 \read_chardata/pattern_buffer_reg[6][4]  ( .D(n1324), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[6][4] ), .QN(n1355) );
  DFFRX1 \read_chardata/pattern_buffer_reg[4][3]  ( .D(n1309), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[4][3] ), .QN(n1357) );
  DFFRX1 \read_chardata/pattern_buffer_reg[4][4]  ( .D(n1308), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[4][4] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[4][1]  ( .D(n1311), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[4][1] ), .QN(n1360) );
  DFFRX1 \read_chardata/pattern_buffer_reg[6][5]  ( .D(n1323), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[6][5] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[6][3]  ( .D(n1325), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[6][3] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[6][1]  ( .D(n1327), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[6][1] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[6][0]  ( .D(n1328), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[6][0] ), .QN(n1354) );
  DFFRX1 \read_chardata/pattern_buffer_reg[4][0]  ( .D(n1312), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[4][0] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[3][5]  ( .D(n1299), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[3][5] ), .QN(n1839) );
  DFFRX1 \read_chardata/pattern_buffer_reg[3][3]  ( .D(n1301), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[3][3] ), .QN(n1838) );
  DFFRX1 \read_chardata/pattern_buffer_reg[3][1]  ( .D(n1303), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[3][1] ), .QN(n1836) );
  DFFRX1 \read_chardata/pattern_buffer_reg[3][4]  ( .D(n1300), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[3][4] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[1][4]  ( .D(n1284), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[1][4] ), .QN(n1843) );
  DFFRX1 \read_chardata/pattern_buffer_reg[0][4]  ( .D(n1276), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[0][4] ), .QN(n1848) );
  DFFRX1 \read_chardata/pattern_buffer_reg[3][0]  ( .D(n1304), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[3][0] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[1][3]  ( .D(n1285), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[1][3] ), .QN(n1349) );
  DFFRX1 \read_chardata/pattern_buffer_reg[2][5]  ( .D(n1291), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[2][5] ), .QN(n1366) );
  DFFRX1 \read_chardata/pattern_buffer_reg[2][3]  ( .D(n1293), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[2][3] ), .QN(n1364) );
  DFFRX1 \read_chardata/pattern_buffer_reg[2][4]  ( .D(n1292), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[2][4] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[2][1]  ( .D(n1295), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[2][1] ), .QN(n1363) );
  DFFRX1 \read_chardata/pattern_buffer_reg[1][0]  ( .D(n1288), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[1][0] ), .QN(n1842) );
  DFFRX1 \read_chardata/pattern_buffer_reg[0][3]  ( .D(n1277), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[0][3] ), .QN(n1370) );
  DFFRX1 \read_chardata/pattern_buffer_reg[0][1]  ( .D(n1279), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[0][1] ), .QN(n1350) );
  DFFRX1 \read_chardata/pattern_buffer_reg[2][0]  ( .D(n1296), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[2][0] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[0][5]  ( .D(n1275), .CK(clk), .RN(
        n1737), .Q(\pattern_buffer[0][5] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[0][0]  ( .D(n1280), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[0][0] ), .QN(n1846) );
  DFFRX1 \read_chardata/pattern_buffer_reg[7][2]  ( .D(n1334), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[7][2] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[5][2]  ( .D(n1318), .CK(clk), .RN(
        n1741), .Q(\pattern_buffer[5][2] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[4][2]  ( .D(n1310), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[4][2] ), .QN(n1359) );
  DFFRX1 \read_chardata/pattern_buffer_reg[6][2]  ( .D(n1326), .CK(clk), .RN(
        n1742), .Q(\pattern_buffer[6][2] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[3][2]  ( .D(n1302), .CK(clk), .RN(
        n1740), .Q(\pattern_buffer[3][2] ), .QN(n1837) );
  DFFRX1 \read_chardata/pattern_buffer_reg[1][2]  ( .D(n1286), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[1][2] ), .QN(n1362) );
  DFFRX1 \read_chardata/pattern_buffer_reg[2][2]  ( .D(n1294), .CK(clk), .RN(
        n1739), .Q(\pattern_buffer[2][2] ), .QN(n1365) );
  DFFRX1 \read_chardata/pattern_buffer_reg[0][2]  ( .D(n1278), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[0][2] ), .QN(n1369) );
  DFFRX1 \read_chardata/temp_read_string_count_reg[4]  ( .D(n1341), .CK(clk), 
        .RN(n1743), .Q(\read_chardata/temp_read_string_count [4]), .QN(n1368)
         );
  DFFRX1 \read_chardata/temp_read_pattern_count_reg[2]  ( .D(n1344), .CK(clk), 
        .RN(n1743), .Q(\read_chardata/temp_read_pattern_count [2]), .QN(n1823)
         );
  DFFRX1 \read_chardata/temp_read_string_count_reg[3]  ( .D(n1337), .CK(clk), 
        .RN(n1743), .Q(\read_chardata/temp_read_string_count [3]), .QN(n1367)
         );
  DFFRX1 \read_chardata/pattern_buffer_reg[1][5]  ( .D(n1283), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[1][5] ) );
  DFFRX1 \read_chardata/pattern_buffer_reg[1][1]  ( .D(n1287), .CK(clk), .RN(
        n1738), .Q(\pattern_buffer[1][1] ) );
  DFFRX1 \match_controller/cur_match_state_reg[3]  ( .D(n1012), .CK(clk), .RN(
        n1714), .Q(n1352), .QN(n987) );
  DFFRX1 \match_controller/cur_match_state_reg[0]  ( .D(n1015), .CK(clk), .RN(
        n1715), .Q(n1353), .QN(n984) );
  DFFRX1 \match_controller/cur_match_state_reg[1]  ( .D(n1014), .CK(clk), .RN(
        n1715), .Q(n1348), .QN(n985) );
  DFFRX1 \match_controller/match_index_reg[0]  ( .D(n1003), .CK(clk), .RN(
        n1714), .Q(n2023), .QN(n961) );
  DFFRX1 \match_controller/match_index_reg[4]  ( .D(n1002), .CK(clk), .RN(
        n1714), .Q(n2019), .QN(n962) );
  DFFRX1 \match_controller/match_index_reg[3]  ( .D(n1001), .CK(clk), .RN(
        n1714), .Q(n2020), .QN(n963) );
  DFFRX1 \match_controller/match_index_reg[2]  ( .D(n1000), .CK(clk), .RN(
        n1714), .Q(n2021), .QN(n964) );
  DFFRX1 \match_controller/match_index_reg[1]  ( .D(n999), .CK(clk), .RN(n1714), .Q(n2022), .QN(n965) );
  DFFRX1 \read_chardata/temp_read_string_count_reg[2]  ( .D(n1338), .CK(clk), 
        .RN(n1770), .Q(\read_chardata/temp_read_string_count [2]), .QN(n1825)
         );
  DFFRX1 \read_chardata/temp_read_string_count_reg[1]  ( .D(n1339), .CK(clk), 
        .RN(n1770), .Q(\read_chardata/temp_read_string_count [1]), .QN(n1824)
         );
  DFFRX1 \read_chardata/temp_read_string_count_reg[0]  ( .D(n1340), .CK(clk), 
        .RN(n1743), .Q(\read_chardata/temp_read_string_count [0]), .QN(
        \read_chardata/N110 ) );
  DFFRX1 \match_controller/cur_match_state_reg[2]  ( .D(n1013), .CK(clk), .RN(
        n1770), .QN(n986) );
  DFFRX1 \match_controller/match_string_count_reg[3]  ( .D(n1007), .CK(clk), 
        .RN(n1770), .Q(\match_controller/N253 ), .QN(n1563) );
  DFFRX2 \read_chardata/read_pattern_count_reg[1]  ( .D(n973), .CK(clk), .RN(
        n1770), .Q(\match_controller/N245 ), .QN(n1662) );
  DFFRX2 \match_controller/match_string_count_reg[4]  ( .D(n1006), .CK(clk), 
        .RN(n1770), .Q(\match_controller/N254 ), .QN(n1562) );
  DFFRX2 \match_controller/match_string_count_reg[2]  ( .D(n1008), .CK(clk), 
        .RN(n1770), .Q(\match_controller/N252 ), .QN(n1564) );
  DFFRX2 \match_controller/match_string_count_reg[1]  ( .D(n1010), .CK(clk), 
        .RN(n1770), .Q(\match_controller/N251 ), .QN(n992) );
  DFFRX2 \match_controller/match_string_count_reg[0]  ( .D(n1009), .CK(clk), 
        .RN(n1770), .Q(\match_controller/N250 ), .QN(n1565) );
  DFFRX4 \match_controller/match_pattern_count_reg[0]  ( .D(n1005), .CK(clk), 
        .RN(n1770), .Q(\match_controller/N247 ), .QN(n1619) );
  DFFRX4 \read_chardata/read_pattern_count_reg[0]  ( .D(n974), .CK(clk), .RN(
        n1770), .Q(\match_controller/N244 ), .QN(n1663) );
  DFFRX2 \read_chardata/read_pattern_count_reg[2]  ( .D(n972), .CK(clk), .RN(
        n1770), .Q(\match_controller/N246 ), .QN(n1661) );
  DFFRX2 \match_controller/match_pattern_count_reg[1]  ( .D(n1011), .CK(clk), 
        .RN(n1770), .Q(\match_controller/N248 ), .QN(n1620) );
  DFFRX2 \match_controller/match_pattern_count_reg[2]  ( .D(n1004), .CK(clk), 
        .RN(n1770), .Q(\match_controller/N249 ), .QN(n1618) );
  DFFRX2 \read_chardata/temp_read_pattern_count_reg[0]  ( .D(n1343), .CK(clk), 
        .RN(n1770), .Q(\read_chardata/temp_read_pattern_count [0]), .QN(n1822)
         );
  NOR3X1 U1202 ( .A(n992), .B(n1565), .C(n1564), .Y(n810) );
  OA22X1 U1203 ( .A0(n1619), .A1(n1609), .B0(\match_controller/N247 ), .B1(
        n1608), .Y(n1345) );
  OA22X1 U1204 ( .A0(n1617), .A1(n1619), .B0(\match_controller/N247 ), .B1(
        n1616), .Y(n1346) );
  AND3X4 U1205 ( .A(n285), .B(n181), .C(n264), .Y(n1347) );
  NOR3X2 U1206 ( .A(n1620), .B(n1619), .C(\match_controller/N249 ), .Y(n324)
         );
  NOR2XL U1207 ( .A(n1620), .B(\match_controller/N249 ), .Y(n1612) );
  NOR2XL U1208 ( .A(n1618), .B(n1620), .Y(n1614) );
  INVX4 U1209 ( .A(reset), .Y(n1770) );
  INVX12 U1210 ( .A(n129), .Y(valid) );
  OAI22X1 U1211 ( .A0(n1619), .A1(n1593), .B0(\match_controller/N247 ), .B1(
        n1592), .Y(\match_controller/N904 ) );
  BUFX12 U1212 ( .A(n2022), .Y(match_index[1]) );
  BUFX12 U1213 ( .A(n2021), .Y(match_index[2]) );
  BUFX12 U1214 ( .A(n2020), .Y(match_index[3]) );
  BUFX12 U1215 ( .A(n2019), .Y(match_index[4]) );
  BUFX12 U1216 ( .A(n2023), .Y(match_index[0]) );
  OR2X1 U1217 ( .A(n1353), .B(n129), .Y(n2018) );
  INVX12 U1218 ( .A(n2018), .Y(match) );
  OAI21XL U1219 ( .A0(n253), .A1(n1995), .B0(n371), .Y(n267) );
  OAI22XL U1220 ( .A0(n1829), .A1(n230), .B0(n275), .B1(n2000), .Y(n167) );
  NOR2X1 U1221 ( .A(n385), .B(n290), .Y(n263) );
  AOI221XL U1222 ( .A0(n1995), .A1(n265), .B0(n261), .B1(n275), .C0(n257), .Y(
        n286) );
  NAND2BX1 U1223 ( .AN(n259), .B(n279), .Y(n377) );
  CLKINVX1 U1224 ( .A(n250), .Y(n1827) );
  OAI222XL U1225 ( .A0(n539), .A1(n1960), .B0(n541), .B1(n1964), .C0(n543), 
        .C1(n1956), .Y(n529) );
  OAI22XL U1226 ( .A0(n536), .A1(n1976), .B0(n371), .B1(n1984), .Y(n530) );
  OAI22XL U1227 ( .A0(n532), .A1(n1968), .B0(n534), .B1(n1972), .Y(n531) );
  OAI22XL U1228 ( .A0(n593), .A1(n1896), .B0(n595), .B1(n1900), .Y(n587) );
  OAI22XL U1229 ( .A0(n597), .A1(n1904), .B0(n599), .B1(n1908), .Y(n586) );
  OAI22XL U1230 ( .A0(n589), .A1(n1952), .B0(n591), .B1(n1892), .Y(n588) );
  OAI22XL U1231 ( .A0(n601), .A1(n1912), .B0(n603), .B1(n1916), .Y(n585) );
  CLKINVX1 U1232 ( .A(n221), .Y(n1821) );
  CLKINVX1 U1233 ( .A(n810), .Y(n2012) );
  NAND3X1 U1234 ( .A(n1348), .B(n1353), .C(n369), .Y(n249) );
  CLKINVX1 U1235 ( .A(n1672), .Y(n1812) );
  CLKINVX1 U1236 ( .A(n1668), .Y(n1815) );
  CLKINVX1 U1237 ( .A(n1670), .Y(n1816) );
  CLKBUFX3 U1238 ( .A(n1776), .Y(n1765) );
  CLKBUFX3 U1239 ( .A(n1778), .Y(n1769) );
  CLKBUFX3 U1240 ( .A(n1777), .Y(n1767) );
  CLKBUFX3 U1241 ( .A(n1773), .Y(n1759) );
  OAI21XL U1242 ( .A0(n1841), .A1(n174), .B0(n262), .Y(n277) );
  OAI22XL U1243 ( .A0(n295), .A1(n296), .B0(n297), .B1(n298), .Y(n287) );
  NOR3X2 U1244 ( .A(\match_controller/N249 ), .B(\match_controller/N248 ), .C(
        \match_controller/N247 ), .Y(n150) );
  OAI22XL U1245 ( .A0(n644), .A1(n595), .B0(n645), .B1(n597), .Y(n701) );
  OAI22XL U1246 ( .A0(n648), .A1(n591), .B0(n649), .B1(n593), .Y(n702) );
  OAI22XL U1247 ( .A0(n640), .A1(n599), .B0(n641), .B1(n601), .Y(n700) );
  OAI22XL U1248 ( .A0(n625), .A1(n603), .B0(n626), .B1(n569), .Y(n699) );
  OAI22XL U1249 ( .A0(n517), .A1(n555), .B0(n513), .B1(n589), .Y(n735) );
  OAI22XL U1250 ( .A0(n629), .A1(n563), .B0(n630), .B1(n549), .Y(n737) );
  OAI22XL U1251 ( .A0(n627), .A1(n551), .B0(n628), .B1(n553), .Y(n736) );
  OAI22XL U1252 ( .A0(n631), .A1(n559), .B0(n632), .B1(n561), .Y(n738) );
  NOR3X1 U1253 ( .A(n1824), .B(n1825), .C(\read_chardata/N110 ), .Y(n882) );
  NAND2X1 U1254 ( .A(n960), .B(n145), .Y(n385) );
  NOR3X1 U1255 ( .A(n1564), .B(n992), .C(\match_controller/N250 ), .Y(n809) );
  NOR3X1 U1256 ( .A(n987), .B(n986), .C(n1998), .Y(n291) );
  NOR2X2 U1257 ( .A(\match_controller/N253 ), .B(n1562), .Y(n633) );
  NOR2X2 U1258 ( .A(n1562), .B(n1563), .Y(n607) );
  NOR2X2 U1259 ( .A(\match_controller/N254 ), .B(n1563), .Y(n620) );
  NOR2X2 U1260 ( .A(n959), .B(n977), .Y(n221) );
  NAND3X1 U1261 ( .A(n213), .B(n1352), .C(n986), .Y(n384) );
  NOR2X1 U1262 ( .A(n1352), .B(n986), .Y(n369) );
  NAND3X1 U1263 ( .A(n369), .B(n1353), .C(n985), .Y(n290) );
  NAND4X1 U1264 ( .A(n842), .B(n843), .C(n844), .D(n845), .Y(n279) );
  AND2X2 U1265 ( .A(n131), .B(\read_chardata/temp_read_string_count [3]), .Y(
        n919) );
  NOR3X2 U1266 ( .A(\read_chardata/temp_read_string_count [3]), .B(
        \read_chardata/temp_read_string_count [4]), .C(n1811), .Y(n861) );
  NOR3X2 U1267 ( .A(n1811), .B(\read_chardata/temp_read_string_count [4]), .C(
        n1367), .Y(n885) );
  NOR2BX1 U1268 ( .AN(n966), .B(n1818), .Y(n136) );
  CLKBUFX3 U1269 ( .A(n949), .Y(n1671) );
  NAND3X2 U1270 ( .A(\read_chardata/temp_read_pattern_count [0]), .B(n1823), 
        .C(n940), .Y(n941) );
  CLKBUFX3 U1271 ( .A(n952), .Y(n1669) );
  CLKINVX1 U1272 ( .A(chardata[2]), .Y(n1776) );
  CLKINVX1 U1273 ( .A(chardata[0]), .Y(n1778) );
  CLKINVX1 U1274 ( .A(chardata[5]), .Y(n1773) );
  CLKINVX1 U1275 ( .A(chardata[1]), .Y(n1777) );
  CLKINVX1 U1276 ( .A(chardata[3]), .Y(n1775) );
  OAI22XL U1277 ( .A0(\read_chardata/temp_read_pattern_count [0]), .A1(n1818), 
        .B0(ispattern), .B1(n221), .Y(n954) );
  CLKINVX1 U1278 ( .A(chardata[7]), .Y(n1771) );
  CLKINVX1 U1279 ( .A(chardata[6]), .Y(n1772) );
  CLKINVX1 U1280 ( .A(chardata[4]), .Y(n1774) );
  NAND2X1 U1281 ( .A(n365), .B(n1618), .Y(n342) );
  NOR3X2 U1282 ( .A(\match_controller/N248 ), .B(n1619), .C(
        \match_controller/N249 ), .Y(n318) );
  NOR3X2 U1283 ( .A(n1661), .B(n1662), .C(\match_controller/N244 ), .Y(n409)
         );
  NOR3X2 U1284 ( .A(n1661), .B(n1663), .C(\match_controller/N245 ), .Y(n410)
         );
  NOR3X2 U1285 ( .A(n1662), .B(n1663), .C(n1661), .Y(n408) );
  NOR3X1 U1286 ( .A(n985), .B(n984), .C(n210), .Y(n261) );
  NOR3X1 U1287 ( .A(n1353), .B(n985), .C(n210), .Y(n170) );
  NOR3X1 U1288 ( .A(\read_chardata/temp_read_string_count [1]), .B(
        \read_chardata/temp_read_string_count [2]), .C(\read_chardata/N110 ), 
        .Y(n864) );
  NOR3X1 U1289 ( .A(n1824), .B(\read_chardata/temp_read_string_count [2]), .C(
        \read_chardata/N110 ), .Y(n870) );
  NOR3X1 U1290 ( .A(n1825), .B(\read_chardata/temp_read_string_count [1]), .C(
        \read_chardata/N110 ), .Y(n876) );
  NOR3X1 U1291 ( .A(\read_chardata/temp_read_string_count [0]), .B(
        \read_chardata/temp_read_string_count [1]), .C(n1825), .Y(n873) );
  NOR3X1 U1292 ( .A(n1825), .B(\read_chardata/temp_read_string_count [0]), .C(
        n1824), .Y(n879) );
  NOR3X1 U1293 ( .A(\read_chardata/temp_read_string_count [0]), .B(
        \read_chardata/temp_read_string_count [2]), .C(n1824), .Y(n867) );
  NOR3X1 U1294 ( .A(\read_chardata/temp_read_string_count [1]), .B(
        \read_chardata/temp_read_string_count [2]), .C(
        \read_chardata/temp_read_string_count [0]), .Y(n860) );
  CLKINVX1 U1295 ( .A(n1683), .Y(n1803) );
  CLKINVX1 U1296 ( .A(n124), .Y(n212) );
  AND2X2 U1297 ( .A(n264), .B(n178), .Y(n193) );
  NAND2X1 U1298 ( .A(n2009), .B(n1820), .Y(n182) );
  CLKINVX1 U1299 ( .A(n522), .Y(n2013) );
  CLKINVX1 U1300 ( .A(n207), .Y(n189) );
  CLKINVX1 U1301 ( .A(n267), .Y(n370) );
  CLKINVX1 U1302 ( .A(n371), .Y(n2009) );
  CLKINVX1 U1303 ( .A(n167), .Y(n1828) );
  CLKINVX1 U1304 ( .A(n262), .Y(n1864) );
  CLKBUFX3 U1305 ( .A(n1713), .Y(n1714) );
  CLKBUFX3 U1306 ( .A(n1751), .Y(n1715) );
  CLKBUFX3 U1307 ( .A(n1753), .Y(n1716) );
  CLKBUFX3 U1308 ( .A(n1753), .Y(n1717) );
  CLKBUFX3 U1309 ( .A(n1752), .Y(n1718) );
  CLKBUFX3 U1310 ( .A(n1752), .Y(n1719) );
  CLKBUFX3 U1311 ( .A(n1751), .Y(n1720) );
  CLKBUFX3 U1312 ( .A(n1751), .Y(n1721) );
  CLKBUFX3 U1313 ( .A(n1750), .Y(n1722) );
  CLKBUFX3 U1314 ( .A(n1750), .Y(n1723) );
  CLKBUFX3 U1315 ( .A(n1749), .Y(n1724) );
  CLKBUFX3 U1316 ( .A(n1749), .Y(n1725) );
  CLKBUFX3 U1317 ( .A(n1748), .Y(n1726) );
  CLKBUFX3 U1318 ( .A(n1748), .Y(n1727) );
  CLKBUFX3 U1319 ( .A(n1711), .Y(n1728) );
  CLKBUFX3 U1320 ( .A(n1750), .Y(n1729) );
  CLKBUFX3 U1321 ( .A(n1711), .Y(n1730) );
  CLKBUFX3 U1322 ( .A(n1749), .Y(n1731) );
  CLKBUFX3 U1323 ( .A(n1747), .Y(n1732) );
  CLKBUFX3 U1324 ( .A(n1747), .Y(n1733) );
  CLKBUFX3 U1325 ( .A(n1746), .Y(n1734) );
  CLKBUFX3 U1326 ( .A(n1746), .Y(n1735) );
  CLKBUFX3 U1327 ( .A(n1710), .Y(n1736) );
  CLKBUFX3 U1328 ( .A(n1752), .Y(n1737) );
  CLKBUFX3 U1329 ( .A(n1745), .Y(n1738) );
  CLKBUFX3 U1330 ( .A(n1745), .Y(n1739) );
  CLKBUFX3 U1331 ( .A(n1744), .Y(n1740) );
  CLKBUFX3 U1332 ( .A(n1744), .Y(n1741) );
  CLKBUFX3 U1333 ( .A(n1709), .Y(n1742) );
  CLKBUFX3 U1334 ( .A(n1753), .Y(n1743) );
  CLKINVX1 U1335 ( .A(n1674), .Y(n1814) );
  CLKINVX1 U1336 ( .A(n1706), .Y(n1786) );
  CLKINVX1 U1337 ( .A(n1673), .Y(n1817) );
  CLKINVX1 U1338 ( .A(n1705), .Y(n1785) );
  CLKINVX1 U1339 ( .A(n1704), .Y(n1784) );
  CLKINVX1 U1340 ( .A(n1703), .Y(n1783) );
  CLKINVX1 U1341 ( .A(n1702), .Y(n1782) );
  CLKINVX1 U1342 ( .A(n1701), .Y(n1781) );
  CLKINVX1 U1343 ( .A(n1700), .Y(n1780) );
  CLKINVX1 U1344 ( .A(n1699), .Y(n1779) );
  CLKINVX1 U1345 ( .A(n1698), .Y(n1794) );
  CLKINVX1 U1346 ( .A(n1697), .Y(n1793) );
  CLKINVX1 U1347 ( .A(n1696), .Y(n1792) );
  CLKINVX1 U1348 ( .A(n1695), .Y(n1791) );
  CLKINVX1 U1349 ( .A(n1694), .Y(n1790) );
  CLKINVX1 U1350 ( .A(n1693), .Y(n1789) );
  CLKINVX1 U1351 ( .A(n1692), .Y(n1788) );
  CLKINVX1 U1352 ( .A(n1691), .Y(n1787) );
  CLKBUFX3 U1353 ( .A(n915), .Y(n1683) );
  NAND2X1 U1354 ( .A(n902), .B(n882), .Y(n915) );
  CLKINVX1 U1355 ( .A(n1690), .Y(n1810) );
  CLKINVX1 U1356 ( .A(n1682), .Y(n1802) );
  CLKINVX1 U1357 ( .A(n1689), .Y(n1809) );
  CLKINVX1 U1358 ( .A(n1688), .Y(n1808) );
  CLKINVX1 U1359 ( .A(n1687), .Y(n1807) );
  CLKINVX1 U1360 ( .A(n1686), .Y(n1806) );
  CLKINVX1 U1361 ( .A(n1685), .Y(n1805) );
  CLKINVX1 U1362 ( .A(n1684), .Y(n1804) );
  CLKINVX1 U1363 ( .A(n1681), .Y(n1801) );
  CLKINVX1 U1364 ( .A(n1680), .Y(n1800) );
  CLKINVX1 U1365 ( .A(n1679), .Y(n1799) );
  CLKINVX1 U1366 ( .A(n1678), .Y(n1798) );
  CLKINVX1 U1367 ( .A(n1677), .Y(n1797) );
  CLKINVX1 U1368 ( .A(n1676), .Y(n1796) );
  CLKINVX1 U1369 ( .A(n1675), .Y(n1795) );
  INVX3 U1370 ( .A(n199), .Y(n120) );
  NOR2X1 U1371 ( .A(n1995), .B(n120), .Y(n207) );
  NAND2X1 U1372 ( .A(n462), .B(n463), .Y(n124) );
  NOR4X1 U1373 ( .A(n464), .B(n465), .C(n466), .D(n467), .Y(n463) );
  NOR4X1 U1374 ( .A(n481), .B(n482), .C(n483), .D(n484), .Y(n462) );
  XOR2X1 U1375 ( .A(n478), .B(n479), .Y(n464) );
  CLKINVX1 U1376 ( .A(n265), .Y(n178) );
  CLKBUFX3 U1377 ( .A(n470), .Y(n1708) );
  XOR2X1 U1378 ( .A(n488), .B(n489), .Y(n483) );
  OAI22XL U1379 ( .A0(n470), .A1(n1833), .B0(n1347), .B1(n1858), .Y(n488) );
  OAI22XL U1380 ( .A0(n470), .A1(n1858), .B0(n1347), .B1(n1833), .Y(n489) );
  CLKINVX1 U1381 ( .A(n121), .Y(n206) );
  XOR2X1 U1382 ( .A(n475), .B(n476), .Y(n465) );
  OAI22XL U1383 ( .A0(n1708), .A1(n1834), .B0(n1347), .B1(n1859), .Y(n475) );
  OAI22XL U1384 ( .A0(n1708), .A1(n1859), .B0(n1347), .B1(n1834), .Y(n476) );
  CLKINVX1 U1385 ( .A(\match_controller/N910 ), .Y(n1859) );
  XOR2X1 U1386 ( .A(n491), .B(n492), .Y(n482) );
  OAI22XL U1387 ( .A0(n470), .A1(n1826), .B0(n1347), .B1(n1851), .Y(n491) );
  OAI22XL U1388 ( .A0(n470), .A1(n1851), .B0(n1347), .B1(n1826), .Y(n492) );
  CLKINVX1 U1389 ( .A(\match_controller/N914 ), .Y(n1851) );
  OAI22XL U1390 ( .A0(n1708), .A1(n1860), .B0(n1347), .B1(n1835), .Y(n479) );
  XOR2X1 U1391 ( .A(n494), .B(n495), .Y(n481) );
  OAI22XL U1392 ( .A0(n470), .A1(n1831), .B0(n1347), .B1(n1854), .Y(n494) );
  OAI22XL U1393 ( .A0(n1708), .A1(n1854), .B0(n1347), .B1(n1831), .Y(n495) );
  CLKINVX1 U1394 ( .A(n284), .Y(n194) );
  OAI211X1 U1395 ( .A0(n276), .A1(n230), .B0(n285), .C0(n286), .Y(n284) );
  OAI22XL U1396 ( .A0(n1708), .A1(n1835), .B0(n1347), .B1(n1860), .Y(n478) );
  OR2X1 U1397 ( .A(n120), .B(n377), .Y(n181) );
  OAI21XL U1398 ( .A0(n1840), .A1(n1996), .B0(n204), .Y(n197) );
  OAI21XL U1399 ( .A0(n1999), .A1(n1820), .B0(n206), .Y(n204) );
  NOR3X1 U1400 ( .A(n1827), .B(n212), .C(n249), .Y(n257) );
  OAI21XL U1401 ( .A0(n1997), .A1(n189), .B0(n190), .Y(n187) );
  AOI32X1 U1402 ( .A0(n1852), .A1(n219), .A2(n1999), .B0(n207), .B1(n121), .Y(
        n166) );
  CLKINVX1 U1403 ( .A(n220), .Y(n1852) );
  CLKINVX1 U1404 ( .A(n201), .Y(n1820) );
  NAND3X1 U1405 ( .A(n1995), .B(n371), .C(n263), .Y(n264) );
  NAND2X1 U1406 ( .A(n1999), .B(n220), .Y(n259) );
  NOR2X1 U1407 ( .A(n2014), .B(n2016), .Y(n522) );
  NAND2X2 U1408 ( .A(n1707), .B(n642), .Y(n371) );
  CLKINVX1 U1409 ( .A(n642), .Y(n2008) );
  NOR2X1 U1410 ( .A(n179), .B(n199), .Y(n253) );
  CLKINVX1 U1411 ( .A(n213), .Y(n1998) );
  CLKINVX1 U1412 ( .A(\match_controller/N912 ), .Y(n1856) );
  CLKINVX1 U1413 ( .A(\match_controller/N911 ), .Y(n1858) );
  CLKINVX1 U1414 ( .A(n276), .Y(n1829) );
  CLKINVX1 U1415 ( .A(n260), .Y(n1841) );
  CLKINVX1 U1416 ( .A(\match_controller/N907 ), .Y(n1863) );
  CLKINVX1 U1417 ( .A(\match_controller/N913 ), .Y(n1854) );
  CLKINVX1 U1418 ( .A(\match_controller/N909 ), .Y(n1860) );
  CLKINVX1 U1419 ( .A(n277), .Y(n1840) );
  NOR2X1 U1420 ( .A(n1992), .B(n1830), .Y(n276) );
  CLKINVX1 U1421 ( .A(n287), .Y(n1830) );
  CLKINVX1 U1422 ( .A(n263), .Y(n1819) );
  NAND4X1 U1423 ( .A(\match_controller/N909 ), .B(n1863), .C(n387), .D(n388), 
        .Y(n179) );
  NOR2X1 U1424 ( .A(\match_controller/N910 ), .B(\match_controller/N908 ), .Y(
        n387) );
  NOR4X1 U1425 ( .A(\match_controller/N914 ), .B(\match_controller/N913 ), .C(
        \match_controller/N912 ), .D(\match_controller/N911 ), .Y(n388) );
  NAND2X1 U1426 ( .A(n371), .B(n657), .Y(n262) );
  NAND4X1 U1427 ( .A(n658), .B(n659), .C(n660), .D(n661), .Y(n657) );
  NOR4X1 U1428 ( .A(n735), .B(n736), .C(n737), .D(n738), .Y(n659) );
  NOR4X1 U1429 ( .A(n699), .B(n700), .C(n701), .D(n702), .Y(n660) );
  CLKINVX1 U1430 ( .A(n150), .Y(n2001) );
  CLKINVX1 U1431 ( .A(n320), .Y(n2002) );
  OAI2BB1X1 U1432 ( .A0N(n249), .A1N(n244), .B0(n1827), .Y(n278) );
  CLKBUFX3 U1433 ( .A(n1713), .Y(n1753) );
  CLKBUFX3 U1434 ( .A(n1713), .Y(n1752) );
  CLKBUFX3 U1435 ( .A(n1712), .Y(n1751) );
  CLKBUFX3 U1436 ( .A(n1712), .Y(n1750) );
  CLKBUFX3 U1437 ( .A(n1712), .Y(n1749) );
  CLKBUFX3 U1438 ( .A(n1711), .Y(n1748) );
  CLKBUFX3 U1439 ( .A(n1710), .Y(n1747) );
  CLKBUFX3 U1440 ( .A(n1710), .Y(n1746) );
  CLKBUFX3 U1441 ( .A(n1709), .Y(n1745) );
  CLKBUFX3 U1442 ( .A(n1709), .Y(n1744) );
  INVX3 U1443 ( .A(n941), .Y(n1813) );
  OAI22XL U1444 ( .A0(n1755), .A1(n941), .B0(n1813), .B1(n1845), .Y(n1281) );
  OAI22XL U1445 ( .A0(n1757), .A1(n941), .B0(n1813), .B1(n1844), .Y(n1282) );
  OAI22XL U1446 ( .A0(n1761), .A1(n941), .B0(n1813), .B1(n1843), .Y(n1284) );
  OAI22XL U1447 ( .A0(n1762), .A1(n941), .B0(n1813), .B1(n1349), .Y(n1285) );
  OAI22XL U1448 ( .A0(n1764), .A1(n941), .B0(n1813), .B1(n1362), .Y(n1286) );
  OAI22XL U1449 ( .A0(n1768), .A1(n941), .B0(n1813), .B1(n1842), .Y(n1288) );
  OAI22XL U1450 ( .A0(n1815), .A1(n1839), .B0(n1758), .B1(n1668), .Y(n1299) );
  OAI22XL U1451 ( .A0(n1815), .A1(n1838), .B0(n1763), .B1(n1668), .Y(n1301) );
  OAI22XL U1452 ( .A0(n1815), .A1(n1837), .B0(n1764), .B1(n1668), .Y(n1302) );
  OAI22XL U1453 ( .A0(n1815), .A1(n1836), .B0(n1766), .B1(n1668), .Y(n1303) );
  OAI22XL U1454 ( .A0(n1816), .A1(n1354), .B0(n1768), .B1(n1670), .Y(n1328) );
  OAI22XL U1455 ( .A0(n1816), .A1(n1358), .B0(n1755), .B1(n1670), .Y(n1321) );
  OAI22XL U1456 ( .A0(n1816), .A1(n1356), .B0(n1757), .B1(n1670), .Y(n1322) );
  OAI22XL U1457 ( .A0(n1816), .A1(n1355), .B0(n1761), .B1(n1670), .Y(n1324) );
  OAI22XL U1458 ( .A0(n1755), .A1(n1674), .B0(n1814), .B1(n1850), .Y(n1273) );
  OAI22XL U1459 ( .A0(n1757), .A1(n1674), .B0(n1814), .B1(n1849), .Y(n1274) );
  OAI22XL U1460 ( .A0(n1761), .A1(n1674), .B0(n1814), .B1(n1848), .Y(n1276) );
  OAI22XL U1461 ( .A0(n1762), .A1(n1674), .B0(n1814), .B1(n1370), .Y(n1277) );
  OAI22XL U1462 ( .A0(n1764), .A1(n1674), .B0(n1814), .B1(n1369), .Y(n1278) );
  OAI22XL U1463 ( .A0(n1766), .A1(n1674), .B0(n1814), .B1(n1350), .Y(n1279) );
  OAI22XL U1464 ( .A0(n1768), .A1(n1674), .B0(n1814), .B1(n1846), .Y(n1280) );
  CLKBUFX3 U1465 ( .A(n938), .Y(n1674) );
  NAND3X1 U1466 ( .A(n1822), .B(n1823), .C(n940), .Y(n938) );
  OAI22XL U1467 ( .A0(n1817), .A1(n1366), .B0(n1758), .B1(n1673), .Y(n1291) );
  OAI22XL U1468 ( .A0(n1817), .A1(n1365), .B0(n1764), .B1(n1673), .Y(n1294) );
  OAI22XL U1469 ( .A0(n1817), .A1(n1363), .B0(n1766), .B1(n1673), .Y(n1295) );
  OAI22XL U1470 ( .A0(n1817), .A1(n1364), .B0(n1763), .B1(n1673), .Y(n1293) );
  CLKBUFX3 U1471 ( .A(n943), .Y(n1673) );
  NAND3X1 U1472 ( .A(n1822), .B(n1823), .C(n136), .Y(n943) );
  OAI22XL U1473 ( .A0(n1785), .A1(n1981), .B0(n1768), .B1(n1705), .Y(n1032) );
  OAI22XL U1474 ( .A0(n1785), .A1(n1983), .B0(n1764), .B1(n1705), .Y(n1030) );
  OAI22XL U1475 ( .A0(n1785), .A1(n1982), .B0(n1766), .B1(n1705), .Y(n1031) );
  OAI22XL U1476 ( .A0(n1783), .A1(n1975), .B0(n1765), .B1(n1703), .Y(n1046) );
  OAI22XL U1477 ( .A0(n1783), .A1(n1973), .B0(n1769), .B1(n1703), .Y(n1048) );
  OAI22XL U1478 ( .A0(n1782), .A1(n1971), .B0(n1765), .B1(n1702), .Y(n1054) );
  OAI22XL U1479 ( .A0(n1782), .A1(n1969), .B0(n1769), .B1(n1702), .Y(n1056) );
  OAI22XL U1480 ( .A0(n1781), .A1(n1967), .B0(n1765), .B1(n1701), .Y(n1062) );
  OAI22XL U1481 ( .A0(n1781), .A1(n1965), .B0(n1769), .B1(n1701), .Y(n1064) );
  OAI22XL U1482 ( .A0(n1780), .A1(n1963), .B0(n1765), .B1(n1700), .Y(n1070) );
  OAI22XL U1483 ( .A0(n1780), .A1(n1961), .B0(n1769), .B1(n1700), .Y(n1072) );
  OAI22XL U1484 ( .A0(n1779), .A1(n1959), .B0(n1765), .B1(n1699), .Y(n1078) );
  OAI22XL U1485 ( .A0(n1779), .A1(n1957), .B0(n1769), .B1(n1699), .Y(n1080) );
  OAI22XL U1486 ( .A0(n1785), .A1(n1984), .B0(n1758), .B1(n1705), .Y(n1027) );
  OAI22XL U1487 ( .A0(n1784), .A1(n1980), .B0(n1759), .B1(n1704), .Y(n1035) );
  OAI22XL U1488 ( .A0(n1784), .A1(n1978), .B0(n1767), .B1(n1704), .Y(n1039) );
  OAI22XL U1489 ( .A0(n1783), .A1(n1976), .B0(n1758), .B1(n1703), .Y(n1043) );
  OAI22XL U1490 ( .A0(n1783), .A1(n1974), .B0(n1767), .B1(n1703), .Y(n1047) );
  OAI22XL U1491 ( .A0(n1782), .A1(n1972), .B0(n1759), .B1(n1702), .Y(n1051) );
  OAI22XL U1492 ( .A0(n1782), .A1(n1970), .B0(n1767), .B1(n1702), .Y(n1055) );
  OAI22XL U1493 ( .A0(n1781), .A1(n1968), .B0(n1773), .B1(n1701), .Y(n1059) );
  OAI22XL U1494 ( .A0(n1781), .A1(n1966), .B0(n1767), .B1(n1701), .Y(n1063) );
  OAI22XL U1495 ( .A0(n1780), .A1(n1964), .B0(n1773), .B1(n1700), .Y(n1067) );
  OAI22XL U1496 ( .A0(n1780), .A1(n1962), .B0(n1767), .B1(n1700), .Y(n1071) );
  OAI22XL U1497 ( .A0(n1779), .A1(n1960), .B0(n1773), .B1(n1699), .Y(n1075) );
  OAI22XL U1498 ( .A0(n1779), .A1(n1958), .B0(n1767), .B1(n1699), .Y(n1079) );
  OAI22XL U1499 ( .A0(n1784), .A1(n1979), .B0(n1764), .B1(n1704), .Y(n1038) );
  OAI22XL U1500 ( .A0(n1784), .A1(n1977), .B0(n1768), .B1(n1704), .Y(n1040) );
  CLKBUFX3 U1501 ( .A(n862), .Y(n1705) );
  NAND2X1 U1502 ( .A(n864), .B(n861), .Y(n862) );
  CLKBUFX3 U1503 ( .A(n865), .Y(n1704) );
  NAND2X1 U1504 ( .A(n867), .B(n861), .Y(n865) );
  CLKBUFX3 U1505 ( .A(n868), .Y(n1703) );
  NAND2X1 U1506 ( .A(n870), .B(n861), .Y(n868) );
  CLKBUFX3 U1507 ( .A(n871), .Y(n1702) );
  NAND2X1 U1508 ( .A(n873), .B(n861), .Y(n871) );
  CLKBUFX3 U1509 ( .A(n874), .Y(n1701) );
  NAND2X1 U1510 ( .A(n876), .B(n861), .Y(n874) );
  CLKBUFX3 U1511 ( .A(n877), .Y(n1700) );
  NAND2X1 U1512 ( .A(n879), .B(n861), .Y(n877) );
  CLKBUFX3 U1513 ( .A(n880), .Y(n1699) );
  NAND2X1 U1514 ( .A(n882), .B(n861), .Y(n880) );
  OAI22XL U1515 ( .A0(n1786), .A1(n1987), .B0(n1706), .B1(n1759), .Y(n1019) );
  OAI22XL U1516 ( .A0(n1786), .A1(n1989), .B0(n1706), .B1(n1755), .Y(n1017) );
  OAI22XL U1517 ( .A0(n1786), .A1(n1988), .B0(n1706), .B1(n1757), .Y(n1018) );
  OAI22XL U1518 ( .A0(n1786), .A1(n1986), .B0(n1706), .B1(n1761), .Y(n1020) );
  OAI22XL U1519 ( .A0(n1786), .A1(n1985), .B0(n1706), .B1(n1763), .Y(n1021) );
  CLKBUFX3 U1520 ( .A(n851), .Y(n1706) );
  NAND2X1 U1521 ( .A(n860), .B(n861), .Y(n851) );
  OAI22XL U1522 ( .A0(n1794), .A1(n1955), .B0(n1765), .B1(n1698), .Y(n1086) );
  OAI22XL U1523 ( .A0(n1794), .A1(n1953), .B0(n1769), .B1(n1698), .Y(n1088) );
  OAI22XL U1524 ( .A0(n1793), .A1(n1951), .B0(n1765), .B1(n1697), .Y(n1094) );
  OAI22XL U1525 ( .A0(n1793), .A1(n1949), .B0(n1769), .B1(n1697), .Y(n1096) );
  OAI22XL U1526 ( .A0(n1792), .A1(n1947), .B0(n1765), .B1(n1696), .Y(n1102) );
  OAI22XL U1527 ( .A0(n1792), .A1(n1945), .B0(n1769), .B1(n1696), .Y(n1104) );
  OAI22XL U1528 ( .A0(n1791), .A1(n1943), .B0(n1765), .B1(n1695), .Y(n1110) );
  OAI22XL U1529 ( .A0(n1791), .A1(n1941), .B0(n1769), .B1(n1695), .Y(n1112) );
  OAI22XL U1530 ( .A0(n1790), .A1(n1939), .B0(n1765), .B1(n1694), .Y(n1118) );
  OAI22XL U1531 ( .A0(n1790), .A1(n1937), .B0(n1769), .B1(n1694), .Y(n1120) );
  OAI22XL U1532 ( .A0(n1789), .A1(n1935), .B0(n1765), .B1(n1693), .Y(n1126) );
  OAI22XL U1533 ( .A0(n1789), .A1(n1933), .B0(n1769), .B1(n1693), .Y(n1128) );
  OAI22XL U1534 ( .A0(n1788), .A1(n1931), .B0(n1765), .B1(n1692), .Y(n1134) );
  OAI22XL U1535 ( .A0(n1788), .A1(n1929), .B0(n1769), .B1(n1692), .Y(n1136) );
  OAI22XL U1536 ( .A0(n1787), .A1(n1927), .B0(n1765), .B1(n1691), .Y(n1142) );
  OAI22XL U1537 ( .A0(n1787), .A1(n1925), .B0(n1769), .B1(n1691), .Y(n1144) );
  OAI22XL U1538 ( .A0(n1794), .A1(n1956), .B0(n1773), .B1(n1698), .Y(n1083) );
  OAI22XL U1539 ( .A0(n1794), .A1(n1954), .B0(n1767), .B1(n1698), .Y(n1087) );
  OAI22XL U1540 ( .A0(n1793), .A1(n1952), .B0(n1773), .B1(n1697), .Y(n1091) );
  OAI22XL U1541 ( .A0(n1793), .A1(n1950), .B0(n1767), .B1(n1697), .Y(n1095) );
  OAI22XL U1542 ( .A0(n1792), .A1(n1948), .B0(n1758), .B1(n1696), .Y(n1099) );
  OAI22XL U1543 ( .A0(n1792), .A1(n1946), .B0(n1767), .B1(n1696), .Y(n1103) );
  OAI22XL U1544 ( .A0(n1791), .A1(n1944), .B0(n1759), .B1(n1695), .Y(n1107) );
  OAI22XL U1545 ( .A0(n1791), .A1(n1942), .B0(n1767), .B1(n1695), .Y(n1111) );
  OAI22XL U1546 ( .A0(n1790), .A1(n1940), .B0(n1758), .B1(n1694), .Y(n1115) );
  OAI22XL U1547 ( .A0(n1790), .A1(n1938), .B0(n1767), .B1(n1694), .Y(n1119) );
  OAI22XL U1548 ( .A0(n1789), .A1(n1936), .B0(n1759), .B1(n1693), .Y(n1123) );
  OAI22XL U1549 ( .A0(n1789), .A1(n1934), .B0(n1767), .B1(n1693), .Y(n1127) );
  OAI22XL U1550 ( .A0(n1788), .A1(n1932), .B0(n1759), .B1(n1692), .Y(n1131) );
  OAI22XL U1551 ( .A0(n1788), .A1(n1930), .B0(n1767), .B1(n1692), .Y(n1135) );
  OAI22XL U1552 ( .A0(n1787), .A1(n1928), .B0(n1759), .B1(n1691), .Y(n1139) );
  OAI22XL U1553 ( .A0(n1787), .A1(n1926), .B0(n1766), .B1(n1691), .Y(n1143) );
  CLKBUFX3 U1554 ( .A(n883), .Y(n1698) );
  NAND2X1 U1555 ( .A(n885), .B(n860), .Y(n883) );
  CLKBUFX3 U1556 ( .A(n886), .Y(n1697) );
  NAND2X1 U1557 ( .A(n885), .B(n864), .Y(n886) );
  CLKBUFX3 U1558 ( .A(n888), .Y(n1696) );
  NAND2X1 U1559 ( .A(n885), .B(n867), .Y(n888) );
  CLKBUFX3 U1560 ( .A(n890), .Y(n1695) );
  NAND2X1 U1561 ( .A(n885), .B(n870), .Y(n890) );
  CLKBUFX3 U1562 ( .A(n892), .Y(n1694) );
  NAND2X1 U1563 ( .A(n885), .B(n873), .Y(n892) );
  CLKBUFX3 U1564 ( .A(n894), .Y(n1693) );
  NAND2X1 U1565 ( .A(n885), .B(n876), .Y(n894) );
  CLKBUFX3 U1566 ( .A(n896), .Y(n1692) );
  NAND2X1 U1567 ( .A(n885), .B(n879), .Y(n896) );
  CLKBUFX3 U1568 ( .A(n898), .Y(n1691) );
  NAND2X1 U1569 ( .A(n885), .B(n882), .Y(n898) );
  OAI22XL U1570 ( .A0(n1758), .A1(n1672), .B0(n1812), .B1(n1361), .Y(n1307) );
  OAI22XL U1571 ( .A0(n1762), .A1(n1672), .B0(n1812), .B1(n1357), .Y(n1309) );
  OAI22XL U1572 ( .A0(n1764), .A1(n1672), .B0(n1812), .B1(n1359), .Y(n1310) );
  OAI22XL U1573 ( .A0(n1766), .A1(n1672), .B0(n1812), .B1(n1360), .Y(n1311) );
  AND2X2 U1574 ( .A(n131), .B(n1367), .Y(n902) );
  OAI22XL U1575 ( .A0(n1797), .A1(n1869), .B0(n1768), .B1(n1677), .Y(n1256) );
  OAI22XL U1576 ( .A0(n1796), .A1(n1865), .B0(n1768), .B1(n1676), .Y(n1264) );
  OAI22XL U1577 ( .A0(n1795), .A1(n1853), .B0(n1768), .B1(n1675), .Y(n1272) );
  OAI22XL U1578 ( .A0(n1801), .A1(n1888), .B0(n1758), .B1(n1681), .Y(n1219) );
  OAI22XL U1579 ( .A0(n1800), .A1(n1884), .B0(n1758), .B1(n1680), .Y(n1227) );
  OAI22XL U1580 ( .A0(n1799), .A1(n1880), .B0(n1758), .B1(n1679), .Y(n1235) );
  OAI22XL U1581 ( .A0(n1798), .A1(n1876), .B0(n1758), .B1(n1678), .Y(n1243) );
  OAI22XL U1582 ( .A0(n1798), .A1(n1875), .B0(n1764), .B1(n1678), .Y(n1246) );
  OAI22XL U1583 ( .A0(n1797), .A1(n1872), .B0(n1758), .B1(n1677), .Y(n1251) );
  OAI22XL U1584 ( .A0(n1796), .A1(n1867), .B0(n1764), .B1(n1676), .Y(n1262) );
  OAI22XL U1585 ( .A0(n1795), .A1(n1861), .B0(n1758), .B1(n1675), .Y(n1267) );
  OAI22XL U1586 ( .A0(n1795), .A1(n1857), .B0(n1764), .B1(n1675), .Y(n1270) );
  OAI22XL U1587 ( .A0(n1810), .A1(n1923), .B0(n1765), .B1(n1690), .Y(n1150) );
  OAI22XL U1588 ( .A0(n1810), .A1(n1921), .B0(n1769), .B1(n1690), .Y(n1152) );
  OAI22XL U1589 ( .A0(n1809), .A1(n1919), .B0(n1765), .B1(n1689), .Y(n1158) );
  OAI22XL U1590 ( .A0(n1809), .A1(n1917), .B0(n1769), .B1(n1689), .Y(n1160) );
  OAI22XL U1591 ( .A0(n1808), .A1(n1915), .B0(n1764), .B1(n1688), .Y(n1166) );
  OAI22XL U1592 ( .A0(n1808), .A1(n1913), .B0(n1768), .B1(n1688), .Y(n1168) );
  OAI22XL U1593 ( .A0(n1807), .A1(n1911), .B0(n1765), .B1(n1687), .Y(n1174) );
  OAI22XL U1594 ( .A0(n1807), .A1(n1909), .B0(n1769), .B1(n1687), .Y(n1176) );
  OAI22XL U1595 ( .A0(n1806), .A1(n1907), .B0(n1764), .B1(n1686), .Y(n1182) );
  OAI22XL U1596 ( .A0(n1806), .A1(n1905), .B0(n1768), .B1(n1686), .Y(n1184) );
  OAI22XL U1597 ( .A0(n1805), .A1(n1903), .B0(n1776), .B1(n1685), .Y(n1190) );
  OAI22XL U1598 ( .A0(n1805), .A1(n1901), .B0(n1778), .B1(n1685), .Y(n1192) );
  OAI22XL U1599 ( .A0(n1804), .A1(n1899), .B0(n1776), .B1(n1684), .Y(n1198) );
  OAI22XL U1600 ( .A0(n1804), .A1(n1897), .B0(n1778), .B1(n1684), .Y(n1200) );
  OAI22XL U1601 ( .A0(n1803), .A1(n1895), .B0(n1776), .B1(n1683), .Y(n1206) );
  OAI22XL U1602 ( .A0(n1803), .A1(n1893), .B0(n1778), .B1(n1683), .Y(n1208) );
  OAI22XL U1603 ( .A0(n1802), .A1(n1891), .B0(n1776), .B1(n1682), .Y(n1214) );
  OAI22XL U1604 ( .A0(n1802), .A1(n1889), .B0(n1778), .B1(n1682), .Y(n1216) );
  OAI22XL U1605 ( .A0(n1801), .A1(n1887), .B0(n1776), .B1(n1681), .Y(n1222) );
  OAI22XL U1606 ( .A0(n1801), .A1(n1885), .B0(n1778), .B1(n1681), .Y(n1224) );
  OAI22XL U1607 ( .A0(n1800), .A1(n1883), .B0(n1765), .B1(n1680), .Y(n1230) );
  OAI22XL U1608 ( .A0(n1800), .A1(n1881), .B0(n1769), .B1(n1680), .Y(n1232) );
  OAI22XL U1609 ( .A0(n1799), .A1(n1879), .B0(n1764), .B1(n1679), .Y(n1238) );
  OAI22XL U1610 ( .A0(n1799), .A1(n1878), .B0(n1766), .B1(n1679), .Y(n1239) );
  OAI22XL U1611 ( .A0(n1799), .A1(n1877), .B0(n1768), .B1(n1679), .Y(n1240) );
  OAI22XL U1612 ( .A0(n1798), .A1(n1874), .B0(n1766), .B1(n1678), .Y(n1247) );
  OAI22XL U1613 ( .A0(n1798), .A1(n1873), .B0(n1769), .B1(n1678), .Y(n1248) );
  OAI22XL U1614 ( .A0(n1797), .A1(n1871), .B0(n1765), .B1(n1677), .Y(n1254) );
  OAI22XL U1615 ( .A0(n1797), .A1(n1870), .B0(n1766), .B1(n1677), .Y(n1255) );
  OAI22XL U1616 ( .A0(n1795), .A1(n1855), .B0(n1766), .B1(n1675), .Y(n1271) );
  OAI22XL U1617 ( .A0(n1810), .A1(n1924), .B0(n1759), .B1(n1690), .Y(n1147) );
  OAI22XL U1618 ( .A0(n1810), .A1(n1922), .B0(n1767), .B1(n1690), .Y(n1151) );
  OAI22XL U1619 ( .A0(n1809), .A1(n1920), .B0(n1759), .B1(n1689), .Y(n1155) );
  OAI22XL U1620 ( .A0(n1809), .A1(n1918), .B0(n1766), .B1(n1689), .Y(n1159) );
  OAI22XL U1621 ( .A0(n1808), .A1(n1916), .B0(n1759), .B1(n1688), .Y(n1163) );
  OAI22XL U1622 ( .A0(n1808), .A1(n1914), .B0(n1767), .B1(n1688), .Y(n1167) );
  OAI22XL U1623 ( .A0(n1807), .A1(n1912), .B0(n1759), .B1(n1687), .Y(n1171) );
  OAI22XL U1624 ( .A0(n1807), .A1(n1910), .B0(n1777), .B1(n1687), .Y(n1175) );
  OAI22XL U1625 ( .A0(n1806), .A1(n1908), .B0(n1759), .B1(n1686), .Y(n1179) );
  OAI22XL U1626 ( .A0(n1806), .A1(n1906), .B0(n1777), .B1(n1686), .Y(n1183) );
  OAI22XL U1627 ( .A0(n1805), .A1(n1904), .B0(n1759), .B1(n1685), .Y(n1187) );
  OAI22XL U1628 ( .A0(n1805), .A1(n1902), .B0(n1777), .B1(n1685), .Y(n1191) );
  OAI22XL U1629 ( .A0(n1804), .A1(n1900), .B0(n1759), .B1(n1684), .Y(n1195) );
  OAI22XL U1630 ( .A0(n1804), .A1(n1898), .B0(n1777), .B1(n1684), .Y(n1199) );
  OAI22XL U1631 ( .A0(n1803), .A1(n1896), .B0(n1759), .B1(n1683), .Y(n1203) );
  OAI22XL U1632 ( .A0(n1803), .A1(n1894), .B0(n1777), .B1(n1683), .Y(n1207) );
  OAI22XL U1633 ( .A0(n1802), .A1(n1892), .B0(n1759), .B1(n1682), .Y(n1211) );
  OAI22XL U1634 ( .A0(n1802), .A1(n1890), .B0(n1766), .B1(n1682), .Y(n1215) );
  OAI22XL U1635 ( .A0(n1801), .A1(n1886), .B0(n1767), .B1(n1681), .Y(n1223) );
  OAI22XL U1636 ( .A0(n1800), .A1(n1882), .B0(n1766), .B1(n1680), .Y(n1231) );
  OAI22XL U1637 ( .A0(n1796), .A1(n1868), .B0(n1759), .B1(n1676), .Y(n1259) );
  OAI22XL U1638 ( .A0(n1796), .A1(n1866), .B0(n1767), .B1(n1676), .Y(n1263) );
  NOR2X1 U1639 ( .A(n1368), .B(n1811), .Y(n131) );
  CLKBUFX3 U1640 ( .A(n913), .Y(n1684) );
  NAND2X1 U1641 ( .A(n902), .B(n879), .Y(n913) );
  CLKBUFX3 U1642 ( .A(n900), .Y(n1690) );
  NAND2X1 U1643 ( .A(n902), .B(n860), .Y(n900) );
  CLKBUFX3 U1644 ( .A(n903), .Y(n1689) );
  NAND2X1 U1645 ( .A(n902), .B(n864), .Y(n903) );
  CLKBUFX3 U1646 ( .A(n905), .Y(n1688) );
  NAND2X1 U1647 ( .A(n902), .B(n867), .Y(n905) );
  CLKBUFX3 U1648 ( .A(n907), .Y(n1687) );
  NAND2X1 U1649 ( .A(n902), .B(n870), .Y(n907) );
  CLKBUFX3 U1650 ( .A(n909), .Y(n1686) );
  NAND2X1 U1651 ( .A(n902), .B(n873), .Y(n909) );
  CLKBUFX3 U1652 ( .A(n911), .Y(n1685) );
  NAND2X1 U1653 ( .A(n902), .B(n876), .Y(n911) );
  CLKBUFX3 U1654 ( .A(n917), .Y(n1682) );
  NAND2X1 U1655 ( .A(n919), .B(n860), .Y(n917) );
  CLKBUFX3 U1656 ( .A(n920), .Y(n1681) );
  NAND2X1 U1657 ( .A(n919), .B(n864), .Y(n920) );
  CLKBUFX3 U1658 ( .A(n923), .Y(n1680) );
  NAND2X1 U1659 ( .A(n919), .B(n867), .Y(n923) );
  CLKBUFX3 U1660 ( .A(n926), .Y(n1679) );
  NAND2X1 U1661 ( .A(n919), .B(n870), .Y(n926) );
  CLKBUFX3 U1662 ( .A(n928), .Y(n1678) );
  NAND2X1 U1663 ( .A(n919), .B(n873), .Y(n928) );
  CLKBUFX3 U1664 ( .A(n931), .Y(n1677) );
  NAND2X1 U1665 ( .A(n919), .B(n876), .Y(n931) );
  CLKBUFX3 U1666 ( .A(n933), .Y(n1676) );
  NAND2X1 U1667 ( .A(n919), .B(n879), .Y(n933) );
  CLKBUFX3 U1668 ( .A(n935), .Y(n1675) );
  NAND2X1 U1669 ( .A(n919), .B(n882), .Y(n935) );
  NAND2X1 U1670 ( .A(n146), .B(n147), .Y(n148) );
  NAND3X1 U1671 ( .A(n146), .B(n149), .C(n150), .Y(n147) );
  NOR2BX1 U1672 ( .AN(n146), .B(n154), .Y(n155) );
  OA21X2 U1673 ( .A0(n161), .A1(n162), .B0(n146), .Y(n154) );
  NAND3X1 U1674 ( .A(n181), .B(n182), .C(n183), .Y(n161) );
  OAI211X1 U1675 ( .A0(n1995), .A1(n164), .B0(n1828), .C0(n166), .Y(n162) );
  NAND4X1 U1676 ( .A(n184), .B(n185), .C(n186), .D(n187), .Y(n183) );
  AO22X1 U1677 ( .A0(\match_controller/N288 ), .A1(n154), .B0(n155), .B1(
        \match_controller/N253 ), .Y(n1007) );
  AO22X1 U1678 ( .A0(\match_controller/N287 ), .A1(n154), .B0(n155), .B1(
        \match_controller/N252 ), .Y(n1008) );
  AO22X1 U1679 ( .A0(\match_controller/N286 ), .A1(n154), .B0(n155), .B1(
        \match_controller/N251 ), .Y(n1010) );
  AO21X1 U1680 ( .A0(\match_controller/N245 ), .A1(n1818), .B0(n136), .Y(n973)
         );
  NAND2BX1 U1681 ( .AN(n145), .B(n146), .Y(n142) );
  NAND2X1 U1682 ( .A(n146), .B(n145), .Y(n140) );
  CLKBUFX3 U1683 ( .A(n1778), .Y(n1768) );
  CLKBUFX3 U1684 ( .A(n1776), .Y(n1764) );
  CLKBUFX3 U1685 ( .A(n1775), .Y(n1762) );
  CLKBUFX3 U1686 ( .A(n1771), .Y(n1754) );
  CLKBUFX3 U1687 ( .A(n1772), .Y(n1756) );
  CLKBUFX3 U1688 ( .A(n1774), .Y(n1760) );
  CLKBUFX3 U1689 ( .A(n1771), .Y(n1755) );
  CLKBUFX3 U1690 ( .A(n1772), .Y(n1757) );
  CLKBUFX3 U1691 ( .A(n1774), .Y(n1761) );
  CLKBUFX3 U1692 ( .A(n1773), .Y(n1758) );
  CLKBUFX3 U1693 ( .A(n1777), .Y(n1766) );
  CLKBUFX3 U1694 ( .A(n1775), .Y(n1763) );
  NAND2X1 U1695 ( .A(n1811), .B(n1821), .Y(n953) );
  OAI21X1 U1696 ( .A0(n122), .A1(n123), .B0(n124), .Y(n121) );
  NAND4X1 U1697 ( .A(n1346), .B(n1345), .C(n1834), .D(n1826), .Y(n122) );
  NAND4XL U1698 ( .A(\match_controller/N904 ), .B(\match_controller/N905 ), 
        .C(\match_controller/N903 ), .D(\match_controller/N901 ), .Y(n123) );
  CLKINVX1 U1699 ( .A(n383), .Y(n378) );
  OAI31XL U1700 ( .A0(n201), .A1(n2009), .A2(n1995), .B0(n208), .Y(n383) );
  AOI221XL U1701 ( .A0(n150), .A1(n168), .B0(n1864), .B1(n170), .C0(n171), .Y(
        n164) );
  OAI31XL U1702 ( .A0(n1996), .A1(n1841), .A2(n174), .B0(n2000), .Y(n171) );
  OAI211X1 U1703 ( .A0(n120), .A1(n1819), .B0(n177), .C0(n178), .Y(n168) );
  NAND3X1 U1704 ( .A(n179), .B(n1820), .C(n120), .Y(n177) );
  XOR2X1 U1705 ( .A(n485), .B(n486), .Y(n484) );
  OAI22XL U1706 ( .A0(n1708), .A1(n1832), .B0(n1347), .B1(n1856), .Y(n485) );
  OAI22XL U1707 ( .A0(n470), .A1(n1856), .B0(n1347), .B1(n1832), .Y(n486) );
  INVXL U1708 ( .A(\match_controller/N904 ), .Y(n1832) );
  NAND4X1 U1709 ( .A(n1346), .B(n1345), .C(n848), .D(n849), .Y(n145) );
  NOR4X1 U1710 ( .A(n1821), .B(n1835), .C(n1833), .D(n1831), .Y(n849) );
  NOR3XL U1711 ( .A(\match_controller/N902 ), .B(\match_controller/N906 ), .C(
        \match_controller/N904 ), .Y(n848) );
  NOR2X1 U1712 ( .A(n291), .B(n263), .Y(n201) );
  NOR3X1 U1713 ( .A(n385), .B(n121), .C(n384), .Y(n265) );
  NAND3X1 U1714 ( .A(n372), .B(n373), .C(n374), .Y(n199) );
  XNOR2X1 U1715 ( .A(n381), .B(n382), .Y(n372) );
  XNOR2X1 U1716 ( .A(n379), .B(n380), .Y(n373) );
  XNOR2X1 U1717 ( .A(n375), .B(n376), .Y(n374) );
  AND4X1 U1718 ( .A(n653), .B(n249), .C(n182), .D(n384), .Y(n470) );
  OAI21XL U1719 ( .A0(n291), .A1(n263), .B0(n207), .Y(n653) );
  XOR2X1 U1720 ( .A(n468), .B(n469), .Y(n467) );
  OAI22XL U1721 ( .A0(n1708), .A1(n1345), .B0(n1347), .B1(n1862), .Y(n468) );
  OAI22XL U1722 ( .A0(n1708), .A1(n1862), .B0(n1347), .B1(n1345), .Y(n469) );
  CLKINVX1 U1723 ( .A(\match_controller/N908 ), .Y(n1862) );
  XOR2X1 U1724 ( .A(n473), .B(n474), .Y(n466) );
  OAI22XL U1725 ( .A0(n1708), .A1(n1346), .B0(n1347), .B1(n1863), .Y(n473) );
  OAI22XL U1726 ( .A0(n1708), .A1(n1863), .B0(n1347), .B1(n1346), .Y(n474) );
  AOI211X1 U1727 ( .A0(n1840), .A1(n170), .B0(n167), .C0(n270), .Y(n214) );
  OAI2BB1X1 U1728 ( .A0N(n207), .A1N(n271), .B0(n272), .Y(n270) );
  OAI21XL U1729 ( .A0(n259), .A1(n206), .B0(n273), .Y(n271) );
  NAND2BX1 U1730 ( .AN(n191), .B(n149), .Y(n152) );
  OR2X1 U1731 ( .A(n149), .B(n191), .Y(n151) );
  CLKBUFX3 U1732 ( .A(n1614), .Y(n1622) );
  NAND2X1 U1733 ( .A(n257), .B(n279), .Y(n190) );
  OAI21XL U1734 ( .A0(n207), .A1(n248), .B0(n194), .Y(n283) );
  AOI2BB2X1 U1735 ( .B0(n1995), .B1(n391), .A0N(n285), .A1N(n392), .Y(n390) );
  OAI221XL U1736 ( .A0(n392), .A1(n290), .B0(n231), .B1(n259), .C0(n120), .Y(
        n391) );
  NOR2X1 U1737 ( .A(n228), .B(n206), .Y(n392) );
  INVX1 U1738 ( .A(\match_controller/N905 ), .Y(n1831) );
  INVX1 U1739 ( .A(\match_controller/N903 ), .Y(n1833) );
  INVX1 U1740 ( .A(\match_controller/N901 ), .Y(n1835) );
  CLKBUFX3 U1741 ( .A(n1657), .Y(n1665) );
  NOR2X1 U1742 ( .A(n1661), .B(n1662), .Y(n1657) );
  AOI32X1 U1743 ( .A0(n519), .A1(n520), .A2(n521), .B0(n522), .B1(n523), .Y(
        n499) );
  NAND4X1 U1744 ( .A(n1855), .B(n1857), .C(n1853), .D(n527), .Y(n523) );
  NOR4X1 U1745 ( .A(n585), .B(n586), .C(n587), .D(n588), .Y(n519) );
  NOR4X1 U1746 ( .A(n528), .B(n529), .C(n530), .D(n531), .Y(n521) );
  OAI22XL U1747 ( .A0(n577), .A1(n1888), .B0(n2013), .B1(n1861), .Y(n566) );
  NAND4BX1 U1748 ( .AN(n497), .B(n498), .C(n499), .D(n500), .Y(n220) );
  OAI21XL U1749 ( .A0(n605), .A1(n606), .B0(n607), .Y(n498) );
  OAI31XL U1750 ( .A0(n501), .A1(n502), .A2(n503), .B0(n1707), .Y(n500) );
  OAI222XL U1751 ( .A0(n615), .A1(n2015), .B0(n617), .B1(n2017), .C0(n619), 
        .C1(n371), .Y(n497) );
  CLKINVX1 U1752 ( .A(n809), .Y(n2014) );
  NOR4X1 U1753 ( .A(n565), .B(n566), .C(n567), .D(n568), .Y(n520) );
  OAI22XL U1754 ( .A0(n581), .A1(n1868), .B0(n583), .B1(n1872), .Y(n565) );
  OAI22XL U1755 ( .A0(n573), .A1(n1880), .B0(n575), .B1(n1884), .Y(n567) );
  OAI22XL U1756 ( .A0(n569), .A1(n1920), .B0(n571), .B1(n1876), .Y(n568) );
  NOR3X2 U1757 ( .A(\match_controller/N250 ), .B(\match_controller/N251 ), .C(
        \match_controller/N252 ), .Y(n642) );
  NAND2X1 U1758 ( .A(n1707), .B(n651), .Y(n541) );
  OAI22XL U1759 ( .A0(n549), .A1(n1936), .B0(n551), .B1(n1940), .Y(n548) );
  NAND2X1 U1760 ( .A(n620), .B(n647), .Y(n551) );
  OR4X1 U1761 ( .A(n545), .B(n546), .C(n547), .D(n548), .Y(n528) );
  OAI22XL U1762 ( .A0(n557), .A1(n1980), .B0(n559), .B1(n1924), .Y(n546) );
  OAI22XL U1763 ( .A0(n561), .A1(n1928), .B0(n563), .B1(n1932), .Y(n545) );
  OAI22XL U1764 ( .A0(n553), .A1(n1944), .B0(n555), .B1(n1948), .Y(n547) );
  NAND2X1 U1765 ( .A(n620), .B(n643), .Y(n555) );
  NAND2X1 U1766 ( .A(n620), .B(n651), .Y(n563) );
  NAND2X1 U1767 ( .A(n620), .B(n650), .Y(n549) );
  NAND2X1 U1768 ( .A(n620), .B(n646), .Y(n553) );
  NAND2X1 U1769 ( .A(n1707), .B(n809), .Y(n539) );
  NAND2X1 U1770 ( .A(n1707), .B(n643), .Y(n557) );
  NAND2X1 U1771 ( .A(n1707), .B(n647), .Y(n534) );
  NAND2X1 U1772 ( .A(n647), .B(n607), .Y(n571) );
  NAND2X1 U1773 ( .A(n620), .B(n809), .Y(n561) );
  NAND2X1 U1774 ( .A(n643), .B(n607), .Y(n575) );
  NAND2X1 U1775 ( .A(n1707), .B(n650), .Y(n532) );
  NAND2X1 U1776 ( .A(n1707), .B(n646), .Y(n536) );
  OAI22XL U1777 ( .A0(n629), .A1(n2011), .B0(n630), .B1(n2010), .Y(n622) );
  CLKINVX1 U1778 ( .A(n646), .Y(n2010) );
  NOR4X1 U1779 ( .A(n621), .B(n622), .C(n623), .D(n624), .Y(n617) );
  OAI22XL U1780 ( .A0(n625), .A1(n2012), .B0(n626), .B1(n2014), .Y(n624) );
  OAI22XL U1781 ( .A0(n627), .A1(n2007), .B0(n628), .B1(n2008), .Y(n623) );
  OAI22XL U1782 ( .A0(n631), .A1(n2005), .B0(n632), .B1(n2006), .Y(n621) );
  NAND2X1 U1783 ( .A(n633), .B(n651), .Y(n595) );
  NAND2X1 U1784 ( .A(n607), .B(n650), .Y(n583) );
  NAND2X1 U1785 ( .A(n646), .B(n607), .Y(n573) );
  NAND2X1 U1786 ( .A(n633), .B(n647), .Y(n599) );
  NAND2X1 U1787 ( .A(n633), .B(n642), .Y(n569) );
  NAND2X1 U1788 ( .A(n642), .B(n607), .Y(n577) );
  CLKINVX1 U1789 ( .A(n650), .Y(n2006) );
  NAND2X1 U1790 ( .A(n633), .B(n643), .Y(n603) );
  CLKINVX1 U1791 ( .A(n643), .Y(n2007) );
  CLKINVX1 U1792 ( .A(n647), .Y(n2011) );
  OAI22XL U1793 ( .A0(n644), .A1(n2011), .B0(n645), .B1(n2010), .Y(n635) );
  NOR4X1 U1794 ( .A(n634), .B(n635), .C(n636), .D(n637), .Y(n615) );
  OAI22XL U1795 ( .A0(n638), .A1(n2012), .B0(n639), .B1(n2014), .Y(n637) );
  OAI22XL U1796 ( .A0(n640), .A1(n2007), .B0(n641), .B1(n2008), .Y(n636) );
  OAI22XL U1797 ( .A0(n648), .A1(n2005), .B0(n649), .B1(n2006), .Y(n634) );
  NAND2X1 U1798 ( .A(n651), .B(n607), .Y(n581) );
  NAND2X1 U1799 ( .A(n620), .B(n642), .Y(n589) );
  NAND2X1 U1800 ( .A(n620), .B(n810), .Y(n559) );
  NAND2X1 U1801 ( .A(n633), .B(n650), .Y(n597) );
  CLKINVX1 U1802 ( .A(n651), .Y(n2005) );
  NAND2X1 U1803 ( .A(n633), .B(n646), .Y(n601) );
  CLKBUFX3 U1804 ( .A(n504), .Y(n1707) );
  NOR2X1 U1805 ( .A(\match_controller/N254 ), .B(\match_controller/N253 ), .Y(
        n504) );
  NAND2X1 U1806 ( .A(n633), .B(n809), .Y(n593) );
  CLKINVX1 U1807 ( .A(n607), .Y(n2016) );
  OAI22XL U1808 ( .A0(n120), .A1(n273), .B0(n230), .B1(n287), .Y(n256) );
  OAI222XL U1809 ( .A0(n513), .A1(n2014), .B0(n515), .B1(n2007), .C0(n517), 
        .C1(n2012), .Y(n501) );
  OAI222XL U1810 ( .A0(n608), .A1(n2008), .B0(n610), .B1(n2011), .C0(n611), 
        .C1(n2007), .Y(n606) );
  NAND2X1 U1811 ( .A(n1707), .B(n810), .Y(n543) );
  NAND2X1 U1812 ( .A(n810), .B(n633), .Y(n591) );
  OAI222XL U1813 ( .A0(n612), .A1(n2005), .B0(n613), .B1(n2006), .C0(n614), 
        .C1(n2010), .Y(n605) );
  OAI22XL U1814 ( .A0(n505), .A1(n2011), .B0(n507), .B1(n2010), .Y(n503) );
  OAI22XL U1815 ( .A0(n509), .A1(n2005), .B0(n511), .B1(n2006), .Y(n502) );
  OAI31XL U1816 ( .A0(n199), .A1(n2009), .A2(n201), .B0(n202), .Y(n198) );
  CLKINVX1 U1817 ( .A(n620), .Y(n2017) );
  CLKINVX1 U1818 ( .A(n633), .Y(n2015) );
  INVX3 U1819 ( .A(n279), .Y(n1995) );
  NOR2X1 U1820 ( .A(n1348), .B(n1353), .Y(n213) );
  AOI2BB2X1 U1821 ( .B0(n253), .B1(n216), .A0N(n290), .A1N(n279), .Y(n289) );
  CLKBUFX3 U1822 ( .A(n1551), .Y(n1581) );
  NAND2X1 U1823 ( .A(n1389), .B(n1388), .Y(n1551) );
  CLKBUFX3 U1824 ( .A(n1549), .Y(n1579) );
  NAND2X1 U1825 ( .A(n1389), .B(n1386), .Y(n1549) );
  CLKBUFX3 U1826 ( .A(n1545), .Y(n1577) );
  NAND2X1 U1827 ( .A(n1384), .B(n1388), .Y(n1545) );
  CLKBUFX3 U1828 ( .A(n1547), .Y(n1575) );
  NAND2X1 U1829 ( .A(n1384), .B(n1385), .Y(n1547) );
  CLKBUFX3 U1830 ( .A(n1537), .Y(n1571) );
  NAND2X1 U1831 ( .A(n1386), .B(n1379), .Y(n1537) );
  CLKBUFX3 U1832 ( .A(n1535), .Y(n1569) );
  NAND2X1 U1833 ( .A(n1378), .B(n1388), .Y(n1535) );
  AOI32X1 U1834 ( .A0(n174), .A1(n279), .A2(n260), .B0(n262), .B1(n1841), .Y(
        n275) );
  XNOR2XL U1835 ( .A(n1842), .B(\match_controller/N914 ), .Y(n832) );
  NAND2X1 U1836 ( .A(n828), .B(n829), .Y(n260) );
  NOR4X1 U1837 ( .A(n836), .B(n837), .C(n838), .D(n839), .Y(n828) );
  NOR4X1 U1838 ( .A(n830), .B(n831), .C(n832), .D(n833), .Y(n829) );
  XNOR2X1 U1839 ( .A(n1845), .B(\match_controller/N907 ), .Y(n837) );
  CLKBUFX3 U1840 ( .A(n1546), .Y(n1574) );
  NAND2X1 U1841 ( .A(n1384), .B(n1386), .Y(n1546) );
  CLKBUFX3 U1842 ( .A(n1553), .Y(n1567) );
  NAND2XL U1843 ( .A(n1378), .B(n1386), .Y(n1553) );
  CLKBUFX3 U1844 ( .A(n1539), .Y(n1573) );
  NAND2X1 U1845 ( .A(n1388), .B(n1379), .Y(n1539) );
  CLKBUFX3 U1846 ( .A(n1552), .Y(n1580) );
  NAND2X1 U1847 ( .A(n1389), .B(n1387), .Y(n1552) );
  CLKBUFX3 U1848 ( .A(n1550), .Y(n1578) );
  NAND2XL U1849 ( .A(n1389), .B(n1385), .Y(n1550) );
  XNOR2X1 U1850 ( .A(n1843), .B(\match_controller/N910 ), .Y(n838) );
  CLKBUFX3 U1851 ( .A(n1548), .Y(n1576) );
  NAND2XL U1852 ( .A(n1384), .B(n1387), .Y(n1548) );
  CLKBUFX3 U1853 ( .A(n1540), .Y(n1572) );
  NAND2X1 U1854 ( .A(n1379), .B(n1387), .Y(n1540) );
  CLKBUFX3 U1855 ( .A(n1538), .Y(n1570) );
  NAND2XL U1856 ( .A(n1385), .B(n1379), .Y(n1538) );
  CLKBUFX3 U1857 ( .A(n1536), .Y(n1568) );
  NAND2X1 U1858 ( .A(n1378), .B(n1387), .Y(n1536) );
  XNOR2X1 U1859 ( .A(n1844), .B(\match_controller/N908 ), .Y(n836) );
  CLKBUFX3 U1860 ( .A(n1534), .Y(n1566) );
  NAND2XL U1861 ( .A(n1378), .B(n1385), .Y(n1534) );
  XNOR2X1 U1862 ( .A(n1349), .B(\match_controller/N911 ), .Y(n831) );
  XNOR2X1 U1863 ( .A(n1362), .B(\match_controller/N912 ), .Y(n830) );
  CLKINVX1 U1864 ( .A(n209), .Y(n1999) );
  XNOR2XL U1865 ( .A(\match_controller/N908 ), .B(n303), .Y(n302) );
  NAND4X1 U1866 ( .A(n314), .B(n311), .C(n312), .D(n306), .Y(n295) );
  OR4X1 U1867 ( .A(n305), .B(n304), .C(n303), .D(n313), .Y(n296) );
  NAND4X1 U1868 ( .A(n307), .B(n308), .C(n309), .D(n310), .Y(n297) );
  NAND4X1 U1869 ( .A(n299), .B(n300), .C(n301), .D(n302), .Y(n298) );
  XNOR2X1 U1870 ( .A(\match_controller/N909 ), .B(n306), .Y(n299) );
  XNOR2X1 U1871 ( .A(\match_controller/N907 ), .B(n304), .Y(n301) );
  XNOR2XL U1872 ( .A(\match_controller/N910 ), .B(n305), .Y(n300) );
  XNOR2XL U1873 ( .A(\match_controller/N914 ), .B(n313), .Y(n308) );
  INVX1 U1874 ( .A(\match_controller/N902 ), .Y(n1834) );
  XNOR2XL U1875 ( .A(\match_controller/N914 ), .B(n239), .Y(n397) );
  OAI21XL U1876 ( .A0(n231), .A1(n232), .B0(n1992), .Y(n219) );
  NOR2X1 U1877 ( .A(n234), .B(n235), .Y(n232) );
  NAND4X1 U1878 ( .A(n236), .B(n237), .C(n238), .D(n239), .Y(n235) );
  NAND4X1 U1879 ( .A(n240), .B(n241), .C(n242), .D(n243), .Y(n234) );
  AND2X2 U1880 ( .A(n393), .B(n394), .Y(n231) );
  NOR4X1 U1881 ( .A(n429), .B(n430), .C(n431), .D(n432), .Y(n393) );
  NOR4X1 U1882 ( .A(n395), .B(n396), .C(n397), .D(n398), .Y(n394) );
  XNOR2X1 U1883 ( .A(\match_controller/N907 ), .B(n237), .Y(n430) );
  INVX1 U1884 ( .A(\match_controller/N906 ), .Y(n1826) );
  XNOR2X1 U1885 ( .A(n1858), .B(n242), .Y(n396) );
  XNOR2X1 U1886 ( .A(\match_controller/N912 ), .B(n311), .Y(n310) );
  XNOR2X1 U1887 ( .A(\match_controller/N910 ), .B(n236), .Y(n431) );
  XNOR2X1 U1888 ( .A(\match_controller/N911 ), .B(n312), .Y(n309) );
  XNOR2X1 U1889 ( .A(n1854), .B(n241), .Y(n398) );
  OAI2BB1X1 U1890 ( .A0N(n384), .A1N(n290), .B0(n385), .Y(n272) );
  XNOR2X1 U1891 ( .A(n1856), .B(n243), .Y(n395) );
  XNOR2X1 U1892 ( .A(\match_controller/N908 ), .B(n238), .Y(n429) );
  XNOR2X1 U1893 ( .A(n1860), .B(n240), .Y(n432) );
  XNOR2X1 U1894 ( .A(\match_controller/N913 ), .B(n314), .Y(n307) );
  OAI21XL U1895 ( .A0(n1864), .A1(n260), .B0(n261), .Y(n258) );
  NAND3X1 U1896 ( .A(n1995), .B(n277), .C(n170), .Y(n247) );
  NAND3X1 U1897 ( .A(n247), .B(n1997), .C(n248), .Y(n225) );
  NAND3X1 U1898 ( .A(n1995), .B(n371), .C(n291), .Y(n285) );
  OAI22XL U1899 ( .A0(n1888), .A1(n573), .B0(n1872), .B1(n2013), .Y(n806) );
  NOR4X1 U1900 ( .A(n805), .B(n806), .C(n807), .D(n808), .Y(n804) );
  OAI22XL U1901 ( .A0(n583), .A1(n1880), .B0(n575), .B1(n1892), .Y(n807) );
  OAI22XL U1902 ( .A0(n1920), .A1(n601), .B0(n1884), .B1(n571), .Y(n808) );
  OAI32X1 U1903 ( .A0(n2012), .A1(n2016), .A2(n1868), .B0(n581), .B1(n1876), 
        .Y(n805) );
  NOR4X1 U1904 ( .A(n771), .B(n772), .C(n773), .D(n774), .Y(n658) );
  OAI22XL U1905 ( .A0(n509), .A1(n543), .B0(n511), .B1(n539), .Y(n774) );
  OAI22XL U1906 ( .A0(n515), .A1(n534), .B0(n619), .B1(n536), .Y(n772) );
  OAI22XL U1907 ( .A0(n505), .A1(n541), .B0(n507), .B1(n532), .Y(n773) );
  OAI32X1 U1908 ( .A0(n2012), .A1(n612), .A2(n2016), .B0(n613), .B1(n2013), 
        .Y(n665) );
  NOR4X1 U1909 ( .A(n662), .B(n663), .C(n664), .D(n665), .Y(n661) );
  OAI22XL U1910 ( .A0(n638), .A1(n575), .B0(n639), .B1(n577), .Y(n662) );
  OAI22XL U1911 ( .A0(n610), .A1(n581), .B0(n614), .B1(n583), .Y(n664) );
  OAI22XL U1912 ( .A0(n611), .A1(n571), .B0(n608), .B1(n573), .Y(n663) );
  NOR3X1 U1913 ( .A(n819), .B(n820), .C(n821), .Y(n801) );
  OAI22XL U1914 ( .A0(n1976), .A1(n532), .B0(n557), .B1(n1987), .Y(n820) );
  OAI22XL U1915 ( .A0(n1972), .A1(n541), .B0(n1980), .B1(n534), .Y(n821) );
  OAI222XL U1916 ( .A0(n589), .A1(n1960), .B0(n1968), .B1(n539), .C0(n1964), 
        .C1(n543), .Y(n819) );
  NAND2X1 U1917 ( .A(n366), .B(\match_controller/N247 ), .Y(n320) );
  CLKINVX1 U1918 ( .A(n342), .Y(n2004) );
  OAI22XL U1919 ( .A0(n1984), .A1(n536), .B0(n569), .B1(n1928), .Y(n818) );
  NOR4X1 U1920 ( .A(n815), .B(n816), .C(n817), .D(n818), .Y(n802) );
  OAI22XL U1921 ( .A0(n1932), .A1(n559), .B0(n1936), .B1(n561), .Y(n817) );
  OAI22XL U1922 ( .A0(n1944), .A1(n549), .B0(n555), .B1(n1956), .Y(n815) );
  OAI22XL U1923 ( .A0(n1940), .A1(n563), .B0(n1948), .B1(n551), .Y(n816) );
  OAI22XL U1924 ( .A0(n1908), .A1(n595), .B0(n1916), .B1(n599), .Y(n812) );
  NOR4X1 U1925 ( .A(n811), .B(n812), .C(n813), .D(n814), .Y(n803) );
  OAI22XL U1926 ( .A0(n1952), .A1(n553), .B0(n1900), .B1(n591), .Y(n814) );
  OAI22XL U1927 ( .A0(n1912), .A1(n597), .B0(n603), .B1(n1924), .Y(n811) );
  OAI22XL U1928 ( .A0(n577), .A1(n1896), .B0(n1904), .B1(n593), .Y(n813) );
  AND2X2 U1929 ( .A(n385), .B(n129), .Y(n1016) );
  CLKINVX1 U1930 ( .A(n324), .Y(n2003) );
  CLKINVX1 U1931 ( .A(n418), .Y(n1991) );
  CLKINVX1 U1932 ( .A(n402), .Y(n1993) );
  AND2X2 U1933 ( .A(n365), .B(\match_controller/N249 ), .Y(n326) );
  CLKINVX1 U1934 ( .A(n403), .Y(n1990) );
  CLKINVX1 U1935 ( .A(n417), .Y(n1994) );
  AO21X1 U1936 ( .A0(n1847), .A1(n1827), .B0(n202), .Y(n244) );
  AO21X1 U1937 ( .A0(n250), .A1(n288), .B0(n244), .Y(n389) );
  CLKINVX1 U1938 ( .A(n228), .Y(n1992) );
  NAND2X1 U1939 ( .A(n290), .B(n1997), .Y(n216) );
  CLKINVX1 U1940 ( .A(n291), .Y(n1997) );
  CLKINVX1 U1941 ( .A(n170), .Y(n1996) );
  NAND2X1 U1942 ( .A(n213), .B(n369), .Y(n230) );
  CLKINVX1 U1943 ( .A(n261), .Y(n2000) );
  CLKINVX1 U1944 ( .A(n288), .Y(n1847) );
  CLKBUFX3 U1945 ( .A(n1770), .Y(n1713) );
  CLKBUFX3 U1946 ( .A(n1770), .Y(n1712) );
  CLKBUFX3 U1947 ( .A(n1770), .Y(n1711) );
  CLKBUFX3 U1948 ( .A(n1770), .Y(n1710) );
  CLKBUFX3 U1949 ( .A(n1770), .Y(n1709) );
  NAND3X1 U1950 ( .A(n1352), .B(n1348), .C(n986), .Y(n129) );
  NOR2X2 U1951 ( .A(n1818), .B(n966), .Y(n940) );
  INVX3 U1952 ( .A(ispattern), .Y(n1818) );
  AO22X1 U1953 ( .A0(chardata[5]), .A1(n1813), .B0(n941), .B1(
        \pattern_buffer[1][5] ), .Y(n1283) );
  AO22X1 U1954 ( .A0(chardata[1]), .A1(n1813), .B0(n941), .B1(
        \pattern_buffer[1][1] ), .Y(n1287) );
  CLKBUFX3 U1955 ( .A(n945), .Y(n1668) );
  NAND3X1 U1956 ( .A(\read_chardata/temp_read_pattern_count [0]), .B(n1823), 
        .C(n136), .Y(n945) );
  CLKBUFX3 U1957 ( .A(n951), .Y(n1670) );
  NAND3X1 U1958 ( .A(\read_chardata/temp_read_pattern_count [2]), .B(n1822), 
        .C(n136), .Y(n951) );
  OAI2BB2XL U1959 ( .B0(n1754), .B1(n1669), .A0N(n1669), .A1N(
        \pattern_buffer[7][7] ), .Y(n1329) );
  OAI2BB2XL U1960 ( .B0(n1756), .B1(n1669), .A0N(n1669), .A1N(
        \pattern_buffer[7][6] ), .Y(n1330) );
  OAI2BB2XL U1961 ( .B0(n1758), .B1(n1669), .A0N(n1669), .A1N(
        \pattern_buffer[7][5] ), .Y(n1331) );
  OAI2BB2XL U1962 ( .B0(n1760), .B1(n1669), .A0N(n1669), .A1N(
        \pattern_buffer[7][4] ), .Y(n1332) );
  OAI2BB2XL U1963 ( .B0(n1762), .B1(n1669), .A0N(n1669), .A1N(
        \pattern_buffer[7][3] ), .Y(n1333) );
  OAI2BB2XL U1964 ( .B0(n1764), .B1(n1669), .A0N(n1669), .A1N(
        \pattern_buffer[7][2] ), .Y(n1334) );
  OAI2BB2XL U1965 ( .B0(n1766), .B1(n1669), .A0N(n1669), .A1N(
        \pattern_buffer[7][1] ), .Y(n1335) );
  OAI2BB2XL U1966 ( .B0(n1768), .B1(n1669), .A0N(n1669), .A1N(
        \pattern_buffer[7][0] ), .Y(n1336) );
  NAND3X1 U1967 ( .A(\read_chardata/temp_read_pattern_count [0]), .B(
        \read_chardata/temp_read_pattern_count [2]), .C(n136), .Y(n952) );
  OAI2BB2XL U1968 ( .B0(n1768), .B1(n1668), .A0N(n1668), .A1N(
        \pattern_buffer[3][0] ), .Y(n1304) );
  OAI2BB2XL U1969 ( .B0(n1754), .B1(n1668), .A0N(n1668), .A1N(
        \pattern_buffer[3][7] ), .Y(n1297) );
  OAI2BB2XL U1970 ( .B0(n1756), .B1(n1668), .A0N(n1668), .A1N(
        \pattern_buffer[3][6] ), .Y(n1298) );
  OAI2BB2XL U1971 ( .B0(n1760), .B1(n1668), .A0N(n1668), .A1N(
        \pattern_buffer[3][4] ), .Y(n1300) );
  OAI2BB2XL U1972 ( .B0(n1764), .B1(n1670), .A0N(n1670), .A1N(
        \pattern_buffer[6][2] ), .Y(n1326) );
  OAI2BB2XL U1973 ( .B0(n1758), .B1(n1670), .A0N(n1670), .A1N(
        \pattern_buffer[6][5] ), .Y(n1323) );
  OAI2BB2XL U1974 ( .B0(n1766), .B1(n1670), .A0N(n1670), .A1N(
        \pattern_buffer[6][1] ), .Y(n1327) );
  OAI2BB2XL U1975 ( .B0(n1763), .B1(n1670), .A0N(n1670), .A1N(
        \pattern_buffer[6][3] ), .Y(n1325) );
  INVX3 U1976 ( .A(isstring), .Y(n1811) );
  OAI2BB2XL U1977 ( .B0(n1754), .B1(n1671), .A0N(n1671), .A1N(
        \pattern_buffer[5][7] ), .Y(n1313) );
  OAI2BB2XL U1978 ( .B0(n1756), .B1(n1671), .A0N(n1671), .A1N(
        \pattern_buffer[5][6] ), .Y(n1314) );
  OAI2BB2XL U1979 ( .B0(n1758), .B1(n1671), .A0N(n1671), .A1N(
        \pattern_buffer[5][5] ), .Y(n1315) );
  OAI2BB2XL U1980 ( .B0(n1760), .B1(n1671), .A0N(n1671), .A1N(
        \pattern_buffer[5][4] ), .Y(n1316) );
  OAI2BB2XL U1981 ( .B0(n1763), .B1(n1671), .A0N(n1671), .A1N(
        \pattern_buffer[5][3] ), .Y(n1317) );
  OAI2BB2XL U1982 ( .B0(n1764), .B1(n1671), .A0N(n1671), .A1N(
        \pattern_buffer[5][2] ), .Y(n1318) );
  OAI2BB2XL U1983 ( .B0(n1766), .B1(n1671), .A0N(n1671), .A1N(
        \pattern_buffer[5][1] ), .Y(n1319) );
  OAI2BB2XL U1984 ( .B0(n1768), .B1(n1671), .A0N(n1671), .A1N(
        \pattern_buffer[5][0] ), .Y(n1320) );
  NAND3X1 U1985 ( .A(\read_chardata/temp_read_pattern_count [0]), .B(
        \read_chardata/temp_read_pattern_count [2]), .C(n940), .Y(n949) );
  OAI2BB2XL U1986 ( .B0(n1768), .B1(n1673), .A0N(n1673), .A1N(
        \pattern_buffer[2][0] ), .Y(n1296) );
  OAI2BB2XL U1987 ( .B0(n1755), .B1(n1673), .A0N(n1673), .A1N(
        \pattern_buffer[2][7] ), .Y(n1289) );
  OAI2BB2XL U1988 ( .B0(n1757), .B1(n1673), .A0N(n1673), .A1N(
        \pattern_buffer[2][6] ), .Y(n1290) );
  OAI2BB2XL U1989 ( .B0(n1761), .B1(n1673), .A0N(n1673), .A1N(
        \pattern_buffer[2][4] ), .Y(n1292) );
  CLKBUFX3 U1990 ( .A(n947), .Y(n1672) );
  NAND3X1 U1991 ( .A(\read_chardata/temp_read_pattern_count [2]), .B(n1822), 
        .C(n940), .Y(n947) );
  OAI2BB2XL U1992 ( .B0(n1768), .B1(n1672), .A0N(n1672), .A1N(
        \pattern_buffer[4][0] ), .Y(n1312) );
  OAI2BB2XL U1993 ( .B0(n1754), .B1(n1672), .A0N(n1672), .A1N(
        \pattern_buffer[4][7] ), .Y(n1305) );
  OAI2BB2XL U1994 ( .B0(n1756), .B1(n1672), .A0N(n1672), .A1N(
        \pattern_buffer[4][6] ), .Y(n1306) );
  OAI2BB2XL U1995 ( .B0(n1760), .B1(n1672), .A0N(n1672), .A1N(
        \pattern_buffer[4][4] ), .Y(n1308) );
  OAI2BB2XL U1996 ( .B0(n1762), .B1(n1705), .A0N(n1705), .A1N(
        \string_buffer[1][3] ), .Y(n1029) );
  OAI2BB2XL U1997 ( .B0(n1762), .B1(n1704), .A0N(n1704), .A1N(
        \string_buffer[2][3] ), .Y(n1037) );
  OAI2BB2XL U1998 ( .B0(n1762), .B1(n1703), .A0N(n1703), .A1N(
        \string_buffer[3][3] ), .Y(n1045) );
  OAI2BB2XL U1999 ( .B0(n1762), .B1(n1702), .A0N(n1702), .A1N(
        \string_buffer[4][3] ), .Y(n1053) );
  OAI2BB2XL U2000 ( .B0(n1762), .B1(n1701), .A0N(n1701), .A1N(
        \string_buffer[5][3] ), .Y(n1061) );
  OAI2BB2XL U2001 ( .B0(n1762), .B1(n1700), .A0N(n1700), .A1N(
        \string_buffer[6][3] ), .Y(n1069) );
  OAI2BB2XL U2002 ( .B0(n1762), .B1(n1699), .A0N(n1699), .A1N(
        \string_buffer[7][3] ), .Y(n1077) );
  OAI2BB2XL U2003 ( .B0(n1755), .B1(n1705), .A0N(n1705), .A1N(
        \string_buffer[1][7] ), .Y(n1025) );
  OAI2BB2XL U2004 ( .B0(n1757), .B1(n1705), .A0N(n1705), .A1N(
        \string_buffer[1][6] ), .Y(n1026) );
  OAI2BB2XL U2005 ( .B0(n1761), .B1(n1705), .A0N(n1705), .A1N(
        \string_buffer[1][4] ), .Y(n1028) );
  OAI2BB2XL U2006 ( .B0(n1755), .B1(n1704), .A0N(n1704), .A1N(
        \string_buffer[2][7] ), .Y(n1033) );
  OAI2BB2XL U2007 ( .B0(n1757), .B1(n1704), .A0N(n1704), .A1N(
        \string_buffer[2][6] ), .Y(n1034) );
  OAI2BB2XL U2008 ( .B0(n1761), .B1(n1704), .A0N(n1704), .A1N(
        \string_buffer[2][4] ), .Y(n1036) );
  OAI2BB2XL U2009 ( .B0(n1755), .B1(n1703), .A0N(n1703), .A1N(
        \string_buffer[3][7] ), .Y(n1041) );
  OAI2BB2XL U2010 ( .B0(n1757), .B1(n1703), .A0N(n1703), .A1N(
        \string_buffer[3][6] ), .Y(n1042) );
  OAI2BB2XL U2011 ( .B0(n1761), .B1(n1703), .A0N(n1703), .A1N(
        \string_buffer[3][4] ), .Y(n1044) );
  OAI2BB2XL U2012 ( .B0(n1755), .B1(n1702), .A0N(n1702), .A1N(
        \string_buffer[4][7] ), .Y(n1049) );
  OAI2BB2XL U2013 ( .B0(n1757), .B1(n1702), .A0N(n1702), .A1N(
        \string_buffer[4][6] ), .Y(n1050) );
  OAI2BB2XL U2014 ( .B0(n1761), .B1(n1702), .A0N(n1702), .A1N(
        \string_buffer[4][4] ), .Y(n1052) );
  OAI2BB2XL U2015 ( .B0(n1755), .B1(n1701), .A0N(n1701), .A1N(
        \string_buffer[5][7] ), .Y(n1057) );
  OAI2BB2XL U2016 ( .B0(n1757), .B1(n1701), .A0N(n1701), .A1N(
        \string_buffer[5][6] ), .Y(n1058) );
  OAI2BB2XL U2017 ( .B0(n1761), .B1(n1701), .A0N(n1701), .A1N(
        \string_buffer[5][4] ), .Y(n1060) );
  OAI2BB2XL U2018 ( .B0(n1755), .B1(n1700), .A0N(n1700), .A1N(
        \string_buffer[6][7] ), .Y(n1065) );
  OAI2BB2XL U2019 ( .B0(n1757), .B1(n1700), .A0N(n1700), .A1N(
        \string_buffer[6][6] ), .Y(n1066) );
  OAI2BB2XL U2020 ( .B0(n1761), .B1(n1700), .A0N(n1700), .A1N(
        \string_buffer[6][4] ), .Y(n1068) );
  OAI2BB2XL U2021 ( .B0(n1755), .B1(n1699), .A0N(n1699), .A1N(
        \string_buffer[7][7] ), .Y(n1073) );
  OAI2BB2XL U2022 ( .B0(n1757), .B1(n1699), .A0N(n1699), .A1N(
        \string_buffer[7][6] ), .Y(n1074) );
  OAI2BB2XL U2023 ( .B0(n1761), .B1(n1699), .A0N(n1699), .A1N(
        \string_buffer[7][4] ), .Y(n1076) );
  NAND2X1 U2024 ( .A(n1668), .B(n955), .Y(n1344) );
  OAI21XL U2025 ( .A0(n940), .A1(n954), .B0(
        \read_chardata/temp_read_pattern_count [2]), .Y(n955) );
  OAI2BB2XL U2026 ( .B0(n1706), .B1(n1768), .A0N(n1706), .A1N(
        \string_buffer[0][0] ), .Y(n1024) );
  OAI2BB2XL U2027 ( .B0(n1706), .B1(n1764), .A0N(n1706), .A1N(
        \string_buffer[0][2] ), .Y(n1022) );
  OAI2BB2XL U2028 ( .B0(n1706), .B1(n1766), .A0N(n1706), .A1N(
        \string_buffer[0][1] ), .Y(n1023) );
  OAI2BB2XL U2029 ( .B0(n1762), .B1(n1698), .A0N(n1698), .A1N(
        \string_buffer[8][3] ), .Y(n1085) );
  OAI2BB2XL U2030 ( .B0(n1762), .B1(n1697), .A0N(n1697), .A1N(
        \string_buffer[9][3] ), .Y(n1093) );
  OAI2BB2XL U2031 ( .B0(n1762), .B1(n1696), .A0N(n1696), .A1N(
        \string_buffer[10][3] ), .Y(n1101) );
  OAI2BB2XL U2032 ( .B0(n1755), .B1(n1698), .A0N(n1698), .A1N(
        \string_buffer[8][7] ), .Y(n1081) );
  OAI2BB2XL U2033 ( .B0(n1757), .B1(n1698), .A0N(n1698), .A1N(
        \string_buffer[8][6] ), .Y(n1082) );
  OAI2BB2XL U2034 ( .B0(n1761), .B1(n1698), .A0N(n1698), .A1N(
        \string_buffer[8][4] ), .Y(n1084) );
  OAI2BB2XL U2035 ( .B0(n1755), .B1(n1697), .A0N(n1697), .A1N(
        \string_buffer[9][7] ), .Y(n1089) );
  OAI2BB2XL U2036 ( .B0(n1757), .B1(n1697), .A0N(n1697), .A1N(
        \string_buffer[9][6] ), .Y(n1090) );
  OAI2BB2XL U2037 ( .B0(n1761), .B1(n1697), .A0N(n1697), .A1N(
        \string_buffer[9][4] ), .Y(n1092) );
  OAI2BB2XL U2038 ( .B0(n1754), .B1(n1696), .A0N(n1696), .A1N(
        \string_buffer[10][7] ), .Y(n1097) );
  OAI2BB2XL U2039 ( .B0(n1756), .B1(n1696), .A0N(n1696), .A1N(
        \string_buffer[10][6] ), .Y(n1098) );
  OAI2BB2XL U2040 ( .B0(n1760), .B1(n1696), .A0N(n1696), .A1N(
        \string_buffer[10][4] ), .Y(n1100) );
  OAI2BB2XL U2041 ( .B0(n1754), .B1(n1695), .A0N(n1695), .A1N(
        \string_buffer[11][7] ), .Y(n1105) );
  OAI2BB2XL U2042 ( .B0(n1756), .B1(n1695), .A0N(n1695), .A1N(
        \string_buffer[11][6] ), .Y(n1106) );
  OAI2BB2XL U2043 ( .B0(n1760), .B1(n1695), .A0N(n1695), .A1N(
        \string_buffer[11][4] ), .Y(n1108) );
  OAI2BB2XL U2044 ( .B0(n1762), .B1(n1695), .A0N(n1695), .A1N(
        \string_buffer[11][3] ), .Y(n1109) );
  OAI2BB2XL U2045 ( .B0(n1755), .B1(n1694), .A0N(n1694), .A1N(
        \string_buffer[12][7] ), .Y(n1113) );
  OAI2BB2XL U2046 ( .B0(n1757), .B1(n1694), .A0N(n1694), .A1N(
        \string_buffer[12][6] ), .Y(n1114) );
  OAI2BB2XL U2047 ( .B0(n1761), .B1(n1694), .A0N(n1694), .A1N(
        \string_buffer[12][4] ), .Y(n1116) );
  OAI2BB2XL U2048 ( .B0(n1763), .B1(n1694), .A0N(n1694), .A1N(
        \string_buffer[12][3] ), .Y(n1117) );
  OAI2BB2XL U2049 ( .B0(n1754), .B1(n1693), .A0N(n1693), .A1N(
        \string_buffer[13][7] ), .Y(n1121) );
  OAI2BB2XL U2050 ( .B0(n1756), .B1(n1693), .A0N(n1693), .A1N(
        \string_buffer[13][6] ), .Y(n1122) );
  OAI2BB2XL U2051 ( .B0(n1760), .B1(n1693), .A0N(n1693), .A1N(
        \string_buffer[13][4] ), .Y(n1124) );
  OAI2BB2XL U2052 ( .B0(n1775), .B1(n1693), .A0N(n1693), .A1N(
        \string_buffer[13][3] ), .Y(n1125) );
  OAI2BB2XL U2053 ( .B0(n1754), .B1(n1692), .A0N(n1692), .A1N(
        \string_buffer[14][7] ), .Y(n1129) );
  OAI2BB2XL U2054 ( .B0(n1756), .B1(n1692), .A0N(n1692), .A1N(
        \string_buffer[14][6] ), .Y(n1130) );
  OAI2BB2XL U2055 ( .B0(n1760), .B1(n1692), .A0N(n1692), .A1N(
        \string_buffer[14][4] ), .Y(n1132) );
  OAI2BB2XL U2056 ( .B0(n1775), .B1(n1692), .A0N(n1692), .A1N(
        \string_buffer[14][3] ), .Y(n1133) );
  OAI2BB2XL U2057 ( .B0(n1754), .B1(n1691), .A0N(n1691), .A1N(
        \string_buffer[15][7] ), .Y(n1137) );
  OAI2BB2XL U2058 ( .B0(n1756), .B1(n1691), .A0N(n1691), .A1N(
        \string_buffer[15][6] ), .Y(n1138) );
  OAI2BB2XL U2059 ( .B0(n1760), .B1(n1691), .A0N(n1691), .A1N(
        \string_buffer[15][4] ), .Y(n1140) );
  OAI2BB2XL U2060 ( .B0(n1775), .B1(n1691), .A0N(n1691), .A1N(
        \string_buffer[15][3] ), .Y(n1141) );
  OAI2BB2XL U2061 ( .B0(n1758), .B1(n1674), .A0N(n1674), .A1N(
        \pattern_buffer[0][5] ), .Y(n1275) );
  OAI2BB2XL U2062 ( .B0(n1754), .B1(n1690), .A0N(n1690), .A1N(
        \string_buffer[16][7] ), .Y(n1145) );
  OAI2BB2XL U2063 ( .B0(n1756), .B1(n1690), .A0N(n1690), .A1N(
        \string_buffer[16][6] ), .Y(n1146) );
  OAI2BB2XL U2064 ( .B0(n1760), .B1(n1690), .A0N(n1690), .A1N(
        \string_buffer[16][4] ), .Y(n1148) );
  OAI2BB2XL U2065 ( .B0(n1775), .B1(n1690), .A0N(n1690), .A1N(
        \string_buffer[16][3] ), .Y(n1149) );
  OAI2BB2XL U2066 ( .B0(n1754), .B1(n1689), .A0N(n1689), .A1N(
        \string_buffer[17][7] ), .Y(n1153) );
  OAI2BB2XL U2067 ( .B0(n1756), .B1(n1689), .A0N(n1689), .A1N(
        \string_buffer[17][6] ), .Y(n1154) );
  OAI2BB2XL U2068 ( .B0(n1760), .B1(n1689), .A0N(n1689), .A1N(
        \string_buffer[17][4] ), .Y(n1156) );
  OAI2BB2XL U2069 ( .B0(n1775), .B1(n1689), .A0N(n1689), .A1N(
        \string_buffer[17][3] ), .Y(n1157) );
  OAI2BB2XL U2070 ( .B0(n1754), .B1(n1688), .A0N(n1688), .A1N(
        \string_buffer[18][7] ), .Y(n1161) );
  OAI2BB2XL U2071 ( .B0(n1756), .B1(n1688), .A0N(n1688), .A1N(
        \string_buffer[18][6] ), .Y(n1162) );
  OAI2BB2XL U2072 ( .B0(n1760), .B1(n1688), .A0N(n1688), .A1N(
        \string_buffer[18][4] ), .Y(n1164) );
  OAI2BB2XL U2073 ( .B0(n1762), .B1(n1688), .A0N(n1688), .A1N(
        \string_buffer[18][3] ), .Y(n1165) );
  OAI2BB2XL U2074 ( .B0(n1754), .B1(n1687), .A0N(n1687), .A1N(
        \string_buffer[19][7] ), .Y(n1169) );
  OAI2BB2XL U2075 ( .B0(n1756), .B1(n1687), .A0N(n1687), .A1N(
        \string_buffer[19][6] ), .Y(n1170) );
  OAI2BB2XL U2076 ( .B0(n1760), .B1(n1687), .A0N(n1687), .A1N(
        \string_buffer[19][4] ), .Y(n1172) );
  OAI2BB2XL U2077 ( .B0(n1763), .B1(n1687), .A0N(n1687), .A1N(
        \string_buffer[19][3] ), .Y(n1173) );
  OAI2BB2XL U2078 ( .B0(n1754), .B1(n1686), .A0N(n1686), .A1N(
        \string_buffer[20][7] ), .Y(n1177) );
  OAI2BB2XL U2079 ( .B0(n1756), .B1(n1686), .A0N(n1686), .A1N(
        \string_buffer[20][6] ), .Y(n1178) );
  OAI2BB2XL U2080 ( .B0(n1760), .B1(n1686), .A0N(n1686), .A1N(
        \string_buffer[20][4] ), .Y(n1180) );
  OAI2BB2XL U2081 ( .B0(n1762), .B1(n1686), .A0N(n1686), .A1N(
        \string_buffer[20][3] ), .Y(n1181) );
  OAI2BB2XL U2082 ( .B0(n1754), .B1(n1685), .A0N(n1685), .A1N(
        \string_buffer[21][7] ), .Y(n1185) );
  OAI2BB2XL U2083 ( .B0(n1756), .B1(n1685), .A0N(n1685), .A1N(
        \string_buffer[21][6] ), .Y(n1186) );
  OAI2BB2XL U2084 ( .B0(n1760), .B1(n1685), .A0N(n1685), .A1N(
        \string_buffer[21][4] ), .Y(n1188) );
  OAI2BB2XL U2085 ( .B0(n1763), .B1(n1685), .A0N(n1685), .A1N(
        \string_buffer[21][3] ), .Y(n1189) );
  OAI2BB2XL U2086 ( .B0(n1754), .B1(n1684), .A0N(n1684), .A1N(
        \string_buffer[22][7] ), .Y(n1193) );
  OAI2BB2XL U2087 ( .B0(n1756), .B1(n1684), .A0N(n1684), .A1N(
        \string_buffer[22][6] ), .Y(n1194) );
  OAI2BB2XL U2088 ( .B0(n1760), .B1(n1684), .A0N(n1684), .A1N(
        \string_buffer[22][4] ), .Y(n1196) );
  OAI2BB2XL U2089 ( .B0(n1763), .B1(n1684), .A0N(n1684), .A1N(
        \string_buffer[22][3] ), .Y(n1197) );
  OAI2BB2XL U2090 ( .B0(n1754), .B1(n1683), .A0N(n1683), .A1N(
        \string_buffer[23][7] ), .Y(n1201) );
  OAI2BB2XL U2091 ( .B0(n1756), .B1(n1683), .A0N(n1683), .A1N(
        \string_buffer[23][6] ), .Y(n1202) );
  OAI2BB2XL U2092 ( .B0(n1760), .B1(n1683), .A0N(n1683), .A1N(
        \string_buffer[23][4] ), .Y(n1204) );
  OAI2BB2XL U2093 ( .B0(n1763), .B1(n1683), .A0N(n1683), .A1N(
        \string_buffer[23][3] ), .Y(n1205) );
  OAI2BB2XL U2094 ( .B0(n1754), .B1(n1682), .A0N(n1682), .A1N(
        \string_buffer[24][7] ), .Y(n1209) );
  OAI2BB2XL U2095 ( .B0(n1756), .B1(n1682), .A0N(n1682), .A1N(
        \string_buffer[24][6] ), .Y(n1210) );
  OAI2BB2XL U2096 ( .B0(n1760), .B1(n1682), .A0N(n1682), .A1N(
        \string_buffer[24][4] ), .Y(n1212) );
  OAI2BB2XL U2097 ( .B0(n1763), .B1(n1682), .A0N(n1682), .A1N(
        \string_buffer[24][3] ), .Y(n1213) );
  OAI2BB2XL U2098 ( .B0(n1755), .B1(n1681), .A0N(n1681), .A1N(
        \string_buffer[25][7] ), .Y(n1217) );
  OAI2BB2XL U2099 ( .B0(n1757), .B1(n1681), .A0N(n1681), .A1N(
        \string_buffer[25][6] ), .Y(n1218) );
  OAI2BB2XL U2100 ( .B0(n1761), .B1(n1681), .A0N(n1681), .A1N(
        \string_buffer[25][4] ), .Y(n1220) );
  OAI2BB2XL U2101 ( .B0(n1763), .B1(n1681), .A0N(n1681), .A1N(
        \string_buffer[25][3] ), .Y(n1221) );
  OAI2BB2XL U2102 ( .B0(n1771), .B1(n1680), .A0N(n1680), .A1N(
        \string_buffer[26][7] ), .Y(n1225) );
  OAI2BB2XL U2103 ( .B0(n1772), .B1(n1680), .A0N(n1680), .A1N(
        \string_buffer[26][6] ), .Y(n1226) );
  OAI2BB2XL U2104 ( .B0(n1774), .B1(n1680), .A0N(n1680), .A1N(
        \string_buffer[26][4] ), .Y(n1228) );
  OAI2BB2XL U2105 ( .B0(n1763), .B1(n1680), .A0N(n1680), .A1N(
        \string_buffer[26][3] ), .Y(n1229) );
  OAI2BB2XL U2106 ( .B0(n1771), .B1(n1679), .A0N(n1679), .A1N(
        \string_buffer[27][7] ), .Y(n1233) );
  OAI2BB2XL U2107 ( .B0(n1772), .B1(n1679), .A0N(n1679), .A1N(
        \string_buffer[27][6] ), .Y(n1234) );
  OAI2BB2XL U2108 ( .B0(n1774), .B1(n1679), .A0N(n1679), .A1N(
        \string_buffer[27][4] ), .Y(n1236) );
  OAI2BB2XL U2109 ( .B0(n1763), .B1(n1679), .A0N(n1679), .A1N(
        \string_buffer[27][3] ), .Y(n1237) );
  OAI2BB2XL U2110 ( .B0(n1771), .B1(n1678), .A0N(n1678), .A1N(
        \string_buffer[28][7] ), .Y(n1241) );
  OAI2BB2XL U2111 ( .B0(n1772), .B1(n1678), .A0N(n1678), .A1N(
        \string_buffer[28][6] ), .Y(n1242) );
  OAI2BB2XL U2112 ( .B0(n1774), .B1(n1678), .A0N(n1678), .A1N(
        \string_buffer[28][4] ), .Y(n1244) );
  OAI2BB2XL U2113 ( .B0(n1763), .B1(n1678), .A0N(n1678), .A1N(
        \string_buffer[28][3] ), .Y(n1245) );
  OAI2BB2XL U2114 ( .B0(n1771), .B1(n1677), .A0N(n1677), .A1N(
        \string_buffer[29][7] ), .Y(n1249) );
  OAI2BB2XL U2115 ( .B0(n1772), .B1(n1677), .A0N(n1677), .A1N(
        \string_buffer[29][6] ), .Y(n1250) );
  OAI2BB2XL U2116 ( .B0(n1774), .B1(n1677), .A0N(n1677), .A1N(
        \string_buffer[29][4] ), .Y(n1252) );
  OAI2BB2XL U2117 ( .B0(n1762), .B1(n1677), .A0N(n1677), .A1N(
        \string_buffer[29][3] ), .Y(n1253) );
  OAI2BB2XL U2118 ( .B0(n1771), .B1(n1676), .A0N(n1676), .A1N(
        \string_buffer[30][7] ), .Y(n1257) );
  OAI2BB2XL U2119 ( .B0(n1772), .B1(n1676), .A0N(n1676), .A1N(
        \string_buffer[30][6] ), .Y(n1258) );
  OAI2BB2XL U2120 ( .B0(n1774), .B1(n1676), .A0N(n1676), .A1N(
        \string_buffer[30][4] ), .Y(n1260) );
  OAI2BB2XL U2121 ( .B0(n1763), .B1(n1676), .A0N(n1676), .A1N(
        \string_buffer[30][3] ), .Y(n1261) );
  OAI2BB2XL U2122 ( .B0(n1754), .B1(n1675), .A0N(n1675), .A1N(
        \string_buffer[31][7] ), .Y(n1265) );
  OAI2BB2XL U2123 ( .B0(n1756), .B1(n1675), .A0N(n1675), .A1N(
        \string_buffer[31][6] ), .Y(n1266) );
  OAI2BB2XL U2124 ( .B0(n1760), .B1(n1675), .A0N(n1675), .A1N(
        \string_buffer[31][4] ), .Y(n1268) );
  OAI2BB2XL U2125 ( .B0(n1763), .B1(n1675), .A0N(n1675), .A1N(
        \string_buffer[31][3] ), .Y(n1269) );
  NOR2X2 U2126 ( .A(ispattern), .B(isstring), .Y(n146) );
  OAI22XL U2127 ( .A0(n1565), .A1(n147), .B0(n961), .B1(n148), .Y(n1003) );
  OAI22XL U2128 ( .A0(n1564), .A1(n147), .B0(n964), .B1(n148), .Y(n1000) );
  OAI22XL U2129 ( .A0(n992), .A1(n147), .B0(n965), .B1(n148), .Y(n999) );
  OAI22XL U2130 ( .A0(n1562), .A1(n147), .B0(n962), .B1(n148), .Y(n1002) );
  OAI22XL U2131 ( .A0(n1563), .A1(n147), .B0(n963), .B1(n148), .Y(n1001) );
  AO22X1 U2132 ( .A0(\match_controller/N289 ), .A1(n154), .B0(n155), .B1(
        \match_controller/N254 ), .Y(n1006) );
  AO22X1 U2133 ( .A0(n1565), .A1(n154), .B0(n155), .B1(\match_controller/N250 ), .Y(n1009) );
  AO22X1 U2134 ( .A0(\read_chardata/temp_read_pattern_count [0]), .A1(n940), 
        .B0(n954), .B1(n966), .Y(n1342) );
  OAI22XL U2135 ( .A0(n981), .A1(n140), .B0(\match_controller/N247 ), .B1(n142), .Y(n998) );
  OAI22XL U2136 ( .A0(n983), .A1(n140), .B0(n141), .B1(n142), .Y(n996) );
  OAI22XL U2137 ( .A0(n982), .A1(n140), .B0(n143), .B1(n142), .Y(n997) );
  OAI31XL U2138 ( .A0(n1371), .A1(n959), .A2(n1818), .B0(n139), .Y(n975) );
  OAI21XL U2139 ( .A0(n959), .A1(n1811), .B0(n1371), .Y(n139) );
  OAI32X1 U2140 ( .A0(n1822), .A1(ispattern), .A2(n221), .B0(
        \read_chardata/temp_read_pattern_count [0]), .B1(n1818), .Y(n1343) );
  OAI2BB2XL U2141 ( .B0(n1824), .B1(n953), .A0N(\read_chardata/N111 ), .A1N(
        isstring), .Y(n1339) );
  OAI2BB2XL U2142 ( .B0(\read_chardata/N110 ), .B1(n953), .A0N(
        \read_chardata/N110 ), .A1N(isstring), .Y(n1340) );
  OAI2BB2XL U2143 ( .B0(n1825), .B1(n953), .A0N(\read_chardata/N112 ), .A1N(
        isstring), .Y(n1338) );
  OAI2BB2XL U2144 ( .B0(n1367), .B1(n953), .A0N(\read_chardata/N113 ), .A1N(
        isstring), .Y(n1337) );
  OAI2BB2XL U2145 ( .B0(n1368), .B1(n953), .A0N(\read_chardata/N114 ), .A1N(
        isstring), .Y(n1341) );
  OAI22XL U2146 ( .A0(n1818), .A1(n1823), .B0(n1661), .B1(ispattern), .Y(n972)
         );
  OAI22XL U2147 ( .A0(n1818), .A1(n1822), .B0(n1663), .B1(ispattern), .Y(n974)
         );
  AO21X1 U2148 ( .A0(n1811), .A1(read_string_count[4]), .B0(n131), .Y(n967) );
  OAI2BB2XL U2149 ( .B0(n1811), .B1(n1367), .A0N(n1811), .A1N(
        read_string_count[3]), .Y(n968) );
  AO22X1 U2150 ( .A0(isstring), .A1(\read_chardata/temp_read_string_count [0]), 
        .B0(n1811), .B1(read_string_count[0]), .Y(n971) );
  AO22X1 U2151 ( .A0(isstring), .A1(\read_chardata/temp_read_string_count [1]), 
        .B0(n1811), .B1(read_string_count[1]), .Y(n970) );
  AO22X1 U2152 ( .A0(isstring), .A1(\read_chardata/temp_read_string_count [2]), 
        .B0(n1811), .B1(read_string_count[2]), .Y(n969) );
  OAI22XL U2153 ( .A0(n956), .A1(n1811), .B0(ispattern), .B1(n957), .Y(
        \fsm/next_state[0] ) );
  NOR2X1 U2154 ( .A(n1371), .B(n1351), .Y(n957) );
  OA21XL U2155 ( .A0(n1351), .A1(n1371), .B0(n1821), .Y(n956) );
  OAI22XL U2156 ( .A0(n1619), .A1(n377), .B0(n1663), .B1(n378), .Y(n376) );
  CLKBUFX3 U2157 ( .A(n1612), .Y(n1623) );
  OAI22XL U2158 ( .A0(n1618), .A1(n377), .B0(n1661), .B1(n378), .Y(n380) );
  OAI22XL U2159 ( .A0(n1620), .A1(n377), .B0(n1662), .B1(n378), .Y(n382) );
  NAND3X1 U2160 ( .A(n214), .B(n166), .C(n215), .Y(n149) );
  AOI32X1 U2161 ( .A0(n2009), .A1(n216), .A2(n212), .B0(n217), .B1(n120), .Y(
        n215) );
  CLKBUFX3 U2162 ( .A(n1611), .Y(n1624) );
  NOR2X1 U2163 ( .A(\match_controller/N248 ), .B(\match_controller/N249 ), .Y(
        n1611) );
  OAI22XL U2164 ( .A0(n1663), .A1(n377), .B0(n1619), .B1(n378), .Y(n375) );
  OAI22XL U2165 ( .A0(n1661), .A1(n377), .B0(n1618), .B1(n378), .Y(n379) );
  OAI22XL U2166 ( .A0(n1662), .A1(n377), .B0(n1620), .B1(n378), .Y(n381) );
  OAI222XL U2167 ( .A0(n1618), .A1(n151), .B0(n141), .B1(n152), .C0(n983), 
        .C1(n153), .Y(n1004) );
  OAI222XL U2168 ( .A0(n1619), .A1(n151), .B0(\match_controller/N247 ), .B1(
        n152), .C0(n981), .C1(n153), .Y(n1005) );
  OAI222XL U2169 ( .A0(n1620), .A1(n151), .B0(n143), .B1(n152), .C0(n982), 
        .C1(n153), .Y(n1011) );
  NAND4BX1 U2170 ( .AN(n192), .B(n193), .C(n194), .D(n195), .Y(n191) );
  OAI222XL U2171 ( .A0(n210), .A1(n1998), .B0(n182), .B1(n212), .C0(n213), 
        .C1(n987), .Y(n192) );
  AOI211X1 U2172 ( .A0(n196), .A1(n189), .B0(n197), .C0(n198), .Y(n195) );
  NAND2X1 U2173 ( .A(n208), .B(n209), .Y(n196) );
  NOR2X1 U2174 ( .A(n217), .B(n252), .Y(n208) );
  CLKBUFX3 U2175 ( .A(n1615), .Y(n1621) );
  NOR2X1 U2176 ( .A(n1618), .B(\match_controller/N248 ), .Y(n1615) );
  NAND2BX1 U2177 ( .AN(n960), .B(n191), .Y(n153) );
  OAI21XL U2178 ( .A0(n985), .A1(n221), .B0(n280), .Y(n1014) );
  OAI31XL U2179 ( .A0(n281), .A1(n282), .A2(n283), .B0(n221), .Y(n280) );
  NAND4X1 U2180 ( .A(n1996), .B(n272), .C(n273), .D(n209), .Y(n281) );
  OAI22XL U2181 ( .A0(n288), .A1(n202), .B0(n2009), .B1(n289), .Y(n282) );
  OAI22XL U2182 ( .A0(n984), .A1(n221), .B0(n292), .B1(n1821), .Y(n1015) );
  NOR4BX1 U2183 ( .AN(n286), .B(n293), .C(n294), .D(n256), .Y(n292) );
  OAI22XL U2184 ( .A0(n1998), .A1(n210), .B0(n370), .B1(n290), .Y(n294) );
  NAND4X1 U2185 ( .A(n272), .B(n247), .C(n389), .D(n390), .Y(n293) );
  OAI22XL U2186 ( .A0(n986), .A1(n221), .B0(n266), .B1(n1821), .Y(n1013) );
  AOI211X1 U2187 ( .A0(n267), .A1(n216), .B0(n268), .C0(n269), .Y(n266) );
  NAND2X1 U2188 ( .A(n278), .B(n190), .Y(n268) );
  CLKINVX1 U2189 ( .A(n214), .Y(n269) );
  OAI22XL U2190 ( .A0(n987), .A1(n221), .B0(n222), .B1(n1821), .Y(n1012) );
  NOR4X1 U2191 ( .A(n224), .B(n225), .C(n226), .D(n227), .Y(n222) );
  NOR3X1 U2192 ( .A(n244), .B(n1827), .C(n1847), .Y(n226) );
  OAI33X1 U2193 ( .A0(n219), .A1(n209), .A2(n220), .B0(n228), .B1(n1830), .B2(
        n230), .Y(n227) );
  OAI211X1 U2194 ( .A0(n249), .A1(n250), .B0(n193), .C0(n251), .Y(n224) );
  AOI222XL U2195 ( .A0(n252), .A1(n120), .B0(n253), .B1(n254), .C0(n1995), 
        .C1(n255), .Y(n251) );
  OAI21XL U2196 ( .A0(n2009), .A1(n1819), .B0(n259), .Y(n254) );
  NAND4BBXL U2197 ( .AN(n256), .BN(n257), .C(n258), .D(n259), .Y(n255) );
  NAND4X1 U2198 ( .A(\match_controller/N260 ), .B(\match_controller/N257 ), 
        .C(n655), .D(n656), .Y(n250) );
  NOR2X1 U2199 ( .A(\match_controller/N256 ), .B(\match_controller/N255 ), .Y(
        n655) );
  NOR4X1 U2200 ( .A(\match_controller/N262 ), .B(\match_controller/N261 ), .C(
        \match_controller/N259 ), .D(\match_controller/N258 ), .Y(n656) );
  CLKBUFX3 U2201 ( .A(n1655), .Y(n1666) );
  NOR2X1 U2202 ( .A(n1662), .B(\match_controller/N246 ), .Y(n1655) );
  CLKBUFX3 U2203 ( .A(n1654), .Y(n1667) );
  NOR2X1 U2204 ( .A(\match_controller/N245 ), .B(\match_controller/N246 ), .Y(
        n1654) );
  CLKBUFX3 U2205 ( .A(n1658), .Y(n1664) );
  NOR2X1 U2206 ( .A(n1661), .B(\match_controller/N245 ), .Y(n1658) );
  NOR3X2 U2207 ( .A(n1564), .B(n1565), .C(\match_controller/N251 ), .Y(n651)
         );
  NOR3X2 U2208 ( .A(n992), .B(n1565), .C(\match_controller/N252 ), .Y(n647) );
  NOR3X2 U2209 ( .A(\match_controller/N251 ), .B(n1565), .C(
        \match_controller/N252 ), .Y(n643) );
  NOR3X2 U2210 ( .A(\match_controller/N251 ), .B(n1564), .C(
        \match_controller/N250 ), .Y(n650) );
  NOR3X2 U2211 ( .A(\match_controller/N250 ), .B(n992), .C(
        \match_controller/N252 ), .Y(n646) );
  AND4X1 U2212 ( .A(n1926), .B(n1927), .C(n1925), .D(n730), .Y(n626) );
  NOR4X1 U2213 ( .A(\string_buffer[15][7] ), .B(\string_buffer[15][6] ), .C(
        \string_buffer[15][4] ), .D(\string_buffer[15][3] ), .Y(n730) );
  AND4X1 U2214 ( .A(n1922), .B(n1923), .C(n1921), .D(n734), .Y(n625) );
  NOR4X1 U2215 ( .A(\string_buffer[16][7] ), .B(\string_buffer[16][6] ), .C(
        \string_buffer[16][4] ), .D(\string_buffer[16][3] ), .Y(n734) );
  AND4X1 U2216 ( .A(n1894), .B(n1895), .C(n1893), .D(n694), .Y(n639) );
  NOR4X1 U2217 ( .A(\string_buffer[23][7] ), .B(\string_buffer[23][6] ), .C(
        \string_buffer[23][4] ), .D(\string_buffer[23][3] ), .Y(n694) );
  AND4X1 U2218 ( .A(n1950), .B(n1951), .C(n1949), .D(n758), .Y(n628) );
  NOR4X1 U2219 ( .A(\string_buffer[9][7] ), .B(\string_buffer[9][6] ), .C(
        \string_buffer[9][4] ), .D(\string_buffer[9][3] ), .Y(n758) );
  AND4X1 U2220 ( .A(n1890), .B(n1891), .C(n1889), .D(n698), .Y(n638) );
  NOR4X1 U2221 ( .A(\string_buffer[24][7] ), .B(\string_buffer[24][6] ), .C(
        \string_buffer[24][4] ), .D(\string_buffer[24][3] ), .Y(n698) );
  AND4X1 U2222 ( .A(n1946), .B(n1947), .C(n1945), .D(n762), .Y(n627) );
  NOR4X1 U2223 ( .A(\string_buffer[10][7] ), .B(\string_buffer[10][6] ), .C(
        \string_buffer[10][4] ), .D(\string_buffer[10][3] ), .Y(n762) );
  AND4X1 U2224 ( .A(n1918), .B(n1919), .C(n1917), .D(n722), .Y(n641) );
  NOR4X1 U2225 ( .A(\string_buffer[17][7] ), .B(\string_buffer[17][6] ), .C(
        \string_buffer[17][4] ), .D(\string_buffer[17][3] ), .Y(n722) );
  AND4X1 U2226 ( .A(n1914), .B(n1915), .C(n1913), .D(n726), .Y(n640) );
  NOR4X1 U2227 ( .A(\string_buffer[18][7] ), .B(\string_buffer[18][6] ), .C(
        \string_buffer[18][4] ), .D(\string_buffer[18][3] ), .Y(n726) );
  AND4X1 U2228 ( .A(n1942), .B(n1943), .C(n1941), .D(n750), .Y(n630) );
  NOR4X1 U2229 ( .A(\string_buffer[11][7] ), .B(\string_buffer[11][6] ), .C(
        \string_buffer[11][4] ), .D(\string_buffer[11][3] ), .Y(n750) );
  AND4X1 U2230 ( .A(n1938), .B(n1939), .C(n1937), .D(n754), .Y(n629) );
  NOR4X1 U2231 ( .A(\string_buffer[12][7] ), .B(\string_buffer[12][6] ), .C(
        \string_buffer[12][4] ), .D(\string_buffer[12][3] ), .Y(n754) );
  AND4X1 U2232 ( .A(n1910), .B(n1911), .C(n1909), .D(n714), .Y(n645) );
  NOR4X1 U2233 ( .A(\string_buffer[19][7] ), .B(\string_buffer[19][6] ), .C(
        \string_buffer[19][4] ), .D(\string_buffer[19][3] ), .Y(n714) );
  AND4X1 U2234 ( .A(n1906), .B(n1907), .C(n1905), .D(n718), .Y(n644) );
  NOR4X1 U2235 ( .A(\string_buffer[20][7] ), .B(\string_buffer[20][6] ), .C(
        \string_buffer[20][4] ), .D(\string_buffer[20][3] ), .Y(n718) );
  AND4X1 U2236 ( .A(n1934), .B(n1935), .C(n1933), .D(n742), .Y(n632) );
  NOR4X1 U2237 ( .A(\string_buffer[13][7] ), .B(\string_buffer[13][6] ), .C(
        \string_buffer[13][4] ), .D(\string_buffer[13][3] ), .Y(n742) );
  AND4X1 U2238 ( .A(n1930), .B(n1931), .C(n1929), .D(n746), .Y(n631) );
  NOR4X1 U2239 ( .A(\string_buffer[14][7] ), .B(\string_buffer[14][6] ), .C(
        \string_buffer[14][4] ), .D(\string_buffer[14][3] ), .Y(n746) );
  AND4X1 U2240 ( .A(n1902), .B(n1903), .C(n1901), .D(n706), .Y(n649) );
  NOR4X1 U2241 ( .A(\string_buffer[21][7] ), .B(\string_buffer[21][6] ), .C(
        \string_buffer[21][4] ), .D(\string_buffer[21][3] ), .Y(n706) );
  AND4X1 U2242 ( .A(n1898), .B(n1899), .C(n1897), .D(n710), .Y(n648) );
  NOR4X1 U2243 ( .A(\string_buffer[22][7] ), .B(\string_buffer[22][6] ), .C(
        \string_buffer[22][4] ), .D(\string_buffer[22][3] ), .Y(n710) );
  AND4X1 U2244 ( .A(n1978), .B(n1979), .C(n1977), .D(n798), .Y(n515) );
  NOR4X1 U2245 ( .A(\string_buffer[2][7] ), .B(\string_buffer[2][6] ), .C(
        \string_buffer[2][4] ), .D(\string_buffer[2][3] ), .Y(n798) );
  AND4X1 U2246 ( .A(n1958), .B(n1959), .C(n1957), .D(n766), .Y(n513) );
  NOR4X1 U2247 ( .A(\string_buffer[7][7] ), .B(\string_buffer[7][6] ), .C(
        \string_buffer[7][4] ), .D(\string_buffer[7][3] ), .Y(n766) );
  AND4X1 U2248 ( .A(n1954), .B(n1955), .C(n1953), .D(n770), .Y(n517) );
  NOR4X1 U2249 ( .A(\string_buffer[8][7] ), .B(\string_buffer[8][6] ), .C(
        \string_buffer[8][4] ), .D(\string_buffer[8][3] ), .Y(n770) );
  AND4X1 U2250 ( .A(n1974), .B(n1975), .C(n1973), .D(n786), .Y(n507) );
  NOR4X1 U2251 ( .A(\string_buffer[3][7] ), .B(\string_buffer[3][6] ), .C(
        \string_buffer[3][4] ), .D(\string_buffer[3][3] ), .Y(n786) );
  AND4X1 U2252 ( .A(n1970), .B(n1971), .C(n1969), .D(n790), .Y(n505) );
  NOR4X1 U2253 ( .A(\string_buffer[4][7] ), .B(\string_buffer[4][6] ), .C(
        \string_buffer[4][4] ), .D(\string_buffer[4][3] ), .Y(n790) );
  AND4X1 U2254 ( .A(n1966), .B(n1967), .C(n1965), .D(n778), .Y(n511) );
  NOR4X1 U2255 ( .A(\string_buffer[5][7] ), .B(\string_buffer[5][6] ), .C(
        \string_buffer[5][4] ), .D(\string_buffer[5][3] ), .Y(n778) );
  AND4X1 U2256 ( .A(n1962), .B(n1963), .C(n1961), .D(n782), .Y(n509) );
  NOR4X1 U2257 ( .A(\string_buffer[6][7] ), .B(\string_buffer[6][6] ), .C(
        \string_buffer[6][4] ), .D(\string_buffer[6][3] ), .Y(n782) );
  AND4X1 U2258 ( .A(n1874), .B(n1875), .C(n1873), .D(n682), .Y(n610) );
  NOR4X1 U2259 ( .A(\string_buffer[28][7] ), .B(\string_buffer[28][6] ), .C(
        \string_buffer[28][4] ), .D(\string_buffer[28][3] ), .Y(n682) );
  AND4X1 U2260 ( .A(n1870), .B(n1871), .C(n1869), .D(n670), .Y(n613) );
  NOR4X1 U2261 ( .A(\string_buffer[29][7] ), .B(\string_buffer[29][6] ), .C(
        \string_buffer[29][4] ), .D(\string_buffer[29][3] ), .Y(n670) );
  AND4X1 U2262 ( .A(n1886), .B(n1887), .C(n1885), .D(n686), .Y(n608) );
  NOR4X1 U2263 ( .A(\string_buffer[25][7] ), .B(\string_buffer[25][6] ), .C(
        \string_buffer[25][4] ), .D(\string_buffer[25][3] ), .Y(n686) );
  AND4X1 U2264 ( .A(n1866), .B(n1867), .C(n1865), .D(n674), .Y(n612) );
  NOR4X1 U2265 ( .A(\string_buffer[30][7] ), .B(\string_buffer[30][6] ), .C(
        \string_buffer[30][4] ), .D(\string_buffer[30][3] ), .Y(n674) );
  AND4X1 U2266 ( .A(n1882), .B(n1883), .C(n1881), .D(n690), .Y(n611) );
  NOR4X1 U2267 ( .A(\string_buffer[26][7] ), .B(\string_buffer[26][6] ), .C(
        \string_buffer[26][4] ), .D(\string_buffer[26][3] ), .Y(n690) );
  AND4X1 U2268 ( .A(n1878), .B(n1879), .C(n1877), .D(n678), .Y(n614) );
  NOR4X1 U2269 ( .A(\string_buffer[27][7] ), .B(\string_buffer[27][6] ), .C(
        \string_buffer[27][4] ), .D(\string_buffer[27][3] ), .Y(n678) );
  NOR2X1 U2270 ( .A(n846), .B(n847), .Y(n844) );
  XNOR2X1 U2271 ( .A(read_string_count[2]), .B(\match_controller/N252 ), .Y(
        n842) );
  XNOR2X1 U2272 ( .A(read_string_count[1]), .B(\match_controller/N251 ), .Y(
        n843) );
  XNOR2X1 U2273 ( .A(read_string_count[0]), .B(\match_controller/N250 ), .Y(
        n845) );
  AND4X1 U2274 ( .A(n1982), .B(n1983), .C(n1981), .D(n794), .Y(n619) );
  NOR4X1 U2275 ( .A(\string_buffer[1][7] ), .B(\string_buffer[1][6] ), .C(
        \string_buffer[1][4] ), .D(\string_buffer[1][3] ), .Y(n794) );
  NOR4X1 U2276 ( .A(\string_buffer[31][7] ), .B(\string_buffer[31][6] ), .C(
        \string_buffer[31][4] ), .D(\string_buffer[31][3] ), .Y(n527) );
  XNOR2X1 U2277 ( .A(\pattern_buffer[1][1] ), .B(n1854), .Y(n833) );
  XNOR2X1 U2278 ( .A(\pattern_buffer[1][5] ), .B(n1860), .Y(n839) );
  XNOR2X1 U2279 ( .A(read_string_count[4]), .B(n1562), .Y(n847) );
  XNOR2X1 U2280 ( .A(read_string_count[3]), .B(n1563), .Y(n846) );
  NAND3X1 U2281 ( .A(n369), .B(n1348), .C(n984), .Y(n209) );
  CLKINVX1 U2282 ( .A(n217), .Y(n248) );
  CLKINVX1 U2283 ( .A(n252), .Y(n273) );
  OAI21XL U2284 ( .A0(n799), .A1(n557), .B0(n800), .Y(n771) );
  NOR4X1 U2285 ( .A(n823), .B(\string_buffer[0][0] ), .C(\string_buffer[0][2] ), .D(\string_buffer[0][1] ), .Y(n799) );
  NAND4X1 U2286 ( .A(n801), .B(n802), .C(n803), .D(n804), .Y(n800) );
  NAND4X1 U2287 ( .A(n1985), .B(n1986), .C(n1988), .D(n1989), .Y(n823) );
  NAND2X1 U2288 ( .A(n327), .B(n328), .Y(n303) );
  AOI222XL U2289 ( .A0(\pattern_buffer[4][6] ), .A1(n324), .B0(
        \pattern_buffer[5][6] ), .B1(n325), .C0(\pattern_buffer[7][6] ), .C1(
        n326), .Y(n327) );
  AOI221XL U2290 ( .A0(\pattern_buffer[3][6] ), .A1(n2004), .B0(
        \pattern_buffer[2][6] ), .B1(n318), .C0(n329), .Y(n328) );
  OAI22XL U2291 ( .A0(n320), .A1(n1356), .B0(n2001), .B1(n1844), .Y(n329) );
  NAND2X1 U2292 ( .A(n332), .B(n333), .Y(n304) );
  AOI222XL U2293 ( .A0(\pattern_buffer[4][7] ), .A1(n324), .B0(
        \pattern_buffer[5][7] ), .B1(n325), .C0(\pattern_buffer[7][7] ), .C1(
        n326), .Y(n332) );
  AOI221XL U2294 ( .A0(\pattern_buffer[3][7] ), .A1(n2004), .B0(
        \pattern_buffer[2][7] ), .B1(n318), .C0(n334), .Y(n333) );
  OAI22XL U2295 ( .A0(n320), .A1(n1358), .B0(n2001), .B1(n1845), .Y(n334) );
  NAND2X1 U2296 ( .A(n337), .B(n338), .Y(n305) );
  AOI222XL U2297 ( .A0(\pattern_buffer[4][4] ), .A1(n324), .B0(
        \pattern_buffer[5][4] ), .B1(n325), .C0(\pattern_buffer[7][4] ), .C1(
        n326), .Y(n337) );
  AOI221XL U2298 ( .A0(\pattern_buffer[3][4] ), .A1(n2004), .B0(
        \pattern_buffer[2][4] ), .B1(n318), .C0(n339), .Y(n338) );
  OAI22XL U2299 ( .A0(n320), .A1(n1355), .B0(n2001), .B1(n1843), .Y(n339) );
  NAND2X1 U2300 ( .A(n315), .B(n316), .Y(n313) );
  AOI222XL U2301 ( .A0(\pattern_buffer[4][0] ), .A1(n324), .B0(
        \pattern_buffer[5][0] ), .B1(n325), .C0(\pattern_buffer[7][0] ), .C1(
        n326), .Y(n315) );
  AOI221XL U2302 ( .A0(\pattern_buffer[3][0] ), .A1(n2004), .B0(
        \pattern_buffer[2][0] ), .B1(n318), .C0(n319), .Y(n316) );
  OAI22XL U2303 ( .A0(n320), .A1(n1354), .B0(n2001), .B1(n1842), .Y(n319) );
  NAND2X1 U2304 ( .A(n355), .B(n356), .Y(n311) );
  AOI222XL U2305 ( .A0(\pattern_buffer[1][2] ), .A1(n150), .B0(
        \pattern_buffer[5][2] ), .B1(n325), .C0(\pattern_buffer[2][2] ), .C1(
        n318), .Y(n355) );
  AOI221XL U2306 ( .A0(\pattern_buffer[7][2] ), .A1(n326), .B0(
        \pattern_buffer[6][2] ), .B1(n2002), .C0(n357), .Y(n356) );
  OAI22XL U2307 ( .A0(n2003), .A1(n1359), .B0(n342), .B1(n1837), .Y(n357) );
  NAND2X1 U2308 ( .A(n350), .B(n351), .Y(n312) );
  AOI222XL U2309 ( .A0(\pattern_buffer[1][3] ), .A1(n150), .B0(
        \pattern_buffer[5][3] ), .B1(n325), .C0(\pattern_buffer[2][3] ), .C1(
        n318), .Y(n350) );
  AOI221XL U2310 ( .A0(\pattern_buffer[7][3] ), .A1(n326), .B0(
        \pattern_buffer[6][3] ), .B1(n2002), .C0(n352), .Y(n351) );
  OAI22XL U2311 ( .A0(n2003), .A1(n1357), .B0(n342), .B1(n1838), .Y(n352) );
  NOR2X1 U2312 ( .A(\match_controller/N247 ), .B(n1620), .Y(n365) );
  NAND2X1 U2313 ( .A(n343), .B(n344), .Y(n306) );
  AOI222XL U2314 ( .A0(\pattern_buffer[1][5] ), .A1(n150), .B0(
        \pattern_buffer[5][5] ), .B1(n325), .C0(\pattern_buffer[2][5] ), .C1(
        n318), .Y(n343) );
  AOI221XL U2315 ( .A0(\pattern_buffer[7][5] ), .A1(n326), .B0(
        \pattern_buffer[6][5] ), .B1(n2002), .C0(n346), .Y(n344) );
  OAI22XL U2316 ( .A0(n2003), .A1(n1361), .B0(n342), .B1(n1839), .Y(n346) );
  NAND2X1 U2317 ( .A(n360), .B(n361), .Y(n314) );
  AOI222XL U2318 ( .A0(\pattern_buffer[1][1] ), .A1(n150), .B0(
        \pattern_buffer[5][1] ), .B1(n325), .C0(\pattern_buffer[2][1] ), .C1(
        n318), .Y(n360) );
  AOI221XL U2319 ( .A0(\pattern_buffer[7][1] ), .A1(n326), .B0(
        \pattern_buffer[6][1] ), .B1(n2002), .C0(n362), .Y(n361) );
  OAI22XL U2320 ( .A0(n2003), .A1(n1360), .B0(n342), .B1(n1836), .Y(n362) );
  NOR3X2 U2321 ( .A(\match_controller/N244 ), .B(n1661), .C(
        \match_controller/N245 ), .Y(n418) );
  NAND2X1 U2322 ( .A(n400), .B(n401), .Y(n241) );
  AOI222XL U2323 ( .A0(n408), .A1(\pattern_buffer[6][1] ), .B0(n409), .B1(
        \pattern_buffer[5][1] ), .C0(n410), .C1(\pattern_buffer[4][1] ), .Y(
        n400) );
  AOI221XL U2324 ( .A0(\pattern_buffer[0][1] ), .A1(n402), .B0(n403), .B1(
        \pattern_buffer[1][1] ), .C0(n404), .Y(n401) );
  OAI22XL U2325 ( .A0(n1363), .A1(n1994), .B0(n1836), .B1(n1991), .Y(n404) );
  NAND2X1 U2326 ( .A(n434), .B(n435), .Y(n240) );
  AOI222XL U2327 ( .A0(n408), .A1(\pattern_buffer[6][5] ), .B0(n409), .B1(
        \pattern_buffer[5][5] ), .C0(n410), .C1(\pattern_buffer[4][5] ), .Y(
        n434) );
  AOI221XL U2328 ( .A0(\pattern_buffer[0][5] ), .A1(n402), .B0(n403), .B1(
        \pattern_buffer[1][5] ), .C0(n436), .Y(n435) );
  OAI22XL U2329 ( .A0(n1366), .A1(n1994), .B0(n1839), .B1(n1991), .Y(n436) );
  NOR3X2 U2330 ( .A(\match_controller/N246 ), .B(n1663), .C(
        \match_controller/N245 ), .Y(n402) );
  AND2X2 U2331 ( .A(n411), .B(n412), .Y(n239) );
  AOI222XL U2332 ( .A0(n417), .A1(\pattern_buffer[2][0] ), .B0(n410), .B1(
        \pattern_buffer[4][0] ), .C0(n418), .C1(\pattern_buffer[3][0] ), .Y(
        n411) );
  AOI221XL U2333 ( .A0(n408), .A1(\pattern_buffer[6][0] ), .B0(n409), .B1(
        \pattern_buffer[5][0] ), .C0(n413), .Y(n412) );
  OAI22XL U2334 ( .A0(n1842), .A1(n1990), .B0(n1993), .B1(n1846), .Y(n413) );
  AND2X2 U2335 ( .A(n438), .B(n439), .Y(n236) );
  AOI222XL U2336 ( .A0(n417), .A1(\pattern_buffer[2][4] ), .B0(n410), .B1(
        \pattern_buffer[4][4] ), .C0(n418), .C1(\pattern_buffer[3][4] ), .Y(
        n438) );
  AOI221XL U2337 ( .A0(n408), .A1(\pattern_buffer[6][4] ), .B0(n409), .B1(
        \pattern_buffer[5][4] ), .C0(n440), .Y(n439) );
  OAI22XL U2338 ( .A0(n1843), .A1(n1990), .B0(n1993), .B1(n1848), .Y(n440) );
  NOR3X2 U2339 ( .A(\match_controller/N244 ), .B(n1662), .C(
        \match_controller/N246 ), .Y(n403) );
  NOR3X2 U2340 ( .A(n1662), .B(n1663), .C(\match_controller/N246 ), .Y(n417)
         );
  NAND2X1 U2341 ( .A(n420), .B(n421), .Y(n242) );
  AOI222XL U2342 ( .A0(n408), .A1(\pattern_buffer[6][3] ), .B0(n409), .B1(
        \pattern_buffer[5][3] ), .C0(n410), .C1(\pattern_buffer[4][3] ), .Y(
        n420) );
  AOI221XL U2343 ( .A0(\pattern_buffer[0][3] ), .A1(n402), .B0(n403), .B1(
        \pattern_buffer[1][3] ), .C0(n422), .Y(n421) );
  OAI22XL U2344 ( .A0(n1364), .A1(n1994), .B0(n1838), .B1(n1991), .Y(n422) );
  AND2X2 U2345 ( .A(n442), .B(n443), .Y(n237) );
  AOI222XL U2346 ( .A0(n417), .A1(\pattern_buffer[2][7] ), .B0(n410), .B1(
        \pattern_buffer[4][7] ), .C0(n418), .C1(\pattern_buffer[3][7] ), .Y(
        n442) );
  AOI221XL U2347 ( .A0(n408), .A1(\pattern_buffer[6][7] ), .B0(n409), .B1(
        \pattern_buffer[5][7] ), .C0(n444), .Y(n443) );
  OAI22XL U2348 ( .A0(n1845), .A1(n1990), .B0(n1993), .B1(n1850), .Y(n444) );
  AND2X2 U2349 ( .A(n446), .B(n447), .Y(n238) );
  AOI222XL U2350 ( .A0(n417), .A1(\pattern_buffer[2][6] ), .B0(n410), .B1(
        \pattern_buffer[4][6] ), .C0(n418), .C1(\pattern_buffer[3][6] ), .Y(
        n446) );
  AOI221XL U2351 ( .A0(n408), .A1(\pattern_buffer[6][6] ), .B0(n409), .B1(
        \pattern_buffer[5][6] ), .C0(n448), .Y(n447) );
  OAI22XL U2352 ( .A0(n1844), .A1(n1990), .B0(n1993), .B1(n1849), .Y(n448) );
  NAND2X1 U2353 ( .A(n425), .B(n426), .Y(n243) );
  AOI222XL U2354 ( .A0(n408), .A1(\pattern_buffer[6][2] ), .B0(n409), .B1(
        \pattern_buffer[5][2] ), .C0(n410), .C1(\pattern_buffer[4][2] ), .Y(
        n425) );
  AOI221XL U2355 ( .A0(\pattern_buffer[0][2] ), .A1(n402), .B0(n403), .B1(
        \pattern_buffer[1][2] ), .C0(n427), .Y(n426) );
  OAI22XL U2356 ( .A0(n1365), .A1(n1994), .B0(n1837), .B1(n1991), .Y(n427) );
  NOR2X1 U2357 ( .A(\match_controller/N248 ), .B(n1618), .Y(n366) );
  AND2X2 U2358 ( .A(n366), .B(n1619), .Y(n325) );
  AOI211X1 U2359 ( .A0(\match_controller/N249 ), .A1(n1619), .B0(n324), .C0(
        n366), .Y(n141) );
  NAND3X1 U2360 ( .A(n452), .B(n453), .C(n454), .Y(n228) );
  AOI2BB2X1 U2361 ( .B0(n455), .B1(\match_controller/N247 ), .A0N(
        \match_controller/N244 ), .A1N(\match_controller/N247 ), .Y(n454) );
  XNOR2X1 U2362 ( .A(n1662), .B(n143), .Y(n452) );
  XNOR2X1 U2363 ( .A(n141), .B(n1661), .Y(n453) );
  AOI2BB1X1 U2364 ( .A0N(n1619), .A1N(\match_controller/N248 ), .B0(n365), .Y(
        n143) );
  AND4X1 U2365 ( .A(\pattern_buffer[1][5] ), .B(\pattern_buffer[1][1] ), .C(
        n840), .D(n841), .Y(n174) );
  NOR4X1 U2366 ( .A(\pattern_buffer[1][7] ), .B(\pattern_buffer[1][6] ), .C(
        \pattern_buffer[1][4] ), .D(\pattern_buffer[1][0] ), .Y(n841) );
  NOR2X1 U2367 ( .A(n1362), .B(n1349), .Y(n840) );
  OAI21XL U2368 ( .A0(n1620), .A1(n1618), .B0(n1663), .Y(n455) );
  NAND2X1 U2369 ( .A(n986), .B(n987), .Y(n210) );
  NAND3BX1 U2370 ( .AN(n210), .B(n985), .C(n1353), .Y(n202) );
  XNOR2X1 U2371 ( .A(n981), .B(n1619), .Y(n185) );
  XNOR2X1 U2372 ( .A(n983), .B(n1618), .Y(n186) );
  XNOR2X1 U2373 ( .A(n982), .B(n1620), .Y(n184) );
  NAND2X1 U2374 ( .A(n457), .B(n458), .Y(n288) );
  NOR4X1 U2375 ( .A(n1370), .B(n1350), .C(n1849), .D(n1848), .Y(n457) );
  NOR4X1 U2376 ( .A(\pattern_buffer[0][7] ), .B(\pattern_buffer[0][5] ), .C(
        \pattern_buffer[0][0] ), .D(n1369), .Y(n458) );
  ADDHXL U2377 ( .A(\read_chardata/temp_read_string_count [1]), .B(
        \read_chardata/temp_read_string_count [0]), .CO(
        \read_chardata/add_192/carry [2]), .S(\read_chardata/N111 ) );
  ADDHXL U2378 ( .A(\read_chardata/temp_read_string_count [2]), .B(
        \read_chardata/add_192/carry [2]), .CO(
        \read_chardata/add_192/carry [3]), .S(\read_chardata/N112 ) );
  ADDHXL U2379 ( .A(\read_chardata/temp_read_string_count [3]), .B(
        \read_chardata/add_192/carry [3]), .CO(
        \read_chardata/add_192/carry [4]), .S(\read_chardata/N113 ) );
  ADDHXL U2380 ( .A(\match_controller/N251 ), .B(\match_controller/N250 ), 
        .CO(\match_controller/add_304/carry [2]), .S(\match_controller/N286 )
         );
  ADDHXL U2381 ( .A(\match_controller/N252 ), .B(
        \match_controller/add_304/carry [2]), .CO(
        \match_controller/add_304/carry [3]), .S(\match_controller/N287 ) );
  ADDHXL U2382 ( .A(\match_controller/N253 ), .B(
        \match_controller/add_304/carry [3]), .CO(
        \match_controller/add_304/carry [4]), .S(\match_controller/N288 ) );
  NOR2X1 U2383 ( .A(n1563), .B(\match_controller/N252 ), .Y(n1378) );
  NOR2X1 U2384 ( .A(n1565), .B(\match_controller/N251 ), .Y(n1385) );
  NOR2X1 U2385 ( .A(\match_controller/N250 ), .B(\match_controller/N251 ), .Y(
        n1386) );
  OAI22XL U2386 ( .A0(\string_buffer[9][0] ), .A1(n1566), .B0(
        \string_buffer[8][0] ), .B1(n1567), .Y(n1383) );
  AND2X1 U2387 ( .A(\match_controller/N251 ), .B(\match_controller/N250 ), .Y(
        n1387) );
  AND2X1 U2388 ( .A(\match_controller/N251 ), .B(n1565), .Y(n1388) );
  OAI22XL U2389 ( .A0(\string_buffer[11][0] ), .A1(n1568), .B0(
        \string_buffer[10][0] ), .B1(n1569), .Y(n1382) );
  NOR2X1 U2390 ( .A(n1563), .B(n1564), .Y(n1379) );
  OAI22XL U2391 ( .A0(\string_buffer[13][0] ), .A1(n1570), .B0(
        \string_buffer[12][0] ), .B1(n1571), .Y(n1381) );
  OAI22XL U2392 ( .A0(\string_buffer[15][0] ), .A1(n1572), .B0(
        \string_buffer[14][0] ), .B1(n1573), .Y(n1380) );
  NOR4X1 U2393 ( .A(n1383), .B(n1382), .C(n1381), .D(n1380), .Y(n1405) );
  NOR2X1 U2394 ( .A(\match_controller/N252 ), .B(\match_controller/N253 ), .Y(
        n1384) );
  OAI221XL U2395 ( .A0(\string_buffer[0][0] ), .A1(n1574), .B0(
        \string_buffer[1][0] ), .B1(n1575), .C0(n1562), .Y(n1393) );
  OAI22XL U2396 ( .A0(\string_buffer[3][0] ), .A1(n1576), .B0(
        \string_buffer[2][0] ), .B1(n1577), .Y(n1392) );
  NOR2X1 U2397 ( .A(n1564), .B(\match_controller/N253 ), .Y(n1389) );
  OAI22XL U2398 ( .A0(\string_buffer[5][0] ), .A1(n1578), .B0(
        \string_buffer[4][0] ), .B1(n1579), .Y(n1391) );
  OAI22XL U2399 ( .A0(\string_buffer[7][0] ), .A1(n1580), .B0(
        \string_buffer[6][0] ), .B1(n1581), .Y(n1390) );
  NOR4X1 U2400 ( .A(n1393), .B(n1392), .C(n1391), .D(n1390), .Y(n1404) );
  OAI22XL U2401 ( .A0(\string_buffer[25][0] ), .A1(n1566), .B0(
        \string_buffer[24][0] ), .B1(n1567), .Y(n1397) );
  OAI22XL U2402 ( .A0(\string_buffer[27][0] ), .A1(n1568), .B0(
        \string_buffer[26][0] ), .B1(n1569), .Y(n1396) );
  OAI22XL U2403 ( .A0(\string_buffer[29][0] ), .A1(n1570), .B0(
        \string_buffer[28][0] ), .B1(n1571), .Y(n1395) );
  OAI22XL U2404 ( .A0(\string_buffer[31][0] ), .A1(n1572), .B0(
        \string_buffer[30][0] ), .B1(n1573), .Y(n1394) );
  NOR4X1 U2405 ( .A(n1397), .B(n1396), .C(n1395), .D(n1394), .Y(n1403) );
  OAI221XL U2406 ( .A0(\string_buffer[16][0] ), .A1(n1574), .B0(
        \string_buffer[17][0] ), .B1(n1575), .C0(\match_controller/N254 ), .Y(
        n1401) );
  OAI22XL U2407 ( .A0(\string_buffer[19][0] ), .A1(n1576), .B0(
        \string_buffer[18][0] ), .B1(n1577), .Y(n1400) );
  OAI22XL U2408 ( .A0(\string_buffer[21][0] ), .A1(n1578), .B0(
        \string_buffer[20][0] ), .B1(n1579), .Y(n1399) );
  OAI22XL U2409 ( .A0(\string_buffer[23][0] ), .A1(n1580), .B0(
        \string_buffer[22][0] ), .B1(n1581), .Y(n1398) );
  NOR4X1 U2410 ( .A(n1401), .B(n1400), .C(n1399), .D(n1398), .Y(n1402) );
  AO22X1 U2411 ( .A0(n1405), .A1(n1404), .B0(n1403), .B1(n1402), .Y(
        \match_controller/N914 ) );
  OAI22XL U2412 ( .A0(\string_buffer[9][1] ), .A1(n1566), .B0(
        \string_buffer[8][1] ), .B1(n1567), .Y(n1409) );
  OAI22XL U2413 ( .A0(\string_buffer[11][1] ), .A1(n1568), .B0(
        \string_buffer[10][1] ), .B1(n1569), .Y(n1408) );
  OAI22XL U2414 ( .A0(\string_buffer[13][1] ), .A1(n1570), .B0(
        \string_buffer[12][1] ), .B1(n1571), .Y(n1407) );
  OAI22XL U2415 ( .A0(\string_buffer[15][1] ), .A1(n1572), .B0(
        \string_buffer[14][1] ), .B1(n1573), .Y(n1406) );
  NOR4X1 U2416 ( .A(n1409), .B(n1408), .C(n1407), .D(n1406), .Y(n1425) );
  OAI221XL U2417 ( .A0(\string_buffer[0][1] ), .A1(n1574), .B0(
        \string_buffer[1][1] ), .B1(n1575), .C0(n1562), .Y(n1413) );
  OAI22XL U2418 ( .A0(\string_buffer[3][1] ), .A1(n1576), .B0(
        \string_buffer[2][1] ), .B1(n1577), .Y(n1412) );
  OAI22XL U2419 ( .A0(\string_buffer[5][1] ), .A1(n1578), .B0(
        \string_buffer[4][1] ), .B1(n1579), .Y(n1411) );
  OAI22XL U2420 ( .A0(\string_buffer[7][1] ), .A1(n1580), .B0(
        \string_buffer[6][1] ), .B1(n1581), .Y(n1410) );
  NOR4X1 U2421 ( .A(n1413), .B(n1412), .C(n1411), .D(n1410), .Y(n1424) );
  OAI22XL U2422 ( .A0(\string_buffer[25][1] ), .A1(n1566), .B0(
        \string_buffer[24][1] ), .B1(n1567), .Y(n1417) );
  OAI22XL U2423 ( .A0(\string_buffer[27][1] ), .A1(n1568), .B0(
        \string_buffer[26][1] ), .B1(n1569), .Y(n1416) );
  OAI22XL U2424 ( .A0(\string_buffer[29][1] ), .A1(n1570), .B0(
        \string_buffer[28][1] ), .B1(n1571), .Y(n1415) );
  OAI22XL U2425 ( .A0(\string_buffer[31][1] ), .A1(n1572), .B0(
        \string_buffer[30][1] ), .B1(n1573), .Y(n1414) );
  NOR4X1 U2426 ( .A(n1417), .B(n1416), .C(n1415), .D(n1414), .Y(n1423) );
  OAI221XL U2427 ( .A0(\string_buffer[16][1] ), .A1(n1574), .B0(
        \string_buffer[17][1] ), .B1(n1575), .C0(\match_controller/N254 ), .Y(
        n1421) );
  OAI22XL U2428 ( .A0(\string_buffer[19][1] ), .A1(n1576), .B0(
        \string_buffer[18][1] ), .B1(n1577), .Y(n1420) );
  OAI22XL U2429 ( .A0(\string_buffer[21][1] ), .A1(n1578), .B0(
        \string_buffer[20][1] ), .B1(n1579), .Y(n1419) );
  OAI22XL U2430 ( .A0(\string_buffer[23][1] ), .A1(n1580), .B0(
        \string_buffer[22][1] ), .B1(n1581), .Y(n1418) );
  NOR4X1 U2431 ( .A(n1421), .B(n1420), .C(n1419), .D(n1418), .Y(n1422) );
  AO22X1 U2432 ( .A0(n1425), .A1(n1424), .B0(n1423), .B1(n1422), .Y(
        \match_controller/N913 ) );
  OAI22XL U2433 ( .A0(\string_buffer[9][2] ), .A1(n1566), .B0(
        \string_buffer[8][2] ), .B1(n1567), .Y(n1429) );
  OAI22XL U2434 ( .A0(\string_buffer[11][2] ), .A1(n1568), .B0(
        \string_buffer[10][2] ), .B1(n1569), .Y(n1428) );
  OAI22XL U2435 ( .A0(\string_buffer[13][2] ), .A1(n1570), .B0(
        \string_buffer[12][2] ), .B1(n1571), .Y(n1427) );
  OAI22XL U2436 ( .A0(\string_buffer[15][2] ), .A1(n1572), .B0(
        \string_buffer[14][2] ), .B1(n1573), .Y(n1426) );
  NOR4X1 U2437 ( .A(n1429), .B(n1428), .C(n1427), .D(n1426), .Y(n1445) );
  OAI221XL U2438 ( .A0(\string_buffer[0][2] ), .A1(n1574), .B0(
        \string_buffer[1][2] ), .B1(n1575), .C0(n1562), .Y(n1433) );
  OAI22XL U2439 ( .A0(\string_buffer[3][2] ), .A1(n1576), .B0(
        \string_buffer[2][2] ), .B1(n1577), .Y(n1432) );
  OAI22XL U2440 ( .A0(\string_buffer[5][2] ), .A1(n1578), .B0(
        \string_buffer[4][2] ), .B1(n1579), .Y(n1431) );
  OAI22XL U2441 ( .A0(\string_buffer[7][2] ), .A1(n1580), .B0(
        \string_buffer[6][2] ), .B1(n1581), .Y(n1430) );
  NOR4X1 U2442 ( .A(n1433), .B(n1432), .C(n1431), .D(n1430), .Y(n1444) );
  OAI22XL U2443 ( .A0(\string_buffer[25][2] ), .A1(n1566), .B0(
        \string_buffer[24][2] ), .B1(n1567), .Y(n1437) );
  OAI22XL U2444 ( .A0(\string_buffer[27][2] ), .A1(n1568), .B0(
        \string_buffer[26][2] ), .B1(n1569), .Y(n1436) );
  OAI22XL U2445 ( .A0(\string_buffer[29][2] ), .A1(n1570), .B0(
        \string_buffer[28][2] ), .B1(n1571), .Y(n1435) );
  OAI22XL U2446 ( .A0(\string_buffer[31][2] ), .A1(n1572), .B0(
        \string_buffer[30][2] ), .B1(n1573), .Y(n1434) );
  NOR4X1 U2447 ( .A(n1437), .B(n1436), .C(n1435), .D(n1434), .Y(n1443) );
  OAI221XL U2448 ( .A0(\string_buffer[16][2] ), .A1(n1574), .B0(
        \string_buffer[17][2] ), .B1(n1575), .C0(\match_controller/N254 ), .Y(
        n1441) );
  OAI22XL U2449 ( .A0(\string_buffer[19][2] ), .A1(n1576), .B0(
        \string_buffer[18][2] ), .B1(n1577), .Y(n1440) );
  OAI22XL U2450 ( .A0(\string_buffer[21][2] ), .A1(n1578), .B0(
        \string_buffer[20][2] ), .B1(n1579), .Y(n1439) );
  OAI22XL U2451 ( .A0(\string_buffer[23][2] ), .A1(n1580), .B0(
        \string_buffer[22][2] ), .B1(n1581), .Y(n1438) );
  NOR4X1 U2452 ( .A(n1441), .B(n1440), .C(n1439), .D(n1438), .Y(n1442) );
  AO22X1 U2453 ( .A0(n1445), .A1(n1444), .B0(n1443), .B1(n1442), .Y(
        \match_controller/N912 ) );
  OAI22XL U2454 ( .A0(\string_buffer[9][3] ), .A1(n1566), .B0(
        \string_buffer[8][3] ), .B1(n1567), .Y(n1449) );
  OAI22XL U2455 ( .A0(\string_buffer[11][3] ), .A1(n1568), .B0(
        \string_buffer[10][3] ), .B1(n1569), .Y(n1448) );
  OAI22XL U2456 ( .A0(\string_buffer[13][3] ), .A1(n1570), .B0(
        \string_buffer[12][3] ), .B1(n1571), .Y(n1447) );
  OAI22XL U2457 ( .A0(\string_buffer[15][3] ), .A1(n1572), .B0(
        \string_buffer[14][3] ), .B1(n1573), .Y(n1446) );
  NOR4X1 U2458 ( .A(n1449), .B(n1448), .C(n1447), .D(n1446), .Y(n1465) );
  OAI221XL U2459 ( .A0(\string_buffer[0][3] ), .A1(n1574), .B0(
        \string_buffer[1][3] ), .B1(n1575), .C0(n1562), .Y(n1453) );
  OAI22XL U2460 ( .A0(\string_buffer[3][3] ), .A1(n1576), .B0(
        \string_buffer[2][3] ), .B1(n1577), .Y(n1452) );
  OAI22XL U2461 ( .A0(\string_buffer[5][3] ), .A1(n1578), .B0(
        \string_buffer[4][3] ), .B1(n1579), .Y(n1451) );
  OAI22XL U2462 ( .A0(\string_buffer[7][3] ), .A1(n1580), .B0(
        \string_buffer[6][3] ), .B1(n1581), .Y(n1450) );
  NOR4X1 U2463 ( .A(n1453), .B(n1452), .C(n1451), .D(n1450), .Y(n1464) );
  OAI22XL U2464 ( .A0(\string_buffer[25][3] ), .A1(n1566), .B0(
        \string_buffer[24][3] ), .B1(n1567), .Y(n1457) );
  OAI22XL U2465 ( .A0(\string_buffer[27][3] ), .A1(n1568), .B0(
        \string_buffer[26][3] ), .B1(n1569), .Y(n1456) );
  OAI22XL U2466 ( .A0(\string_buffer[29][3] ), .A1(n1570), .B0(
        \string_buffer[28][3] ), .B1(n1571), .Y(n1455) );
  OAI22XL U2467 ( .A0(\string_buffer[31][3] ), .A1(n1572), .B0(
        \string_buffer[30][3] ), .B1(n1573), .Y(n1454) );
  NOR4X1 U2468 ( .A(n1457), .B(n1456), .C(n1455), .D(n1454), .Y(n1463) );
  OAI221XL U2469 ( .A0(\string_buffer[16][3] ), .A1(n1574), .B0(
        \string_buffer[17][3] ), .B1(n1575), .C0(\match_controller/N254 ), .Y(
        n1461) );
  OAI22XL U2470 ( .A0(\string_buffer[19][3] ), .A1(n1576), .B0(
        \string_buffer[18][3] ), .B1(n1577), .Y(n1460) );
  OAI22XL U2471 ( .A0(\string_buffer[21][3] ), .A1(n1578), .B0(
        \string_buffer[20][3] ), .B1(n1579), .Y(n1459) );
  OAI22XL U2472 ( .A0(\string_buffer[23][3] ), .A1(n1580), .B0(
        \string_buffer[22][3] ), .B1(n1581), .Y(n1458) );
  NOR4X1 U2473 ( .A(n1461), .B(n1460), .C(n1459), .D(n1458), .Y(n1462) );
  AO22X1 U2474 ( .A0(n1465), .A1(n1464), .B0(n1463), .B1(n1462), .Y(
        \match_controller/N911 ) );
  OAI22XL U2475 ( .A0(\string_buffer[9][4] ), .A1(n1566), .B0(
        \string_buffer[8][4] ), .B1(n1567), .Y(n1469) );
  OAI22XL U2476 ( .A0(\string_buffer[11][4] ), .A1(n1568), .B0(
        \string_buffer[10][4] ), .B1(n1569), .Y(n1468) );
  OAI22XL U2477 ( .A0(\string_buffer[13][4] ), .A1(n1570), .B0(
        \string_buffer[12][4] ), .B1(n1571), .Y(n1467) );
  OAI22XL U2478 ( .A0(\string_buffer[15][4] ), .A1(n1572), .B0(
        \string_buffer[14][4] ), .B1(n1573), .Y(n1466) );
  NOR4X1 U2479 ( .A(n1469), .B(n1468), .C(n1467), .D(n1466), .Y(n1485) );
  OAI221XL U2480 ( .A0(\string_buffer[0][4] ), .A1(n1574), .B0(
        \string_buffer[1][4] ), .B1(n1575), .C0(n1562), .Y(n1473) );
  OAI22XL U2481 ( .A0(\string_buffer[3][4] ), .A1(n1576), .B0(
        \string_buffer[2][4] ), .B1(n1577), .Y(n1472) );
  OAI22XL U2482 ( .A0(\string_buffer[5][4] ), .A1(n1578), .B0(
        \string_buffer[4][4] ), .B1(n1579), .Y(n1471) );
  OAI22XL U2483 ( .A0(\string_buffer[7][4] ), .A1(n1580), .B0(
        \string_buffer[6][4] ), .B1(n1581), .Y(n1470) );
  NOR4X1 U2484 ( .A(n1473), .B(n1472), .C(n1471), .D(n1470), .Y(n1484) );
  OAI22XL U2485 ( .A0(\string_buffer[25][4] ), .A1(n1566), .B0(
        \string_buffer[24][4] ), .B1(n1567), .Y(n1477) );
  OAI22XL U2486 ( .A0(\string_buffer[27][4] ), .A1(n1568), .B0(
        \string_buffer[26][4] ), .B1(n1569), .Y(n1476) );
  OAI22XL U2487 ( .A0(\string_buffer[29][4] ), .A1(n1570), .B0(
        \string_buffer[28][4] ), .B1(n1571), .Y(n1475) );
  OAI22XL U2488 ( .A0(\string_buffer[31][4] ), .A1(n1572), .B0(
        \string_buffer[30][4] ), .B1(n1573), .Y(n1474) );
  NOR4X1 U2489 ( .A(n1477), .B(n1476), .C(n1475), .D(n1474), .Y(n1483) );
  OAI221XL U2490 ( .A0(\string_buffer[16][4] ), .A1(n1574), .B0(
        \string_buffer[17][4] ), .B1(n1575), .C0(\match_controller/N254 ), .Y(
        n1481) );
  OAI22XL U2491 ( .A0(\string_buffer[19][4] ), .A1(n1576), .B0(
        \string_buffer[18][4] ), .B1(n1577), .Y(n1480) );
  OAI22XL U2492 ( .A0(\string_buffer[21][4] ), .A1(n1578), .B0(
        \string_buffer[20][4] ), .B1(n1579), .Y(n1479) );
  OAI22XL U2493 ( .A0(\string_buffer[23][4] ), .A1(n1580), .B0(
        \string_buffer[22][4] ), .B1(n1581), .Y(n1478) );
  NOR4X1 U2494 ( .A(n1481), .B(n1480), .C(n1479), .D(n1478), .Y(n1482) );
  AO22X1 U2495 ( .A0(n1485), .A1(n1484), .B0(n1483), .B1(n1482), .Y(
        \match_controller/N910 ) );
  OAI22XL U2496 ( .A0(\string_buffer[9][5] ), .A1(n1566), .B0(
        \string_buffer[8][5] ), .B1(n1567), .Y(n1489) );
  OAI22XL U2497 ( .A0(\string_buffer[11][5] ), .A1(n1568), .B0(
        \string_buffer[10][5] ), .B1(n1569), .Y(n1488) );
  OAI22XL U2498 ( .A0(\string_buffer[13][5] ), .A1(n1570), .B0(
        \string_buffer[12][5] ), .B1(n1571), .Y(n1487) );
  OAI22XL U2499 ( .A0(\string_buffer[15][5] ), .A1(n1572), .B0(
        \string_buffer[14][5] ), .B1(n1573), .Y(n1486) );
  NOR4X1 U2500 ( .A(n1489), .B(n1488), .C(n1487), .D(n1486), .Y(n1505) );
  OAI221XL U2501 ( .A0(\string_buffer[0][5] ), .A1(n1574), .B0(
        \string_buffer[1][5] ), .B1(n1575), .C0(n1562), .Y(n1493) );
  OAI22XL U2502 ( .A0(\string_buffer[3][5] ), .A1(n1576), .B0(
        \string_buffer[2][5] ), .B1(n1577), .Y(n1492) );
  OAI22XL U2503 ( .A0(\string_buffer[5][5] ), .A1(n1578), .B0(
        \string_buffer[4][5] ), .B1(n1579), .Y(n1491) );
  OAI22XL U2504 ( .A0(\string_buffer[7][5] ), .A1(n1580), .B0(
        \string_buffer[6][5] ), .B1(n1581), .Y(n1490) );
  NOR4X1 U2505 ( .A(n1493), .B(n1492), .C(n1491), .D(n1490), .Y(n1504) );
  OAI22XL U2506 ( .A0(\string_buffer[25][5] ), .A1(n1566), .B0(
        \string_buffer[24][5] ), .B1(n1567), .Y(n1497) );
  OAI22XL U2507 ( .A0(\string_buffer[27][5] ), .A1(n1568), .B0(
        \string_buffer[26][5] ), .B1(n1569), .Y(n1496) );
  OAI22XL U2508 ( .A0(\string_buffer[29][5] ), .A1(n1570), .B0(
        \string_buffer[28][5] ), .B1(n1571), .Y(n1495) );
  OAI22XL U2509 ( .A0(\string_buffer[31][5] ), .A1(n1572), .B0(
        \string_buffer[30][5] ), .B1(n1573), .Y(n1494) );
  NOR4X1 U2510 ( .A(n1497), .B(n1496), .C(n1495), .D(n1494), .Y(n1503) );
  OAI221XL U2511 ( .A0(\string_buffer[16][5] ), .A1(n1574), .B0(
        \string_buffer[17][5] ), .B1(n1575), .C0(\match_controller/N254 ), .Y(
        n1501) );
  OAI22XL U2512 ( .A0(\string_buffer[19][5] ), .A1(n1576), .B0(
        \string_buffer[18][5] ), .B1(n1577), .Y(n1500) );
  OAI22XL U2513 ( .A0(\string_buffer[21][5] ), .A1(n1578), .B0(
        \string_buffer[20][5] ), .B1(n1579), .Y(n1499) );
  OAI22XL U2514 ( .A0(\string_buffer[23][5] ), .A1(n1580), .B0(
        \string_buffer[22][5] ), .B1(n1581), .Y(n1498) );
  NOR4X1 U2515 ( .A(n1501), .B(n1500), .C(n1499), .D(n1498), .Y(n1502) );
  AO22X1 U2516 ( .A0(n1505), .A1(n1504), .B0(n1503), .B1(n1502), .Y(
        \match_controller/N909 ) );
  OAI22XL U2517 ( .A0(\string_buffer[9][6] ), .A1(n1566), .B0(
        \string_buffer[8][6] ), .B1(n1567), .Y(n1509) );
  OAI22XL U2518 ( .A0(\string_buffer[11][6] ), .A1(n1568), .B0(
        \string_buffer[10][6] ), .B1(n1569), .Y(n1508) );
  OAI22XL U2519 ( .A0(\string_buffer[13][6] ), .A1(n1570), .B0(
        \string_buffer[12][6] ), .B1(n1571), .Y(n1507) );
  OAI22XL U2520 ( .A0(\string_buffer[15][6] ), .A1(n1572), .B0(
        \string_buffer[14][6] ), .B1(n1573), .Y(n1506) );
  NOR4X1 U2521 ( .A(n1509), .B(n1508), .C(n1507), .D(n1506), .Y(n1525) );
  OAI221XL U2522 ( .A0(\string_buffer[0][6] ), .A1(n1574), .B0(
        \string_buffer[1][6] ), .B1(n1575), .C0(n1562), .Y(n1513) );
  OAI22XL U2523 ( .A0(\string_buffer[3][6] ), .A1(n1576), .B0(
        \string_buffer[2][6] ), .B1(n1577), .Y(n1512) );
  OAI22XL U2524 ( .A0(\string_buffer[5][6] ), .A1(n1578), .B0(
        \string_buffer[4][6] ), .B1(n1579), .Y(n1511) );
  OAI22XL U2525 ( .A0(\string_buffer[7][6] ), .A1(n1580), .B0(
        \string_buffer[6][6] ), .B1(n1581), .Y(n1510) );
  NOR4X1 U2526 ( .A(n1513), .B(n1512), .C(n1511), .D(n1510), .Y(n1524) );
  OAI22XL U2527 ( .A0(\string_buffer[25][6] ), .A1(n1566), .B0(
        \string_buffer[24][6] ), .B1(n1567), .Y(n1517) );
  OAI22XL U2528 ( .A0(\string_buffer[27][6] ), .A1(n1568), .B0(
        \string_buffer[26][6] ), .B1(n1569), .Y(n1516) );
  OAI22XL U2529 ( .A0(\string_buffer[29][6] ), .A1(n1570), .B0(
        \string_buffer[28][6] ), .B1(n1571), .Y(n1515) );
  OAI22XL U2530 ( .A0(\string_buffer[31][6] ), .A1(n1572), .B0(
        \string_buffer[30][6] ), .B1(n1573), .Y(n1514) );
  NOR4X1 U2531 ( .A(n1517), .B(n1516), .C(n1515), .D(n1514), .Y(n1523) );
  OAI221XL U2532 ( .A0(\string_buffer[16][6] ), .A1(n1574), .B0(
        \string_buffer[17][6] ), .B1(n1575), .C0(\match_controller/N254 ), .Y(
        n1521) );
  OAI22XL U2533 ( .A0(\string_buffer[19][6] ), .A1(n1576), .B0(
        \string_buffer[18][6] ), .B1(n1577), .Y(n1520) );
  OAI22XL U2534 ( .A0(\string_buffer[21][6] ), .A1(n1578), .B0(
        \string_buffer[20][6] ), .B1(n1579), .Y(n1519) );
  OAI22XL U2535 ( .A0(\string_buffer[23][6] ), .A1(n1580), .B0(
        \string_buffer[22][6] ), .B1(n1581), .Y(n1518) );
  NOR4X1 U2536 ( .A(n1521), .B(n1520), .C(n1519), .D(n1518), .Y(n1522) );
  AO22X1 U2537 ( .A0(n1525), .A1(n1524), .B0(n1523), .B1(n1522), .Y(
        \match_controller/N908 ) );
  OAI22XL U2538 ( .A0(\string_buffer[9][7] ), .A1(n1566), .B0(
        \string_buffer[8][7] ), .B1(n1567), .Y(n1529) );
  OAI22XL U2539 ( .A0(\string_buffer[11][7] ), .A1(n1568), .B0(
        \string_buffer[10][7] ), .B1(n1569), .Y(n1528) );
  OAI22XL U2540 ( .A0(\string_buffer[13][7] ), .A1(n1570), .B0(
        \string_buffer[12][7] ), .B1(n1571), .Y(n1527) );
  OAI22XL U2541 ( .A0(\string_buffer[15][7] ), .A1(n1572), .B0(
        \string_buffer[14][7] ), .B1(n1573), .Y(n1526) );
  NOR4X1 U2542 ( .A(n1529), .B(n1528), .C(n1527), .D(n1526), .Y(n1561) );
  OAI221XL U2543 ( .A0(\string_buffer[0][7] ), .A1(n1574), .B0(
        \string_buffer[1][7] ), .B1(n1575), .C0(n1562), .Y(n1533) );
  OAI22XL U2544 ( .A0(\string_buffer[3][7] ), .A1(n1576), .B0(
        \string_buffer[2][7] ), .B1(n1577), .Y(n1532) );
  OAI22XL U2545 ( .A0(\string_buffer[5][7] ), .A1(n1578), .B0(
        \string_buffer[4][7] ), .B1(n1579), .Y(n1531) );
  OAI22XL U2546 ( .A0(\string_buffer[7][7] ), .A1(n1580), .B0(
        \string_buffer[6][7] ), .B1(n1581), .Y(n1530) );
  NOR4X1 U2547 ( .A(n1533), .B(n1532), .C(n1531), .D(n1530), .Y(n1560) );
  OAI22XL U2548 ( .A0(\string_buffer[26][7] ), .A1(n1569), .B0(
        \string_buffer[25][7] ), .B1(n1566), .Y(n1544) );
  OAI22XL U2549 ( .A0(\string_buffer[28][7] ), .A1(n1571), .B0(
        \string_buffer[27][7] ), .B1(n1568), .Y(n1543) );
  OAI22XL U2550 ( .A0(\string_buffer[30][7] ), .A1(n1573), .B0(
        \string_buffer[29][7] ), .B1(n1570), .Y(n1542) );
  OAI21XL U2551 ( .A0(\string_buffer[31][7] ), .A1(n1572), .B0(
        \match_controller/N254 ), .Y(n1541) );
  NOR4X1 U2552 ( .A(n1544), .B(n1543), .C(n1542), .D(n1541), .Y(n1559) );
  OAI222XL U2553 ( .A0(\string_buffer[17][7] ), .A1(n1575), .B0(
        \string_buffer[16][7] ), .B1(n1574), .C0(\string_buffer[18][7] ), .C1(
        n1577), .Y(n1557) );
  OAI22XL U2554 ( .A0(\string_buffer[20][7] ), .A1(n1579), .B0(
        \string_buffer[19][7] ), .B1(n1576), .Y(n1556) );
  OAI22XL U2555 ( .A0(\string_buffer[22][7] ), .A1(n1581), .B0(
        \string_buffer[21][7] ), .B1(n1578), .Y(n1555) );
  OAI22XL U2556 ( .A0(\string_buffer[24][7] ), .A1(n1567), .B0(
        \string_buffer[23][7] ), .B1(n1580), .Y(n1554) );
  NOR4X1 U2557 ( .A(n1557), .B(n1556), .C(n1555), .D(n1554), .Y(n1558) );
  AO22X1 U2558 ( .A0(n1561), .A1(n1560), .B0(n1559), .B1(n1558), .Y(
        \match_controller/N907 ) );
  AO22X1 U2559 ( .A0(\pattern_buffer[3][0] ), .A1(n1623), .B0(
        \pattern_buffer[1][0] ), .B1(n1624), .Y(n1582) );
  AOI221XL U2560 ( .A0(\pattern_buffer[5][0] ), .A1(n1621), .B0(
        \pattern_buffer[7][0] ), .B1(n1622), .C0(n1582), .Y(n1585) );
  AO22X1 U2561 ( .A0(\pattern_buffer[2][0] ), .A1(n1623), .B0(
        \pattern_buffer[0][0] ), .B1(n1624), .Y(n1583) );
  AOI221XL U2562 ( .A0(\pattern_buffer[4][0] ), .A1(n1621), .B0(
        \pattern_buffer[6][0] ), .B1(n1622), .C0(n1583), .Y(n1584) );
  OAI22XL U2563 ( .A0(n1619), .A1(n1585), .B0(\match_controller/N247 ), .B1(
        n1584), .Y(\match_controller/N906 ) );
  AO22X1 U2564 ( .A0(\pattern_buffer[3][1] ), .A1(n1623), .B0(
        \pattern_buffer[1][1] ), .B1(n1624), .Y(n1586) );
  AOI221XL U2565 ( .A0(\pattern_buffer[5][1] ), .A1(n1621), .B0(
        \pattern_buffer[7][1] ), .B1(n1622), .C0(n1586), .Y(n1589) );
  AO22X1 U2566 ( .A0(\pattern_buffer[2][1] ), .A1(n1623), .B0(
        \pattern_buffer[0][1] ), .B1(n1624), .Y(n1587) );
  AOI221XL U2567 ( .A0(\pattern_buffer[4][1] ), .A1(n1621), .B0(
        \pattern_buffer[6][1] ), .B1(n1622), .C0(n1587), .Y(n1588) );
  OAI22XL U2568 ( .A0(n1619), .A1(n1589), .B0(\match_controller/N247 ), .B1(
        n1588), .Y(\match_controller/N905 ) );
  AO22X1 U2569 ( .A0(\pattern_buffer[3][2] ), .A1(n1623), .B0(
        \pattern_buffer[1][2] ), .B1(n1624), .Y(n1590) );
  AOI221XL U2570 ( .A0(\pattern_buffer[5][2] ), .A1(n1621), .B0(
        \pattern_buffer[7][2] ), .B1(n1622), .C0(n1590), .Y(n1593) );
  AO22X1 U2571 ( .A0(\pattern_buffer[2][2] ), .A1(n1623), .B0(
        \pattern_buffer[0][2] ), .B1(n1624), .Y(n1591) );
  AOI221XL U2572 ( .A0(\pattern_buffer[4][2] ), .A1(n1621), .B0(
        \pattern_buffer[6][2] ), .B1(n1622), .C0(n1591), .Y(n1592) );
  AO22X1 U2573 ( .A0(\pattern_buffer[3][3] ), .A1(n1623), .B0(
        \pattern_buffer[1][3] ), .B1(n1624), .Y(n1594) );
  AOI221XL U2574 ( .A0(\pattern_buffer[5][3] ), .A1(n1621), .B0(
        \pattern_buffer[7][3] ), .B1(n1622), .C0(n1594), .Y(n1597) );
  AO22X1 U2575 ( .A0(\pattern_buffer[2][3] ), .A1(n1623), .B0(
        \pattern_buffer[0][3] ), .B1(n1624), .Y(n1595) );
  AOI221XL U2576 ( .A0(\pattern_buffer[4][3] ), .A1(n1621), .B0(
        \pattern_buffer[6][3] ), .B1(n1622), .C0(n1595), .Y(n1596) );
  OAI22XL U2577 ( .A0(n1619), .A1(n1597), .B0(\match_controller/N247 ), .B1(
        n1596), .Y(\match_controller/N903 ) );
  AO22X1 U2578 ( .A0(\pattern_buffer[3][4] ), .A1(n1623), .B0(
        \pattern_buffer[1][4] ), .B1(n1624), .Y(n1598) );
  AOI221XL U2579 ( .A0(\pattern_buffer[5][4] ), .A1(n1621), .B0(
        \pattern_buffer[7][4] ), .B1(n1622), .C0(n1598), .Y(n1601) );
  AO22X1 U2580 ( .A0(\pattern_buffer[2][4] ), .A1(n1623), .B0(
        \pattern_buffer[0][4] ), .B1(n1624), .Y(n1599) );
  AOI221XL U2581 ( .A0(\pattern_buffer[4][4] ), .A1(n1621), .B0(
        \pattern_buffer[6][4] ), .B1(n1622), .C0(n1599), .Y(n1600) );
  OAI22XL U2582 ( .A0(n1619), .A1(n1601), .B0(\match_controller/N247 ), .B1(
        n1600), .Y(\match_controller/N902 ) );
  AO22X1 U2583 ( .A0(\pattern_buffer[3][5] ), .A1(n1623), .B0(
        \pattern_buffer[1][5] ), .B1(n1624), .Y(n1602) );
  AOI221XL U2584 ( .A0(\pattern_buffer[5][5] ), .A1(n1621), .B0(
        \pattern_buffer[7][5] ), .B1(n1622), .C0(n1602), .Y(n1605) );
  AO22X1 U2585 ( .A0(\pattern_buffer[2][5] ), .A1(n1623), .B0(
        \pattern_buffer[0][5] ), .B1(n1624), .Y(n1603) );
  AOI221XL U2586 ( .A0(\pattern_buffer[4][5] ), .A1(n1621), .B0(
        \pattern_buffer[6][5] ), .B1(n1622), .C0(n1603), .Y(n1604) );
  OAI22XL U2587 ( .A0(n1619), .A1(n1605), .B0(\match_controller/N247 ), .B1(
        n1604), .Y(\match_controller/N901 ) );
  AO22X1 U2588 ( .A0(\pattern_buffer[3][6] ), .A1(n1623), .B0(
        \pattern_buffer[1][6] ), .B1(n1624), .Y(n1606) );
  AOI221XL U2589 ( .A0(\pattern_buffer[5][6] ), .A1(n1621), .B0(
        \pattern_buffer[7][6] ), .B1(n1622), .C0(n1606), .Y(n1609) );
  AO22X1 U2590 ( .A0(\pattern_buffer[2][6] ), .A1(n1623), .B0(
        \pattern_buffer[0][6] ), .B1(n1624), .Y(n1607) );
  AOI221XL U2591 ( .A0(\pattern_buffer[4][6] ), .A1(n1621), .B0(
        \pattern_buffer[6][6] ), .B1(n1622), .C0(n1607), .Y(n1608) );
  AO22X1 U2592 ( .A0(\pattern_buffer[3][7] ), .A1(n1623), .B0(
        \pattern_buffer[1][7] ), .B1(n1624), .Y(n1610) );
  AOI221XL U2593 ( .A0(\pattern_buffer[5][7] ), .A1(n1621), .B0(
        \pattern_buffer[7][7] ), .B1(n1622), .C0(n1610), .Y(n1617) );
  AO22X1 U2594 ( .A0(\pattern_buffer[2][7] ), .A1(n1623), .B0(
        \pattern_buffer[0][7] ), .B1(n1624), .Y(n1613) );
  AOI221XL U2595 ( .A0(\pattern_buffer[4][7] ), .A1(n1621), .B0(
        \pattern_buffer[6][7] ), .B1(n1622), .C0(n1613), .Y(n1616) );
  AO22X1 U2596 ( .A0(\pattern_buffer[3][0] ), .A1(n1666), .B0(
        \pattern_buffer[1][0] ), .B1(n1667), .Y(n1625) );
  AOI221XL U2597 ( .A0(\pattern_buffer[5][0] ), .A1(n1664), .B0(
        \pattern_buffer[7][0] ), .B1(n1665), .C0(n1625), .Y(n1628) );
  AO22X1 U2598 ( .A0(\pattern_buffer[2][0] ), .A1(n1666), .B0(
        \pattern_buffer[0][0] ), .B1(n1667), .Y(n1626) );
  AOI221XL U2599 ( .A0(\pattern_buffer[4][0] ), .A1(n1664), .B0(
        \pattern_buffer[6][0] ), .B1(n1665), .C0(n1626), .Y(n1627) );
  OAI22XL U2600 ( .A0(n1663), .A1(n1628), .B0(\match_controller/N244 ), .B1(
        n1627), .Y(\match_controller/N262 ) );
  AO22X1 U2601 ( .A0(\pattern_buffer[3][1] ), .A1(n1666), .B0(
        \pattern_buffer[1][1] ), .B1(n1667), .Y(n1629) );
  AOI221XL U2602 ( .A0(\pattern_buffer[5][1] ), .A1(n1664), .B0(
        \pattern_buffer[7][1] ), .B1(n1665), .C0(n1629), .Y(n1632) );
  AO22X1 U2603 ( .A0(\pattern_buffer[2][1] ), .A1(n1666), .B0(
        \pattern_buffer[0][1] ), .B1(n1667), .Y(n1630) );
  AOI221XL U2604 ( .A0(\pattern_buffer[4][1] ), .A1(n1664), .B0(
        \pattern_buffer[6][1] ), .B1(n1665), .C0(n1630), .Y(n1631) );
  OAI22XL U2605 ( .A0(n1663), .A1(n1632), .B0(\match_controller/N244 ), .B1(
        n1631), .Y(\match_controller/N261 ) );
  AO22X1 U2606 ( .A0(\pattern_buffer[3][2] ), .A1(n1666), .B0(
        \pattern_buffer[1][2] ), .B1(n1667), .Y(n1633) );
  AOI221XL U2607 ( .A0(\pattern_buffer[5][2] ), .A1(n1664), .B0(
        \pattern_buffer[7][2] ), .B1(n1665), .C0(n1633), .Y(n1636) );
  AO22X1 U2608 ( .A0(\pattern_buffer[2][2] ), .A1(n1666), .B0(
        \pattern_buffer[0][2] ), .B1(n1667), .Y(n1634) );
  AOI221XL U2609 ( .A0(\pattern_buffer[4][2] ), .A1(n1664), .B0(
        \pattern_buffer[6][2] ), .B1(n1665), .C0(n1634), .Y(n1635) );
  OAI22XL U2610 ( .A0(n1663), .A1(n1636), .B0(\match_controller/N244 ), .B1(
        n1635), .Y(\match_controller/N260 ) );
  AO22X1 U2611 ( .A0(\pattern_buffer[3][3] ), .A1(n1666), .B0(
        \pattern_buffer[1][3] ), .B1(n1667), .Y(n1637) );
  AOI221XL U2612 ( .A0(\pattern_buffer[5][3] ), .A1(n1664), .B0(
        \pattern_buffer[7][3] ), .B1(n1665), .C0(n1637), .Y(n1640) );
  AO22X1 U2613 ( .A0(\pattern_buffer[2][3] ), .A1(n1666), .B0(
        \pattern_buffer[0][3] ), .B1(n1667), .Y(n1638) );
  AOI221XL U2614 ( .A0(\pattern_buffer[4][3] ), .A1(n1664), .B0(
        \pattern_buffer[6][3] ), .B1(n1665), .C0(n1638), .Y(n1639) );
  OAI22XL U2615 ( .A0(n1663), .A1(n1640), .B0(\match_controller/N244 ), .B1(
        n1639), .Y(\match_controller/N259 ) );
  AO22X1 U2616 ( .A0(\pattern_buffer[3][4] ), .A1(n1666), .B0(
        \pattern_buffer[1][4] ), .B1(n1667), .Y(n1641) );
  AOI221XL U2617 ( .A0(\pattern_buffer[5][4] ), .A1(n1664), .B0(
        \pattern_buffer[7][4] ), .B1(n1665), .C0(n1641), .Y(n1644) );
  AO22X1 U2618 ( .A0(\pattern_buffer[2][4] ), .A1(n1666), .B0(
        \pattern_buffer[0][4] ), .B1(n1667), .Y(n1642) );
  AOI221XL U2619 ( .A0(\pattern_buffer[4][4] ), .A1(n1664), .B0(
        \pattern_buffer[6][4] ), .B1(n1665), .C0(n1642), .Y(n1643) );
  OAI22XL U2620 ( .A0(n1663), .A1(n1644), .B0(\match_controller/N244 ), .B1(
        n1643), .Y(\match_controller/N258 ) );
  AO22X1 U2621 ( .A0(\pattern_buffer[3][5] ), .A1(n1666), .B0(
        \pattern_buffer[1][5] ), .B1(n1667), .Y(n1645) );
  AOI221XL U2622 ( .A0(\pattern_buffer[5][5] ), .A1(n1664), .B0(
        \pattern_buffer[7][5] ), .B1(n1665), .C0(n1645), .Y(n1648) );
  AO22X1 U2623 ( .A0(\pattern_buffer[2][5] ), .A1(n1666), .B0(
        \pattern_buffer[0][5] ), .B1(n1667), .Y(n1646) );
  AOI221XL U2624 ( .A0(\pattern_buffer[4][5] ), .A1(n1664), .B0(
        \pattern_buffer[6][5] ), .B1(n1665), .C0(n1646), .Y(n1647) );
  OAI22XL U2625 ( .A0(n1663), .A1(n1648), .B0(\match_controller/N244 ), .B1(
        n1647), .Y(\match_controller/N257 ) );
  AO22X1 U2626 ( .A0(\pattern_buffer[3][6] ), .A1(n1666), .B0(
        \pattern_buffer[1][6] ), .B1(n1667), .Y(n1649) );
  AOI221XL U2627 ( .A0(\pattern_buffer[5][6] ), .A1(n1664), .B0(
        \pattern_buffer[7][6] ), .B1(n1665), .C0(n1649), .Y(n1652) );
  AO22X1 U2628 ( .A0(\pattern_buffer[2][6] ), .A1(n1666), .B0(
        \pattern_buffer[0][6] ), .B1(n1667), .Y(n1650) );
  AOI221XL U2629 ( .A0(\pattern_buffer[4][6] ), .A1(n1664), .B0(
        \pattern_buffer[6][6] ), .B1(n1665), .C0(n1650), .Y(n1651) );
  OAI22XL U2630 ( .A0(n1663), .A1(n1652), .B0(\match_controller/N244 ), .B1(
        n1651), .Y(\match_controller/N256 ) );
  AO22X1 U2631 ( .A0(\pattern_buffer[3][7] ), .A1(n1666), .B0(
        \pattern_buffer[1][7] ), .B1(n1667), .Y(n1653) );
  AOI221XL U2632 ( .A0(\pattern_buffer[5][7] ), .A1(n1664), .B0(
        \pattern_buffer[7][7] ), .B1(n1665), .C0(n1653), .Y(n1660) );
  AO22X1 U2633 ( .A0(\pattern_buffer[2][7] ), .A1(n1666), .B0(
        \pattern_buffer[0][7] ), .B1(n1667), .Y(n1656) );
  AOI221XL U2634 ( .A0(\pattern_buffer[4][7] ), .A1(n1664), .B0(
        \pattern_buffer[6][7] ), .B1(n1665), .C0(n1656), .Y(n1659) );
  OAI22XL U2635 ( .A0(n1660), .A1(n1663), .B0(\match_controller/N244 ), .B1(
        n1659), .Y(\match_controller/N255 ) );
  XOR2X1 U2636 ( .A(\read_chardata/add_192/carry [4]), .B(
        \read_chardata/temp_read_string_count [4]), .Y(\read_chardata/N114 )
         );
  XOR2X1 U2637 ( .A(\match_controller/add_304/carry [4]), .B(
        \match_controller/N254 ), .Y(\match_controller/N289 ) );
endmodule

