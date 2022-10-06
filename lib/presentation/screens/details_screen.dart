import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution/constants.dart';
import 'package:qtec_solution/models.dart';

import '../../cubit/search_cubit.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  final Result product;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kTextColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "প্রোডাক্ট ডিটেইল",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 12, right: 12, bottom: 12),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            searchField(),
            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Text(
              widget.product.productName,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, height: 1.5),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "ব্র্যান্ড: ",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  widget.product.brand.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  width: 7,
                ),
                Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                      color: kHighlighTextColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  width: 7,
                ),
                const Text(
                  "ডিস্ট্রিবিউটর: ",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  widget.product.seller,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "ক্রয়মূল্যঃ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kHighlighTextColor),
                      ),
                      Text(
                        '৳ ${widget.product.charge.sellingPrice}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kHighlighTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "বিক্রয়মূল্যঃ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '৳ ${widget.product.charge.sellingPrice}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(
                        400 ~/ 10,
                        (index) => Expanded(
                              child: Container(
                                color: index % 2 == 0
                                    ? Colors.transparent
                                    : Colors.grey,
                                height: 2,
                              ),
                            )),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "লাভঃ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '৳ ${widget.product.charge.profit}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "বিস্তারিত",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 14, wordSpacing: 3, height: 1.5),
            )
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        controller: searchController,
        cursorHeight: 22,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Icon(Icons.search),
            hintText: "Search Item",
            hintStyle:
                TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Raleway'),
            border: InputBorder.none),
        onChanged: (value) {
          context.read<SearchCubit>().searchProduct(searchController.text);
        },
      ),
    );
  }
}
