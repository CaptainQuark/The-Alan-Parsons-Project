//
//  TowerBuilder.swift
//  The Alan Parsons Project
//
//  Created by Thomas Schönmann on 28.04.17.
//  Copyright © 2017 Thomas Schönmann. All rights reserved.
//

import GameplayKit

class TowerBuilder {

    // MARK: - Variables
    
    static let instance: TowerBuilder = {
        return TowerBuilder()
    }()
    
    var towerInCache: Tower?
    
    enum TowerType {
        case Basic
        case Advanced
    }
    
    // MARK: - Methods.
    
    private init() {}
    
    func start(type: TowerType) -> TowerBuilder {
        TowerBuilder.instance.towerInCache = Tower(
            column: 0,
            row: 0,
            type: type,
            name: createName(),
            rangeImage: createRangeImage(type: type),
            originOfRange: CGPoint(x: 0, y: 0),
            level: 1,
            coolDownTimeInMillis: 1000,
            initalResourcesRequired: [Resources.Coal:100])
        
        return self
    }
    
    func addVisuals() -> TowerBuilder {
        if let tower = towerInCache {
            switch tower.type {
            case .Basic:
                // DEBUG Replace with meaningful selection of visual representation.
                towerInCache?.visuals = MapBuilder.instance.defaultBuildingSet.tileGroups
            default:
                print("ERROR @ TowerBuiler : addVisuals() : No matching type in switch found.")
            }
        }
        
        return self
    }
    
    // TODO
    // Add funtion to add constraints.
    
    func make() -> Tower {
        return towerInCache!
    }
    
    fileprivate func createName() -> String {
        let names = ["Türmchen", "Tower Number One"]
        
        return names[GKRandomSource.sharedRandom().nextInt(upperBound: names.count)]
    }
    
    fileprivate func createRangeImage(type: TowerType) -> SKShapeNode {
        var radius: CGFloat
        
        switch type {
        case .Basic:
            radius = 30
        default:
            print("ERROR @ TowerBuiler : createRangeImage() : No matching type in switch found.")
            radius = 50
        }
        
        let shape = SKShapeNode(circleOfRadius: radius)
        shape.fillColor = .blue
        shape.alpha = 0.5
        
        return shape
    }
}
