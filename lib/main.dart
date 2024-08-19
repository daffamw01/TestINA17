import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NumberBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Test Flutter"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputSection(controller: _controller),
              SizedBox(height: 16),
              ButtonSection(controller: _controller),
              SizedBox(height: 16),
              ResultSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class InputSection extends StatelessWidget {
  final TextEditingController controller;

  InputSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Input Nomor/N:",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan angka N',
          ),
        ),
      ],
    );
  }
}

class ButtonSection extends StatelessWidget {
  final TextEditingController controller;

  ButtonSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.425,
                  child: ElevatedButton(
                    onPressed: () {
                      _onCalculateSequence(context, 1);
                    },
                    child: Text("Soal 1"),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(                  
                  width: MediaQuery.of(context).size.width*0.425,
                  child: ElevatedButton(
                    onPressed: () {
                      _onCalculateSequence(context, 2);
                    },
                    child: Text("Soal 2"),
                              ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(                  
                  width: MediaQuery.of(context).size.width*0.425,
                  child: ElevatedButton(
                    onPressed: () {
                      _onCalculateSequence(context, 3);
                    },
                    child: Text("Soal 3"),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.425,
                  child: ElevatedButton(
                    onPressed: () {
                      _onCalculateSequence(context, 4);
                    },
                    child: Text("Soal 4"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _onCalculateSequence(BuildContext context, int sequenceType) {
    final inputText = controller.text.trim();
    if (inputText.isNotEmpty && int.tryParse(inputText) != null) {
      int number = int.parse(inputText);
      context.read<NumberBloc>().add(CalculateSequence(sequenceType, number));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Masukkan nomor yang valid")),
      );
    }
  }
}

class ResultSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberBloc, NumberState>(
      builder: (context, state) {
        if (state is InitialState) {
          return Text("Hasil akan muncul di sini.");
        } else if (state is SequenceCalculated) {
          return Text(
            state.result,
            style: TextStyle(fontSize: 18),
          );
        }
        return Container();
      },
    );
  }
}

abstract class NumberEvent {}

class CalculateSequence extends NumberEvent {
  final int sequenceType;
  final int number;
  CalculateSequence(this.sequenceType, this.number);
}

abstract class NumberState {}

class InitialState extends NumberState {}

class SequenceCalculated extends NumberState {
  final String result;
  SequenceCalculated(this.result);
}

class NumberBloc extends Bloc<NumberEvent, NumberState> {
  NumberBloc() : super(InitialState()) {
    on<CalculateSequence>(_onCalculateSequence);
  }

  void _onCalculateSequence(CalculateSequence event, Emitter<NumberState> emit) {
    String result = _calculateSequence(event.sequenceType, event.number);
    emit(SequenceCalculated(result));
  }

  String _calculateSequence(int type, int number) {
    switch (type) {
      case 1:
        return List.generate(number, (index) => index + 1).join(' ');
      case 2:
        var ascending = List.generate(number, (index) => index + 1);
        var descending = ascending.reversed.skip(1).toList();
        return (ascending + descending).join(' ');
      case 3:
        return List.generate(number, (index) => '${index + 1}${index + 2}').join(' ');
      case 4:
        return List.generate(number, (index) {
          int current = index + 1;
          if (current % 5 == 0 && current % 7 == 0) {
            return "LIMA TUJUH";
          } else if (current % 5 == 0) {
            return "LIMA";
          } else if (current % 7 == 0) {
            return "TUJUH";
          } else {
            return current.toString();
          }
        }).join(' ');
      default:
        return '';
    }
  }
}
