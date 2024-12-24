import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/network/resp_obj.dart';
import 'package:news_api/providers/category_provider.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final NewsModel apiModel;
  const DetailsPage({super.key, required this.apiModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            apiModel.title.toString().toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            apiModel.content.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: CachedNetworkImage(
              imageUrl: apiModel.urlToImage.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}




class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().getApiData("health");
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
                            imageUrl: article.urlToImage.toString(),
                            fit: BoxFit.fill,
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
    );
  }
}