//
//  CustomCorners.swift
//  Pixel-Store
//
//  Created by Ahmed Sayed on 03/01/2024.
//

import SwiftUI

struct CustomCorners: Shape {

    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
