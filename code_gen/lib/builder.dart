import 'package:code_gen/sci_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

Builder routeParseBuilder(BuilderOptions options) => LibraryBuilder(RouteParseGenerator(),
    generatedExtension: '.route.dart');
Builder redirectedBuilder(BuilderOptions options) => LibraryBuilder(SciRedirectedRouteGenerator(),
    generatedExtension: '.redirected.dart');
Builder functionBuilder(BuilderOptions options) => LibraryBuilder(SciFunctionGenerator(),
    generatedExtension: '.function.dart');
Builder sciBuilder(BuilderOptions options) => LibraryBuilder(SciRouteGenerator(),
    generatedExtension: '.g.dart');

