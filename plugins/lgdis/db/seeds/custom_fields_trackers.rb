# encoding: utf-8
# 削除（tracker_idが100以下 且つ custom_field_idが1000以下）
ActiveRecord::Base.connection.execute(%{DELETE FROM custom_fields_trackers WHERE tracker_id<= 100 and custom_field_id <= 1000})

# 登録
{  1 => [2,3,4,5,6,7,8,9,10,11,12,13],
  30 => [133,134,135,136,21],
   2 => [2,3,4,5,6,7,8,9,10,11,12,13],
  31 => [133],
   3 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,44],
   4 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,44],
   5 => [44],
   6 => [44],
   7 => [28,29,30,137,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,189,420,421,],
   8 => [28,29,30,31,32,33,137,189,420,421],
  33 => [28,29,30,34,35,33,137,189,420,421],
   9 => [28,29,30,137,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,189,420,421],
  10 => [28,29,30,137,159,160,164,166,167,168,169,170,171,174,175,176,177,178,179,180,181,182,183,184,185,186,187,189,419,420,421],
  11 => [28,29,30,137,188,189,190,191,192,193,194,195,196,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,420,421],
  12 => [28,29,30,137,188,189,190,200,215,216,217,218,219,220,221,420,421],
  13 => [28,29,30,137,222,223,224,225,189,420,421],
  14 => [28,29,30,137,189,222,223,225,226,420,421],
  
  34 => [28,29,30,137,189,280,283,284,285,286,287,288,289,290,291,292,293,294,295,296,420,421],
  35 => [28,29,30,137,189,280,283,284,285,286,287,288,289,290,291,292,293,294,295,296,420,421],
  36 => [28,29,30,137,189,280,283,284,285,286,287,288,289,290,291,292,293,294,295,296,420,421],
  37 => [28,29,30,137,189,280,283,284,285,286,287,288,289,290,291,292,293,294,295,296,420,421],
  38 => [28,29,30,137,189,280,283,284,285,286,287,288,289,290,291,292,293,294,295,296,420,421],
  39 => [28,29,30,137,189,280,289,290,291,292,293,294,295,296,310,311,313,314,315,316,317,420,421],
  40 => [28,29,30,137,189,280,289,290,291,292,293,294,295,296,311,322,323,324,327,328,329,330,331,332,333,334,335,336,337,338,339,340,420,421],
  
  41 => [28,29,30,33,137,140,141,189,420,421],
  15 => [28,29,30,33,137,140,141,189,420,421],
  16 => [1,2,3,4,6,7,10,11,12,13,114,115,116,117,118,119,120,121],
  17 => [8,9,22,28,29,30,45,46,122,123,124,125,126,127,128,129,130,131],
  18 => [1,2,3,4,5,6,7,8,9,10,11,12,13,22,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113],

  20 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,36,37,159,160,161,162,165,166,167,182,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246],
  21 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,37,182,238,247,248,249,250,251],
  22 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,37,182,252,253,254,255,256,257,258],
  23 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,37,182,259,260],
  24 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,37,182,261,262,263],
  25 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,37,182,238,246,264,265,266,267,268,269,270,271],
  26 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,37,182,272,273,274],
  27 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,37,182,275,276,277,278],
  42 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,132,22,36,37,197,198,222,343,344,345,346],
  43 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,347,22,37,188,189,190,191,192,193,194,195,196,197,198,199,200,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389],
  44 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,347,22,37,188,189,190,191,192,193,194,195,196,197,198,199,200,390,391,392,393,394,395,396,397,398,399,400,401],
  45 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,22,36,37,197,198,222,402,403,404,405,406,407,408,409],
  46 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,22,36,37,197,198,222,344,410,411,412],
  47 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,413,36,37],
  28 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,37,38,39,41,43,],
  29 => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,37,38,40,42,43,],
  
  }.each {|tr_id, cf_ids|
  cf_ids.each {|cf_id|
    ActiveRecord::Base.connection.execute(%{INSERT INTO custom_fields_trackers (tracker_id, custom_field_id) VALUES (#{tr_id},#{cf_id})})
  }
}