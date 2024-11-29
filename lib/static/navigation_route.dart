enum NavigationRoute {
  spalashRoute("/splash"),
  mainRoute("/main"),
  detailRoute("/detail");

  const NavigationRoute(this.name);
  final String name;
}
