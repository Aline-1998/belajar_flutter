import 'package:flutter/material.dart';

class StateDay12 extends StatefulWidget {
  const StateDay12({super.key});

  @override
  State<StateDay12> createState() => _StateDay12State();
}

class _StateDay12State extends State<StateDay12> {
  bool showInfo = false;
  bool showSecret = false;
  bool favorite = false;
  int counter = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          setState(() {
            counter--;
          });
        },
        child: const Icon(Icons.remove),
      ),
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/images/eren.jpg"),
                  ),

                  Text(
                    "Eren Yearger",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showSecret = !showSecret;
                  });
                },
                child: const Text("Deskripsi"),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              showSecret
                  ? "Jika kau tidak berjuang, kau tidak akan menang.Karena aku dilahirkan ke dunia ini"
                  : "",
            ),
            const SizedBox(height: 5),

            // Row(
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         setState(() {
            //           favorite = !favorite;
            //         });
            //       },
            //       icon: Icon(
            //         Icons.favorite,
            //         color: favorite ? Colors.red : Colors.grey,
            //         size: 40,
            //       ),
            //     ),

            //     Text(
            //       favorite ? "Disukai" : "Belum Disukai",
            //       style: const TextStyle(fontSize: 20),
            //     ),
            //   ],
            // ),
            TextButton(
              onPressed: () {
                setState(() {
                  showInfo = !showInfo;
                });
              },
              child: const Text("Info"),
            ),
            Text(
              showInfo
                  ? "Do you wanna know what I hate more than everything else in this world? Anyone who isn't free. They're no better than cattle"
                  : "",
            ),

            const SizedBox(height: 0),

            InkWell(
              onTap: () {
                print("Sentuhan terdeteksi");

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Container berhasil disentuh")),
                );
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/eren.jpg"),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            favorite = !favorite;
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: favorite ? Colors.red : Colors.grey,
                          size: 40,
                        ),
                      ),

                      Text(
                        favorite ? "like" : "",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  counter += 1;
                });

                print("tekan sekali");
              },

              onDoubleTap: () {
                setState(() {
                  counter += 2;
                });

                print("tekan dua kali");
              },

              onLongPress: () {
                setState(() {
                  counter += 1;
                });

                print("Tahan lama");
              },

              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    " Like: $counter",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
