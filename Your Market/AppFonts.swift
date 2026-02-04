//
//  AppFonts.swift
//  Your Market
//
//  Created by Viktor Grygoriev on 2026-02-04.
//
import SwiftUI

enum AppFont {
    static func dancingBold(_ size: CGFloat) -> Font {
        .custom("DancingScript-Bold", size: size)
    }

    static func dancingMedium(_ size: CGFloat) -> Font {
        .custom("DancingScript-Medium", size: size)
    }

    static func dancingRegular(_ size: CGFloat) -> Font {
        .custom("DancingScript-Regular", size: size)
    }

    static func playwriteRegular(_ size: CGFloat) -> Font {
        .custom("PlaywriteUSTrad-Regular", size: size)
    }
}

