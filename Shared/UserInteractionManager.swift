//
//  UserInteractionHelper.swift
//  The Alan Parsons Project
//
//  Created by Thomas Schönmann on 16.04.17.
//  Copyright © 2017 Thomas Schönmann. All rights reserved.
//

import SpriteKit

class UserInteractionManager {
    
    // MARK: - Variables
    
    static let instance: UserInteractionManager = {
        return UserInteractionManager()
    }()
    
    var selection: BuildableUnit?
    
    // MARK: - Methods.
    
    private init() {}
    
    /// Check for every possible node touched by the user.
    ///
    /// - Parameters:
    ///   - event: The NSEvent from the sender.
    ///   - scene: The GameScene-object where the touch was registered.
    func checkInput(event: NSEvent, scene: GameScene) {
        
        // Start checking for possible touches.
        if isInBuildMenuView(event: event, scene: scene) {}
        else if isInStateValuesView(event: event, scene: scene) {}
        else if isInMap(event: event, scene: scene) {}
        else {
            print("No functional nodes were touched.")
        }
    }
    
    private func isInBuildMenuView(event: NSEvent, scene: GameScene) -> Bool {
        
        // TODO
        // Change to correct selection from build menu.
        if let node = scene.camMenu.atPoint(event.location(in: scene.camMenu)) as? SKSpriteNode {
            print("Hurray, a node in the build menu was touched: \(node.name ?? "No node-name provided.")!")
            
            if let name = node.name {
                switch name {
                case "forestTower":
                    //scene.buildMenu.select(key: BuildableUnitCategories, value: BuildableUnit)
                    selection = TowerBuilder.instance.start(type: .Basic).addVisuals().make()
                    print("forestTower touched and selcted.")
                default:
                    print("ERROR @ UserInteractionManager : isInBuildMenuView() : default called.")
                }
            }
            
            return true
        
        } else {
            return false
        }
    }
    
    private func isInStateValuesView(event: NSEvent, scene: GameScene) -> Bool {
        if let node = scene.stateValuesView.atPoint(event.location(in: scene.stateValuesView)) as? SKLabelNode {
            print("Hurray, a node in the state values view was touched: \(node.text!)!")
            return true
            
        } else {
            return false
        }
    }
    
    private func isInMap(event: NSEvent, scene: GameScene) -> Bool {
        let map = MapManager.instance.maps[.Ground]!
        let point = event.location(in: map)
        
        let c = map.tileColumnIndex(fromPosition: point)
        let r = map.tileRowIndex(fromPosition: point)
        
        print("Columnn touched: \(c).")
        print("Row touched: \(r).")
        
        if (map.contains(event.location(in: scene))) {
            print("Map touched.")
            
            if let unit = selection {
                unit.column = c
                unit.row = r
                
                MapManager.instance.add(building: unit, location: event.location(in: map))
            }
            
            // Every operation regarding the selection should now be processed, so clear the cache.
            selection = nil
            return true
            
        } else {
            print("No map touched.")
        }
        
        return false
    }
}
