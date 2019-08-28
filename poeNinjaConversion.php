<?php

include_once 'framework.php';

//Get currency info for specific league and save to file
function getConversionInfo($league) : void{
	$urlString = 'https://poe.ninja/api/data/ItemOverview?league='.$league.'&type=Currency';
	$serverResponseString = getRequest($urlString);
	$fp = fopen('resultsPNC.json', 'w');
	fwrite($fp, $serverResponseString);
	fclose($fp);
};

//Find chaos convertion for specified currency
function getChaosConvertion($currencyType){
	$fileNPC = 'resultsPNC.json';
	$fp = fopen($fileNPC, 'r');
	$content = fread($fp, filesize($fileNPC));
	fclose($fp);
	$arrayNPC = json_decode($content, true);
	foreach($arrayNPC['lines'] as $key => $value){		
		if($value['currencyTypeName'] == $currencyType){
			return $value['chaosEquivalent'];
		}
	}	
	return false;
}

//Takes exalt based listing price and returns converted amount in ex/chaos
function splitCurrencyValue($amount){
	$exWorth = getChaosConvertion('Exalted Orb');
	$ex = (int) $amount;
	$chaos = ($amount - $ex) * $exWorth;
	$currencyArray = [
		'exa' => $ex,
		'chaos' => $chaos
	];
	return $currencyArray;
}
?>