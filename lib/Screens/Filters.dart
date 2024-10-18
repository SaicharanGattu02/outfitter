import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  // State variables to hold selected values for dropdowns
  String selectedDelivery = 'Select Delivery';
  String selectedBrand = 'Select Brand';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Filter
            buildFilterRow(
              context: context,
              field: 'Price',
              widget: RangeSlider(
                values: RangeValues(0, 1000),
                min: 0,
                max: 2000,
                divisions: 10,
                labels: RangeLabels('0', '1000'),
                onChanged: (values) {
                  // Handle slider change
                },
              ),
            ),

            Divider(),

            // Delivery At Filter
            buildFilterRow(
              context: context,
              field: 'Delivery At',
              widget: DropdownButton<String>(
                value: selectedDelivery,
                items: ['Select Delivery', 'Today', 'Tomorrow', 'Within a week']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDelivery = newValue!;
                  });
                },
              ),
            ),

            Divider(),

            // Brand Filter
            buildFilterRow(
              context: context,
              field: 'Brand',
              widget: DropdownButton<String>(
                value: selectedBrand,
                items: ['Select Brand', 'Brand A', 'Brand B', 'Brand C']
                    .map((String brand) {
                  return DropdownMenuItem<String>(
                    value: brand,
                    child: Text(brand),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedBrand = newValue!;
                  });
                },
              ),
            ),

            Divider(),

            // Customer Rating Filter
            buildFilterRow(
              context: context,
              field: 'Customer Rating',
              widget: Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < 3 ? Colors.orange : Colors.grey,
                  );
                }),
              ),
            ),

            Divider(),

            // Discount Filter
            buildFilterRow(
              context: context,
              field: 'Discount',
              widget: CheckboxListTile(
                value: true,
                onChanged: (bool? value) {
                  // Handle discount toggle
                },
                title: Text('Discounted Products Only'),
              ),
            ),

            Divider(),

            // Offers Filter
            buildFilterRow(
              context: context,
              field: 'Offers',
              widget: CheckboxListTile(
                value: true,
                onChanged: (bool? value) {
                  // Handle offers toggle
                },
                title: Text('Show Offers Only'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterRow({
    required BuildContext context,
    required String field,
    required Widget widget,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Side: Filter Field
        Text(
          field,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        // Right Side: Filter Widget (Dropdown, Slider, etc.)
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: widget,
          ),
        ),
      ],
    );
  }
}
