# About app

In this we are going to create a chat app with chat functionality by using firebase service.We will be using firebase packages for authentication, working with database, getting realtime data and image uploads.This app comes with an auth page for registering and loggin in user also image uploading functionality is being added to upload the image of user while registering.once user logs in they are directed to the chat screen real time chat message from user is displayed like in any messaging app.The image of the user is uploaded and stored in firebase using firebase storage.

## screenshots
<img width="208" alt="Screen Shot 2021-03-04 at 7 00 11 PM" src="https://user-images.githubusercontent.com/23056679/110174731-8fb82880-7e26-11eb-93a0-d2013537dcd7.png">  &nbsp; &nbsp; <img width="235" alt="Screen Shot 2021-03-06 at 2 17 13 AM" src="https://user-images.githubusercontent.com/23056679/110174907-e58cd080-7e26-11eb-8fc3-29871643d5de.png">.  <br> </br> <img width="650" alt="Screen Shot 2021-03-06 at 2 56 03 AM" src="https://user-images.githubusercontent.com/23056679/110175373-a448f080-7e27-11eb-9618-227c2137815f.png">



## How to use

### step 1:

Download or clone this repo by using the following link:
[git@github.com:harleenkaurchadha/chat_app.git](git@github.com:harleenkaurchadha/chat_app.git)

### step 2:

Go to your local extracted clone copy of the project, open the android/build.gradle file and change the applicationId to your own application ID.

### step 3:
Go to the project root and execute the following command to get all dependencies packages:
```bash
flutter pub get
```

### step 4:

Go to your Firebase console. Create a new Firebase project. Once created without any issue, register your app by clicking the icon – for Android, click on the Android icon and for iOS, click on the iOS icon. Complete the rest of the steps required as mentioned in the docs.

### Note:

Ensure the Android package name is the same value as your application ID setup in step 2.

### step 5:

Go back to your Firebase console to create the database Cloud Firestore. Choose the test mode option. You can change it later.

### step 6:

Still within Fiebase console, go to Authentication and turn on the sign-in method. In our case, that would be email/password have to turn on by setting the status to enabled.

### step 7:

Done. Try launch the app using emulator or your preferred physical test device.

### step 8:

We need to go to cloud firestore and in rules section paste this to give read and write permissions.
```bash
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
  
  match /users/{uid} {
    allow write: if request.auth!= null && request.auth.uid == uid;
  } 
  
  match /users/{uid} {
    allow read: if request.auth!= null;
  }
  
  match /chat/{document=**} {
    allow read, create: if request.auth!= null; 
  }
          
    }
  }
```

## Third Party Libraries Dependencies:

1. firebase_core
2. cloud_firestore
3. firebase_auth
4. image_picker
5. firebase_storage
6. firebase_messaging
