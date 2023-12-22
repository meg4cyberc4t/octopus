import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:octopus/octopus.dart';

/// {@template octopus_navigator}
/// Octopus navigator widget.
/// {@endtemplate}
class OctopusNavigator extends Navigator {
  /// {@macro octopus_navigator}
  @internal
  const OctopusNavigator({
    required Octopus router,
    super.pages = const <Page<Object?>>[],
    super.onPopPage,
    super.onUnknownRoute,
    super.transitionDelegate = const DefaultTransitionDelegate<Object?>(),
    super.reportsRouteUpdateToEngine = false,
    super.clipBehavior = Clip.hardEdge,
    super.observers = const <NavigatorObserver>[],
    super.requestFocus = true,
    super.restorationScopeId,
    super.routeTraversalEdgeBehavior = kDefaultRouteTraversalEdgeBehavior,
    super.key,
  }) : _router = router;

  /// Receives the [Octopus] instance from the elements tree.
  static Octopus? maybeOf(BuildContext context) {
    Octopus? controller;
    context.visitAncestorElements((element) {
      if (element is _OctopusNavigatorContext) {
        controller = element.router;
        if (controller != null) return false;
      }
      return true;
    });
    return controller;
  }

  static Never _notFound() => throw ArgumentError(
        'Out of scope, not found a OctopusNavigator widget',
        'out_of_scope',
      );

  /// Receives the [Octopus] instance from the elements tree.
  static Octopus of(BuildContext context) => maybeOf(context) ?? _notFound();

  /// {@nodoc}
  final Octopus _router;

  @override
  NavigatorState createState() => _OctopusNavigatorState();

  @override
  StatefulElement createElement() => _OctopusNavigatorContext(this);
}

class _OctopusNavigatorState extends NavigatorState {}

class _OctopusNavigatorContext extends StatefulElement {
  _OctopusNavigatorContext(OctopusNavigator super.widget)
      : router = widget._router;

  @override
  OctopusNavigator get widget => super.widget as OctopusNavigator;

  Octopus? router;

  @override
  void mount(Element? parent, Object? newSlot) {
    // Mount the navigator.
    super.mount(parent, newSlot);
    router = widget._router;
  }

  @override
  void update(covariant OctopusNavigator newWidget) {
    // Unmount the navigator.
    super.update(newWidget);
    router = newWidget._router;
  }
}
