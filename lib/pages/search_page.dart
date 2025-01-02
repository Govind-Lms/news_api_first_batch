import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/network/resp_obj.dart';
import 'package:news_api/pages/tabs/everything_page.dart';
import 'package:news_api/providers/everything_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  context.read<EverythingProvider>().getApiData(value);
                },
                decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<EverythingProvider>(
                builder: (context, apiProvider, child) {
                  final response = apiProvider.respObj;
              
                  if (response.apiState == ApiState.initial || response.apiState == ApiState.loading) {
                    return const Center(
                      child: CircularProgressIndicator()
                    );
                  }
              
                  else if(response.apiState == ApiState.success){
                    if (response.data != null) {
                      List<NewsModel> articles = response.data;
                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DetailsPage(apiModel: article),
                                ),
                              );
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage.toString(),
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) => Container(),
                                ),
                              ),
                            ),
                            title: Text(
                              article.title.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              article.author.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(Icons.more_horiz),
                          );
                        },
                      );
                    }
                    else{
                      return const Center(
                        child: Text("Empty List"),
                      );
                    } 
                  }
                  else {
                    return Center(
                      child: Text(response.data.toString()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}