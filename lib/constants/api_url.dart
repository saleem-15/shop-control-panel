// ignore_for_file: unnecessary_string_interpolations

import 'package:dio/dio.dart';

const apiUrl = 'localhost';
const apiFullUrl = 'http://192.168.56.1:80/laravel9/e-commerce/public/api';
const apiPath = '/laravel9/e-commerce/public/api';

const apikey = 'p@ssword123';
const adminToken =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NzUyMTllMy02ZmNmLTQ1ZTYtYmFkYy0wM2Y1OTBmYWYwNWIiLCJqdGkiOiIzYjUzYjg0YmQyNWU0NGI5ZjY5YTU5ODlkMGUwODRlNjRkMzk4MWQwODc1MmYzYTIzZDljNGI2YjRkM2Y0OWJlZWI0MmQ0MDk5NzJkMjk0ZSIsImlhdCI6MTY2Mzc4ODc4Ni45ODc4MDUsIm5iZiI6MTY2Mzc4ODc4Ni45ODc4MDcsImV4cCI6MTY5NTMyNDc4Ni45NzIyNDgsInN1YiI6IjEiLCJzY29wZXMiOlsiZGFzaGJvYXJkIl19.MJfVygIuiGHKPqGDPU3L1j9MyeSyoFsGxYya8EuYbRSRttFGWcApSHhfwCiYzSXNWcksuvWb30hdEN_fPJvpilFKqQmAZKh__DCrcMmpoeiiUohrTY8B_IfXa3FJ2pU0A0YmbuFjPx0xsxWPVy1aSagBUfVrqrPESr1Ouj7yLjudVvshoPEg2yA7HXMtDUGPWadfd76oVyaVI_LJNYwH4Q5cLakgkP0b60nOnbrO4GBI6PfFfWRNr0VuooWep2rIygyVVV_C34iqqsJSqN2S5gZ-9xhbD8Ic7UMx92Fc1rEUeK0ZOfM2UKV13iGLevA7GLDGGvvePb4l80JB-JBTbjCDWlnr2XyhJV63o9W6eWwUe-B--EnhKUFybX_KL5jZCYzTm4PMyvQQjGeiEpcVDbeqh98QbtaeC4aMCL_KbubjXbFZ3INPQwQa_rLqPG4TzJIQwVxOh5-i5QK_BPtnjfxqaI70Z8Lgs1332HgATkrVpVmAPe4HoKzJwwJRFhfaLpq7y_TJ0IBHLmu3B5V-F7G0dz_Igz2C-oeOjotAPwABIcyOzdTGJEBGC56G26INbmMnwHEfyGNaIzpeONjvmZKpwM2lphpmHBPQ6BP0jEAgxtBzeGRVV_vcnZrCSIHZhhWgvrxw57vwQG-0al7Xu2H78R2zJjQtI1PI0ct4rnU';

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
