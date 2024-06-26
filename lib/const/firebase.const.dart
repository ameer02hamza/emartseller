import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
User? currentUser = firebaseAuth.currentUser;

//Colections
const vendorCollections = "vendors";
const productCollections = "products";
const orderCollection = "orders";
const usersCollections = "users";