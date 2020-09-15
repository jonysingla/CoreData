//
//  DataListModel.swift
//  CoreDataWithApi
//
//  Created by Jony on 21/08/20.
//  Copyright © 2020 Jony. All rights reserved.
//

import UIKit

class DataListModel: NSObject {
    
    var tabReview: String = ""
    var product_id: Int = 0
    var name: String = ""
    var manufacturer: String = ""
    var manufacturer_id: Int = 0
    var brand_image: String = ""
    var brand_description: String = ""
    var model: String = ""
    var reward: String = ""
    var points: String = ""
    var shipping : String = ""
    var stock : String = ""
    var popup: String = ""
    var thumb: String = ""
    var videos: NSMutableArray = []
    var instruction_video: String = ""
    var wishlist_status : Bool = false
    var images: NSMutableArray = []
    var price: String = ""
    var priceValue: String = ""
    var special: String = ""
    var specialValue : String = ""
    var tax : String = ""
    var discounts: NSMutableArray = []
    var options: NSMutableArray = []
    var quantity: String = ""
    var minimum: String = ""
    var review_status: String = ""
    var review_guest : Bool = true
    var customer_name : String = ""
    var reviews: String = ""
    var rating: Int = 0
    var descriptionO : String = ""
    var attribute_groups: NSMutableArray = []
    var relatedProducts: NSMutableArray = []
    var tags : NSMutableArray = []
    var href: String = ""
    var text_payment_recurring: String = ""
    var recurrings: NSMutableArray = []
    var reviewData: NSMutableArray = []
    var productPrev: NSMutableArray = []
    var productNext: NSMutableArray = []
    var return_plicy: String = ""
    var out_of_stock_checkout: Bool = false
    
    class func setPostList(postAPIData : NSDictionary)-> DataListModel {
        let dataListModel = DataListModel()
        dataListModel.tabReview = JSON.StringValueForKey(json: postAPIData, key: "tab_review")
                
        return dataListModel
    }
}

class DataModel: NSObject {
    var postDataArray = NSMutableArray()
    class func getPostData(dataDict : NSDictionary)-> DataModel {
        let dataModel = DataModel()
        let postArray = JSON.DictionaryValueForKey(json: dataDict, key: "payload")
//        let postArray = JSON.ArrayValueForKey(json: dataDict, key: "payload")
        for recItem in postArray {
            var dict = recItem as? NSMutableDictionary ?? <#default value#>
            let dataListModel:DataListModel = DataListModel.setPostList(postAPIData: dict)
            dataModel.postDataArray.add(dataListModel)
        }
        return dataModel
    }
}
/* Response
 
 {
 "status": 200,
 "payload": {
 "tab_review": "Reviews (0)",
 "product_id": 58,
 "name": "HEXBUG VEX Robotics Catapult Kit 2.0, STEM Learning, Toys for Kids (Red)",
 "manufacturer": "HEXBUG VEX Robotics ",
 "manufacturer_id": "23",
 "brand_image": "",
 "brand_description": "",
 "model": "HexBug001",
 "reward": null,
 "points": "0",
 "shipping": "1",
 "stock": "In Stock",
 "popup": "",
 "thumb": "",
 "videos": [
 {
 "video_id": "22",
 "product_id": "58",
 "url": "https://www.youtube.com/watch?v=7zhw8h6bXgw",
 "code": "7zhw8h6bXgw",
 "thumb": "https://i1.ytimg.com/vi/7zhw8h6bXgw/1.jpg",
 "type": "youtube"
 }
 ],
 "instruction_video": "http://youtube.com/aaaaa",
 "wishlist_status": false,
 "images": [
 {
 "popup": "",
 "thumb": ""
 }
 ],
 "price": "KD 40.00",
 "priceValue": "40.0000",
 "special": "KD 36.00",
 "specialValue": "36.0000",
 "tax": "KD 36.00",
 "discounts": [],
 "options": [
 {
 "product_option_id": "238",
 "product_option_value": [
 {
 "product_option_value_id": "56",
 "option_value_id": "59",
 "name": "Red",
 "color_code": "",
 "image": "",
 "price": "",
 "priceValue": "",
 "price_prefix": "+"
 },
 {
 "product_option_value_id": "55",
 "option_value_id": "60",
 "name": "Blue",
 "color_code": "",
 "image": "",
 "price": "",
 "priceValue": "",
 "price_prefix": "+"
 }
 ],
 "option_id": "14",
 "name": "Color",
 "type": "radio",
 "value": "",
 "required": "1"
 },
 {
 "product_option_id": "239",
 "product_option_value": [
 {
 "product_option_value_id": "57",
 "option_value_id": "72",
 "name": "No Wrapping",
 "color_code": "",
 "image": "http://tarkeebc.ampro5.fcomet.com/image/cache/catalog/Wrapping%20Paper/No%20Option%20Selected-200x200.png",
 "price": "",
 "priceValue": "",
 "price_prefix": "+"
 },
 {
 "product_option_value_id": "58",
 "option_value_id": "66",
 "name": "Boys Free",
 "color_code": "",
 "image": "http://tarkeebc.ampro5.fcomet.com/image/cache/catalog/Wrapping%20Paper/Wrapping%20Boys%20Free-200x200.png",
 "price": "",
 "priceValue": "",
 "price_prefix": "+"
 },
 {
 "product_option_value_id": "59",
 "option_value_id": "67",
 "name": "Girls Free",
 "color_code": "",
 "image": "http://tarkeebc.ampro5.fcomet.com/image/cache/catalog/Wrapping%20Paper/Wrapping%20Girls%20Free-200x200.png",
 "price": "",
 "priceValue": "",
 "price_prefix": "+"
 },
 {
 "product_option_value_id": "60",
 "option_value_id": "68",
 "name": "Child Free",
 "color_code": "",
 "image": "http://tarkeebc.ampro5.fcomet.com/image/cache/catalog/Wrapping%20Paper/Wrapping%20Child%20Free-200x200.png",
 "price": "",
 "priceValue": "",
 "price_prefix": "+"
 },
 {
 "product_option_value_id": "61",
 "option_value_id": "69",
 "name": "Boys 1.500 KD",
 "color_code": "",
 "image": "http://tarkeebc.ampro5.fcomet.com/image/cache/catalog/Wrapping%20Paper/Wrapping%20Boys%20Paid-200x200.png",
 "price": "KD 1.50",
 "priceValue": "1.5000",
 "price_prefix": "+"
 },
 {
 "product_option_value_id": "62",
 "option_value_id": "70",
 "name": "Girls 1.500 KD",
 "color_code": "",
 "image": "http://tarkeebc.ampro5.fcomet.com/image/cache/catalog/Wrapping%20Paper/Wrapping%20Girls%20Paid-200x200.png",
 "price": "KD 1.50",
 "priceValue": "1.5000",
 "price_prefix": "+"
 },
 {
 "product_option_value_id": "63",
 "option_value_id": "70",
 "name": "Girls 1.500 KD",
 "color_code": "",
 "image": "http://tarkeebc.ampro5.fcomet.com/image/cache/catalog/Wrapping%20Paper/Wrapping%20Girls%20Paid-200x200.png",
 "price": "KD 1.50",
 "priceValue": "1.5000",
 "price_prefix": "+"
 }
 ],
 "option_id": "16",
 "name": "Select Wrapping Paper",
 "type": "radio",
 "value": "",
 "required": "0"
 },
 {
 "product_option_id": "240",
 "product_option_value": [
 {
 "product_option_value_id": "64",
 "option_value_id": "73",
 "name": "No Greeting",
 "color_code": "",
 "image": "http://tarkeebc.ampro5.fcomet.com/image/cache/catalog/Greeting%20Card/No%20Option%20Selected-200x200.png",
 "price": "",
 "priceValue": "",
 "price_prefix": "+"
 },
 {
 "product_option_value_id": "65",
 "option_value_id": "74",
 "name": "Greeting Card 0.500 KD",
 "color_code": "",
 "image": "http://tarkeebc.ampro5.fcomet.com/image/cache/catalog/Greeting%20Card/Greetings%20Cards-200x200.png",
 "price": "KD 0.50",
 "priceValue": "0.5000",
 "price_prefix": "+"
 }
 ],
 "option_id": "17",
 "name": "Add a Greeting",
 "type": "radio",
 "value": "",
 "required": "0"
 },
 {
 "product_option_id": "241",
 "product_option_value": [],
 "option_id": "18",
 "name": "Send your Greetings",
 "type": "textarea",
 "value": "Enter greetings here.....",
 "required": "0"
 }
 ],
 "quantity": "69",
 "minimum": "1",
 "review_status": "1",
 "review_guest": true,
 "customer_name": "rajni&nbsp;Raswant",
 "reviews": "0 reviews",
 "rating": 0,
 "description": "<div class=\"row details collapsible-xs \" style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-style: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: none; box-sizing: border-box; display: flex; flex-wrap: wrap; margin-right: -15px; margin-left: -15px; margin-bottom: 2em;\"><div class=\"col-sm-12 col-md-8 col-lg-9 value content\" id=\"collapsible-details-1\" style=\"box-sizing: border-box; position: relative; width: 855px; padding-right: 15px; padding-left: 15px; flex: 0 0 75%; max-width: 75%;\">Launch into a world of fun with the redesigned VEX Robotics Catapult! Develop your love for physics and STEM concepts, all while letting your playful imagination run wild. Whether your goal is precision, distance, or even trick shots, the Catapult can do it all!</div></div>",
 "attribute_groups": [
 {
 "attribute_group_id": "10",
 "name": "Gender",
 "attribute": [
 {
 "attribute_id": "13",
 "name": "Boys",
 "text": "Boys"
 }
 ]
 },
 {
 "attribute_group_id": "9",
 "name": "Age",
 "attribute": [
 {
 "attribute_id": "17",
 "name": "5 Plus",
 "text": "5 Plus"
 }
 ]
 }
 ],
 "relatedProducts": [],
 "tags": [],
 "href": "http://tarkeebc.ampro5.fcomet.com/index.php?route=product/product&product_id=58&name=HEXBUG VEX Robotics Catapult Kit 2.0, STEM Learning, Toys for Kids (Red)",
 "text_payment_recurring": "Payment Profile",
 "recurrings": [],
 "reviewData": {
 "text_no_reviews": "There are no reviews for this product.",
 "reviews": []
 },
 "productPrev": [],
 "productNext": [],
 "return_plicy": "",
 "out_of_stock_checkout": false
 },
 "error": 0,
 "message": []
 }
 
 */

