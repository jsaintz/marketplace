import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:nu_conta_marketplace/src/services/resource.dart';

class GraphQLService {
  // GraphQLClient client;
  ValueNotifier<GraphQLClient> initClient() {
    HttpLink httpLink = HttpLink('${Resource.BASE_HOST}');

    final AuthLink authLink = AuthLink(getToken: () => 'Bearer ${Resource.TOKEN}');

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
          cache: GraphQLCache(dataIdFromObject: _typenameDataIdFromObject),
          link: link,
          alwaysRebroadcast: true,
          defaultPolicies: DefaultPolicies()),
    );

    return client;
  }

  String _typenameDataIdFromObject(Object object) {
    if (object is Map<String, Object> && object.containsKey('__typename') && object.containsKey('id')) {
      return "${object['__typename']}/${object['id']}";
    }
    return null;
  }
}
