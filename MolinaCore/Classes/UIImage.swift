//
//  UIImage.swift
//  TeslaCopilot
//
//  Created by Jaren Hamblin on 6/25/16.
//  Copyright © 2016 JariousApps. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    /// Returns a new image with the specified color and size
    public convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }

    /// Returns a base64 encoded string from a UIImage instance
    public var base64string: String? {
        let imageData = UIImagePNGRepresentation(self)
        let base64string = imageData?.base64EncodedString(options: .lineLength64Characters)
        return base64string
    }

    /// Initializes a UIImage given a base64 encoded string
    public convenience init?(base64string: String) {
        guard let decodedData = Data(base64Encoded: base64string, options: .ignoreUnknownCharacters) else { return nil }
        self.init(data: decodedData)
    }

    public class func convertToGrayScale(_ image: UIImage) -> UIImage {
        let imageRect:CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height

        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context?.makeImage()
        let newImage = UIImage(cgImage: imageRef!)
        
        return newImage
    }
}
