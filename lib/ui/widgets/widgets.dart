import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [CircularProgressIndicator(), Text("Loading News Items")],
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Oh no! Something went wrong! 😞");
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.label});

  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.7),
      ),
      child: label,
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.onSubmit});

  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: onSubmit,
        decoration: const InputDecoration(
          icon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
