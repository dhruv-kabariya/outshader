import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade/model/address.dart';

import 'search_cubit/address_bloc/address_bloc.dart';
import 'search_cubit/search_cubit.dart';

class SearchLocation extends StatefulWidget {
  SearchLocation({
    Key key,
  }) : super(key: key);

  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  TextEditingController searchController;

  SearchCubit search;
  Suggestion initialData;

  @override
  void initState() {
    initialData = (BlocProvider.of<AddressBloc>(context).state is AddressChange)
        ? (BlocProvider.of<AddressBloc>(context).state as AddressChange)
            .address
            .suggestion
        : null;

    searchController = TextEditingController(
        text: (initialData != null) ? initialData.description : null);

    search = SearchCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          // decoration: ,
          child: TextFormField(
            controller: searchController,
            onChanged: search.search,
            decoration: InputDecoration(hintText: "Search Address"),
          ),
        ),
        Container(
          height: 300,
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

  @override
  void dispose() {
    search.close();
    super.dispose();
  }
}
