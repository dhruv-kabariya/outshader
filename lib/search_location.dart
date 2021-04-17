import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade/address_bloc/address_bloc.dart';

import 'search_cubit/search_cubit.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({
    Key key,
    @required this.searchController,
    @required this.search,
  }) : super(key: key);

  final TextEditingController searchController;
  final SearchCubit search;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextFormField(
            controller: searchController,
            onChanged: search.search,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: "Search Address"),
          ),
        ),
        Container(
          child: BlocBuilder(
            bloc: search,
            builder: (context, state) {
              if (state is SearchInitial) {
                return Container();
              } else if (state is SearchedLocation) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.suggestions[index].description),
                      onTap: () {
                        BlocProvider.of<AddressBloc>(context)
                          ..add(
                              SelectAddress(address: state.suggestions[index]));
                      },
                    );
                  },
                  itemCount: state.suggestions.length,
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
