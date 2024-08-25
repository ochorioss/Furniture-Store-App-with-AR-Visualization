//
//  CategoryDetailViewModel.swift
//  furniture-finalproject
//
//  Created by andra-dev on 15/08/24.
//

import Foundation

class CategoryDetailViewModel: ObservableObject {
    @Published var featuredItems: [Product] = []
    @Published var categoryItems: [Product] = []
    
    let category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    func loadCategoryItems() {
        // Simulating API call or data fetch
        switch category.name {
        case "Drawer":
            featuredItems = [Product(name: "Brand New Drawer", description: "A lot of space and appealing", price: 0, rating: 0, soldCount: 0, imageName: "featured_drawer", bannerImageName: "featuredBanner_drawer", modelName: "")]
            categoryItems = [
                Product(name: "Modern Nightstand", description: "This chic nightstand brings a touch of mid-century modern style to your bedroom while offering practical bedside storage. The two-tone design features a crisp white frame contrasted with a natural wood drawer front, creating a visually appealing piece. A single spacious drawer provides ample space for bedside essentials, while an open shelf below offers additional storage or display options. The nightstand's compact size makes it perfect for small spaces, and its ideal height pairs well with most beds. Tapered legs give it a retro-inspired look, complementing the overall clean lines and minimalist aesthetic. This nightstand seamlessly blends functionality and fashion, serving as both a convenient storage solution and a stylish accent to elevate your bedroom decor.", price: 5500000, rating: 4.5, soldCount: 390, imageName: "drawer1", bannerImageName: "", modelName: "drawer_1.usdz"),
                Product(name: "Wardrobe Cabinet", description: "This spacious wardrobe cabinet is the perfect solution for expanding your storage options, especially in bedrooms lacking built-in closet space. Featuring a warm cherry wood finish, the wardrobe boasts four full-length doors that provide easy access to your belongings. Two smaller drawers at the bottom offer additional storage for accessories or folded items. The silver-toned handles add a modern accent to the sleek, simple design, allowing it to complement various decor styles. This versatile piece combines hanging space, shelving, and drawer storage in one unit, offering a comprehensive clothing organization system. Not only does it keep your wardrobe tidy and accessible, but it also enhances your bedroom's appearance with its attractive design.", price: 1000000, rating: 4.5, soldCount: 200, imageName: "drawer2", bannerImageName: "", modelName: "drawer_2.usdz"),
                Product(name: "Cube Storage Shelf", description: "This cube storage shelf unit offers a versatile and stylish organization solution for any space. Crafted with a natural wood finish, it features 12 equally-sized open cubbies arranged in a 3x4 grid. The unit comes with 3 light gray fabric storage bins, allowing for a mix of open display and concealed storage. Its modern and minimalist design makes it suitable for various settings, from living rooms and offices to playrooms and bedrooms. The sturdy construction can support books, decor items, or additional storage bins. With the flexibility to be used vertically or horizontally, this shelving unit can be customized to fit your specific needs and style preferences, making it an adaptable piece for any home.", price: 1500000, rating: 4.0, soldCount: 150, imageName: "drawer3", bannerImageName: "", modelName: "drawer_3.usdz"),
                Product(name: "Tall Chest of Drawers", description: "This elegant tall chest of drawers combines ample storage with sleek, contemporary design. Featuring a light wood finish with a warm, golden tone, it boasts 7 spacious drawers of varying sizes, each adorned with slim silver handles for easy access. The clean lines and minimalist aesthetic make this piece versatile enough to complement bedrooms, living rooms, or offices. Its sturdy construction ensures durability, while the vertical design maximizes floor space efficiency. This chest of drawers not only provides practical storage for clothes, linens, or miscellaneous items but also adds a modern touch to your decor, making it a stylish and functional addition to any room.", price: 1500000, rating: 4.0, soldCount: 237, imageName: "drawer4", bannerImageName: "", modelName: "drawer_4.usdz")
            ]
        case "Table":
            featuredItems = [Product(name: "Modern Dining Table", description: "Sleek and functional design", price: 0, rating: 0, soldCount: 0, imageName: "featured_table", bannerImageName: "featuredBanner_table", modelName: "")]
            categoryItems = [
                Product(name: "Modern Marble-Top Accent Table", description: "This sophisticated accent table features a round white marble top supported by three curved black metal legs. The combination of luxurious marble and sleek metal creates a striking contrast that embodies modern elegance. The table's compact size and unique tripod base make it perfect for small spaces or as a statement piece in a larger room. It could function beautifully as a side table in a living room, a nightstand in a bedroom, or even as a small bar table in an entertaining area. The timeless materials and design ensure this piece will remain stylish for years to come.", price: 2000000, rating: 4.7, soldCount: 450, imageName: "table1", bannerImageName: "", modelName: "table_1.usdz"),
                Product(name: "Industrial Chic Dining Table", description: "This dining table beautifully merges industrial and rustic styles. The table top is made of solid wood with a warm, natural finish that showcases the wood grain. In contrast, the frame and legs are constructed of sturdy black metal, creating an appealing mix of materials. The simple, clean-lined design makes it adaptable to various interior styles, from urban loft to farmhouse chic. This table would be perfect for a dining room, kitchen, or open-concept living space, comfortably seating 4-6 people.", price: 1800000, rating: 4.3, soldCount: 280, imageName: "table2", bannerImageName: "", modelName: "table_2.usdz"),
                Product(name: "Minimalist Black Side Table", description: "This striking side table embodies minimalist design with its clean lines and monochromatic black finish. Crafted from durable wood or engineered wood, the table features a simple rectangular top and four straight legs. Its compact size makes it versatile for use as an end table, nightstand, or accent piece in any room. The sleek black finish allows it to blend seamlessly with various decor styles while making a bold statement. This table is an ideal choice for those who appreciate understated, modern design.", price: 3500000, rating: 4.6, soldCount: 320, imageName: "table3", bannerImageName: "", modelName: "table_3.usdz"),
                Product(name: "Modern Wood and Glass Coffee Table", description: "This sleek coffee table combines natural wood and glass for a contemporary look. The table features a rectangular glass top encased in a light oak wood frame, creating an airy and open aesthetic. The distinctive angled legs give the piece a sculptural quality while providing sturdy support. With its blend of materials and clean lines, this coffee table would complement a variety of modern and transitional interiors, serving as an elegant centerpiece in a living room or lounge area.", price: 1200000, rating: 4.2, soldCount: 180, imageName: "table4", bannerImageName: "", modelName: "table_4.usdz")
            ]
        case "Chair":
            featuredItems = [Product(name: "Modern Chair", description: "Sleek and functional design", price: 0, rating: 0, soldCount: 0, imageName: "featured_chair", bannerImageName: "featuredBanner_chair", modelName: "")]
            categoryItems = [
                Product(name: "Sven Lounge Chair", description: "This elegant black leather armchair, named the Sven Lounge Chair, exudes contemporary style and comfort. The chair features a gently curved backrest that gracefully wraps around to form the armrests. Upholstered in soft, supple black leather, it invites you to sink in and relax. The chair is supported by sturdy wooden legs in a warm, natural finish that beautifully complements the dark leather. Perfect for a living room, study, or bedroom, the Sven Lounge Chair combines sophistication and coziness in one timeless piece.", price: 2000000, rating: 4.7, soldCount: 450, imageName: "chair1", bannerImageName: "", modelName: "chair_1.usdz"),
                Product(name: "Brooklyn Leather Armchair", description: "Add a touch of retro charm to your space with the Brooklyn Leather Armchair. Upholstered in rich, cognac-colored leather that will develop a beautiful patina over time, this chair is built to last. The simple yet striking design features a straight backrest and wide, comfortable seat. Slender metal legs in a sleek black finish provide a subtle contrast and lend the chair an industrial edge. Whether used as an accent piece or paired with a matching sofa, the Brooklyn Leather Armchair is sure to make a statement.", price: 1800000, rating: 4.3, soldCount: 280, imageName: "chair2", bannerImageName: "", modelName: "chair_2.usdz"),
                Product(name: "Luna Armchair", description: "Simple, sleek, and undeniably stylish, the Luna Armchair is a versatile addition to any modern interior. The chair boasts clean lines and a minimalist silhouette, with a gently curved seat and backrest that offer both comfort and support. The Luna Armchair is expertly crafted with a sturdy black metal frame and is upholstered in smooth, easy-to-clean black fabric. The open armrests and slightly splayed legs give the chair a lightweight, airy feel, making it perfect for smaller spaces. Use it as a dining chair, office chair, or simply a stylish accent piece in your living room.", price: 3500000, rating: 4.6, soldCount: 320, imageName: "chair3", bannerImageName: "", modelName: "chair_3.usdz"),
                Product(name: "Mia Dining Chair", description: "Bring a touch of Scandinavian style to your home with the charming Mia Dining Chair. Crafted from light-colored wood, the chair features a gently curved backrest and seat that showcase the natural grain and beauty of the material. The four legs are slightly tapered, adding a subtle yet stylish detail. The minimalist design and neutral color of the Mia Dining Chair make it incredibly versatile - it can easily blend in with a variety of decor styles, from rustic to modern. Use it as a dining chair, desk chair, or even as a bedside accent. Its simple, timeless design ensures it will be a cherished piece in your home for years to come.", price: 1200000, rating: 4.2, soldCount: 180, imageName: "chair4", bannerImageName: "", modelName: "chair_4.usdz")
            ]
        case "Decoration":
            featuredItems = [Product(name: "Fancy Decoration", description: "Made your house more beautiful", price: 0, rating: 0, soldCount: 0, imageName: "featured_decor", bannerImageName: "featuredBanner_decor", modelName: "")]
            categoryItems = [
                Product(name: "Desert Stone Vase", description: "Bring a touch of natural elegance to your home with the Desert Stone Vase. Crafted from high-quality stone, this unique vase features a subtle, textured surface that evokes the rugged beauty of the desert landscape. Its simple, organic shape makes it a versatile addition to any decor style, from modern to bohemian. Measuring 12 inches tall and 8 inches wide, the Desert Stone Vase is the perfect size for displaying a striking arrangement of dried grasses, branches, or your favorite fresh flowers. Each vase is one-of-a-kind, showcasing the natural variations in color and texture that make stone such a captivating material.", price: 2000000, rating: 4.7, soldCount: 450, imageName: "decor1", bannerImageName: "", modelName: "decor_1.usdz"),
                Product(name: "Emerald Pothos in White Ceramic", description: "Bring a touch of lush greenery to your space with the Emerald Pothos in White Ceramic. This easy-care trailing plant features vibrant green, heart-shaped leaves that will brighten up any room. Pothos plants are known for their air-purifying qualities, making them a healthy and attractive addition to your home or office. The plant comes pre-potted in a sleek, white ceramic planter that measures 6 inches in diameter and 5 inches tall. The clean, modern lines of the planter complement the lush, organic shape of the pothos vine. With proper care, this plant will thrive and grow, cascading gracefully over the edges of its pot.", price: 1800000, rating: 4.3, soldCount: 280, imageName: "decor2", bannerImageName: "", modelName: "decor_2.usdz"),
                Product(name: "Sansevieria in Terracotta Pot", description: "Add a striking architectural element to your plant collection with the Sansevieria in Terracotta Pot. Also known as snake plant or mother-in-law's tongue, sansevieria is a low-maintenance, drought-tolerant plant that thrives in a variety of conditions. Its tall, upright leaves feature a unique, variegated pattern of dark and light green stripes. The plant comes pre-potted in a classic terracotta pot that measures 6 inches in diameter and 5 inches tall. The warm, earthy tones of the terracotta complement the bold, graphic shapes of the sansevieria leaves. Place this plant on a shelf, desk, or windowsill for a stylish pop of greenery that requires minimal care.", price: 3500000, rating: 4.6, soldCount: 320, imageName: "decor3", bannerImageName: "", modelName: "decor_3.usdz"),
            ]
            
        default:
            break
        }
    }
}

