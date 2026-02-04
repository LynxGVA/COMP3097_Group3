//
//  FontDebug.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import UIKit

func printAllFonts() {
    for family in UIFont.familyNames.sorted() {
        print("== \(family) ==")
        for name in UIFont.fontNames(forFamilyName: family).sorted() {
            print("  \(name)")
        }
    }
}
