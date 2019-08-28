<?php

include_once 'poeNinjaConversion.php';

function averagePrice($pricesArray){
	return array_sum($pricesArray)/floatval(count($pricesArray));
}

function getPrices($itemArray){
	$returnArray = [];
	$price = [];
	$valueListingCurrency = [];
	foreach ($itemArray as $key => $value) {
		$valueListingCurrency[] = $value["listing"]["price"]["currency"];	
		$amount = $value["listing"]["price"]["amount"];
		$price[] = floatval($amount);
	}
	$returnArray['price'] = $price;
	$returnArray['type'] = $valueListingCurrency;
	return $returnArray;
}

function convertCurrencyToChaos($prices){
	foreach($prices['type'] as $key => $value){
		if($value == 'chaos'){}
		elseif($value == 'exa'){
			$prices['price'][$key] = $prices['price'][$key]*getChaosConvertion('Exalted Orb');
			$prices['type'][$key] = 'chaos';
		}
	}
	return $prices;
}

function analysisManager($itemArray, $currencyType){
	if(!is_array($itemArray)){
		return FALSE;
	}
	$returnArray = array();
	$prices = getPrices($itemArray);
	$cCV = convertCurrencyToChaos($prices);
	$cCVP = $cCV['price'];

	$returnArray['priceArray'] = $cCV;
	$returnArray['averagePrice'] = averagePrice($cCVP);
	return $returnArray;
}

?>