sqlite> PRAGMA table_info(reader); List all columns in the reader table.

//Use this to select specific objects / data directly from json column value
//Use JSON_QUERY() for custom selects in json column data
//            SELECT name, JSON_EXTRACT(details, '$.price') AS price
//            FROM products
//            WHERE JSON_EXTRACT(details, '$.category') = 'Electronics';


// Encode
let user = User(id: 1, name: "Alice", email: "alice@example.com", preferences: Preferences(theme: "dark", notifications: true))

   do {
       let encoder = JSONEncoder()
       let jsonData = try encoder.encode(user)
       let jsonString = String(data: jsonData, encoding: .utf8)

       if let jsonString = jsonString {
           // jsonString now contains the JSON representation of your User object
           // You can now insert this string into your SQLite TEXT column
       }
   } catch {
       print("Error encoding JSON: \(error)")
   }
// Decode

// Assuming you retrieved a jsonString from your database
// let retrievedJsonString: String = ...

do {
    let decoder = JSONDecoder()
    if let retrievedJsonData = retrievedJsonString.data(using: .utf8) {
        let decodedUser = try decoder.decode(User.self, from: retrievedJsonData)
        // decodedUser now contains your Swift User object
    }
} catch {
    print("Error decoding JSON: \(error)")
}




