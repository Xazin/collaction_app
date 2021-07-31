import 'package:collaction_app/api/queries.dart';
import 'package:collaction_app/models/crowd_action_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


final QueryOptions options = QueryOptions(
  document: gql(get_crowdactions_query),
);

// Link to the collaction API
final HttpLink httpLink = HttpLink(
  'https://api.collaction.org/graphql',
);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: httpLink,
// The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(store: HiveStore()),
  ),
);


class GraphQL_API {

  static Future<List<CrowdActionModel>> fetchCrowdActions() async {
    // Gets the crowdactions from the API and parses them
    await Future.delayed(Duration(seconds: 1));
    QueryResult response = await _fetchCrowdActionsString();
    List<CrowdActionModel> models =
    GraphQL_Parser.parseCollactionActionString(response);
    return models;
  }

  static Future<QueryResult> _fetchCrowdActionsString() async {
    // Asynchronously requests the available crowdactions through the client
    final QueryResult response = await client.value.query(options);

    if (response.hasException) {
      print(response.exception.toString());
    }
    return response;
  }
}

class GraphQL_Parser {
  static List<CrowdActionModel> parseCollactionActionString(QueryResult input) {
    // Read the response from the server and convert it to a list of
    // CrowdactionModel objects
    List<dynamic> parsed = input.data['crowdactions'].map( (crowdaction) {
      String name = crowdaction['name'];
      String description = crowdaction['description'];

      return CrowdActionModel(
        title: name,
        description: description,
      );
    }).toList();

    List<CrowdActionModel> models = List<CrowdActionModel>.from(parsed);

    return models;
  }
}
