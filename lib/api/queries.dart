// List of GraphQL queries.

String get_crowdactions_query = """
{
crowdactions{
  name
  description
  }
}
""";


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
