import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '../flutter_flow_theme.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '../../auth/base_auth_user_provider.dart';
import '../../backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;

import '../../index.dart';
import '../../main.dart';
import '../lat_lng.dart';
import '../place.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    if (notifyOnAuthChange) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, _) => appStateNotifier.loggedIn
          ? NavBarPage()
          : AuthentificationCopyWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? NavBarPage()
              : AuthentificationCopyWidget(),
          routes: [
            FFRoute(
              name: 'Authentification',
              path: 'authentification',
              builder: (context, params) => AuthentificationWidget(),
            ),
            FFRoute(
              name: 'VerificationSMS',
              path: 'verificationSMS',
              builder: (context, params) => VerificationSMSWidget(
                phoneNumber: params.getParam('phoneNumber', ParamType.String),
              ),
            ),
            FFRoute(
              name: 'CreerProfil',
              path: 'creerProfil',
              builder: (context, params) => CreerProfilWidget(
                isFirst: params.getParam('isFirst', ParamType.bool),
                phoneNumber: params.getParam('phoneNumber', ParamType.String),
              ),
            ),
            FFRoute(
              name: 'PasseOublie',
              path: 'passeOublie',
              builder: (context, params) => PasseOublieWidget(),
            ),
            FFRoute(
              name: 'Rechercher',
              path: 'rechercher',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Rechercher')
                  : RechercherWidget(),
            ),
            FFRoute(
              name: 'AjouterTrajet',
              path: 'ajouterTrajet',
              builder: (context, params) => AjouterTrajetWidget(),
            ),
            FFRoute(
              name: 'MesTrajets',
              path: 'mesTrajets',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'MesTrajets')
                  : MesTrajetsWidget(),
            ),
            FFRoute(
              name: 'Destination',
              path: 'destination',
              builder: (context, params) => DestinationWidget(
                depart: params.getParam('depart', ParamType.FFPlace),
              ),
            ),
            FFRoute(
              name: 'Messages',
              path: 'messages',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Messages')
                  : MessagesWidget(),
            ),
            FFRoute(
              name: 'Parametres',
              path: 'parametres',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Parametres')
                  : ParametresWidget(),
            ),
            FFRoute(
              name: 'HeureDepart',
              path: 'heureDepart',
              builder: (context, params) => HeureDepartWidget(
                depart: params.getParam('depart', ParamType.FFPlace),
                destination: params.getParam('destination', ParamType.FFPlace),
                dateDepart: params.getParam('dateDepart', ParamType.DateTime),
                retour: params.getParam('retour', ParamType.bool),
              ),
            ),
            FFRoute(
              name: 'DateDepart',
              path: 'dateDepart',
              builder: (context, params) => DateDepartWidget(
                depart: params.getParam('depart', ParamType.FFPlace),
                destination: params.getParam('destination', ParamType.FFPlace),
                dateDepart: params.getParam('dateDepart', ParamType.DateTime),
                retour: params.getParam('retour', ParamType.bool),
              ),
            ),
            FFRoute(
              name: 'PlacesDispo',
              path: 'placesDispo',
              builder: (context, params) => PlacesDispoWidget(
                depart: params.getParam('depart', ParamType.FFPlace),
                destination: params.getParam('destination', ParamType.FFPlace),
                dateDepart: params.getParam('dateDepart', ParamType.DateTime),
                heureDepart: params.getParam('heureDepart', ParamType.DateTime),
                retour: params.getParam('retour', ParamType.bool),
              ),
            ),
            FFRoute(
              name: 'Tarifs',
              path: 'tarifs',
              builder: (context, params) => TarifsWidget(
                depart: params.getParam('depart', ParamType.FFPlace),
                destination: params.getParam('destination', ParamType.FFPlace),
                dateDepart: params.getParam('dateDepart', ParamType.DateTime),
                heureDepart: params.getParam('heureDepart', ParamType.DateTime),
                placesDispo: params.getParam('placesDispo', ParamType.int),
                retour: params.getParam('retour', ParamType.bool),
              ),
            ),
            FFRoute(
              name: 'TrajetRetour',
              path: 'trajetRetour',
              builder: (context, params) => TrajetRetourWidget(
                depart: params.getParam('depart', ParamType.FFPlace),
                destination: params.getParam('destination', ParamType.FFPlace),
                dateDepart: params.getParam('dateDepart', ParamType.DateTime),
                duree: params.getParam('duree', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'Recapitulatif',
              path: 'recapitulatif',
              builder: (context, params) => RecapitulatifWidget(
                depart: params.getParam('depart', ParamType.FFPlace),
                destination: params.getParam('destination', ParamType.FFPlace),
                dateDepart: params.getParam('dateDepart', ParamType.DateTime),
                heureDepart: params.getParam('heureDepart', ParamType.DateTime),
                placesDispo: params.getParam('placesDispo', ParamType.int),
                prix: params.getParam('prix', ParamType.int),
                retour: params.getParam('retour', ParamType.bool),
              ),
            ),
            FFRoute(
              name: 'resultatRecherche',
              path: 'resultatRecherche',
              builder: (context, params) => ResultatRechercheWidget(
                departVille: params.getParam('departVille', ParamType.String),
                destinationVille:
                    params.getParam('destinationVille', ParamType.String),
                places: params.getParam('places', ParamType.int),
                dateDepart: params.getParam('dateDepart', ParamType.DateTime),
              ),
            ),
            FFRoute(
              name: 'trajetDetails',
              path: 'trajetDetails',
              builder: (context, params) => TrajetDetailsWidget(
                voyage: params.getParam(
                    'voyage', ParamType.DocumentReference, false, ['voyage']),
                places: params.getParam('places', ParamType.int),
                reservationID: params.getParam(
                    'reservationID',
                    ParamType.DocumentReference,
                    false,
                    ['voyage', 'reservation']),
                isDriver: params.getParam('isDriver', ParamType.bool),
              ),
            ),
            FFRoute(
              name: 'conversation',
              path: 'conversation',
              asyncParams: {
                'chatUser': getDoc(['users'], UsersRecord.fromSnapshot),
              },
              builder: (context, params) => ConversationWidget(
                chatRef: params.getParam(
                    'chatRef', ParamType.DocumentReference, false, ['chats']),
                chatUser: params.getParam('chatUser', ParamType.Document),
              ),
            ),
            FFRoute(
              name: 'Reservation',
              path: 'reservation',
              asyncParams: {
                'voyage': getDoc(['voyage'], VoyageRecord.fromSnapshot),
              },
              builder: (context, params) => ReservationWidget(
                voyage: params.getParam('voyage', ParamType.Document),
                reservationID: params.getParam(
                    'reservationID',
                    ParamType.DocumentReference,
                    false,
                    ['voyage', 'reservation']),
                isDriver: params.getParam('isDriver', ParamType.bool),
                prix: params.getParam('prix', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'Annulation',
              path: 'annulation',
              builder: (context, params) => AnnulationWidget(
                voyageID: params.getParam(
                    'voyageID', ParamType.DocumentReference, false, ['voyage']),
              ),
            ),
            FFRoute(
              name: 'ReservationOK',
              path: 'reservationOK',
              asyncParams: {
                'voyage': getDoc(['voyage'], VoyageRecord.fromSnapshot),
              },
              builder: (context, params) => ReservationOKWidget(
                voyage: params.getParam('voyage', ParamType.Document),
              ),
            ),
            FFRoute(
              name: 'Avis',
              path: 'avis',
              builder: (context, params) => AvisWidget(),
            ),
            FFRoute(
              name: 'Historique',
              path: 'historique',
              builder: (context, params) => HistoriqueWidget(),
            ),
            FFRoute(
              name: 'ajouterAvis',
              path: 'ajouterAvis',
              builder: (context, params) => AjouterAvisWidget(
                destinataire: params.getParam('destinataire',
                    ParamType.DocumentReference, false, ['users']),
              ),
            ),
            FFRoute(
              name: 'Verification_profil',
              path: 'verificationProfil',
              builder: (context, params) => VerificationProfilWidget(),
            ),
            FFRoute(
              name: 'profil_verifie',
              path: 'profilVerifie',
              builder: (context, params) => ProfilVerifieWidget(),
            ),
            FFRoute(
              name: 'paiement',
              path: 'paiement',
              asyncParams: {
                'voyage': getDoc(['voyage'], VoyageRecord.fromSnapshot),
              },
              builder: (context, params) => PaiementWidget(
                prix: params.getParam('prix', ParamType.int),
                voyage: params.getParam('voyage', ParamType.Document),
              ),
            ),
            FFRoute(
              name: 'codeOTP',
              path: 'codeOTP',
              asyncParams: {
                'voyage': getDoc(['voyage'], VoyageRecord.fromSnapshot),
              },
              builder: (context, params) => CodeOTPWidget(
                voyage: params.getParam('voyage', ParamType.Document),
                mcpRef: params.getParam('mcpRef', ParamType.String),
                myTransactionRef: params.getParam('myTransactionRef',
                    ParamType.DocumentReference, false, ['transactions']),
              ),
            ),
            FFRoute(
              name: 'Transactions',
              path: 'transactions',
              builder: (context, params) => TransactionsWidget(),
            ),
            FFRoute(
              name: 'Support',
              path: 'support',
              builder: (context, params) => SupportWidget(),
            ),
            FFRoute(
              name: 'AuthentificationCopy',
              path: 'authentificationCopy',
              builder: (context, params) => AuthentificationCopyWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      urlPathStrategy: UrlPathStrategy.path,
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (GoRouter.of(this).routerDelegate.matches.length <= 1) {
      go('/');
    } else {
      pop();
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState =>
      (routerDelegate.refreshListenable as AppStateNotifier);
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      (routerDelegate.refreshListenable as AppStateNotifier)
          .updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(params)
    ..addAll(queryParams)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList,
        collectionNamePath: collectionNamePath);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/authentificationCopy';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/travelo.jpg',
                    fit: BoxFit.contain,
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}
