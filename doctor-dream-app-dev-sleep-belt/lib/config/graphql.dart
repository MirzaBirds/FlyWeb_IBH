import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient getGraphQLClient() {
  final Link _link = HttpLink(
    // 'https://binarytraining.myshopify.com/api/2021-10/graphql.json',
    'https://doctor-dreams.myshopify.com/api/2021-10/graphql.json',
    defaultHeaders: {
      // 'X-Shopify-Storefront-Access-Token': 'de38d0ce54424b4f952537fe5094c575',
      'X-Shopify-Storefront-Access-Token': 'fde4d5e96b71d3ccddf913b873a2c4af',
    },
  );

  return GraphQLClient(
    cache: GraphQLCache(),
    link: _link,
  );
}
