//
//  CoreDataManager.swift
//  BookApp
//
//  Created by SAMSUNG on 5/8/24.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    var persistent : NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    func saveWish(myWish: MyWish) {
        guard let context = self.persistent?.viewContext else { return }
        let newPd = Wish(context: context)
        newPd.price = Int64(myWish.price)
        newPd.title = myWish.title
        newPd.thumbnail = myWish.thumbnail
        try? context.save()
    }
    
    func readWish() -> [MyWish] {
      var read : [MyWish] = []
      guard let context = self.persistent?.viewContext else { return [] }
      let request = Wish.fetchRequest()
      let loadData = try? context.fetch(request)
      for i in loadData! {
          read.append(MyWish(title: i.title!, thumbnail: i.thumbnail!, price: Int(i.price), contents: i.contents ?? ""))
      }
      return read
    }
    
    func deleteWish(num : Int) {
      guard let context = self.persistent?.viewContext else { return }
      let request = Wish.fetchRequest()
      guard let loadData = try? context.fetch(request) else { return }
      let filtered = loadData[num]
      context.delete(filtered)
      try? context.save()
    }
    
    func deleteAllWish() {
        guard let context = self.persistent?.viewContext else { return }
        let request = Wish.fetchRequest()
        guard let loadData = try? context.fetch(request) else { return }
        for data in loadData {
            context.delete(data)
        }
        try? context.save()
    }
}

