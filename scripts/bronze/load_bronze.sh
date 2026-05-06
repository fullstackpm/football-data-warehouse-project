'
=================================================================================================
Bash script: Load Bronze Layer (Source -> Bronze)
=================================================================================================
Script Purpose:
  This script procedure loads data into the "bronze" schema from external CSV files.
  It performs the following actions:
  - Truncates the bronze tables before loading data.
  - Bulk inserts the data
'

#!/bin/bash

# Football Data Warehouse - Bronze Layer Loader
# Usage: ./load_bronze.sh

DB_NAME="FootballDataWarehouse"
DB_USER="postgres"
DATA_PATH="/Users/saidursikder/Documents/projects/football-dwh/data"

echo "Loading bronze layer..."

psql -U $DB_USER -d $DB_NAME <<EOF

TRUNCATE TABLE bronze.players_details;
\copy bronze.players_details FROM '$DATA_PATH/players/players.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.players_valuations;
\copy bronze.players_valuations FROM '$DATA_PATH/players/player_valuations.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.players_transfers;
\copy bronze.players_transfers FROM '$DATA_PATH/players/transfers.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.games_appearances;
\copy bronze.games_appearances FROM '$DATA_PATH/games/appearances.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.games_details;
\copy bronze.games_details FROM '$DATA_PATH/games/games.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.games_lineups;
\copy bronze.games_lineups FROM '$DATA_PATH/games/game_lineups.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.games_events;
\copy bronze.games_events FROM '$DATA_PATH/games/game_events.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.games_club_games;
\copy bronze.games_club_games FROM '$DATA_PATH/games/club_games.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.competitions_clubs;
\copy bronze.competitions_clubs FROM '$DATA_PATH/competitions/clubs.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.competitions_details;
\copy bronze.competitions_details FROM '$DATA_PATH/competitions/competitions.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.competitions_countries;
\copy bronze.competitions_countries FROM '$DATA_PATH/competitions/countries.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

TRUNCATE TABLE bronze.competitions_national_teams;
\copy bronze.competitions_national_teams FROM '$DATA_PATH/competitions/national_teams.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

EOF

echo "Done!"
