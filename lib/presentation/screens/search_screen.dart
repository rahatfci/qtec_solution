import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution/api_services.dart';
import 'package:qtec_solution/models.dart';

import '../../constants.dart';
import '../../cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(top: 60, left: 12, right: 12, bottom: 0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              searchField(),
              const SizedBox(
                height: 20,
              ),
              productDesign(),
            ],
          ),
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

  Widget productDesign() {
    return BlocBuilder<SearchCubit, dynamic>(
      builder: (context, state) {
        if (state == null) {
          return const Text(
            "Enter the product name to search",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: .8,
                fontFamily: 'Raleway'),
          );
        } else if (state is String) {
          return Text(
            state,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: .8,
                fontFamily: 'Raleway'),
          );
        } else {
          List<Result> data = state.results as List<Result>;
          return GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 280,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () async {
                  FocusManager.instance.primaryFocus!.unfocus();
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                        title: Center(child: CircularProgressIndicator())),
                  );
                  dynamic productDetails = await fetchDetails(data[i].slug);
                  Navigator.pop(context);
                  if (productDetails is String) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          state,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .8,
                              fontFamily: 'Raleway'),
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushNamed(context, '/details',
                        arguments: productDetails);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Hero(
                        tag: data[i].id,
                        child: data[i].stock <= 0
                            ? Badge(
                                shape: BadgeShape.square,
                                badgeContent: const Text("স্টকে নেই",
                                    style: TextStyle(
                                        color: Color(0xFFC6706C),
                                        fontFamily: 'Raleway',
                                        fontSize: 16)),
                                badgeColor:
                                    const Color(0xFFC6706C).withOpacity(.7),
                                animationType: BadgeAnimationType.scale,
                                child: CachedNetworkImage(
                                  imageUrl: data[i].image,
                                  height: 140,
                                  progressIndicatorBuilder:
                                      (BuildContext context, String url,
                                              DownloadProgress progress) =>
                                          Center(
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(
                                          color: kPrimaryColor,
                                          value: progress.progress),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.error,
                                        color: kPrimaryColor,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Something went wrong",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              overflow: TextOverflow.fade,
                                              fontFamily: 'Raleway'),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            : CachedNetworkImage(
                                imageUrl: data[i].image,
                                height: 140,
                                progressIndicatorBuilder: (BuildContext context,
                                        String url,
                                        DownloadProgress progress) =>
                                    Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                        value: progress.progress),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.error,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Something went wrong",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            overflow: TextOverflow.fade,
                                            fontFamily: 'Raleway'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data[i].productName,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1.1),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ক্রয়",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                          Text(
                            '৳ ${data[i].charge.currentCharge}',
                            style: const TextStyle(
                                color: kHighlighTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Text(
                            data[i].charge.discountCharge == null
                                ? 'N/A'
                                : '৳ ${data[i].charge.discountCharge}',
                            style: const TextStyle(
                              color: kHighlighTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "বিক্রয়",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                          Text(
                            '৳ ${data[i].charge.sellingPrice}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "লাভ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                              Text(
                                ' ৳ ${data[i].charge.profit}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
