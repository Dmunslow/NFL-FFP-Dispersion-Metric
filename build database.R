##############################
##### Build Database #########
##############################


#set wd
setwd("E:/Projects/NFL FFP Dispersion")

# Get nflscrapR package from github

library(devtools)

devtools::install_github(repo = "maksimhorowitz/nflscrapR")


# Load Package

library(nflscrapR)

# Download Data for all seasons - takes ~15 minutes to load
playerstats09 <- season_player_game(Season = 2009)
playerstats10 <- season_player_game(Season = 2010)
playerstats11 <- season_player_game(Season = 2011)
playerstats12 <- season_player_game(Season = 2012)
playerstats13 <- season_player_game(Season = 2013)
playerstats14 <- season_player_game(Season = 2014)
playerstats15 <- season_player_game(Season = 2015)
playerstats16 <- season_player_game(Season = 2016)


# combine all downloaded data 
gamePlayerStats <- rbind(playerstats09, playerstats10, playerstats11,
                        playerstats12, playerstats13, playerstats14,
                        playerstats15, playerstats16)

# write data to csv for later retrieval
write.csv(gamePlayerStats, "./player_stats_bygame_09_16.csv", row.names = F)


###### Compile stats into season long
library(dplyr)

groupedPlayerStats <- group_by(gamePlayerStats, playerID, Season)

seasonPlayerStats <- summarize(groupedPlayerStats, pass.att = sum(pass.att), pass.comp = sum(pass.comp),
                               passyds = sum(passyds), pass.tds = sum(pass.tds), pass.ints = sum(pass.ints),
                               pass.twopta = sum(pass.twopta), pass.twoptm = sum(pass.twoptm),
                               rush.att = sum(rush.att), rushyds = sum(rushyds), rushtds = sum(rushtds),
                               rushlng = max(rushlng), rushlngtd = max(rushlngtd), rush.twopta = sum(rush.twopta),
                               rush.twoptm = sum(rush.twoptm), recept = sum(recept), recyds = sum(recyds), rec.tds = sum(rec.tds),
                               reclng = max(reclng), reclngtd = max(reclngtd), rec.twopta = sum(rec.twopta),
                               rec.twoptm = sum(rec.twoptm), kick.rets = sum(kick.rets), kickret.avg = mean(kickret.avg),
                               kickret.tds = sum(kickret.tds), kick.ret.lng = max(kick.ret.lng), kickret.lngtd = max(kickret.lngtd),
                               punt.rets = sum(punt.rets), puntret.avg = mean(puntret.avg), puntret.tds = sum(puntret.tds),
                               puntret.lng = max(puntret.lng), puntret.lngtd = max(puntret.lngtd), 
                               fgm = sum(fgm), fga = sum(fga), fgyds = sum(fgyds), totpts.fg = sum(totpts.fg), xpmade = sum(xpmade),
                               xpmissed = sum(xpmissed), xpa = sum(xpa), xpb = sum(xpb), xppts.tot = sum(xppts.tot), 
                               tackles = sum(tackles), asst.tackles = sum(asst.tackles), sacks = sum(sacks), defints = sum(defints),
                               forced.fumbs = sum(forced.fumbs), totalfumbs = sum(totalfumbs), recfumbs = sum(recfumbs), 
                               totalrecfumbs = sum(recfumbs), fumbyds = sum(fumbyds), fumbslost = sum(fumbslost), games = sum(games))

# Write season data to csv
write.csv(seasonPlayerStats, "./player_stats_seasonlong_09_16.csv", row.names = F)