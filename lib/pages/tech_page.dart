
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/network/resp_obj.dart';
import 'package:news_api/pages/health_page.dart';
import 'package:news_api/providers/category_provider.dart';
import 'package:provider/provider.dart';

class TechPage extends StatefulWidget {
  const TechPage({super.key});

  @override
  State<TechPage> createState() => _TechPageState();
}

class _TechPageState extends State<TechPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().getApiData("technology");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: SafeArea(
        child: Consumer<CategoryProvider>(
          builder: (context, apiProvider, child) {
            final response = apiProvider.respObj;
            if (response.apiState == ApiState.initial) {
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
                            // String? name; 
                            imageUrl: article.urlToImage ?? "url" , //''
                            errorWidget: (context, url, error) => const CircularProgressIndicator(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(
                        article.title ?? "Title",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        article.author ?? "Author", //  ''
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
    );
  }
}
