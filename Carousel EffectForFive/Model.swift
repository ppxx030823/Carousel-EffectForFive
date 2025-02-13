import UIKit

// 定义 Interest 模型结构体
struct Interest {
    let title: String
    let description: String
    let numberOfMembers: Int
    let numberOfPosts: Int
    let featuredImage: UIImage?
    let backgroundImage: UIImage?

    // 初始化方法
    init(title: String, description: String, numberOfMembers: Int = 1, numberOfPosts: Int = 1, featuredImage: UIImage?, backgroundImage: UIImage?) {
        self.title = title
        self.description = description
        self.numberOfMembers = numberOfMembers
        self.numberOfPosts = numberOfPosts
        self.featuredImage = featuredImage
        self.backgroundImage = backgroundImage
    }

    // 静态方法，用于创建多个 Interest 实例
    static func createInterests() -> [Interest] {
        // 定义常量
        let imageNames = ["hello", "dudu", "bodyline", "wave", "darkvarder", "hhhhh"]
        let backgroundImageName = "blue"
        let titles = ["Hello there, i miss u.", "🐳🐳🐳🐳🐳", "Training like this, #bodyline", "I'm hungry, indeed.", "Dark Varder, #emoji", "I have no idea, bitch"]
        let descriptions = [
            "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
            "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
            "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
            "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
            "Meet life with full presence. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨",
            "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨"
        ]

        var interests: [Interest] = []
        // 尝试加载背景图片
        guard let backgroundImage = UIImage(named: backgroundImageName) else {
            print("Failed to load background image: \(backgroundImageName)")
            return interests
        }

        for (index, imageName) in imageNames.enumerated() {
            // 尝试加载特色图片
            if let featuredImage = UIImage(named: imageName) {
                let interest = Interest(
                    title: titles[index],
                    description: descriptions[index],
                    numberOfMembers: 1,
                    numberOfPosts: 1,
                    featuredImage: featuredImage,
                    backgroundImage: backgroundImage
                )
                interests.append(interest)
            } else {
                print("Failed to load featured image: \(imageName)")
            }
        }
        print(interests)
        return interests
    }
}
