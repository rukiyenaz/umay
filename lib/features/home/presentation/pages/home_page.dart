import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/pregnancy_cubit.dart';
import '../cubits/pregnancy_state.dart';

class HomePage extends StatelessWidget {
  final String userName;
  final int startWeek;

  const HomePage({super.key, required this.userName, required this.startWeek});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PregnancyCubit(name: userName, currentWeek: startWeek),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<PregnancyCubit, PregnancyState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Başlık
                    Text(
                      "Pregnancy Tracker",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      "Hello, ${state.name}!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "You are in Week ${state.currentWeek} of your pregnancy.",
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    SizedBox(height: 20),

                    /// İlerleme barı
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pregnancy Progress"),
                        Text("${state.currentWeek}/${state.totalWeeks} weeks"),
                      ],
                    ),
                    SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: state.progress,
                      backgroundColor: Colors.grey[300],
                      color: Colors.pinkAccent,
                      minHeight: 8,
                    ),
                    SizedBox(height: 6),
                    Text(
                      "${(state.progress * 100).toStringAsFixed(0)}% complete",
                    ),

                    SizedBox(height: 20),

                    /// Meyve boyutu + resim
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Your baby is the size of a",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            state.fruit,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          SizedBox(height: 16),
                          state.fruitImage.isNotEmpty
                              ? Image.asset(
                                  state.fruitImage,
                                  height: 120,
                                  width: 120,
                                )
                              : Container(
                                  height: 120,
                                  width: 120,
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    /// Alt butonlar
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children: [
                          _buildButton(Icons.food_bank, "Beslenme ve Egzersiz"),
                          _buildButton(Icons.calendar_month, "Gebe Günlüğü"),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String title) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        padding: const EdgeInsets.all(16),
      ),
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
