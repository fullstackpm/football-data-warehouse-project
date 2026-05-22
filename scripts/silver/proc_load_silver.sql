CREATE OR REPLACE PROCEDURE silver.load_silver_layer()
LANGUAGE plpgsql
AS $$
BEGIN

    -- =============================================
    -- competitions_clubs
    -- =============================================
    RAISE NOTICE 'Loading silver.competitions_clubs...';
    TRUNCATE TABLE silver.competitions_clubs;
    INSERT INTO silver.competitions_clubs (
        club_id,
        club_code,
        "name",
        domestic_competition_id,
        country,
        total_market_value,
        squad_size,
        average_age,
        foreigners_number,
        foreigners_percentage,
        national_team_players,
        stadium_name,
        stadium_seats,
        net_transfer_record,
        coach_name,
        last_season,
        dwh_created_at
    )
    SELECT
        club_id,
        club_code,
        "name",
        domestic_competition_id,
        CASE domestic_competition_id
            WHEN 'KR1' THEN 'Croatia'
            WHEN 'PO1' THEN 'Portugal'
            WHEN 'BRA1' THEN 'Brazil'
            WHEN 'A1' THEN 'Austria'
            WHEN 'NO1' THEN 'Norway'
            WHEN 'GR1' THEN 'Greece'
            WHEN 'L1' THEN 'Germany'
            WHEN 'SER1' THEN 'Serbia'
            WHEN 'RSK1' THEN 'South Korea'
            WHEN 'AUS1' THEN 'Australia'
            WHEN 'ARG1' THEN 'Argentina'
            WHEN 'BE1' THEN 'Belgium'
            WHEN 'JAP1' THEN 'Japan'
            WHEN 'RU1' THEN 'Russia'
            WHEN 'UKR1' THEN 'Ukraine'
            WHEN 'RO1' THEN 'Romania'
            WHEN 'DK1' THEN 'Denmark'
            WHEN 'SE1' THEN 'Sweden'
            WHEN 'SA1' THEN 'Saudi Arabia'
            WHEN 'TS1' THEN 'Czech Republic'
            WHEN 'ES1' THEN 'Spain'
            WHEN 'GB1' THEN 'England'
            WHEN 'NL1' THEN 'Netherlands'
            WHEN 'IT1' THEN 'Italy'
            WHEN 'FR1' THEN 'France'
            WHEN 'C1' THEN 'Switzerland'
            WHEN 'COL1' THEN 'Columbia'
            WHEN 'MLS1' THEN 'United States'
            WHEN 'SC1' THEN 'Scotland'
            WHEN 'PL1' THEN 'Poland'
            WHEN 'MEX1' THEN 'Mexico'
            WHEN 'TR1' THEN 'Turkey'
            ELSE 'Unknown'
        END AS country,
        total_market_value,
        squad_size,
        average_age,
        foreigners_number,
        foreigners_percentage,
        national_team_players,
        stadium_name,
        stadium_seats,
        net_transfer_record,
        COALESCE(coach_name, 'N/A'),
        last_season,
        CURRENT_TIMESTAMP
    FROM bronze.competitions_clubs;

    -- =============================================
    -- competitions_details
    -- =============================================
    RAISE NOTICE 'Loading silver.competitions_details...';
    TRUNCATE TABLE silver.competitions_details;
    INSERT INTO silver.competitions_details (
        competition_id,
        competition_code,
        "name",
        sub_type,
        "type",
        country_id,
        country_name,
        domestic_league_code,
        confederation,
        total_clubs,
        dwh_created_at
    )
    SELECT
        competition_id,
        competition_code,
        "name",
        sub_type,
        "type",
        country_id,
        CASE
            WHEN country_name = 'Türkiye' THEN 'Turkey'
            WHEN country_name = 'Korea, South' THEN 'South Korea'
            WHEN country_name = 'Colombia' THEN 'Columbia'
            ELSE COALESCE(country_name, 'N/A')
        END AS country_name,
        COALESCE(domestic_league_code, 'N/A'),
        confederation,
        total_clubs,
        CURRENT_TIMESTAMP
    FROM bronze.competitions_details;

    -- =============================================
    -- competitions_countries
    -- =============================================
    RAISE NOTICE 'Loading silver.competitions_countries...';
    TRUNCATE TABLE silver.competitions_countries;
    INSERT INTO silver.competitions_countries (
        country_id,
        country_name,
        country_code,
        confederation,
        total_clubs,
        total_players,
        average_age,
        dwh_created_at
    )
    SELECT
        country_id,
        CASE
            WHEN country_name = 'Türkiye' THEN 'Turkey'
            WHEN country_name = 'Korea, South' THEN 'South Korea'
            WHEN country_name = 'Colombia' THEN 'Columbia'
            ELSE country_name
        END AS country_name,
        country_code,
        CASE confederation
            WHEN 'europa' THEN 'Europe'
            WHEN 'amerika' THEN 'America'
            WHEN 'afrika' THEN 'Africa'
            WHEN 'asien' THEN 'Asia'
            ELSE confederation
        END AS confederation,
        total_clubs,
        total_players,
        average_age,
        CURRENT_TIMESTAMP
    FROM bronze.competitions_countries;

    -- =============================================
    -- competitions_national_teams
    -- =============================================
    RAISE NOTICE 'Loading silver.competitions_national_teams...';
    TRUNCATE TABLE silver.competitions_national_teams;
    INSERT INTO silver.competitions_national_teams (
        national_team_id,
        "name",
        team_code,
        country_id,
        country_name,
        country_code,
        confederation,
        team_image_url,
        squad_size,
        average_age,
        foreigners_number,
        foreigners_percentage,
        total_market_value,
        coach_name,
        fifa_ranking,
        last_season,
        dwh_created_at
    )
    SELECT
        national_team_id,
        CASE
            WHEN "name" = 'Türkiye' THEN 'Turkey'
            WHEN "name" = 'Korea, South' THEN 'South Korea'
            WHEN "name" = 'Colombia' THEN 'Columbia'
            ELSE "name"
        END AS "name",
        team_code,
        country_id,
        country_name,
        country_code,
        confederation,
        team_image_url,
        squad_size,
        average_age,
        foreigners_number,
        foreigners_percentage,
        total_market_value,
        COALESCE(coach_name, 'N/A'),
        fifa_ranking,
        last_season,
        CURRENT_TIMESTAMP
    FROM bronze.competitions_national_teams;

    -- =============================================
    -- players_details
    -- =============================================
    RAISE NOTICE 'Loading silver.players_details...';
    TRUNCATE TABLE silver.players_details;
    INSERT INTO silver.players_details (
        player_id,
        first_name,
        last_name,
        "name",
        last_season,
        current_club_id,
        player_code,
        country_of_birth,
        city_of_birth,
        country_of_citizenship,
        date_of_birth,
        sub_position,
        "position",
        foot,
        height_in_cm,
        contract_expiration_date,
        agent_name,
        image_url,
        international_caps,
        international_goals,
        current_national_team_id,
        current_club_domestic_competition_id,
        current_club_name,
        market_value_in_eur,
        highest_market_value_in_eur,
        age,
        dwh_created_at
    )
    SELECT
        player_id,
        first_name,
        last_name,
        "name",
        last_season,
        current_club_id,
        player_code,
        country_of_birth,
        city_of_birth,
        country_of_citizenship,
        date_of_birth,
        sub_position,
        "position",
        foot,
        height_in_cm,
        contract_expiration_date,
        COALESCE(agent_name, 'N/A'),
        image_url,
        international_caps,
        international_goals,
        current_national_team_id,
        current_club_domestic_competition_id,
        current_club_name,
        market_value_in_eur,
        highest_market_value_in_eur,
        CASE
            WHEN date_of_birth IS NOT NULL
            THEN DATE_PART('year', AGE(CURRENT_DATE, date_of_birth::DATE))
            ELSE NULL
        END AS age,
        CURRENT_TIMESTAMP
    FROM bronze.players_details;

    -- =============================================
    -- players_valuations
    -- =============================================
    RAISE NOTICE 'Loading silver.players_valuations...';
    TRUNCATE TABLE silver.players_valuations;
    INSERT INTO silver.players_valuations (
        player_id,
        date,
        market_value_in_eur,
        current_club_name,
        current_club_id,
        player_club_domestic_competition_id,
        dwh_created_at
    )
    SELECT
        player_id,
        date,
        market_value_in_eur,
        current_club_name,
        current_club_id,
        player_club_domestic_competition_id,
        CURRENT_TIMESTAMP
    FROM bronze.players_valuations;

    -- =============================================
    -- players_transfers
    -- =============================================
    RAISE NOTICE 'Loading silver.players_transfers...';
    TRUNCATE TABLE silver.players_transfers;
    INSERT INTO silver.players_transfers (
        player_id,
        transfer_date,
        transfer_season,
        from_club_id,
        to_club_id,
        from_club_name,
        to_club_name,
        transfer_fee,
        market_value_in_eur,
        player_name,
        dwh_created_at
    )
    SELECT
        player_id,
        transfer_date,
        transfer_season,
        from_club_id,
        to_club_id,
        from_club_name,
        to_club_name,
        transfer_fee,
        market_value_in_eur,
        player_name,
        CURRENT_TIMESTAMP
    FROM bronze.players_transfers;

    -- =============================================
    -- games_appearances
    -- =============================================
    RAISE NOTICE 'Loading silver.games_appearances...';
    TRUNCATE TABLE silver.games_appearances;
    INSERT INTO silver.games_appearances (
        appearance_id,
        game_id,
        player_id,
        player_club_id,
        player_current_club_id,
        date,
        player_name,
        competition_id,
        yellow_cards,
        red_cards,
        goals,
        assists,
        minutes_played,
        dwh_created_at
    )
    SELECT
        appearance_id,
        game_id,
        player_id,
        player_club_id,
        player_current_club_id,
        date,
        player_name,
        competition_id,
        yellow_cards,
        red_cards,
        goals,
        assists,
        minutes_played,
        CURRENT_TIMESTAMP
    FROM bronze.games_appearances;

    -- =============================================
    -- games_club_games
    -- =============================================
    RAISE NOTICE 'Loading silver.games_club_games...';
    TRUNCATE TABLE silver.games_club_games;
    INSERT INTO silver.games_club_games (
        game_id,
        club_id,
        own_goals,
        own_position,
        own_manager_name,
        opponent_id,
        opponent_goals,
        opponent_position,
        opponent_manager_name,
        hosting,
        is_win,
        dwh_created_at
    )
    SELECT
        game_id,
        club_id,
        own_goals,
        COALESCE(own_position, 'N/A'),
        own_manager_name,
        opponent_id,
        opponent_goals,
        COALESCE(opponent_position, 'N/A'),
        opponent_manager_name,
        hosting,
        is_win,
        CURRENT_TIMESTAMP
    FROM bronze.games_club_games;

    -- =============================================
    -- games_events
    -- =============================================
    RAISE NOTICE 'Loading silver.games_events...';
    TRUNCATE TABLE silver.games_events;
    INSERT INTO silver.games_events (
        game_event_id,
        date,
        game_id,
        "minute",
        "type",
        club_id,
        club_name,
        player_id,
        description,
        player_in_id,
        player_assist_id,
        dwh_created_at
    )
    SELECT
        game_event_id,
        date,
        game_id,
        "minute",
        "type",
        club_id,
        club_name,
        player_id,
        description,
        player_in_id,
        player_assist_id,
        CURRENT_TIMESTAMP
    FROM bronze.games_events;

    -- =============================================
    -- games_lineups
    -- =============================================
    RAISE NOTICE 'Loading silver.games_lineups...';
    TRUNCATE TABLE silver.games_lineups;
    INSERT INTO silver.games_lineups (
        game_lineups_id,
        date,
        game_id,
        player_id,
        club_id,
        player_name,
        type,
        "position",
        number,
        team_captain,
        dwh_created_at
    )
    SELECT
        game_lineups_id,
        date,
        game_id,
        player_id,
        club_id,
        player_name,
        type,
        CASE
            WHEN "position" ILIKE 'midfield' THEN 'Midfield'
            WHEN "position" ILIKE 'Sweeper' THEN 'Centre-Back'
            ELSE COALESCE("position", 'N/A')
        END AS "position",
        number,
        team_captain,
        CURRENT_TIMESTAMP
    FROM bronze.games_lineups;

    -- =============================================
    -- games_details
    -- =============================================
    RAISE NOTICE 'Loading silver.games_details...';
    TRUNCATE TABLE silver.games_details;
    INSERT INTO silver.games_details (
        game_id,
        competition_id,
        season,
        round,
        date,
        home_club_id,
        away_club_id,
        home_club_goals,
        away_club_goals,
        home_result,
        away_result,
        home_club_position,
        away_club_position,
        home_club_manager_name,
        away_club_manager_name,
        stadium,
        attendance,
        referee,
        home_club_formation,
        away_club_formation,
        home_club_name,
        away_club_name,
        "aggregate",
        competition_type,
        dwh_created_at
    )
    SELECT
        game_id,
        competition_id,
        season,
        CASE
            WHEN round ILIKE 'group%' THEN 'Group Stage'
            WHEN round = '|' THEN 'N/A'
            WHEN round = 'First Preliminary Round' THEN 'Qualifying Round'
            WHEN round ILIKE 'qualifying%' THEN 'Qualifying Round'
            WHEN round ILIKE '%vorrunde' THEN 'Qualifying Round'
            WHEN round ILIKE 'qualification round deciders' THEN 'Qualifying Round'
            WHEN round ILIKE 'First Round%' THEN 'First Round'
            WHEN round ILIKE 'Second Round%' THEN 'Second Round'
            WHEN round ILIKE 'Third Round%' THEN 'Third Round'
            WHEN round ILIKE '3rd round%' THEN 'Third Round'
            WHEN round ILIKE '4th round 1st leg' THEN 'Fourth Round'
            WHEN round ILIKE '5th round' THEN 'Fifth Round'
            WHEN round ILIKE '6th round deciders' THEN 'Sixth Round'
            WHEN round ILIKE 'Semi-Finals%' THEN 'Semi-Finals'
            WHEN round ILIKE 'Quarter-Finals%' THEN 'Quarter-Finals'
            WHEN round ILIKE 'last 16%' THEN 'Round of 16'
            WHEN round ILIKE 'Round of 16%' THEN 'Round of 16'
            WHEN round ILIKE 'final%' THEN 'Final'
            WHEN round ILIKE 'intermediate stage%' THEN 'Knockout Rounds'
            WHEN round ILIKE '5th place match' THEN 'Fifth Place'
            ELSE round
        END AS round,
        date,
        home_club_id,
        away_club_id,
        home_club_goals,
        away_club_goals,
        CASE
            WHEN home_club_goals > away_club_goals THEN 'Win'
            WHEN home_club_goals < away_club_goals THEN 'Loss'
            WHEN home_club_goals = away_club_goals THEN 'Draw'
            ELSE 'Unknown'
        END AS home_result,
        CASE
            WHEN away_club_goals > home_club_goals THEN 'Win'
            WHEN away_club_goals < home_club_goals THEN 'Loss'
            WHEN away_club_goals = home_club_goals THEN 'Draw'
            ELSE 'Unknown'
        END AS away_result,
        home_club_position,
        away_club_position,
        home_club_manager_name,
        away_club_manager_name,
        stadium,
        attendance,
        referee,
        CASE
            WHEN home_club_formation IN (
                '0-10-0','7-2-1','5-5-0','6-4-0','2-2-6','6-1-3','2-6-2',
                '6-3-1','4-1-5','6-2-2','1-7-2','7-1-2','3-1-6','2-8-0',
                '3-3-3-1','5-2-3','1-9-0','5-1-4','4-6-0','3-7-0','2-7-1',
                '3-6-1','7-3-0'
            ) THEN 'N/A'
            WHEN home_club_formation = '3-2-5' THEN '5-3-2'
            WHEN home_club_formation = '4-3-3 Attacking' THEN '4-3-3'
            WHEN home_club_formation = '2-4-4' THEN '4-4-2'
            WHEN home_club_formation = '4-4-2 double 6' THEN '4-4-2'
            WHEN home_club_formation = '1-5-4' THEN '4-5-1'
            WHEN home_club_formation = '3-5-2 flat' THEN '3-5-2'
            WHEN home_club_formation = '1-6-3' THEN '3-6-1'
            WHEN home_club_formation = '2-3-5' THEN '5-3-2'
            WHEN home_club_formation = '4-4-2 Diamond' THEN '4-4-2'
            WHEN home_club_formation = '3-3-4' THEN '4-3-3'
            WHEN home_club_formation = '4-5-1 flat' THEN '4-5-1'
            WHEN home_club_formation = '3-4-3 Diamond' THEN '3-4-3'
            WHEN home_club_formation = '3-5-2 Attacking' THEN '3-5-2'
            WHEN home_club_formation = '2-5-3' THEN '3-5-2'
            WHEN home_club_formation = '5-4-1 Diamond' THEN '5-4-1'
            ELSE COALESCE(home_club_formation, 'N/A')
        END AS home_club_formation,
        COALESCE(away_club_formation, 'N/A'),
        home_club_name,
        away_club_name,
        "aggregate",
        competition_type,
        CURRENT_TIMESTAMP
    FROM bronze.games_details;

    RAISE NOTICE 'Silver layer loaded successfully!';

END;
$$;

-- ======================================================
-- This is the call we use to run the above in postgres
-- CALL silver.load_silver_layer();
-- ======================================================
