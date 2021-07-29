import 'dart:math';

import 'package:collaction_app/models/crowd_action_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../dummy_data.dart';
import '../home_screen.dart';

String get_crowdactions_query = """
{
crowdactions{
  name
  description
  }
}
""";

final QueryOptions options = QueryOptions(
  document: gql(get_crowdactions_query),
);

// Setting up the GraphQL interaction client as a global variable
final HttpLink httpLink = HttpLink(
  'https://192.168.0.169:44301/graphql',
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
    await Future.delayed(Duration(seconds: 1));
    String response = await _fetchCrowdActionsString();
    List<CrowdActionModel> models =
    GraphQL_Parser.parseCollactionActionString(response);
    return models;
  }

  static Future<String> _fetchCrowdActionsString() async {
    // Asynchronously requests the available crowdactions through the client
    // NOTE: currently returns an exception since local backend is empty
    final QueryResult response = await client.value.query(options);
    String result = '';

    if (response.hasException) {
      // For now we expect an exception, as there are no
      print(response.exception.toString());
    }

    return result;
  }
}

class GraphQL_Parser {
  static List<CrowdActionModel> parseCollactionActionString(String input) {
    List<CrowdActionModel> dummies = DummyData.dummyModels;
    List<CrowdActionModel> moreDummies = DummyData.moreDummyTitles.map((title) {
      Random random = Random();
      int participants = random.nextInt(1000);
      int participantsGoal = random.nextInt(2000);
      return CrowdActionModel(
        title: title,
        numParticipants: participants,
        participantsGoal: participantsGoal,
      );
    }).toList();

    return dummies + moreDummies;
  }
}

void main() async {
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
            title: 'Welcome to CollAction',
            theme: ThemeData(
              primaryColor: Color(0xff23d884),
            ),
            home: HomeScreen()));
  }
}

/*
crowdaction(
  id: ID = null
  ids: [ID] = null
  orderBy: [OrderByGraph] = null
  where: [WhereExpressionGraph] = null
  skip: Int = null
  take: Int = null
): CrowdactionGraph!

crowdactionComment(
  id: ID = null
  ids: [ID] = null
  orderBy: [OrderByGraph] = null
  where: [WhereExpressionGraph] = null
  skip: Int = null
  take: Int = null
): CrowdactionCommentGraph!

crowdactionCommentCount(
  crowdactionId: ID = null
  status: CrowdactionCommentStatus = null
): Int!

crowdactionComments(
  id: ID = null
  ids: [ID] = null
  orderBy: [OrderByGraph] = null
  where: [WhereExpressionGraph] = null
  skip: Int = null
  take: Int = null
  crowdactionId: ID = null
  status: CrowdactionCommentStatus = null
): [CrowdactionCommentGraph]

crowdactionCount(
  status: SearchCrowdactionStatus = null
  category: Category = null
): Int!

crowdactions(
  id: ID = null
  ids: [ID] = null
  orderBy: [OrderByGraph] = null
  where: [WhereExpressionGraph] = null
  skip: Int = null
  take: Int = null
  status: SearchCrowdactionStatus = nullcategory: Category = null
): [CrowdactionGraph]

currentUser(
  id: ID = null
  ids: [ID] = null
  orderBy: [OrderByGraph] = null
  where: [WhereExpressionGraph] = null
  skip: Int = null
  take: Int = null
): ApplicationUserGraph

misc: MiscellaneousGraph!

stats: StatisticsGraph!

user(
  id: ID = null
  ids: [ID] = null
  orderBy: [OrderByGraph] = null
  where: [WhereExpressionGraph] = null
  skip: Int = null
  take: Int = null
): ApplicationUserGraph!

userCount(
  search: String = null
): Int!

users(
  id: ID = null
  ids: [ID] = null
  orderBy: [OrderByGraph] = null
  where: [WhereExpressionGraph] = null
  skip: Int = null
  take: Int = null
  search: String = null
): [ApplicationUserGraph]
*/
