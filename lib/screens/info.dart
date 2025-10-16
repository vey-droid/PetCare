import 'package:flutter/material.dart';

class PetBreedInfoScreen extends StatelessWidget {
  final List<Map<String, String>> breeds = [
    {
      "name": "Golden Retriever",
      "info": "Friendly, intelligent, and devoted. Great with families."
    },
    {
      "name": "Persian Cat",
      "info": "Calm, affectionate, and long-haired. Needs regular grooming."
    },
    {
      "name": "Bulldog",
      "info": "Gentle and courageous. Loves short walks and naps."
    },
    {
      "name": "Siamese Cat",
      "info": "Vocal, social, and curious. Very interactive with owners."
    },
    {
      "name": "Beagle",
      "info": "Friendly, curious, and merry. Loves sniffing and exploring."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Breeds Info"),
        backgroundColor: const Color(0xFF638C6D),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: breeds.length,
        itemBuilder: (context, index) {
          final breed = breeds[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    breed["name"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF638C6D),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    breed["info"]!,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
