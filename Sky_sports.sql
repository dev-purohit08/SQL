CREATE DATABASE sky_sports;
USE sky;
SHOW TABLES;

-- 1. Show all the UNIQUE team names
SELECT DISTINCT(team)
FROM sky1;

-- 2. Show name of team which has rank 1 from group 7
SELECT team 
FROM sky1 
WHERE `rank` = 1 AND `group` = 7;

-- 3. Show count of all team
SELECT COUNT(team) 
FROM sky1;

-- 4. Show matches_played by each team
SELECT team, matches_played 
FROM sky1;

-- 5. Show team, percent of wins with respect to matches_played by each team and name the resulting column as wins_percent
SELECT team, 100.0*(wins/matches_played) AS wins_percent 
FROM sky1;

-- 6. Show which team has maximum goals_scored and how much
SELECT team, goals_scored 
FROM sky1
WHERE goals_scored = (SELECT MAX(goals_scored) FROM sky1);

-- 7. Show percent of draws with respect to matches_played round of to 2 digits by each team
SELECT team, ROUND(100.0*(draws/matches_played), 2) 
FROM sky1;

-- 8. Show which team has minimum goals_scored and how much
SELECT team, goals_scored 
FROM sky1 
WHERE goals_scored = (SELECT MIN(goals_scored) FROM sky1);

-- 9. Show percent of losses with respect to matches_played by each team in ascending order by losses and name the resulting column as losses_percent
SELECT team, 100.0*(losses/matches_played) AS losses_percent 
FROM sky1 
ORDER BY losses_percent;

-- 10. Show the average goal_difference
SELECT AVG(goal_difference) 
FROM sky1;

-- 11. Show name of the team where points are 0
SELECT team, points 
FROM sky1 
WHERE points = 0;

-- 12. Show all data where expected_goal_scored is less than exp_goal_conceded
SELECT * 
FROM sky1 
WHERE expected_goal_scored < exp_goal_conceded;

-- 13. Show data where exp_goal_difference is in between -0.5 and 0.5
SELECT * 
FROM sky1 
WHERE exp_goal_difference BETWEEN -0.5 AND 0.5;

-- 14. Show all data in ascending order by exp_goal_difference_per_90 
SELECT * 
FROM sky1 
ORDER BY exp_goal_difference_per_90 ASC;

-- 15. Show team which has maximum number of players_used
SELECT team, players_used 
FROM sky2 
WHERE players_used = (SELECT MAX(players_used) FROM sky2);

-- 16. Show each team name and avg_age in ascending order by avg_age
SELECT team, avg_age 
FROM sky2 
ORDER BY avg_age;

-- 17. Show average possession of teams
SELECT AVG(possession) 
FROM sky2;

-- 18. Show team which has played atleast 5 games
SELECT team, games 
FROM sky2 
WHERE games >= 5;

-- 19. Show all data for which minutes is greater than 600
SELECT * 
FROM sky2 
WHERE minutes > 600;

-- 20. Show team, goals, assists in ascending order by goals
SELECT team, goals, assists 
FROM sky2 
ORDER BY goals;

-- 21. Show team, pens_made, pens_att in descending order by pens_made
SELECT team, pens_made, pens_att 
FROM sky2 
ORDER BY pens_made DESC;

-- 22. Show team, cards_yellow, cards_red where cards_red is equal to 1 in ascending order by cards_yellow
SELECT team, cards_yellow, cards_red 
FROM sky2 
WHERE cards_red = 1 
ORDER BY cards_yellow;

-- 23. Show team, goals_per90, assists_per90, goals_assists_per90 in descending order by goals_assists_per90
SELECT team, goals_per90, assists_per90, goals_assists_per90 
FROM sky2 
ORDER BY goals_assists_per90 DESC;

-- 24. Show team, goals_pens_per90, goals_assists_pens_per90 in ascending order by goals_assists_pens_per90
SELECT team, goals_pens_per90, goals_assists_pens_per90 
FROM sky2 
ORDER BY goals_assists_pens_per90;

-- 25. Show team, shots, shots_on_target, shots_on_target_pct where shots_on_target_pct is less than 30 in ascending order by shots_on_target_pct
SELECT team, shots, shots_on_target, shots_on_target_pct 
FROM sky2 
WHERE shots_on_target_pct < 30 
ORDER BY shots_on_target_pct;

-- 26. Show team, shots_per90, shots_on_target_per90 for team Belgium
SELECT team, shots_per90, shots_on_target_per90 
FROM sky2 
WHERE team='Belgium';

-- 27. Show team, goals_per_shot, goals_per_shot_on_target, average_shot_distance in descending order by average_shot_distance
SELECT team, goals_per_shot, goals_per_shot_on_target, average_shot_distance 
FROM sky2 
ORDER BY average_shot_distance DESC;

-- 28. Show team, errors, touches for which errors is 0 and touches is less than 1500
SELECT team, errors, touches  
FROM sky2 
WHERE errors = 0 AND touches < 1500;

-- 29. Show team, fouls which has maximum number of fouls
SELECT team, MAX(fouls) 
FROM sky2;

-- 30. Show team, offisdes which has offsides less than 10 or greater than 20
SELECT team, offsides 
FROM sky2 
WHERE offsides < 10 OR offsides > 20;

-- 31. Show team, aerials_won, aerials_lost, aerials_won_pct in descending order by aerials_won_pct
SELECT team, aerials_won, aerials_lost, aerials_won_pct 
FROM sky2 
ORDER BY aerials_won_pct DESC;

-- 32. Show number of teams each group has
SELECT `group`, COUNT(team) 
FROM sky1 
GROUP BY `group`;

-- 33. Show team names group 6 has
SELECT team, `group` 
FROM sky1 
WHERE `group` = 6;

-- 34. Show Australia belongs to which group
SELECT team, `group` 
FROM sky1
WHERE team = 'Australia';

-- 35. Show group, average wins by each group
SELECT `group`, AVG(wins) 
FROM sky1 
GROUP BY `group`;

-- 36. Show group, maximum expected_goal_scored by each group in ascending order by expected_goal_scored  
SELECT gs.`group`, MAX(gs.expected_goal_scored) AS max_exp_goal_scored 
FROM sky1 gs 
GROUP BY gs.`group` 
ORDER BY max_exp_goal_scored;

-- 37. Show group, minimum exp_goal_conceded by each group in descending order by exp_goal_conceded
SELECT gs.`group`, MIN(gs.exp_goal_conceded) AS min_exp_goal_conceded 
FROM sky1 gs 
GROUP BY gs.`group` 
ORDER BY min_exp_goal_conceded DESC;

-- 38. Show group, average exp_goal_difference_per_90 for each group in ascending order by exp_goal_difference_per_90
SELECT gs.`group`, AVG(gs.exp_goal_difference_per_90) AS avg_exp_goal_diff_per_90 
FROM sky1 gs 
GROUP BY gs.`group` 
ORDER BY avg_exp_goal_diff_per_90;

-- 39. Show which team has equal number of goals_scored and goals_against
SELECT team, goals_scored, goals_against 
FROM sky1 
WHERE goals_scored = goals_against;

-- 40. Show which team has maximum players_used
SELECT team, players_used 
FROM sky2 
WHERE players_used = (SELECT MAX(players_used) FROM sky2);

-- 41. Show team, players_used, avg_age, games, minutes  where minutes less than 500 and greater than 200
SELECT team, players_used, avg_age, games, minutes 
FROM sky2 
WHERE minutes < 500 AND minutes > 200;

-- 42. Show all data of sky1 in ascending order BY points
SELECT * 
FROM sky1 
ORDER BY points;

-- 43. Show ALL UNIQUE team in ascending order by team
SELECT DISTINCT(team) 
FROM sky2 
ORDER BY team;

-- 44. Show average avg_age of each group and arrange it in descending order by avg_age.
SELECT gs.`group`, AVG(td.avg_age) AS avg_group_age
FROM sky2 td INNER JOIN sky1 gs 
ON td.team = gs.team
GROUP BY gs.`group` 
ORDER BY avg_group_age DESC;

-- 45. Show sum of fouls for each group and arrange it in ascending order by fouls.
SELECT gs.`group`, SUM(td.fouls) AS sum_fouls 
FROM sky2 td INNER JOIN sky1 gs 
ON td.team = gs.team
GROUP BY gs.`group` 
ORDER BY sum_fouls;

-- 46. Show total number of games for each group and arrange it in descending order by games.
SELECT gs.`group`, SUM(td.games) AS sum_games 
FROM sky2 td INNER JOIN sky1 gs 
ON td.team = gs.team
GROUP BY gs.`group` 
ORDER BY sum_games DESC;

-- 47. Show total number of players_used for each group and arrange it in ascending order by players_used.
SELECT gs.`group`, SUM(td.players_used) AS sum_players_used 
FROM sky2 td INNER JOIN sky1 gs
ON td.team = gs.team
GROUP BY gs.`group` 
ORDER BY sum_players_used;

-- 48. Show total number of offsides for each group and arrange it in ascending order by offsides.
SELECT gs.`group`, SUM(td.offsides) AS sum_offsides 
FROM sky2 td INNER JOIN sky1 gs 
ON td.team = gs.team
GROUP BY gs.`group` 
ORDER BY sum_offsides;

-- 49. Show average passes_pct for each group and arrange it in descending order by passes_pct.
SELECT gs.`group`, AVG(td.passes_pct) AS avg_passes_pct
FROM sky2 td INNER JOIN sky1 gs 
ON td.team = gs.team
GROUP BY gs.`group` 
ORDER BY avg_passes_pct DESC;

-- 50. Show average goals_per90 for each group and arrange it in ascending order by goals_per90.
SELECT gs.`group`, AVG(td.goals_per90) AS avg_goals_per90
FROM sky2 td INNER JOIN sky1 gs 
ON td.team = gs.team
GROUP BY gs.`group` 
ORDER BY avg_goals_per90;
