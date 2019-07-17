//
//  FixturesResponse.swift
//  EnglandChampions
//
//  Created by Admin on 01/07/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import ObjectMapper

class FixturesResposne: Mappable {
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        api <- map["api"]
    }
    
    var api: FAPIResponse? = nil;
}

class FAPIResponse: Mappable {
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        results <- map["results"]
        fixtures <- map["fixtures"]
    }
    
    
    var results: Int?
    
    var fixtures: [FixtureModel]?
}

class FixtureModel: Mappable {
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        fixtureId <- map["fixture_id"]
        leagueId <- map["league_id"]
        eventDate <- map["event_date"]
        status <- map["status"]
        statusShort <- map["statusShort"]
        homeTeam <- map["homeTeam"]
        awayTeam <- map["awayTeam"]
        goalsHomeTeam <- map["goalsHomeTeam"]
        goalsAwayTeam <- map["goalsAwayTeam"]
    }
    
    var fixtureId: Int?
    
    var leagueId: Int?
    
    var eventDate: String?
//
//    @SerializedName("event_timestamp")
//    @Expose
//    public long event_timestamp;
//
//    @SerializedName("firstHalfStart")
//    @Expose
//    public long firstHalfStart;
//
//    @SerializedName("secondHalfStart")
//    @Expose
//    public long secondHalfStart;
//
//    @SerializedName("round")
//    @Expose
//    public String round;
    
    var status: String?
    
    var statusShort: String?
//
//    @SerializedName("elapsed")
//    @Expose
//    public int elapsed;
//
//    @SerializedName("venue")
//    @Expose
//    public String venue;
//
//    @SerializedName("referee")
//    @Expose
//    public String referee;
    
    var homeTeam: TeamDetails?
    
    var awayTeam: TeamDetails?
//
//    @SerializedName("score")
//    @Expose
//    public ScoreDetails score;
    
    var goalsHomeTeam: Int?
    
    var goalsAwayTeam: Int?
}

class TeamDetails: Mappable {
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        teamId <- map["team_id"]
        teamName <- map["team_name"]
        teamLogo <- map["logo"]
    }
    
    var teamId: Int?
    
    var teamName: String?
    
    var teamLogo: String?
}

//    public class ScoreDetails {
//        @SerializedName("halftime")
//        @Expose
//        public String halftime;
//
//        @SerializedName("fulltime")
//        @Expose
//        public String fulltime;
//
//        @SerializedName("extratime")
//        @Expose
//        public String extratime;
//
//        @SerializedName("penalty")
//        @Expose
//        public String penalty;
//    }
