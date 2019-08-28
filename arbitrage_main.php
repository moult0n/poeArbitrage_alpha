<?php 
include_once 'framework.php';
include 'itemAnalysis.php';

$league = 'Legion';
$serverTick = 0;
$urlString = getUrlStringForLeague($league);
$urlStringRedirec = 'https://www.pathofexile.com/trade/search/Legion/';
$currencyArray = ['exa','chaos'];
$queryFlip = "select * from flip";
static $componentBaseQuery = "select * from component where id = ";
$arrayComponent = [
	'id' => 0,
	'name' => '',
	'query' => '',
	'fullSet' => 0
];
$component = [
	'id' => '',
	'databaseInfo' => NULL,
	'data' => NULL,
	'analysis' => NULL,
	'querySerial' => ''
];
$arrayFlip = array(
	'id' => 0,
	'name' => '',
	'component1' => $component,
	'component2' => $component,
	'component3' => $component,
	'sets' => 0,
	'costCompareFlag' => TRUE,
	'costDifference' => 0
);

$arrayAll = array();

//Setup and check connection to mysql database
$link = mysqli_connect("localhost","superUser", "password", "poe_flips");
if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    exit;
}
else{
	echo "Success: A proper connection to MySQL was made! The poe_flips database is great." . PHP_EOL;
}

echo "\n\n";

if($resultFlip = mysqli_query($link, $queryFlip)){
	$numFlips = mysqli_num_rows($resultFlip);
	while($rowFlip = mysqli_fetch_row($resultFlip)){
		$arrayComponent = array('id' => 0,'name' => '','query' => '','fullSet' => 0);
		$component = ['id' => '','databaseInfo' => NULL,'data' => NULL,'analysis' => NULL,'querySerial' => ''];
		$arrayFlip = array('id' => 0,'name' => '','component1' => $component,'component2' => $component,'component3' => $component,'sets' => 0,'costCompareFlag' => TRUE,'costDifference' => 0);
		//Transform the row array into a mixed array 
		$arrayFlip['id'] = (int) $rowFlip[0];
		$arrayFlip['name'] = $rowFlip[1];
		$arrayFlip['component1']['id'] = (int) $rowFlip[2];
		$arrayFlip['component2']['id'] = (int) $rowFlip[3];
		$arrayFlip['component3']['id'] = (int) $rowFlip[4];
		$arrayFlip['sets'] = (int) $rowFlip[5];
		$keys = array_keys($arrayFlip);
		for($i = 2; $i <= 4; $i++){
			$id = $arrayFlip[$keys[$i]]['id'];
			if($id != 0){
				$queryComponent = $componentBaseQuery . $id;
				$resultComponent = mysqli_query($link, $queryComponent);
				$rowComponent = mysqli_fetch_array($resultComponent, MYSQLI_NUM);
				$arrayComponent['id'] = (int) $rowComponent[0];
				$arrayComponent['name'] = $rowComponent[1];
				$arrayComponent['query'] = $rowComponent[2];
				$arrayComponent['fullSet'] = (int) $rowComponent[3];
				$arrayFlip[$keys[$i]]['databaseInfo'] = $arrayComponent;
				mysqli_free_result($resultComponent);
				//echo "Query: " . $arrayComponent['query'] . "\n";
				//echo "Component: " . $arrayComponent['name'];
				$data = collectData($urlString, $arrayComponent['query'], $arrayComponent['fullSet']*$arrayFlip['sets'], $serverTick, $currencyArray);
				if($data['itemArray'] === NULL){	
					$arrayFlip[$keys[$i]]['data'] = $data['error'];	
					$arrayFlip['costCompareFlag'] = FALSE;
				}
				else{
					$arrayFlip[$keys[$i]]['data'] = $data['itemArray'];
					$arrayFlip[$keys[$i]]['querySerial'] = $data['querySerial'];
					//IM HERE ADDING ITEM ANALYSIS
					$arrayFlip[$keys[$i]]['analysis'] = analysisManager($data['itemArray'],$currencyArray);
				}
				$serverTick = $data['serverTick'];
			}
		}
		//var_dump($arrayFlip);
		$condition = TRUE;
		$position = 0;
		$cost = [];
		if($arrayFlip['costCompareFlag'] === FALSE){
			printf("Grapped data for %s (%d/%d) --- Not enough components on the market for this flip.\n", $arrayFlip['name'], $arrayFlip['id'],$numFlips);
		}
		else{
			if($arrayFlip['component3']['id'] == NULL){
				$c1 = $arrayFlip['component1']['analysis']['averagePrice'] * $arrayFlip['component1']['databaseInfo']['fullSet'];
				$c2 = $arrayFlip['component2']['analysis']['averagePrice'] * $arrayFlip['component2']['databaseInfo']['fullSet'];
				$arrayFlip['costDifference'] = $c2 - $c1;
				printf("Grapped data for %s (%d/%d) --- Estimated Profit is %.2f\n chaos.", $arrayFlip['name'], $arrayFlip['id'],$numFlips, $arrayFlip['costDifference']);
				if($arrayFlip['costDifference'] > 0){
					$urlString1 = $urlStringRedirec . $arrayFlip['component1']['querySerial'];
					$urlString2 = $urlStringRedirec . $arrayFlip['component2']['querySerial'];
					printf("%s: %s\n%s: %s\n",$arrayFlip['component1']['databaseInfo']['name'],$urlString1, $arrayFlip['component2']['databaseInfo']['name'],$urlString2);
				}
			}
			else{
				$c1 = $arrayFlip['component1']['analysis']['averagePrice'] * $arrayFlip['component1']['databaseInfo']['fullSet'];
				$c2 = $arrayFlip['component2']['analysis']['averagePrice'] * $arrayFlip['component2']['databaseInfo']['fullSet'];
				$c3 = $arrayFlip['component3']['analysis']['averagePrice'] * $arrayFlip['component3']['databaseInfo']['fullSet'];
				$arrayFlip['costDifference'] = $c3 - $c2 - $c1;
				printf("Grapped data for %s (%d/%d) --- Estimated Profit is %.2f\n chaos.", $arrayFlip['name'], $arrayFlip['id'],$numFlips, $arrayFlip['costDifference']);
				if($arrayFlip['costDifference'] > 0){
					$urlString1 = $urlStringRedirec . $arrayFlip['component1']['querySerial'];
					$urlString2 = $urlStringRedirec . $arrayFlip['component2']['querySerial'];
					$urlString3 = $urlStringRedirec . $arrayFlip['component3']['querySerial'];
					printf("%s: %s\n%s: %s\n%s: %s\n",$arrayFlip['component1']['databaseInfo']['name'],$urlString1, $arrayFlip['component2']['databaseInfo']['name'],$urlString2, $arrayFlip['component3']['databaseInfo']['name'],$urlString3);
				}
			}
		}

		$arrayAll[] = $arrayFlip;
		echo "\n";
	}
	
}
mysqli_free_result($resultFlip);

if(file_exists('resultsAll.json')){	unlink('resultsAll.json');	}

$fp = fopen('resultsAll.json', 'w');
fwrite($fp, json_encode($arrayAll));
fclose($fp);

mysqli_close($link);
?>