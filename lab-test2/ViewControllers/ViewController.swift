//
//  ViewController.swift
//  lab-test2
//
//  Created by Macbook on 5/23/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // 1 - creating an instance of AppDelage
    /// appDelegaet instance
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 2 - create the context
    var managedContext: NSManagedObjectContext!

    
    @IBOutlet weak var firstProd: UILabel!
    var pro = [ProductModel]()
    var provi = [Providers]()
    
    @IBOutlet weak var idT: UITextField!
    
    @IBOutlet weak var nameT: UITextField!
    
    @IBOutlet weak var priceT: UITextField!
    @IBOutlet weak var descT: UITextField!
    @IBOutlet weak var providerT: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedContext = appDelegate.persistentContainer.viewContext



    loadCoreData()
   
}
    func loadCoreData() {

        let request: NSFetchRequest<ProductModel> = ProductModel.fetchRequest()
        
        do {
            pro = try managedContext.fetch(request)
            
           
        }
        catch {
            print("Error loading folders \(error.localizedDescription)")
        }
       
    }
    
    @IBAction func save(_ sender: Any) {
        
        clearCoreData()
        
        let id = Int(idT.text ?? "0") ?? 0
        let name = nameT.text ?? ""
        let price = Int(priceT.text ?? "0") ?? 0
        let desc = descT.text ?? ""
        let provid = providerT.text ?? ""


        
        let newProduct = ProductModel(context: self.managedContext)
        newProduct.name = name
        newProduct.id = Int16(id)
        newProduct.price = Int16(price)
        newProduct.desc = desc
        newProduct.provider = provid
     
        
        self.pro.append(newProduct)
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
        
        
        clear()
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let prodListTableVC = segue.destination as? ProductListTVC {
            prodListTableVC.pro = self.pro
        }
    }


    
    
    func clearCoreData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductModel")

        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                if let managedObject = result as? NSManagedObject {
                    managedContext.delete(managedObject)
                }
            }
        } catch {
            print("Error deleting records \(error)")
        }
        
        
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Providers")

        do {
            let resultss = try managedContext.fetch(fetchRequest2)
            for result in resultss {
                if let managedObject = result as? NSManagedObject {
                    managedContext.delete(managedObject)
                }
            }
        } catch {
            print("Error deleting records \(error)")
        }

    }
    
    func clear(){
        
        idT.text = ""
        nameT.text = ""
        priceT.text = ""
        descT.text = ""
        providerT.text = ""
    }


}
