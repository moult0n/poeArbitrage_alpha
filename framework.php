<?php

static $MAX_SERVER_TICKS = 1;

//returns the base url string for api requests for specified league
function getUrlStringForLeague($league){
	return 'https://www.pathofexile.com/api/trade/search/'.$league.'?source=';
}

//Post request using cUrl for the id codes for specified query
function postRequest($urlString,$queryString){
	$ch = curl_init($urlString);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLINFO_HEADER_OUT, true);
	curl_setopt($ch, CURLOPT_POST, true);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $queryString);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    	'Content-Type: application/json',
    	'Content-Length: ' . strlen($queryString))
	);
	$serverResponseString = curl_exec($ch);
	curl_close($ch);
	return $serverResponseString;
}

//Get request using cUrl for json data from api - used for getting item info from item id
function getRequest($urlString){
	$ch = curl_init($urlString);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLINFO_HEADER_OUT, true);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    	'Content-Type: application/json',
    	'Content-Length: 0')
	);
	$serverResponseString = curl_exec($ch);
	curl_close($ch);
	return $serverResponseString;
}

//Adds pauses into execution time to ensure api request cap isnt hit
function serverTicker($tick){
	$tick++;
	if($tick == $GLOBALS['MAX_SERVER_TICKS']){
		//echo "\nPause.\n";
		sleep(1);
		$tick = 0;
	}
	return $tick;
}

//Takes a server repsonse string, an item array and a currency array. Returns the item array with all items from the response string that match the currency types given in the currency array.
function itemListParser($serverResponseString, $itemArray, $currencyArray, $listingIdsWanted){

	if(!is_array($itemArray) || !is_array($currencyArray)){
		return $errorArray['error'] = 'ERROR: Either itemArray or currencyArray is not an array';
	}
	$removedListings = 0;
	$addedCount = 0;
	$serverResponseArray = json_decode($serverResponseString, true);	
	foreach ($serverResponseArray["result"] as $key => $value) {
		if(array_search($value["listing"]["price"]["currency"], $currencyArray) === FALSE){
			$removedListings++;
		}
		else{
			$itemArray[] = $value;
			if(count($itemArray) == $listingIdsWanted){
				$returnArray = [
					'itemArray' => $itemArray,
					'removedListings' => $removedListings
				];
				return $returnArray;
			}
			$addedCount++;
		}
	}
	$returnArray = [
		'itemArray' => $itemArray,
		'removedListings' => $removedListings
	];
	return $returnArray;
}

function serverResponseCheck($responseString){
	$responseArray = [
		'isValidResponse' => FALSE,
		'isReSearch' => FALSE
	];
	$arrayResponse = json_decode($responseString, true);
	$keys = NULL;
	if(is_array($arrayResponse)){
		$keys = array_keys($arrayResponse);
		if($keys[0] === 'result'){
			$responseArray['isValidResponse'] = TRUE;
			return $responseArray;
		}
		echo "\n Shit YOU FUCKED UP THE DATABASE FIX IT FOR THIS ITEM !!!!!!\n";
	}
	else{
		$responseArray['isReSearch'] = TRUE;
		return $responseArray;
	}
	return $responseArray;
}

//Ask api for specified number of items and return array w/ items
function collectData($urlString, $queryString, $listingIdsWanted, $serverTick, $currencyArray){
	static $ITEM_REQUEST_MAX = 10;	
	$returnArray = [];
	$returnArray['serverTick'] = $serverTick;
	$returnArray['itemArray'] = NULL;
	$returnArray['totalId'] = NULL;
	$serverResponseStringIdListings = '';
	//request ids for specified item. If cloudflare response is gotten, resend the request. if valid response continue with function
	//If invalid response and non-cloudflare response is gotten, then return error.
	$condition = FALSE;
	do{
		$condition = FALSE;
		$serverResponseStringIdListings = postRequest($urlString, $queryString);	
		$serverTick = serverTicker($serverTick);
		$checkID = serverResponseCheck($serverResponseStringIdListings);
		if($checkID['isReSearch'] == False){
			if($checkID['isValidResponse'] == False){
				$returnArray['error'] = 'An issue occured with the server response for query: ' . $queryString . ' response was ' . $serverResponseStringIdListings . '.';
				return $returnArray;
			}
		}

		if($checkID['isReSearch'] === TRUE){
			$condition = TRUE;
			echo "\nGot cloudflared, pausing program for 10 secs\n";
			sleep(10);
		}
	}while($condition);	
	//For valid responses with enough ids, get array of json information. For valid responses without enough id's
	//return an error message
	$serverResponseArrayIdListings = json_decode($serverResponseStringIdListings, true);
	$serverResponseArrayKeys = array_keys($serverResponseArrayIdListings);
	$serverResponseArrayTotal = $serverResponseArrayIdListings[$serverResponseArrayKeys[2]];
	if($serverResponseArrayTotal < $listingIdsWanted){		
		$returnArray['error'] = 'An insignificant number of items exist to do that flip exist';
		$returnArray['totalId'] = $serverResponseArrayTotal;
		return $returnArray;
	}
	$serverResponseId = $serverResponseArrayIdListings["id"];
	$returnArray['querySerial'] = $serverResponseId;
	$itemArray = [];
	$idCount = 0;
	$currentIdPosition = 0;
	$idGrab = $ITEM_REQUEST_MAX;
	$itemIdString = "";
	//Grab items associated with id's
	do{
		if( ($serverResponseArrayTotal - $idCount) < $ITEM_REQUEST_MAX ){
			$idGrab = ($serverResponseArrayTotal - $idCount);
		}
		else{
			$idGrab = $ITEM_REQUEST_MAX;
		}
		for($i = 0; $i < $idGrab; $i++){ 			
			$itemIdString .= $serverResponseArrayIdListings[$serverResponseArrayKeys[0]][$currentIdPosition];
			if( $i == ($idGrab - 1)){}
			else{
				$itemIdString .= ",";
			}	
			$currentIdPosition++;			
		}
		$idCount = $currentIdPosition;
		$urlStringItem = "https://www.pathofexile.com/api/trade/fetch/". $itemIdString."?query=". $serverResponseId;
		$condition = FALSE;
		do{
			$condition = FALSE;
			$serverResponseStringIdListingsItem = getRequest($urlStringItem);
			$serverTick = serverTicker($serverTick);
			$checkID = serverResponseCheck($serverResponseStringIdListingsItem);
			if($checkID['isReSearch'] == False){
				if($checkID['isValidResponse'] == False){
					$returnArray['error'] = 'An issue occured with the server response for query: ' . $queryString . ' response was ' . $serverResponseStringIdListingsItem . '.';
					return $returnArray;
				}
			}
			if($checkID['isReSearch'] === TRUE){
				$condition = TRUE;
				echo "\nGot cloudflared (during item get call), pausing program for 10 secs\n";
				sleep(10);
			}
		}while($condition);
		$parsedArray = itemListParser($serverResponseStringIdListingsItem, $itemArray, $currencyArray, $listingIdsWanted);
		$itemArray = $parsedArray['itemArray'];
		if( count($itemArray) == $listingIdsWanted){
			$returnArray['serverTick'] = $serverTick;
			$returnArray['itemArray'] = $itemArray;
			$returnArray['error'] = NULL; 
			return $returnArray;
		}
		$itemArray = $parsedArray['itemArray'];
		$itemIdString = '';

	}while( $currentIdPosition < $serverResponseArrayTotal );
	$returnArray['serverTick'] = $serverTick;
	$returnArray['itemArray'] = $itemArray;
	$returnArray['error'] = 'Not Enough ID\'s with valid information';
	return $returnArray;
}

?>