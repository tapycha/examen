//
//  Presenter.swift
//  ExamenPhotoApp
//
//  Created by Andrew Peneznyk on 25.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import Foundation
import Photos

protocol BusinessLogic {
    func loadPhoto()->Model
}

class Presenter: BusinessLogic{
    var view :DisplayLogic?
    var data: Model = Model()
    init() {
    }
    func loadPhoto() -> Model {
        let imageManager = PHImageManager.default()
              let requestOptions =   PHImageRequestOptions()
              requestOptions.isSynchronous = true
              requestOptions.deliveryMode = .opportunistic
              let fetchOptions = PHFetchOptions()
              fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
              
              if let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
                  if fetchResult.count>0{
                      for i in 0..<fetchResult.count{
                          imageManager.requestImage(for: fetchResult.object(at: i) as! PHAsset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: {
                              image, error in
                            self.data.imageArray.append(image!)
                          })
                      }
                  }
                  else{
                      print("There is no photo")
                  }
              }
               return data
    }
}
