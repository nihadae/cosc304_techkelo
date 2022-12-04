DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(60),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Laptops & MacBooks');
INSERT INTO category(categoryName) VALUES ('Desktop Computers');
INSERT INTO category(categoryName) VALUES ('Tablets & iPads');
INSERT INTO category(categoryName) VALUES ('Cell Phones');
INSERT INTO category(categoryName) VALUES ('Televisions');
INSERT INTO category(categoryName) VALUES ('Headphones');
INSERT INTO category(categoryName) VALUES ('Cameras');
INSERT INTO category(categoryName) VALUES ('Video Games & VR');
INSERT INTO category(categoryName) VALUES ('Smartwatches & Apple Watch');
INSERT INTO category(categoryName) VALUES ('Printers, Scanners & Fax');

INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Microsoft Surface Laptop Go 2', 1, 'The Microsoft Surface Laptop Go 2 is a sleek, portable laptop, boasting a powerful 11th generation Intel processor with a 4.2GHz processor speed. It features a 12.4" PixelSense touchscreen that will give you great typing experience with a precision trackpad. With an improved HD camera, preloaded Windows 11 Home, it will boost performance for the things you love to do.',769.99, 'img/1.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Microsoft Surface Pro 9 13',1,'With the power of a laptop and the flexibility of a tablet, the Microsoft Surface Pro 9 is designed for pros like you. It boasts a 13" PixelSense Flow display, an Intel Core i7 processor, Thunderbolt 4 ports for faster connections, and the extra speed when you need it. It comes preloaded with Windows 11, so you have a fresh new feel and tools that make it easier to be efficient.',1759.99, 'img/2.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Lenovo IdeaPad 1 15.6 Laptop - Cloud Grey',1,'Stay productive from anywhere with the Lenovo IdeaPad 1 laptop. It offers a 15.6-inch display with a frameless design that lets you see more of the screen. It includes a 1MP camera with a privacy shutter to enable work or personal video calls and Dolby Audio speakers to ensure clear audio. This laptop also offers up to 9.5 hours of battery life.',219.99, 'img/3.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Acer Aspire 3 15.6 Laptop - Silver',1,'Powered by an AMD Athlon processor, the Acer Aspire 3 laptop provides reliable everyday performance suitable for work, leisure, or study. Its sleek and aesthetic design features a 15.6" display with stunning FHD resolution that gives you crisp text and bright colourful images. For connectivity, it includes USB ports for accessories and a HDMI port for adding a second screen.',369.99, 'img/4.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple MacBook Pro 14 (2021) - Space Grey',1,'The first notebook of its kind, this Apple MacBook Pro is a beast. With the blazing-fast M1 Pro chip — the first Apple silicon designed for pros — you get groundbreaking performance and amazing battery life. Add to that a stunning Liquid Retina XDR display, the best camera and audio ever in a Mac notebook, and all the ports you need.',2199.99, 'img/5.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple MacBook Pro 16 (2021) - Silver',1,'The first notebook of its kind, this Apple MacBook Pro is a beast. With the blazing-fast M1 Pro chip — the first Apple silicon designed for pros — you get groundbreaking performance and amazing battery life. Add to that a stunning Liquid Retina XDR display, the best camera and audio ever in a Mac notebook, and all the ports you need.',2999.99, 'img/6.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple MacBook Pro 13.3 w/ Touch Bar',1,'Bring more power and enhanced performance on-the-go with the Apple MacBook Pro. Supercharged by the next-generation M2 chip, it’s Apple’s most portable pro laptop, with up to 20 hours of battery life. Featuring a brilliant Retina display, a FaceTime HD camera, and studio‑quality mics, it delivers game-changing performance to all your computing and entertainment tasks.',1949.99, 'img/7.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ASUS AiO M3700 27 All-in-One PC - White',2,'Complete your smart home or office setup with the ASUS AiO M3700 all-in-one PC. Designed for high performance, this PC features an AMD Ryzen 5 CPU with 16GB RAM that lets you perform everyday multitasking effortlessly. Connectivity options include Bluetooth 5.2 and Wi-Fi 6 with high speed and wide coverage.',1299.99, 'img/8.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Acer Aspire C 24 All-in-One PC',2,'Bring this Acer Aspire C 24" all-in-one PC to your home for efficient day-to-day computing experience. Powered by an AMD Ryzen 3 3250U processor and 8GB of DDR4 RAM, it keeps your multitasking, photo editing, and other demanding workflows running smooth and lag-free. With built-in Alexa support, you can create to-do lists for streamlined productivity.',649.99, 'img/9.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('HP Pavilion 32 QHD All-in-One Desktop PC',2,'Productivity and entertainment combine with the HP Pavilion All-in-One Desktop PC. Powered by an Intel Core i5 CPU matched with 16GB RAM, it delivers impressive performance so you can do all the things that matter. Its 31.5” QHD IPS display and audio by B&O let you enjoy an immersive experience that is great for streaming.',1499.99, 'img/10.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple iMac 24 (Spring 2021) - Blue',2,'Enjoy reliable, fast performance with the Apple iMac. Powered by the Apple M1 chip and 8GB of RAM, it can easily handle multitasking so you can work efficiently on your projects. Its 4.5K Retina display with P3 wide colour gamut brings your content to life in sharp detail, and it comes complete with a Magic Keyboard and a Magic Mouse so you can get started right away.',1599.99, 'img/11.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple iMac 24 (Spring 2021) - Pink',2,'Enjoy reliable, fast performance with the Apple iMac. Powered by the Apple M1 chip and 8GB of RAM, it can easily handle multitasking so you can work efficiently on your projects. Its 4.5K Retina display with P3 wide colour gamut brings your content to life in sharp detail, and it comes complete with a Magic Keyboard and a Magic Mouse so you can get started right away.',1599.99, 'img/12.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple iMac 24 (Spring 2021) - Green',2,'Enjoy reliable, fast performance with the Apple iMac. Powered by the Apple M1 chip and 8GB of RAM, it can easily handle multitasking so you can work efficiently on your projects. Its 4.5K Retina display with P3 wide colour gamut brings your content to life in sharp detail, and it comes complete with a Magic Keyboard and a Magic Mouse so you can get started right away.',1599.99, 'img/13.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple 11-Inch iPad Pro (2nd Generation)',3,'Apple 11-Inch iPad Pro (2nd Generation) with Wi-Fi - 128GB - Space Gray - Open Box: Unused, 10/10 condition product with manufacturer or seller warranty, only difference with Factory Fresh is open packaging. original accessories included except headphones. Some products sold may be international versions of this device and will be fully compatible with Canada’s mobile networks and seller-provided warranty.',1299.99, 'img/14.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple 10.2-inch iPad (Wi-Fi, 64GB)',3,'The Apple 10.2" iPad features a Retina display with a 2160 x 1620 resolution for crisp details and vivid colors, making it an ideal companion for watching movies, creating content, and much more. The Retina Display also has True Tone technology, which adjusts the display to the color temperature of the room so it is more comfortable for viewing in any light. Apple upgraded the front camera to a 12MP Ultra-Wide camera. ',599.99, 'img/15.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple 12.9 iPad Pro M1 Chip (Mid 2021)',3,'The Apple iPad Pro gives you the ultimate iPad experience. Featuring a powerful Apple M2 chip and 12.9-inch Liquid Retina display, it boasts astonishing performance and incredibly advanced displays, and superfast wireless connectivity. Powerful new features come with iPadOS 16.',1629.95, 'img/16.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Samsung Galaxy Tab S8 Ultra 14.6 256GB',3,'Live an ultimate lifestyle with the Samsung Galaxy Tab S8 Ultra tablet. It is powered with the Qualcomm 8540 8-core processor, 12GB RAM, and 256GB storage capacity. Featuring a 14.6" sAMOLED screen, ultra-wide dual front camera with auto framing, and ultra-fast S Pen, this premium tablet gives you more space to work and create professional-quality projects, with enhanced multitasking on the go.',1499.99, 'img/17.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Samsung Galaxy Tab S8 11 256GB', 3,'Power through your to-do list with this bundle from Samsung. It includes a Samsung Galaxy Tab S8 11" Android 11 tablet with Qualcomm 8540 8-core processor, 8GB RAM, and 256GB storage capacity, plus you also get a Samsung keyboard book cover case with trackpad for Galaxy Tab S8/S7.',1069.99, 'img/18.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Samsung Galaxy Tab S8 11 128GB',3,'Unleash the power to do more with the Samsung Galaxy S8 tablet. It is equipped with the Qualcomm 8540 8-core processor, 8GB RAM, and 128GB storage capacity. Featuring an 11" dynamic LCD screen, ultra-wide front camera with auto framing, and ultra-fast S Pen, this premium tablet levels up your productivity and creativity with powerful PC-like capabilities and enhanced multitasking, anywhere you go.',899.99, 'img/19.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple iPhone 13 Pro 256GB',4,'Explore endless possibilities with the iPhone 13 Pro. It features the powerful A15 Bionic chip, superfast 5G to download and stream high-quality video, a bright 6.1" Super Retina XDR display with ProMotion, and Ceramic Shield for better drop performance. Other features include Pro camera system with new 12MP Telephoto, Wide and Ultra Wide cameras, extra-ordinary battery life, and much more.',1539.95, 'img/20.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Google Pixel 7 Pro 128GB',4,'The Google Pixel 7 Pro brings you the best-of-everything in a phone. Powered by Google Tensor G2, it is fast and secure, with an immersive display and amazing battery life. It features a pro-level camera system that includes a telephoto lens and advanced features like Macro Focus. And with next-gen security features and built-in VPN, it helps protect your personal data.',879.99, 'img/21.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Samsung Galaxy A53 5G 128GB',4,'Enjoy awesome everyday moments with the powerful Samsung Galaxy A53 5G 128GB. It’s equipped with a large screen with Full HD graphics so your apps, photos, and videos are smooth, crisp, and easy to view. It also features high-performance front and rear cameras and tonnes of onboard storage space so you don’t have to worry about running out of room.',399.99, 'img/22.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Samsung Galaxy S22 Ultra 5G 128GB',4,'Make everyday moments come to life with the innovative Samsung Galaxy S22 Ultra 5G smartphone. With 108MP photo resolution and 8K video, this mobile phone is built to capture memories that is important to you. It features night mode for your crystal-clear nightography, 48-hour battery for unstoppable action, and the embedded S Pen to boost your creativity.',1379.99, 'img/23.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple iPhone 13 128GB - Green',4,'The Apple iPhone 14 has full of fantastic features. With the most impressive dual-camera system, it captures stunning photos in low light and bright light. Plus, get peace of mind with groundbreaking safety features.',999.99, 'img/24.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple iPhone 14 128GB - Blue',4,'The Apple iPhone 14 has full of fantastic features. With the most impressive dual-camera system, it captures stunning photos in low light and bright light. Plus, get peace of mind with groundbreaking safety features.',999.99, 'img/25.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('LG 86 Inch 4K UHD HDR LED',5,'Witness every scene in utmost clarity with the LG 86" HDR smart TV. Boasting a LED display, this TV presents your movies and other content in Ultra HD 4K resolution with realistic colours and precise image detailing. Additionally, the webOS operating system provides access to an array of entertainment apps to stream movies, shows, and more.',1799.99, 'img/26.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('TCL 4-Series 55 Inch 4K Smart Google TV',5,'Lay back and relish endless entertainment with the TCL 4-Series 55" 4K UHD HDR LED Smart Google TV. It features the HDR technology to deliver 4K ultra-HD lifelike visuals and the thousands of streaming apps make it easy to watch your favourite shows and movies. The Wi-Fi support, Dolby Digital+ audio and the built-in tuner ensure an immersive experience in the comfort of your home.',399.99, 'img/27.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Samsung 75 Inch 4K TV',5,'Enhance your living room with the Samsung 75" smart TV and experience the difference that 4K Ultra HD picture brings. This television uses the Crystal Processor 4K and other features to deliver the sharpest picture, with MR120 motion enhancement for blur-free details. Connect to voice assistants to enable easy access to your favourite content.',999.99, 'img/28.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple AirPods Pro (2nd generation)',6,'Redefine your listening experience with the AirPods Pro 2. These earphones feature two times more Active Noise Cancellation, Adaptive Transparency, and dynamic head tracking for immersive sound. Enjoy up to six hours of listening time on a single charge. The MagSafe charging case includes a built-in speaker and Precision Finding so you never lose it.',299.98, 'img/29.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Beats by Dr. Dre Solo3 Gray',6,'An unforgettable listening experience awaits you with the Beats by Dr. Dre Solo3 wireless headphones. Bluetooth connectivity lets you wirelessly stream music from your iOS devices and take hands-free calls with the built-in mic. Rechargeable battery offers 40 hours of use on a single charge, plus a 5-minute quick charge gives you 3 hours of playback.',199.97, 'img/30.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Sony WH-1000XM5',6,'Enhance your listening experience with the Sony WH-1000XM5 over-ear headphones. They feature comfortable ear cushions made of leather and offer active noise cancelling technology for distraction-free all-day listening. Connect to your smartphone via Bluetooth to use the built-in microphone for crystal-clear, hands-free calling.',399.99, 'img/31.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('SteelSeries Arctis 3',6,'Bring high-quality audio to every game you play across multiple consoles with this SteelSeries Arctis 3 Console Edition gaming headset. It boasts a comfortable ski goggle suspension headband to ensure marathon sessions stay cozy, while the S1 speaker drivers produce ultra-low distortion audio. The ClearCast microphone is Discord-certified and features background noise cancellation.',89.99, 'img/32.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Canon EOS Rebel T7',7,'Enjoy new perspectives with the Canon offers the EOS Rebel T7 DSLR camera. From everyday pictures of your kids and pets to stunningly beautiful nature photographs, this camera and lens kit can easily handle all photographs. The full range of features makes this a perfect camera choice.',569.99, 'img/33.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Fujifilm Instax Mini 11 Instant Camera',7,'Put the fun back into taking photos with the Fujifilm Instax Mini 11 instant camera. It uses instant film so you can see what you have shot right away. Its auto-exposure capability means you do not have to worry about lighting to capture the perfect shot. It even has a selfie mode with a close-up lens and a mirror included.',99.99, 'img/34.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('GoPro HERO11 Black Waterproof',7,'Take stunning wide cinematic shots and more expansive images with the GoPro Hero 11 Black action camera. Front and rear LCD screens help your perfectly frame your clips and 5.3K video and 27MP images ensure that every exciting moment is caught in high definition, with crystal clear quality. Advanced stabilization technology keeps footage steady even on the most daring adventures.',519.99, 'img/35.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('PlayStation 5 God of War Ragnarok Bundle',8,'Level up your gaming experience with the PlayStation 5 God of War Ragnarok bundle. It comes with the PS5 console featuring advanced technologies to bring every game to life and a DualSense controller with adaptive triggers and haptic feedback support. The bundle also includes a digital download of God of War Ragnarok so you can jump right into the action.',729.99, 'img/36.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Xbox Series X 1TB Console',8,'Get your hands on a gaming powerhouse with the Xbox Series X console. It pairs a custom 1TB SSD and 12 teraflops of graphics processing power for stunningly fast gameplay and reduced load times. Enjoy 4K gaming at up to 120fps, advanced 3D spatial sound, and more for an incredible experience. Plus, it supports thousands of titles across 4 generations of Xbox consoles.',599.99, 'img/37.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Meta Quest 2 128GB VR Headset',8,'Experience virtual reality like never before with this Meta Quest 2 VR headset bundle. It’s packed with advanced features like an incredibly fast processor, high-resolution display, haptic feedback, and 3D positional audio so you become immersed in the experience. It also comes with touch controllers and Resident Evil 4 so you have everything you need to get started.',469.99, 'img/38.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple Watch Series 8 (GPS) 45mm',9,'Apple Watch Series 8 features advanced health sensors and apps, so you can take an ECG, measure heart rate and blood oxygen, and track temperature changes for advanced insights into your menstrual cycle. And with Crash Detection, sleep stages tracking, and advanced workout metrics, it helps you stay active, healthy, safe, and connected.',569.99, 'img/39.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Apple Watch Ultra (GPS + Cellular) 49mm',9,'Stay connected even on your most extreme adventures with the Apple Watch Ultra. Ruggedly built for exploration and endurance, the watch features a 49mm aerospace-grade titanium case, up to 36 hours of battery life, and specialized apps that work with advanced sensors. Advanced safety technologies also help keep you on track in demanding environments.',1099.99, 'img/40.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Samsung Galaxy Watch5 (GPS) 40mm',9,'Keep track of your health and fitness and improve sleeping habits with the Samsung Galaxy Watch5 smartwatch. It helps watch your body composition info right on your wrist and manage your overall sleep quality. It features an AMOLED display in a durable sapphire crystal glass and aluminum case, built-in GPS, and outstanding battery life so you are ready for all your outdoor adventures the way you want.',284.99, 'img/41.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Canon PIXMA G3260 MegaTank',10,'Amp up your productivity with the Canon PIXMA G3260 MegaTank Inkjet printer. Capable of high-speed printing, copying, and scanning, it handles high volumes with cost efficiency. It also has wireless connectivity, so you can print directly from your smartphone. Its MegaTank ink system offers a higher yield compared to conventional ink cartridges.',229.99, 'img/42.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Brother Monochrome Wireless',10,'Get through large office tasks with ease thanks to the Brother DCP-L2550DW. This monochrome laser multi-function copier prints and copies crisp black and white documents at speeds up to 36ppm. It connects with ease to your computer via wireless networking, Ethernet, or Hi-Speed USB and. It also offers colour scanning to a variety of destinations.',249.99, 'img/43.jpeg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Epson ES-50 Portable Document Scanner',10,'Scan photos, documents, and files on the go with this lightweight Epson ES-50 portable scanner. Featuring 600dpi scanning, it digitizes all of your items in sharp clarity. It blazes through scanning jobs as quickly as 5.5 seconds per page. It is conveniently powered by USB so no batteries are required.',129.99, 'img/44.jpeg');




INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 769.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 1759.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 219.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 369.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 2199.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 2999.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 1949.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 10, 1299.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 649.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 1499.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (11, 1, 3, 1599.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (12, 1, 3, 1599.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (13, 1, 3, 1599.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (14, 1, 3, 1299.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (15, 1, 3, 599.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (16, 1, 3, 1629.95);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (17, 1, 3, 1499.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (18, 1, 3, 1069.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (19, 1, 3, 899.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (20, 1, 3, 1539.95);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (21, 1, 3, 879.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (22, 1, 3, 399.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (23, 1, 3, 1379.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (24, 1, 3, 999.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (25, 1, 3, 999.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (26, 1, 3, 1799.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (27, 1, 3, 399.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (28, 1, 3, 999.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (29, 1, 3, 299.98);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (30, 1, 3, 199.97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (31, 1, 3, 399.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (32, 1, 3, 89.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (33, 1, 3, 569.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (34, 1, 3, 99.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (35, 1, 3, 519.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (36, 1, 3, 729.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (37, 1, 3, 599.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (38, 1, 3, 469.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (39, 1, 3, 569.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (40, 1, 3, 1099.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (41, 1, 3, 284.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (42, 1, 3, 229.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (43, 1, 3, 249.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (44, 1, 3, 129.99);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Nihad', 'Alakbarzade', 'alakbarzadenihad@gmail.com', '2364573956', '802 Academy Way', 'Kelowna', 'BC', 'V1V0C4', 'Canada', 'nihadae' , 'pass123');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Joshua', 'Ndala', 'josh@gmail.com', '2222222222', '765 Academy Way', 'Vancouver', 'BC', 'V1V0C4', 'Canada', 'joshndl' , 'pass123');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Anay', 'Legend', 'anay@gmail.com', '3333333333', '985 Academy Way', 'Winnipeg', 'MB', 'V1C7C4', 'Canada', 'anayuser' , 'pass123');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Brandon', 'Gem', 'brandon@gmail.com', '4444444444', '452 Academy Way', 'Toronto', 'ON', 'MXB72A', 'Canada', 'brandonuser' , 'pass123');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('General', 'Manager', 'admin@info.com', '1234567890', '3333 University Way', 'Kelowna', 'BC', 'V1V0V4', 'Canada', 'admin' , 'admin123');

