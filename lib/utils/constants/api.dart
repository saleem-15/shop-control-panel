import 'package:dio/dio.dart';

import '../../app/storage/my_shared_pref.dart';

const apiUrl = 'localhost';
const apiFullUrl = 'http://localhost:80/laravel9/e-commerce/public/api';
const apiPath = '/laravel9/e-commerce/public/api';

const apikey = 'p@ssword123';

final dio = Dio(
  BaseOptions(
    baseUrl: apiFullUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'apiKey': apikey,
      'Authorization': 'Bearer ${MySharedPref.getToken}',
    },
  ),
);

//auth
//
const signIn = '/Auth/dashboard/login';
const signUp = '/Auth/dashboard/register';
const logout = '/Auth/dashboard/logout';
const checkisEmailUsed = '/Auth/user/email';

// Customers
const CUSTOMERS_PATH = '/customer';

//category
const CATEGORY_PATH = '/category';

//products

const PRODUCT_PATH = '/product';
const getCategoryProducts = '/category';

//orders
const ORDER_PATH = '/order';

//cart
const getAllUserCartItems = '/cart/product/index';
const deleteCartItem = '/cart/product/destroy';

//shipping address
const getAllUserShippingAddresses = '/user/address/index';

//shipping type
const SHIPPING_TYPE_PATH = '/shipping/type';

//search
const search = '/product/search';
