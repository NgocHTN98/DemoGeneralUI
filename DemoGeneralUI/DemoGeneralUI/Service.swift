//
//  Service.swift
//  DemoGeneralUI
//
//  Created by NgocHTN6 on 07/03/2023.
//

import Foundation

class Service {
    
    func request(callBackData: ((Response)->())? = nil) {
        var request = URLRequest(url: URL(string: "https://mock.apidog.com/m2/359057-0-default/3650434")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let _data = data else { return }
            do {
                let json = try JSONDecoder().decode(Response.self, from: _data)

                print(json)
                callBackData?(json)
                
            } catch {
                print("JSON Serialization error")
            }
        })

        task.resume()
    }
}

// MARK: - Response
struct Response: Codable {
    let group: [AttributeRes]
    enum CodingKeys: String, CodingKey {
       case group
   }
}

// MARK: - Group
struct AttributeRes: Codable  {
    let attributes: ItemAttributeRes?
    let id: String?
    let type: TypeComponent
    let text_content: String?
    let text_color: String?
    let size: Int?
    let maxLines: Int?
    let image_name: String?
    let width_height_ratio: Float?
    let width_ratio_parent_view: Float?
    let space_vertical: Float?
    let space_horizatal: Float?
    
    enum CodingKeys: String, CodingKey {
        case id
        case attributes
        case type
        case text_content
        case text_color
        case image_name
        case size
        case maxLines
        case width_height_ratio
        case width_ratio_parent_view
        case space_vertical
        case space_horizatal
   }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attributes = try container.decodeIfPresent(ItemAttributeRes.self, forKey: .attributes) ?? nil
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        let strType = try container.decodeIfPresent(String.self, forKey: .type) ?? "None"
        self.type = TypeComponent(rawValue: strType) ?? .None

        self.text_content = try container.decodeIfPresent(String.self, forKey: .text_content) ?? ""
        self.text_color = try container.decodeIfPresent(String.self, forKey: .text_color) ?? ""
        
        self.size = try container.decodeIfPresent(Int.self, forKey: .size)
        self.maxLines = try container.decodeIfPresent(Int.self, forKey: .maxLines)
        
        //image
        self.image_name = try container.decodeIfPresent(String.self, forKey: .image_name) ?? ""
        self.width_height_ratio = try container.decodeIfPresent(Float.self, forKey: .width_height_ratio)
        self.width_ratio_parent_view = try container.decodeIfPresent(Float.self, forKey: .width_ratio_parent_view)
        self.space_vertical = try container.decodeIfPresent(Float.self, forKey: .space_vertical)
        self.space_horizatal = try container.decodeIfPresent(Float.self, forKey: .space_horizatal)
    }
    
    func encode(to encoder: Encoder) throws {

    }
}
struct ItemAttributeRes: Codable {
    let items: [AttributeRes]
    enum CodingKeys: String, CodingKey {
        case items
   }
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decodeIfPresent(Array.self, forKey: .items) ?? []
    }
}


enum TypeComponent:String {
    case Text
    case Image
    case TextMultiStyle
    case List
    case StackModem
    case StackConnect
    case StackInfo
    case None
}

