/*
=================================================================================================
DDL Script: Create Silver Tables
=================================================================================================
Script Purpose:
  This script creates tables in the 'silver' schema, dropping existing tables if they already exist.
  Run this script to re-define the DDL structure of 'bronze' Tables

*/

CREATE TABLE IF NOT EXISTS silver.players_details (
	player_id INTEGER,
	first_name TEXT,
	last_name TEXT,
	"name" TEXT,
	last_season INTEGER,
	current_club_id INTEGER,
	player_code TEXT,
	country_of_birth TEXT,
	city_of_birth TEXT,
	country_of_citizenship TEXT,
	date_of_birth TEXT,
	sub_position TEXT,
	"position" TEXT,
	foot TEXT,
	height_in_cm INTEGER,
	contract_expiration_date TEXT,
	agent_name TEXT,
	image_url TEXT,
	international_caps INTEGER,
	international_goals INTEGER,
	current_national_team_id INTEGER,
	url TEXT,
	current_club_domestic_competition_id TEXT,
	current_club_name TEXT,
	market_value_in_eur NUMERIC,
	highest_market_value_in_eur NUMERIC,
	dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.players_valuations (
	player_id INTEGER,
	date TEXT,
	market_value_in_eur NUMERIC,
	current_club_name TEXT,
	current_club_id INTEGER,
	player_club_domestic_competition_id TEXT,
	dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.players_transfers (
    player_id                           INTEGER,
    transfer_date                       TEXT,
    transfer_season                     TEXT,
    from_club_id                        INTEGER,
    to_club_id                          INTEGER,
    from_club_name                      TEXT,
    to_club_name                        TEXT,
    transfer_fee                        NUMERIC,
    market_value_in_eur                 NUMERIC,
    player_name                         TEXT,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.games_appearances (
    appearance_id                       TEXT,
    game_id                             INTEGER,
    player_id                           INTEGER,
    player_club_id                      INTEGER,
    player_current_club_id              INTEGER,
    date                                TEXT,
    player_name                         TEXT,
    competition_id                      TEXT,
    yellow_cards                        INTEGER,
    red_cards                           INTEGER,
    goals                               INTEGER,
    assists                             INTEGER,
    minutes_played                      INTEGER,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.games_club_games (
    game_id                             INTEGER,
    club_id                             INTEGER,
    own_goals                           INTEGER,
    own_position                        TEXT,
    own_manager_name                    TEXT,
    opponent_id                         INTEGER,
    opponent_goals                      INTEGER,
    opponent_position                   TEXT,
    opponent_manager_name               TEXT,
    hosting                             TEXT,
    is_win                              INTEGER,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.games_events (
    game_event_id                       TEXT,
    date                                TEXT,
    game_id                             INTEGER,
    "minute"                            INTEGER,
    "type"                              TEXT,
    club_id                             INTEGER,
    club_name                           TEXT,
    player_id                           INTEGER,
    description                         TEXT,
    player_in_id                        INTEGER,
    player_assist_id                    INTEGER,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.games_lineups (
    game_lineups_id                     TEXT,
    date                                TEXT,
    game_id                             INTEGER,
    player_id                           INTEGER,
    club_id                             INTEGER,
    player_name                         TEXT,
    type                                TEXT,
    "position"                          TEXT,
    number                              TEXT,
    team_captain                        INTEGER,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.games_details (
    game_id                             INTEGER,
    competition_id                      TEXT,
    season                              INTEGER,
    round                               TEXT,
    date                                TEXT,
    home_club_id                        INTEGER,
    away_club_id                        INTEGER,
    home_club_goals                     INTEGER,
    away_club_goals                     INTEGER,
    home_club_position                  INTEGER,
    away_club_position                  INTEGER,
    home_club_manager_name              TEXT,
    away_club_manager_name              TEXT,
    stadium                             TEXT,
    attendance                          INTEGER,
    referee                             TEXT,
    url                                 TEXT,
    home_club_formation                 TEXT,
    away_club_formation                 TEXT,
    home_club_name                      TEXT,
    away_club_name                      TEXT,
    "aggregate"                           TEXT,
    competition_type                    TEXT,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.competitions_clubs (
    club_id                             INTEGER,
    club_code                           TEXT,
    "name"                              TEXT,
    domestic_competition_id             TEXT,
    total_market_value                  TEXT,
    squad_size                          INTEGER,
    average_age                         NUMERIC,
    foreigners_number                   INTEGER,
    foreigners_percentage               NUMERIC,
    national_team_players               INTEGER,
    stadium_name                        TEXT,
    stadium_seats                       INTEGER,
    net_transfer_record                 TEXT,
    coach_name                          TEXT,
    last_season                         INTEGER,
    filename                            TEXT,
    url                                 TEXT,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.competitions_details (
    competition_id                      TEXT,
    competition_code                    TEXT,
    "name"                              TEXT,
    sub_type                            TEXT,
    "type"                                TEXT,
    country_id                          INTEGER,
    country_name                        TEXT,
    domestic_league_code                TEXT,
    confederation                       TEXT,
    total_clubs                         INTEGER,
    url                                 TEXT,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.competitions_countries (
    country_id                          INTEGER,
    country_name                        TEXT,
    country_code                        TEXT,
    confederation                       TEXT,
    total_clubs                         INTEGER,
    total_players                       INTEGER,
    average_age                         NUMERIC,
    url                                 TEXT,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS silver.competitions_national_teams (
    national_team_id                    INTEGER,
    "name"                              TEXT,
    team_code                           TEXT,
    country_id                          INTEGER,
    country_name                        TEXT,
    country_code                        TEXT,
    confederation                       TEXT,
    team_image_url                      TEXT,
    squad_size                          INTEGER,
    average_age                         NUMERIC,
    foreigners_number                   INTEGER,
    foreigners_percentage               NUMERIC,
    total_market_value                  NUMERIC,
    coach_name                          TEXT,
    fifa_ranking                        INTEGER,
    last_season                         INTEGER,
    url                                 TEXT,
	  dwh_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
