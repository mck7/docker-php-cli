<?php

$start = microtime(1);
$x = 0;
$z = 1;
$results = [];
$string = '';
file_put_contents('test.txt', '');

for ($i = 0; $i < 1000000; $i++) {
  $x = $x + $i;
  $results[] = $x;
  $string .= "${x}";
  $z = $x * $i;
  file_put_contents('test.txt', $x, FILE_APPEND);
}

print_r([
  array_sum($results),
  md5(base64_encode($string)),
  $z,
]);

print_r([microtime(1) - $start]);
