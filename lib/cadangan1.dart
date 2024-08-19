// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter BLoC Example',
//       home: BlocProvider(
//         create: (context) => NumberBloc(),
//         child: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedSequenceType = 1;
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Test Flutter"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _controller,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: "Input N"),
//             ),
//             SizedBox(height: 16),
//             DropdownButton<int>(
//               value: _selectedSequenceType,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedSequenceType = newValue!;
//                 });
//               },
//               items: [
//                 DropdownMenuItem(value: 1, child: Text("1")),
//                 DropdownMenuItem(value: 2, child: Text("2")),
//                 DropdownMenuItem(value: 3, child: Text("3")),
//                 DropdownMenuItem(value: 4, child: Text("4")),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final inputText = _controller.text.trim(); // Remove any leading/trailing spaces
//                 if (inputText.isEmpty || int.tryParse(inputText) == null) {
//                   // Show an error message or handle the invalid input
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Please enter a valid number")),
//                   );
//                   return;
//                 }
    
//     int number = int.parse(inputText);
//     context.read<NumberBloc>().add(CalculateSequence(_selectedSequenceType, number));
//   },
//   child: Text("Calculate"),
// ),
//             SizedBox(height: 16),
//             BlocBuilder<NumberBloc, NumberState>(
//               builder: (context, state) {
//                 if (state is InitialState) {
//                   return Text("Masukkan angka dan pilih terlebih dahulu");
//                 } else if (state is SequenceCalculated) {
//                   return Text(state.result, style: TextStyle(fontSize: 18));
//                 }
//                 return Container();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// abstract class NumberEvent {}

// class NumberChanged extends NumberEvent {
//   final int number;
//   NumberChanged(this.number);
// }

// class CalculateSequence extends NumberEvent {
//   final int sequenceType;
//   final int number;
//   CalculateSequence(this.sequenceType, this.number);
// }

// //StateManagementBLoC
// abstract class NumberState {}

// class InitialState extends NumberState {}

// class SequenceCalculated extends NumberState {
//   final String result;
//   SequenceCalculated(this.result);
// }

// class NumberBloc extends Bloc<NumberEvent, NumberState> {
//   NumberBloc() : super(InitialState()) {
//     on<CalculateSequence>(_onCalculateSequence);
//   }

//   void _onCalculateSequence(CalculateSequence event, Emitter<NumberState> emit) {
//     String result = _calculateSequence(event.sequenceType, event.number);
//     emit(SequenceCalculated(result));
//   }

//   String _calculateSequence(int type, int number) {
//     switch (type) {
//       case 1:
//         return List.generate(number, (index) => index + 1).join(' ');
//       case 2:
//         var ascending = List.generate(number, (index) => index + 1);
//         var descending = ascending.reversed.skip(1).toList(); // Convert Iterable to List
//         return (ascending + descending).join(' ');
//       case 3:
//         return List.generate(number, (index) => '${index + 1}${index + 2}').join(' ');
//       case 4:
//         return List.generate(number, (index) {
//           int current = index + 1;
//           if (current % 5 == 0 && current % 7 == 0) {
//             return "LIMA TUJUH";
//           } else if (current % 5 == 0) {
//             return "LIMA";
//           } else if (current % 7 == 0) {
//             return "TUJUH";
//           } else {
//             return current.toString();
//           }
//         }).join(' ');
//       default:
//         return '';
//     }
//   }
// }
