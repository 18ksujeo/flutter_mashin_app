import 'package:flutter/material.dart';

class MashinFilterButtons extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final void Function(String) onFilterSelected;

  const MashinFilterButtons({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children:
            filters
                .map(
                  (filter) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: selectedFilter == filter,
                      onSelected: (_) => onFilterSelected(filter),
                      selectedColor: const Color(0xFFE8DEF8),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color:
                            selectedFilter == filter
                                ? const Color(0xFF4A4459)
                                : const Color(0xFF49454F),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
