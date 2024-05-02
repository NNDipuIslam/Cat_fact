// ignore_for_file: use_key_in_widget_constructors

import 'package:cat_fact/bloc/cat_fact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    CatFactBloc catFactBloc = CatFactBloc();
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              refreshButton(catFactBloc),
              Center(
                child: BlocBuilder<CatFactBloc, CatFactState>(
                  bloc: catFactBloc,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case CatFactFetchLoadingState:
                        return const CircularProgressIndicator();
                      case CatFactFetchErrorState:
                        return const Text('Error Occurred');
                      case CatFactFetchSuccessState:
                        final successState = state as CatFactFetchSuccessState;
                        return Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: successState.posts.length,
                            itemBuilder: (context, int index) {
                              return Center(
                                child: Text(
                                  successState.posts[index].fact,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              );
                            },
                          ),
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget refreshButton(CatFactBloc catFactBloc) {
    return TextButton(
      onPressed: () {
        catFactBloc.add(CatFactInitialFetchEvent());
      },
      child: const Text("Learn a new Cat Fact"),
    );
  }
}
