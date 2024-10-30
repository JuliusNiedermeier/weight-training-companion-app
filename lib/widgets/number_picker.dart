import 'package:flutter/material.dart';

class NumberPickerWidget extends StatefulWidget {
  final Function(int) onNumberSelected;

  NumberPickerWidget({required this.onNumberSelected});

  @override
  _NumberPickerWidgetState createState() => _NumberPickerWidgetState();
}

class _NumberPickerWidgetState extends State<NumberPickerWidget>
    with SingleTickerProviderStateMixin {
  int _selectedNumber = 3;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateIndicatorPosition(int index) {
    final indicatorPosition = index.toDouble() * 40.0;
    _animation = Tween<double>(
      begin: _animation.value,
      end: indicatorPosition,
    ).animate(_controller);
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      padding: EdgeInsets.all(16.0),
      itemCount: 30,
      itemBuilder: (context, index) {
        final number = index + 1;
        final isSelected = number == _selectedNumber;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedNumber = number;
            });
            _updateIndicatorPosition(index);
            widget.onNumberSelected(number);
          },
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
