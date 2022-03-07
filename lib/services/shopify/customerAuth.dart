import 'package:shared_preferences/shared_preferences.dart';

class CustomerAuth {
  // Customer login

  static String loginWithEmailAndPassword = '''
  mutation SignInWithEmailAndPassword(
    \$email: String!,
    \$password: String!,
){
    customerAccessTokenCreate(input:{
        email: \$email,
        password: \$password,
    }){
        customerAccessToken {
            accessToken
            expiresAt
        }
        customerUserErrors {
            code
            message
        }
    }
}
''';

// Fetch Customer information

  static String getUserInfo =
      '''query FetchCustomerInfo(\$customerAccessToken: String!) {
  customer(customerAccessToken: \$customerAccessToken) {
    email
    firstName
    id
    lastName
    defaultAddress {
        id
    }
    addresses(first: 100) {
        edges {
            node {
                address1
                city
                country
                id
                province
                zip
            }
        }
    }
  }
}''';

// Get Customer Information

  Future<String> getUserData() async {
    final getUserData = await SharedPreferences.getInstance();
    String userData = getUserData.getString('customerData').toString();

    print("++++++++++++print Body++++++++++++++++");
    print(userData);

    print("++++++++++++json encode++++++++++++++++");
    return userData;
  }

  Future<String> getUserAccessToken() async {
    final getUserData = await SharedPreferences.getInstance();
    // String userData = getUserData.getString('customerData').toString();
    String userAccessToken = getUserData.getString('accessToken').toString();
    print("++++++++++++print Token++++++++++++++++");
    print(userAccessToken);
    print("++++++++++++json Token++++++++++++++++");
    return userAccessToken;
  }

  // Customer Sign-up
  static String customerSignUp = '''
mutation RegisterAccount(
    \$email: String!, 
    \$password: String!,  
    \$firstName: String!, 
    \$lastName: String!
) {
    customerCreate(input: {
        email: \$email, 
        password: \$password, 
        firstName: \$firstName, 
        lastName: \$lastName
    }) {
        customer {
            id
        }
        customerUserErrors {
            code
            message
        }
    }
}
''';
}
