//
//  ShowViewController.swift
//  lab-test2
//
//  Created by Macbook on 5/25/21.
//

import UIKit
import CoreData

class ShowViewController: UIViewController {
    // create the context
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var prices: UITextField!
    @IBOutlet weak var descprip: UITextField!
    
    weak var delegate: ProductListTVC?
    
    var products: [ProductModel]?
    
    var managedContext: NSManagedObjectContext!
    
    var selectedProduct: ProductModel?
    
    @IBOutlet weak var provid: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(selectedProduct != nil){
        //Set Selected Product Data in textFields
        id.text =  String (selectedProduct!.id)
        name.text = selectedProduct?.name
        prices.text = String(selectedProduct!.price)
        descprip.text = selectedProduct?.desc
        provid.text =  selectedProduct!.provider
        
        selectedProduct = nil
        }

        // Do any additional setup after loading the view.
    }
    
    
    func loadCoreData() {

    
        do {
            products = try context.fetch(ProductModel.fetchRequest())
            DispatchQueue.main.async {
                self.delegate?.tableView.reloadData()
            }
            
        }
        catch {
            print("Error loading folders \(error.localizedDescription)")
        }
       
    }

    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func update(_ sender: Any) {
        
        
        products = []
        
        let upId = Int16(id.text!)!
        let upName = name.text
        let updPrice = Int16(prices.text!)!
        let updDesp = descprip.text
        let updProvid = provid.text
        
        selectedProduct?.id = upId
        selectedProduct?.name = upName
        selectedProduct?.price = updPrice
        selectedProduct?.desc = updDesp
        selectedProduct?.provider = updProvid
        
      
        let newPr = ProductModel(context: context)
        newPr.name = upName
        
        do {
            try context.save()
        } catch {
            print("Error saving the product \(error.localizedDescription)")
        }
        
        //loadCoreData()
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
