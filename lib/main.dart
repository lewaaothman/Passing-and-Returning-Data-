
import 'package:flutter/material.dart';

class Car {
  final String brand;      
  final String model;       
  final String description; 
  final double price;       
  final String imageUrl;    

  Car({
    required this.brand,
    required this.model,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

void main() {
  runApp(const CarShowroomApp());
}

class CarShowroomApp extends StatelessWidget {
  const CarShowroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'معرض السيارات الحديثة',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.red, 
        useMaterial3: true,
      ),
      home: const CarListScreen(),
    );
  }
}

// --- الشاشة الأولى: قائمة السيارات المتاحة ---
class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  // قائمة السيارات المتوفرة في المعرض
  List<Car> get _cars => [
        Car(
          brand: 'تويوتا',
          model: 'كامري 2024',
          description: 'سيارة سيدان مريحة واقتصادية في استهلاك الوقود، مثالية للعائلات.',
          price: 120000.0,
          imageUrl: 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?q=80&w=400',
        ),
        Car(
          brand: 'مرسيدس',
          model: 'S-Class 2024',
          description: 'قمة الفخامة والرفاهية مع أحدث التقنيات الألمانية المتطورة.',
          price: 550000.0,
          imageUrl: 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?q=80&w=400',
        ),
        Car(
          brand: 'تسلا',
          model: 'Model S',
          description: 'سيارة كهربائية بالكامل مع تسارع مذهل ونظام قيادة ذاتي.',
          price: 380000.0,
          imageUrl: 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?q=80&w=400',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معرض السيارات الحديثة'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: ListView.builder(
        itemCount: _cars.length,
        itemBuilder: (context, index) {
          final car = _cars[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  car.imageUrl,
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                '${car.brand} - ${car.model}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('السعر: ${car.price} ريال'),
              trailing: const Icon(Icons.directions_car, color: Colors.red),
              onTap: () async {
                // --- تمرير بيانات السيارة المحددة واستقبال النتيجة ---
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailsScreen(car: car),
                  ),
                );

                // --- عرض النتيجة في SnackBar ---
                if (result != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.toString()),
                      backgroundColor: Colors.black87,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

// --- الشاشة الثانية: تفاصيل السيارة المختارة ---
class CarDetailsScreen extends StatelessWidget {
  final Car car; // استقبال بيانات السيارة

  const CarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${car.brand} ${car.model}'),
        backgroundColor: Colors.redAccent,
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: SingleChildScrollView( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              car.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        car.brand,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      Text(
                        '${car.price} ريال',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    car.model,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const Divider(height: 30),
                  const Text(
                    'وصف السيارة:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    car.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // --- إرجاع رسالة تأكيد إلى شاشة القائمة ---
                        Navigator.pop(context, 'تمت معاينة سيارة ${car.brand} بنجاح ✅');
                      },
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: const Text('تأكيد المعاينة والرجوع', style: TextStyle(color: Colors.white, fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}