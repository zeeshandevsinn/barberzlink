// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

// class FindCatLevel2 extends StatefulWidget {
//   final String catImage;
//   final String otherImage;
//   final String bucketClosed;
//   final String bucketOpen;
//   final VoidCallback onWin;
//   final VoidCallback onFail;

//   const FindCatLevel2({
//     Key? key,
//     required this.catImage,
//     required this.otherImage,
//     required this.bucketClosed,
//     required this.bucketOpen,
//     required this.onWin,
//     required this.onFail,
//   }) : super(key: key);

//   @override
//   State<FindCatLevel2> createState() => _FindCatLevel2State();
// }

// class _FindCatLevel2State extends State<FindCatLevel2>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _bucketDropAnimation;

//   // Game state
//   List<String> images = [];
//   List<bool> bucketRevealed = [];
//   List<bool> bucketHasCat = [];
//   bool showImagesInitially = true;
//   bool shuffling = false;
//   bool gameReady = false;
//   int catPosition = 0;
//   int selectedBucket = -1;

//   @override
//   void initState() {
//     super.initState();

//     initializeGame();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     _bucketDropAnimation = Tween<double>(begin: -200, end: 0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.bounceOut,
//       ),
//     );

//     startGameSequence();
//   }

//   void initializeGame() {
//     images = [widget.catImage, widget.otherImage, widget.otherImage];
//     bucketRevealed = [false, false, false];
//     bucketHasCat = [false, false, false];
//     showImagesInitially = true;
//     shuffling = false;
//     gameReady = false;
//     selectedBucket = -1;

//     catPosition = DateTime.now().millisecond % 3;
//     bucketHasCat[catPosition] = true;
//   }

//   void startGameSequence() {
//     // Show images for 2 seconds
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       Future.delayed(const Duration(seconds: 2), () {
//         if (mounted) {
//           setState(() {
//             showImagesInitially = false;
//           });

//           // Drop buckets
//           _animationController.forward().then((_) {
//             // Shuffle after buckets drop
//             startShuffling();
//           });
//         }
//       });
//     });
//   }

//   void startShuffling() {
//     setState(() {
//       shuffling = true;
//     });

//     int shuffleCount = 0;
//     const totalShuffles = 8;

//     void performShuffle() {
//       if (shuffleCount < totalShuffles && mounted) {
//         setState(() {
//           // Swap two random positions
//           int pos1 = (shuffleCount * 2) % 3;
//           int pos2 = (shuffleCount * 2 + 1) % 3;

//           // Swap everything
//           String tempImage = images[pos1];
//           images[pos1] = images[pos2];
//           images[pos2] = tempImage;

//           bool tempCat = bucketHasCat[pos1];
//           bucketHasCat[pos1] = bucketHasCat[pos2];
//           bucketHasCat[pos2] = tempCat;

//           if (bucketHasCat[pos1]) catPosition = pos1;
//           if (bucketHasCat[pos2]) catPosition = pos2;
//         });

//         shuffleCount++;
//         Future.delayed(const Duration(milliseconds: 300), performShuffle);
//       } else if (mounted) {
//         setState(() {
//           shuffling = false;
//           gameReady = true;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content:
//                 Text('Buckets are shuffled! Tap any bucket to find the cat!'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     }

//     performShuffle();
//   }

//   void revealBucket(int index) {
//     if (!gameReady || bucketRevealed[index] || selectedBucket != -1) return;

//     setState(() {
//       selectedBucket = index;
//       bucketRevealed[index] = true;
//     });

//     Future.delayed(const Duration(milliseconds: 800), () {
//       if (bucketHasCat[index]) {
//         widget.onWin();
//         showResultDialog(true);
//       } else {
//         widget.onFail();
//         showResultDialog(false);
//       }
//     });
//   }

//   void showResultDialog(bool isWin) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: Icon(
//           isWin ? Icons.celebration : Icons.sentiment_dissatisfied,
//           color: isWin ? Colors.green : Colors.red,
//           size: 50,
//         ),
//         content: Text(
//           isWin
//               ? '🎉 Congratulations! You found the cat!'
//               : '😿 Oops! The cat was in Bucket ${catPosition + 1}',
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 18),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               restartGame();
//             },
//             child: const Text('PLAY AGAIN'),
//           ),
//         ],
//       ),
//     );
//   }

//   void restartGame() {
//     initializeGame();
//     _animationController.reset();
//     Future.delayed(const Duration(milliseconds: 300), () {
//       startGameSequence();
//       _animationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // Title
//         Text(
//           'Find the Cat',
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//         ),
//         const SizedBox(height: 10),
//         Text(
//           'Can you find where the cat is hiding?',
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         const SizedBox(height: 30),

//         // Game area - FIXED: Images stay fixed, buckets move
//         Container(
//           height: 350,
//           width: double.infinity,
//           child: Stack(
//             children: [
//               // ========== FIXED POSITION IMAGES ==========
//               // Images stay at the bottom ALWAYS (fixed position)
//               Positioned(
//                 bottom: 20, // Fixed position at bottom
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: List.generate(3, (index) {
//                     return Container(
//                       width: 100,
//                       height: 100,
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: bucketRevealed[index]
//                             ? Border.all(color: Colors.green, width: 3)
//                             : null,
//                         color: bucketRevealed[index]
//                             ? Colors.grey[200]
//                             : Colors.transparent,
//                       ),
//                       child: bucketRevealed[index]
//                           ? Image.network(
//                               images[index],
//                               fit: BoxFit.contain,
//                             )
//                           : Container(), // Empty container when not revealed
//                     );
//                   }),
//                 ),
//               ),

//               // ========== MOVING BUCKETS ==========
//               // Buckets that drop down and slide up
//               if (!showImagesInitially)
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(3, (index) {
//                       return GestureDetector(
//                         onTap: () => revealBucket(index),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 500),
//                           curve: Curves.easeOut,
//                           transform: Matrix4.translationValues(
//                             0,
//                             bucketRevealed[index]
//                                 ? -140 // Slide UP to reveal image underneath
//                                 : _bucketDropAnimation
//                                     .value, // Drop down from top
//                             0,
//                           ),
//                           child: Column(
//                             children: [
//                               // Bucket number label
//                               Text(
//                                 'Bucket ${index + 1}',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: bucketRevealed[index]
//                                       ? Colors.green
//                                       : Colors.black,
//                                 ),
//                               ),
//                               const SizedBox(height: 5),

//                               // Bucket image
//                               Container(
//                                 width: 130,
//                                 height: 150,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.2),
//                                       blurRadius: 10,
//                                       offset: const Offset(0, 5),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Image.network(
//                                   bucketRevealed[index]
//                                       ? widget.bucketOpen
//                                       : widget.bucketClosed,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),

//               // Initial images preview (shown for 2 seconds only)
//               if (showImagesInitially)
//                 Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: AnimatedOpacity(
//                     opacity: showImagesInitially ? 1.0 : 0.0,
//                     duration: const Duration(milliseconds: 500),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: List.generate(3, (index) {
//                         return Column(
//                           children: [
//                             Container(
//                               width: 100,
//                               height: 100,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Image.network(
//                                 images[index],
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               'Item ${index + 1}',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                     ),
//                   ),
//                 ),

//               // Shuffling overlay
//               if (shuffling)
//                 Positioned.fill(
//                   child: Container(
//                     color: Colors.black.withOpacity(0.7),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const CircularProgressIndicator(
//                             color: Colors.white,
//                           ),
//                           const SizedBox(height: 20),
//                           const Text(
//                             'Shuffling Buckets...',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),

//         // Instructions
//         const SizedBox(height: 30),
//         Container(
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: Colors.blue[50],
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             children: [
//               const Text(
//                 'How to Play:',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 gameReady && !shuffling
//                     ? '✅ Tap any bucket to reveal what\'s inside!'
//                     : shuffling
//                         ? '⏳ Buckets are shuffling...'
//                         : '👀 Watch carefully where the cat goes!',
//                 style: const TextStyle(fontSize: 14),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),

//         // Game controls
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton.icon(
//               onPressed: restartGame,
//               icon: const Icon(Icons.refresh),
//               label: const Text('Restart Game'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.deepPurple,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 12,
//                 ),
//               ),
//             ),
//           ],
//         ),

//         // Game status
//         const SizedBox(height: 20),
//         if (selectedBucket != -1)
//           Text(
//             bucketHasCat[selectedBucket]
//                 ? '🎉 You found the cat!'
//                 : '😿 Not in this bucket...',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: bucketHasCat[selectedBucket] ? Colors.green : Colors.red,
//             ),
//           ),
//       ],
//     );
//   }
// }
