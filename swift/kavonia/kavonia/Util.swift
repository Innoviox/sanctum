//
//  Util.swift
//  kavonia
//
//  Created by Sarah Leavitt on 3/19/20.
//  Copyright © 2020 Innoviox. All rights reserved.
//

import Foundation
import SceneKit
import SceneKit.ModelIO

let tile_map = [
    "A": "tile_riverCorner",
    "B": "tile_spawn",
    "C": "tile_wideSplit",
    "D": "tile_cornerLarge",
    "E": "tile_split",
    "F": "tile_straightHill",
    "G": "tile_slope",
    "H": "tile_endSpawn",
    "I": "tile_riverTransition",
    "J": "tile_transition",
    "K": "tile_hill",
    "L": "tile_riverStraight",
    "M": "tile",
    "N": "tile_tree",
    "O": "tile_riverSlope",
    "P": "tile_wideTransition",
    "Q": "tile_end",
    "R": "tile_cornerSquare",
    "S": "tile_riverSlopeLarge",
    "T": "tile_crossing",
    "U": "tile_endRoundSpawn",
    "V": "tile_cornerOuter",
    "W": "tile_riverBridge",
    "X": "tile_riverFall",
    "Y": "tile_wideStraight",
    "Z": "tile_bump",
    "a": "tile_cornerRound",
    "b": "tile_rock",
    "c": "tile_wideCorner",
    "d": "tile_spawnRound",
    "e": "tile_dirtHigh",
    "f": "tile_treeDouble",
    "g": "tile_cornerInner",
    "h": "tile_endRound",
    "i": "tile_straightHillLarge",
    "j": "tile_crystal",
    "k": "tile_dirt",
    "l": "tile_straight",
    "m": "tile_treeQuad",
]

let test_map = """
ABCDE
FGHIJ
KLMNO
PQRST
"""

func load_map(from map: String, to scene: SCNScene) -> [[SCNNode]] {
    var arr: [[SCNNode]] = []
    
    let lines = map.split(separator: "\n")

    for (i, line) in lines.enumerated() {
        var row: [SCNNode] = []
        for (j, char)in line.enumerated() {
            let obj = load_obj(from: tile_map[String(char)]!)
            obj.position = SCNVector3(x: Float(i), y: 0, z: Float(j))
            scene.rootNode.addChildNode(obj)
            
            row.append(obj)
        }
        arr.append(row)
    }
    
    return arr
}

func load_obj(from file: String) -> SCNNode {
    guard let url = Bundle.main.url(forResource: file, withExtension: "obj", subdirectory: "art.scnassets")
         else { fatalError("Failed to find model file.") }

    let asset = MDLAsset(url:url)
    guard let object = asset.object(at: 0) as? MDLMesh
         else { fatalError("Failed to get mesh from asset.") }

    return SCNNode(mdlObject: object)
}
