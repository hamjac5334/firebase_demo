import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'src/widgets.dart';

class YesNoSelection extends StatelessWidget {
  const YesNoSelection(
      {super.key, required this.state, required this.onSelection});
  final Attending state;
  final void Function(Attending selection) onSelection;

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    switch (state) {
      case Attending.yes:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () => onSelection(Attending.yes),
                    child: const Text('YES'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => onSelection(Attending.no),
                    child: const Text('NO'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Guests #',
                      //style: TextStyle(fontWeight: FontWeight.bold), fontSize: 40,  
                      ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Number of Guests (int)',
                      ),
                      //keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter how many Guests are you bringing (int)';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  StyledButton(
                    onPressed: () {
                      final input = _controller.text;
                      if (input.isNotEmpty) {
                        final count = int.tryParse(input);
                        if (count != null && count > 0) {
                          Provider.of<ApplicationState>(context, listen: false).addAttendees(count);
                          _controller.clear(); // Clear the input after adding
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter a valid positive number')),
                          );
                        }
                      }
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.send),
                        SizedBox(width: 4),
                        Text('SEND'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

      case Attending.no:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () => onSelection(Attending.yes),
                child: const Text('YES'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onSelection(Attending.no),
                child: const Text('NO'),
              ),
            ],
          ),
        );

      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              StyledButton(
                onPressed: () => onSelection(Attending.yes),
                child: const Text('YES'),
              ),
              const SizedBox(width: 8),
              StyledButton(
                onPressed: () => onSelection(Attending.no),
                child: const Text('NO'),
              ),
            ],
          ),
        );
    }
  }
}