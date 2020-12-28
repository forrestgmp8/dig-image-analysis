% % Erhan_Eroglu_2486736

clc
clear all

% % Reading the EO1-Hyperion image file.

 hdfinfo('EO1H0150332002114111KZ.L1R');
 fileinfo = hdfinfo('EO1H0150332002114111KZ.L1R');
 sdsinfo = fileinfo.SDS(1);
 imhdforg=hdfread(sdsinfo);
 imhdforg=double(imhdforg);

% % Changing the band dimension with spatial dimension.

imhdf=permute(imhdforg,[1,3,2]);


% % Pixel value correction by dividing certain value.
% % 1-70 (until NIR) and 71-242 (after NIR).
% % These values are found in order to scale the radiance.


 imhdf2(:,:,1:70)=imhdf(:,:,1:70)/40;
 imhdf2(:,:,71:242)=imhdf(:,:,71:242)/80;

% % Red, Green, Blue and NIR specific values are extracted.

 hyp_r=imhdf2(:,:,29);
 hyp_g=imhdf2(:,:,23);
 hyp_b=imhdf2(:,:,16);
 hyp_nir=imhdf2(:,:,40);

% % The values are changes to 8-bit to create an RGB image.
% % RGB, False Colour and their cropped to speicific areas are created.
% % The images are saved in folder in jpg format and displayed.

% hyp_r=uint8(hyp_r);
% hyp_g=uint8(hyp_g);
% hyp_b=uint8(hyp_b);
% hyp_nir=uint8(hyp_nir);


% RGB=cat(3,r,g,b);
% falseColour=cat(3,hyp_nir,hyp_r,hyp_g);
% cropRGB=RGB((1500:(1500+255)),:,:);
% cropFalseColour=falseColour((1500:(1500+255)),:,:);



% imwrite(RGB,'RGB_original.jpg');
% imwrite(cropRGB,'RGB_Cropped.jpg');
% imwrite(cropFalseColour,'False_Colour.jpg');
% image(RGB)
% image(cropRGB)
% image(cropFalseColour)

% % Spectrums are found by original (not scaled) cropped image.

% crop_imhdf=imhdf(1500:(1500+255),:,:);

% % Pixels are selected as vegetation, soil, water, urbanisation and their coordinates are inserted

% veg_1=crop_imhdf(25,230,:);
% veg_2=crop_imhdf(110,245,:);
% veg_3=crop_imhdf(161,106,:);
% 
% veg_1=squeeze(veg_1);
% veg_2=squeeze(veg_2);
% veg_3=squeeze(veg_3);
% 
% soil_1=crop_imhdf(99,119,:);
% soil_2=crop_imhdf(73,131,:);
% soil_3=crop_imhdf(225,115,:);
% 
% soil_1=squeeze(soil_1);
% soil_2=squeeze(soil_2);
% soil_3=squeeze(soil_3);
% 
% water_1=crop_imhdf(45,145,:);
% water_2=crop_imhdf(120,103,:);
% water_3=crop_imhdf(209,62,:);
% 
% water_1=squeeze(water_1);
% water_2=squeeze(water_2);
% water_3=squeeze(water_3);
% 
% urban_1=crop_imhdf(173,128,:);
% urban_2=crop_imhdf(174,109,:);
% urban_3=crop_imhdf(167,133,:);

%urban_1=squeeze(urban_1);
%urban_2=squeeze(urban_2);
%urban_3=squeeze(urban_3);

%wl=[355.588867,  365.764191,  375.939209,  386.114594,  396.290192,  406.464996,  416.640198,  426.815704,  436.991150,  447.166473,  457.341797,  467.517273,  477.692230,  487.867889,  498.042847,  508.218414,  518.393738,  528.568787,  538.744385,  548.919373,  559.094421,  569.269592,  579.445496,  589.620483,  599.795898,  609.971252,  620.146362,  630.321960,  640.497192,  650.672729,  660.847961,  671.022461,  681.198669,  691.373230,  701.548828,  711.723938,  721.899353,  732.074890,  742.249939,  752.425354,  762.600342,  772.776306,  782.951416,  793.126892,  803.301941,  813.477173,  823.652100,  833.827820,  844.003052,  854.178650,  864.353271,  874.529053,  884.704407,  894.879272,  905.054688,  915.229858,  925.405518,  935.580933,  945.755493,  955.931274,  966.106018,  976.281738,  986.457092,  996.632690, 1006.807556, 1016.982666, 1027.158447, 1037.333496, 1047.508179, 1057.684570,  851.920593,  862.009583,  872.097717,  882.186707,  892.275391,  902.362854,  912.451538,  922.541443,  932.639160,  942.727234,  952.816467,  962.905151,  972.993164,  983.082458,  993.170898, 1003.299622, 1013.298279, 1023.397766, 1033.494385, 1043.592773, 1053.692261, 1063.791626, 1073.888428, 1083.986938, 1094.086914, 1104.186035, 1114.185181, 1124.282715, 1134.379639, 1144.479126, 1154.578369, 1164.675049, 1174.774170, 1184.873901, 1194.972412, 1205.071411, 1215.168457, 1225.167114, 1235.265625, 1245.364380, 1255.464233, 1265.561768, 1275.661011, 1285.757935, 1295.858154, 1305.956421, 1316.054932, 1326.053101, 1336.150391, 1346.251343, 1356.349121, 1366.447632, 1376.545044, 1386.645264, 1396.742432, 1406.843018, 1416.940063, 1426.938110, 1437.037720, 1447.135620, 1457.234741, 1467.333008, 1477.431152, 1487.531616, 1497.628418, 1507.727783, 1517.825684, 1527.924683, 1537.923462, 1548.022217, 1558.120972, 1568.218750, 1578.316895, 1588.415649, 1598.513672, 1608.614502, 1618.711060, 1628.812012, 1638.810059, 1648.904663, 1659.004272, 1669.102783, 1679.204224, 1689.303833, 1699.399048, 1709.498657, 1719.597778, 1729.696289, 1739.695068, 1749.790894, 1759.889404, 1769.991211, 1780.086670, 1790.187744, 1800.286987, 1810.384033, 1820.483032, 1830.580444, 1840.579468, 1850.677612, 1860.778198, 1870.873291, 1880.975220, 1891.074097, 1901.171021, 1911.268799, 1921.368408, 1931.465576, 1941.567871, 1951.565674, 1961.661377, 1971.762451, 1981.860474, 1991.958252, 2002.056274, 2012.154053, 2022.252930, 2032.351440, 2042.452026, 2052.450195, 2062.549805, 2072.646973, 2082.745361, 2092.843994, 2102.940430, 2113.041748, 2123.138428, 2133.239258, 2143.338135, 2153.336914, 2163.433838, 2173.532959, 2183.629639, 2193.729004, 2203.829102, 2213.926270, 2224.025391, 2234.123047, 2244.221680, 2254.220459, 2264.320801, 2274.417480, 2284.516602, 2294.614502, 2304.712646, 2314.813232, 2324.910400, 2335.008545, 2345.108154, 2355.206055, 2365.204590, 2375.303711, 2385.401367, 2395.500000, 2405.600342, 2415.697510, 2425.797119, 2435.894287, 2445.992432, 2456.092773, 2466.092041, 2476.188721, 2486.288086, 2496.385742, 2506.484131, 2516.585205, 2526.680908, 2536.781250, 2546.878418, 2556.976807, 2566.975342, 2577.076416];
% wl=wl.';

% % The spectrums are displayed in one graph
% % The x-axis shows the wavelengths

%figure
%hold on
 
%pv1=plot(wl,veg_1,'g','LineWidth',1)
%pv2=plot(wl,veg_2,'g','LineWidth',1)
%pv3=plot(wl,veg_3,'g','LineWidth',1)

%ps1=plot(wl,soil_1,'Color',[0.8500 0.3250 0.0980],'LineWidth',1)
%ps2=plot(wl,soil_2,'Color',[0.8500 0.3250 0.0980],'LineWidth',1)
%ps3=plot(wl,soil_3,'Color',[0.8500 0.3250 0.0980],'LineWidth',1)
  
%pw1=plot(wl,water_1,'b','LineWidth',1)
%pw2=plot(wl,water_2,'b','LineWidth',1)
%pw3=plot(wl ,water_3,'b','LineWidth',1)

%pu1=plot(wl,urban_1,'k','LineWidth',1)
%pu2=plot(wl,urban_2,'k','LineWidth',1)
%pu3=plot(wl,urban_3,'k','LineWidth',1)

%title('Radiance vs Wavelengths - Hyperion1')
% xlabel('Wavelength (nm)')
% ylabel('Radiance')
% legend([pv1 ps1 pw1 pu1],{'vegetation','soil', 'water','urban'})
