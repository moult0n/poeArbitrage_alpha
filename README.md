# poeArbitrage_alpha
Set of php scripts that using a mysql database, query the Path of Exile api for trade information on potential arbitrage.

Built using php version 7.2.19 w/ phpCurl and phpMysql, using mysql version 14.14 Distrib 5.7.27.

By the php by default connects through a user 'superUser' w/ the password 'password', either follow this when initally setting up mysql database or change in arbitrage_main file. 

Basics on making api calls (how to make json query):
	https://www.reddit.com/r/pathofexiledev/comments/7aiil7/how_to_make_your_own_queries_against_the_official/