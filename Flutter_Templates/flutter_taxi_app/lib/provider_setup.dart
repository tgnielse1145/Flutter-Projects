import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentServices = [
  //Provider.value(value: Api())
];

List<SingleChildCloneableWidget> dependentServices = [


];

List<SingleChildCloneableWidget> uiConsumableProviders = [

];


