class Products {
  // Customer login

  static String getMattress = '''
  query{
  products(first: 4, query: "mattress") {
   edges {
        node {
          id
          title
          vendor
          description
          availableForSale
          images (first:1) {
            edges {
              node {
                id
                transformedSrc
                width
                height
                altText
              }
            }
          }
          priceRange {
            minVariantPrice {
              amount
              currencyCode
            }
            maxVariantPrice {
              amount
              currencyCode
            }
          }
        }
      }
    
  }
}

''';

  static String getBeds = '''
  query{
  products(first: 4, query: "bed-online") {
   edges {
        node {
          id
          title
          vendor
          description
          availableForSale
          images (first:1) {
            edges {
              node {
                id
                transformedSrc
                width
                height
                altText
              }
            }
          }
          priceRange {
            minVariantPrice {
              amount
              currencyCode
            }
            maxVariantPrice {
              amount
              currencyCode
            }
          }
        }
      }
    
  }
}

''';

  static String getPillows = '''
  query{
  products(first: 4, query: "pillows") {
   edges {
        node {
          id
          title
          vendor
          description
          availableForSale
          images (first:1) {
            edges {
              node {
                id
                transformedSrc
                width
                height
                altText
              }
            }
          }
          priceRange {
            minVariantPrice {
              amount
              currencyCode
            }
            maxVariantPrice {
              amount
              currencyCode
            }
          }
        }
      }
    
  }
}

''';

  static String getBedding = '''
  query{
  products(first: 4, query: "duvets-quilts") {
   edges {
        node {
          id
          title
          vendor
          description
          availableForSale
          images (first:1) {
            edges {
              node {
                id
                transformedSrc
                width
                height
                altText
              }
            }
          }
          priceRange {
            minVariantPrice {
              amount
              currencyCode
            }
            maxVariantPrice {
              amount
              currencyCode
            }
          }
        }
      }
    
  }
}

''';

  static String getEssentials = '''
  query{
  products(first: 4, query: "sleep-essentials") {
   edges {
        node {
          id
          title
          vendor
          description
          availableForSale
          images (first:1) {
            edges {
              node {
                id
                transformedSrc
                width
                height
                altText
              }
            }
          }
          priceRange {
            minVariantPrice {
              amount
              currencyCode
            }
            maxVariantPrice {
              amount
              currencyCode
            }
          }
        }
      }
    
  }
}

''';

  static String getProductsById = '''
  query{
  products(first: 4, query: "sleep-essentials") {
   edges {
        node {
          id
          title
          vendor
          description
          availableForSale
          images (first:1) {
            edges {
              node {
                id
                transformedSrc
                width
                height
                altText
              }
            }
          }
          priceRange {
            minVariantPrice {
              amount
              currencyCode
            }
            maxVariantPrice {
              amount
              currencyCode
            }
          }
        }
      }
    
  }
}

''';
}
