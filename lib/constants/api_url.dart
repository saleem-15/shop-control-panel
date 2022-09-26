// ignore_for_file: unnecessary_string_interpolations

import 'package:dio/dio.dart';

const apiUrl = 'localhost';
const apiFullUrl = 'http://192.168.56.1:80/laravel9/e-commerce/public/api';
const apiPath = '/laravel9/e-commerce/public/api';

const apikey = 'p@ssword123';
const adminToken =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NzViMWVkOS1hZDViLTRkMDItYWM3OC1iMzA3YzVjYzA3ZGEiLCJqdGkiOiJkMDhiNjhiYjA5YzM3M2QxNzFmZjUwNGI1YzQxN2UwODAyMmY4Y2FkZDFjZmIyMDM4NGYzMTMxNGY0ZjdmMGE0Y2VlMzc5ZGFkNDliYmE0ZSIsImlhdCI6MTY2NDE3NjIzNC40NTcyMzEsIm5iZiI6MTY2NDE3NjIzNC40NTcyMzQsImV4cCI6MTY5NTcxMjIzNC40NDUzNjgsInN1YiI6IjEiLCJzY29wZXMiOlsiZGFzaGJvYXJkIl19.DOTNoncrd4-TC74NbAZGBncZkFtszgzmNAlDxKjDiYljAxIR286ZtqmN0kraGhxCDYAVmN-NDR5IUuzE9asbsEx3QPJdOzXcoLdHZe44mDHQQbwvS5gsd7JQDbyQyiA4AMmUXtscvyrCbD2iGCO1yLYYbHVwlXS1laANL-judzdz461uE1XJoFAu2q0ovC8isPKIlKZ3eED0X9ziqjh5cn3LVE6dQa3z6qFoX7CQOqJCpD6Thz8A3wF5B0mBhfOC_rGYczDBbk3a3i3gbrtdo13lPmr8qGpfIW4MBC6_8GGDWccHN_YV4LpZ8CO4ksJtPeM6zITZBzpyH6dXSxBeR5gBgTBrzeBhBI-AfvcElnQXo0rgdnzs11Lm2Paje0E7bamX_u5W9K7F3X44ywlwrjpgEVDnheH8etBlow__YOCPKxx_4YnEVJOUcfiTqNGRN_IKYhGW4fPvFPF4gSmp5fm07sZfEw2tt7zl0aRdeSUWPWAUNlbyyQZ-xRfFGNQnyFxGvHRkED42eXz8SM0_dqBy8TEzBX7xW3S9AbLnqlPEDSHCxgDFl29rXzXVoF2QvsJoH1n2Z7oN3U1cfa__4tlgWle8pUxiwVXuT51L_VvsP3T4VHxu6JtqRQbRXBY6KmoaM4csGVvD2uBYr2rA22XvYQB6wcJ9Im9pAFQJ3KM';
final dio = Dio(
  BaseOptions(
    baseUrl: apiFullUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'apiKey': apikey,
      'Authorization': 'Bearer $adminToken',
    },
  ),
);

//auth
const signIn = '/Auth/user/login';
const signUp = '/Auth/user/register';
const logout = '/Auth/user/logout';
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
