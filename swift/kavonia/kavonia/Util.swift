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

let rotations: [String: Float] = [
    "←": .pi / 2,
    "→": .pi * 3 / 2,
    "↑": 0,
    "↓": .pi,
    " ": 0
]

class Tile {
    var node: SCNNode
    
    init(_ obj: SCNNode, pos: SCNVector3, rot: Float) {
        node = obj
        node.position = pos
        node.rotation = SCNVector4(0, 1, 0, rot)
    }
}

let test_map = """
R↑l E←l R←
l←M l→M l←
Z→M l→M l←
l←M l→M l→
U→M R→l R↓
"""

func load_map(from map: String, to scene: SCNScene) -> [[Tile]] {
    var arr: [[Tile]] = []
    
    let lines = map.split(separator: "\n")

    for (i, line) in lines.enumerated() {
        var row: [Tile] = []
        for (j, char) in line.pairs.enumerated() {
            let obj = load_obj(from: tile_map[String(char)[0]]!)
            
            row.append(Tile(obj, pos: SCNVector3(x: Float(i), y: 0, z: Float(j)), rot: Float(rotations[String(char)[1]]!)))
            
            scene.rootNode.addChildNode(obj)
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

extension Collection {
    var pairs: [SubSequence] {
        var startIndex = self.startIndex
        let count = self.count
        let n = count/2 + count % 2
        return (0..<n).map { _ in
            let endIndex = index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return self[startIndex..<endIndex]
        }
    }
}

extension String {
    subscript (i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
