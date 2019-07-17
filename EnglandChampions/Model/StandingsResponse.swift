//
//  StandingsResponse.swift
//  EnglandChampions
//
//  Created by Admin on 29/06/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import ObjectMapper

class StandingsResponse: Mappable {
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        api <- map["api"]
    }
    
    var api: APIResponse? = nil;
}

class APIResponse: Mappable {
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        results <- map["results"]
        standings <- map["standings"]
    }
    
    
    var results: Int?
    
    var standings: [[StandingModel]]?
}

class StandingModel: Mappable {
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        rank <- map["rank"]
        teamId <- map["team_id"]
        teamName <- map["teamName"]
        logo <- map["logo"]
        groupName <- map["group"]
        forme <- map["forme"]
        description <- map["description"]
        goalsDiff <- map["goalsDiff"]
        points <- map["points"]
        lastUpdate <- map["lastUpdate"]
    }
    
    var rank: Int?
    
    var teamId: Int?
    
    var teamName: String?
    
    var logo: String?
    
    var groupName: String?
    
    var forme: String?
    
    var description: String?
    
    var goalsDiff: Int?
    
    var points: Int?
    
    var lastUpdate: String?
}
