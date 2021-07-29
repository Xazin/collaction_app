import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {

  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://localhost:44301/graphql',
  );


  // Doesn't  need auth
  // final AuthLink authLink = AuthLink(
  //   getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  //   // OR
  //   // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  // );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );



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