import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit/news_cubit.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => NewsCubit(context),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            final cubit = context.read<NewsCubit>();
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  color: const Color.fromARGB(255, 228, 226, 220),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      // Replace Row with ListView.builder for dynamic content
                      state is viewData &&
                              state.data.articles?.isNotEmpty == true
                          ? Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.data.articles!.length,
                                itemBuilder: (context, index) {
                                  final article = state.data.articles![index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: article.urlToImage != null
                                              ? NetworkImage(
                                                  article.urlToImage!)
                                              : const AssetImage(
                                                      'assets/placeholder.png')
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              article.title ?? "No Title",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              cubit.fetchdata();
                                            },
                                            child: const Text("Fetch More"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Center(child: Text("No data available")),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
