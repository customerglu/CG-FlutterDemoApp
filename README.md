# **Instructions**

<p align="center">
  <a href="#logging-in">Logging in</a> |
  <a href="#wallet">Wallet</a> |
  <a href="#campaigns">Campaigns</a> |
  <a href="#cart">Cart</a> |
  <a href="#test-screen">Test Screen</a>
</p>

## 📚 Requirements
  - [Flutter](https://docs.flutter.dev/get-started/install?gclid=Cj0KCQjw0JiXBhCFARIsAOSAKqD9HVw8wext7mQpoK_KgBBwFcs9_uRCCE9y0KtH9vDBSmGpqnKfeAsaAowREALw_wcB&gclsrc=aw.ds) installed.
  - [Android Studio](https://developer.android.com/studio/install) installed.



## 🚀 Getting Started



```bash
# Cloning the repository
$ git clone https://github.com/customerglu/CG-FlutterDemoApp.git
  
# Enter the folder
$ cd CG-FlutterDemoApp.git
  
#Running the project
$ flutter run 
```



## ⚙️ Project

## Logging in

**1.** For logging in you only need to type an ID. Logging in can be used to registering an user or updating an existing one. You can check at this page for the [Register User Payload](https://docs.customerglu.com/integration-doc#register-a-device).

<p align="center" width="100%">
  <img src="https://media.discordapp.net/attachments/1003367861609308263/1003367899353845801/login.gif?width=296&height=634"/>
</p>

## Wallet

**2.** Wallet will open a WebView where the user can check Activities & Rewards won.

<p align="center" width="100%">
  <img src="https://media.discordapp.net/attachments/1003367861609308263/1003370055779766272/wallet.gif?width=296&height=634"/>
</p>

## Campaigns

**3.** Campaigns will open WebView where the user can see all the campaigns, select one and play for prizes.

<p align="center" width="100%">
  <img src="https://media.discordapp.net/attachments/1003367861609308263/1003372273325047830/campaigns.gif?width=296&height=634"/>
</p>

## Cart

**4.** Cart lets the user put an order, redeeming the prizes won.

<p align="center" width="100%">
  <img src="https://media.discordapp.net/attachments/1003367861609308263/1003373958411853865/cart.gif?width=296&height=634"/>
</p>

## Test Screen

**5.** Test screen will let you test each functionality individually.

<p align="center" width="100%">
  <img src="https://media.discordapp.net/attachments/1003367861609308263/1003374787080495265/test_screen.gif?width=296&height=634"/>
</p>

  - **Load Campaign by Filter** will open the campaigns filtered by status and/or type. You can check more about the parameters accepted in those two [here](https://docs.customerglu.com/integration-doc#load-campaigns)
  - **Load Campaign by Id** let the user open a specific Campaign by its id. Campaign id can be found in the dashboard, after you create one.
    <p align="center" width="100%">
      <img src="https://2115685913-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-M0ahLW2WavtwcwNbSR9%2Fuploads%2FwsthlE303wIocU4lN6jo%2Fimage.png?alt=media&token=7b0645b2-12cd-4cc7-910a-ce38ad778a3d"/>
    </p>
  - **In-app Middle/Bottom Notification** will open a WebView from the middle or bottom of the screen. To understand more about Send Events go [here](https://docs.customerglu.com/advanced-topics/send-user-events)
    <p align="center" width="100%">
        <img src="https://media.discordapp.net/attachments/1003367861609308263/1003378452080115792/bottom_notification.gif?width=296&height=634"/>
        <img src="https://media.discordapp.net/attachments/1003367861609308263/1003378467129262161/mid_notification.gif?width=296&height=634"/>
    </p>
   - **LoaderColour** lets you change the color of the loader while it waits for the WebView to load in.
   - **disableGluSdk** will disable all the functionalities.

You can check more about the documentation by clicking [here](https://docs.customerglu.com/sdk/flutter)
