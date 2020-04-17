import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertrainer2/logic/posts/bloc.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  GlobalKey<RefreshIndicatorState> indicator =
      new GlobalKey<RefreshIndicatorState>();
  PostsBloc postsBloc;

  @override
  void initState() {
    postsBloc = PostsBloc();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      indicator.currentState.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostsBloc>(
      create: (context) => postsBloc,
      child: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return BlocListener<PostsBloc, PostsState>(
            listener: (BuildContext context, PostsState state) {
              if (state is DownloadingErrorPostsState) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Error: ${state.errorMessage}"),
                ));
              }
            },
            child: RefreshIndicator(
              key: indicator,
              child: BlocBuilder<PostsBloc, PostsState>(
                builder: (BuildContext context, PostsState state) {
                  if (state is DataObtainedPostsState) {
                    return ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.posts[index].title),
                          );
                        });
                  } else if (state is EmptyDataPostsState) {
                    return LayoutBuilder(
                      builder: (context, constraint) {
                        return SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraint.maxHeight,
                            minWidth: constraint.maxWidth),
                            child: Center(child: Text("Brak danych, przeciągnij aby spróbować jeszcze raz")),
                          ),
                        );
                      },
                    );
                  } else if (state is DownloadingPostsState) {
                    return LayoutBuilder(
                      builder: (context, constraint) {
                        return SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraint.maxHeight,
                                minWidth: constraint.maxWidth),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      },
                    );
                  }else {
                    return Container();
                  }
                },
              ),
              onRefresh: () {
                BlocProvider.of<PostsBloc>(context).add(RefreshEvent());
                return BlocProvider.of<PostsBloc>(context)
                    .firstWhere((state) => !(state is DownloadingPostsState));
              },
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    postsBloc.close();
    super.dispose();
  }
}
