<?php

$cd = dirname(__FILE__);

$id = $group = $num1 = $num2 = $bool = $date = []; 
$letters = 'ABCDEFGHIJKLMNOPQRSTUVXWYZ';

srand(99);

// Credit - @Paulpro: https://stackoverflow.com/a/15952104/1422451
function nrand($mean, $sd){
    $x = mt_rand()/mt_getrandmax();
    $y = mt_rand()/mt_getrandmax();
    return sqrt(-2*log($x))*cos(2*pi()*$y)*$sd + $mean;
}

for ($i=0; $i<20; $i++){
   $id[] = rand(1,15);
   $group[] = substr($letters, rand(0,25), 1);
   $num1[] = nrand(0,1)*100;
   $num2[] = nrand(0,1);
   $bool[] = [True, False][rand(0,1)];
   $date[] = date("Y-m-d H:i:s", rand(0,time()));
}

var_dump($bool);

for ($f=1; $f<=10; $f++){
   $strfile = $cd.'/RandomData_PHP_'. $f .'.csv';
   echo $strfile."\n";
   $fs = fopen($strfile, 'w');
   fputcsv($fs, ["ID", "GROUP", "NUM1", "NUM2", "BOOL", "DATE"]);      
   fclose($fs);

   for ($i=0; $i<20; $i++){     
      $fs = fopen($strfile, 'a');
      fputcsv($fs, array($id[$i], $group[$i], $num1[$i], $num2[$i], $bool[$i], $date[$i]));
      fclose($fs);
   }


}


?>
