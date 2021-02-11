<?php
$date= date("H:i", strtotime("now UTC"));

if(date("06:00")< $date AND $date < date("10:00")){
    echo "Günaydın";
}
else if(date("10:00")<$date AND $date<date("17:00")) {
    echo "iYİ Günler";
}
else if(date("17:00")<$date AND $date<date("20:00")) {
    echo "iYİ Akşamlar";
}
else if(date("20:00")<$date AND $date <date("00:00")) {
    echo "iYİ Geceler";
}
else{
    echo "esenlikler dilerim";
}

?>