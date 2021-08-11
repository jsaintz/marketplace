final String query = """
query QueryRoot {
  __typename
  viewer {
    id
    name
    balance
    __typename
    offers{
      id
      price
       __typename
      product{
        id
        name
        description
        image
        __typename
      }
    }
  }
}
""";
