//
//  Service.swift
//  DemoGeneralUI
//
//  Created by NgocHTN6 on 07/03/2023.
//

import Foundation

class Service {
    
    func request() {
        var request = URLRequest(url: URL(string: "https://mock.apidog.com/m1/359057-0-default/m1/359057-0-default/m1/359057-0-default/m2/359057-0-default/3648051")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let _data = data else { return }
            do {
                let json = try JSONDecoder().decode(Response.self, from: _data)

                print(json)
                
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
    let type: String
    let text_content: String?
    let text_color: String?
    enum CodingKeys: String, CodingKey {
        case id
        case attributes
        case type
        case text_content
        case text_color
   }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attributes = try container.decodeIfPresent(ItemAttributeRes.self, forKey: .attributes) ?? nil
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.text_content = try container.decodeIfPresent(String.self, forKey: .text_content) ?? ""
        self.text_color = try container.decodeIfPresent(String.self, forKey: .text_color) ?? ""
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


