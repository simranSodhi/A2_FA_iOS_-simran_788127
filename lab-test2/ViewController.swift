//
//  ViewController.swift
//  lab-test2
//
//  Created by Macbook on 5/22/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // 1 - creating an instance of AppDelage
    /// appDelegaet instance
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 2 - create the context
    var managedContext: NSManagedObjectContext!
    
    @IBOutlet weak var idTxt: UITextField!
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var providerTxt: UITextField!
    
    @IBOutlet weak var firstProd: UILabel!
    
    var pro = [ProductModel]()
    
    //var pro: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    managedContext = appDelegate.persistentContainer.viewContext


    loadCoreData()
   
}
    
    
    @IBAction func save(_ sender: Any) {
        
        let name = nameTxt.text ?? ""
        let id = Int(idTxt.text ?? "0") ?? 0
        let price = Int(priceTxt.text ?? "0") ?? 0
        let desccription = descTxt.text ?? ""
        let provid = providerTxt.text ?? ""


        
        let newProduct = ProductModel(context: self.managedContext)
        newProduct.name = name
        newProduct.id = Int16(id)
        newProduct.price = Int16(price)
        newProduct.desc = desccription
        newProduct.provider = provid
        
        self.pro.append(newProduct)
        
        clear()
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let prodListTableVC = segue.destination as? ProductListTVC {
            prodListTableVC.pro = self.pro
        }
    }

        //MARK: - CoreData functions

        func loadCoreData() {

            
            let request: NSFetchRequest<ProductModel> = ProductModel.fetchRequest()
            
            do {
                pro = try managedContext.fetch(request)
                
                firstProd.text = pro.first?.name
            }
            catch {
                print("Error loading folders \(error.localizedDescription)")
            }
           
        }

    
    
    func clearCoreData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductMod")

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

    }
    
    func clear(){
        
        idTxt.text = ""
        nameTxt.text = ""
        priceTxt.text = ""
        descTxt.text = ""
        providerTxt.text = ""
    }


}
