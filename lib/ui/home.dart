// ignore_for_file: use_key_in_widget_constructors

import 'package:cat_fact/bloc/cat_fact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    CatFactBloc catFactBloc = CatFactBloc();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 223, 164),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Lottie.asset('lib/images/run.json',
                height: 200, alignment: Alignment.topLeft),
          ),
          refreshButton(catFactBloc),
          Center(
            child: BlocBuilder<CatFactBloc, CatFactState>(
              bloc: catFactBloc,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case CatFactFetchLoadingState:
                    return Opacity(
                      opacity: 0.5,
                      child: Lottie.asset('lib/images/paw.json',
                          height: 200, alignment: Alignment.topLeft),
                    );
                  case CatFactFetchErrorState:
                    return Lottie.asset('lib/images/error.json',
                        height: 200, alignment: Alignment.topLeft);

                  case CatFactFetchSuccessState:
                    final successState = state as CatFactFetchSuccessState;
                    return Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: successState.posts.length,
                        itemBuilder: (context, int index) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                successState.posts[index].fact,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
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
    );
  }

  Widget refreshButton(CatFactBloc catFactBloc) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
              shape: StadiumBorder()),
          onPressed: () {
            catFactBloc.add(CatFactInitialFetchEvent());
          },
          child: const Text("Learn a new Cat Fact"),
        ),
      ),
    );
  }
}
