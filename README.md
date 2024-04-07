# SDG Test Task Project

A Test Task project for SDG

## Getting started

In order to launch project with **flutter run** command, three "--dart-define" arguments has to be 
added. One with value "API_KEY=\*api_key\*", another one with value "API_HOST=\*api_host\* and the 
the last one with value "USER_AGENT=\*user_agent\*". 
So the command will look like this:

```shell
flutter run --dart-define=API_KEY=\*your_api_key\* --dart-define=API_HOST=\*your_api_host\* --dart-define=USER_AGENT=\*your_user_agent\*
```

You can also add these arguments using Android Studio's **Edit Configuration** menu and also
VSCode's GUI for configuring **launch.json** (or you can directly modify launch.json file).

P.S. API host must be without scheme and path segments. So, for example, if full base URL looks like
"https://one.two.three/four/v3" then API_HOST must be equal to "one.two.three".

## Project architecture

For this project it has been decided to use feature-first architecture. This type of project 
structure is more fit for bigger projects with multiple modules (this project is not such case since
it has only 1 feature). I am fully aware that for the project of this scale all of it might seem 
overcomplicated but it the architecture was picked because this structure will more likely be used 
in projects at SDG.

The application consists of 4 layers:
- Domain
- Data
- Presentation
- Application

Project also contains tests for some of the functionalities of the application.

### Domain layer

Domain layer is a pure business logic layer that does not depend on any other layer. In current 
project the layer includes:

- Business models
- Use cases (where the main business logic should reside. This project, just like a lot of other 
"thin frontend" projects, contains little or even none of it)
- Repository interfaces (interfaces used to connect domain and data layers while reversing 
dependency direction towards domain layer)

Libraries:
Domain layer is designed to contain as little library dependencies as possible so in this project
the only library used in domain layer is [equatable] which is used for convenient overriding of 
**hashCode** getter, **==** operator and **toString** method.

### Data layer

Data layer is responsible for fetching data from remote sources, parsing, caching, mapping DTO's to
domain models. Usually the layer consist of:

- Repository implementations
- Data sources (remote and local)
- Data transfer objects (not present in this project due to simplicity of the data)
- Data mappers, parsers

Libraries:
- Parsing: Current project does not utilize [json_serializable] library since pattern-matching is a 
simpler way to parse small chunks of data.
- Remote data fetching: [dio]
- Local caching: no libraries since local cache is a RAM cache.

### Presentation layer

Presentation layer contains code responsible for displaying data on screen and handling user input.
Layer contains:

- Presentation models
- BLOC's (in the project BLOC is used for view state management only)
- Layout configuration logic (widgets)
- Might also contain custom elements and render objects (not present in the project)

Libraries:
- State management: [flutter_bloc]
- Data class fields/methods generation: [freezed]

Custom components and utils:
- [UiCommands](./lib/src/core/bloc/ui_commands.dart) - a helper mixin that adds a stream that used for
one-time events (such as showing snacks, modal sheets, routing etc.) emitted from bloc. Why? 
Before using UiCommands usually a field/fields were created and each time this field is triggered
developer had to always keep that in mind and return it back to default (either almost instantly or 
in the next event). Otherwise the listener could be triggered two or more times which often is a 
cause of bugs. Additionally, when people do not utilize **buildWhen** property of **BlocBuilder** 
it causes unnecessary rebuilds. The solution might not be perfect or sometimes even justified but 
in [location_pick_bloc](./lib/src/features/location_pick/presentation/bloc/location_pick/location_pick_bloc.dart)
you can see the example of it.
- [build_when_utils](./lib/src/core/bloc/build_when_utils.dart) - a helper methods for creating more
concise and readable **buildWhen** callbacks for **BlocBuilder**.

### Application layer

Application layer is a layer **outside** of features. It is basically a **glue** for the 
rest of the project hence it has access to all of the other features. It provides real 
implementations of classes required by features and injects aforementioned implementations, hiding 
them from the rest of the application.

- Application start-up logic
- Dependency injection implementation
- Routing implementation (not present in the project)

Libraries:
- Dependency injection: [get_it]. Currently all DI is initialized in [main](./lib/main.dart) by using
[AppDi wrapper](./lib/src/app_di.dart).
GetIt is a basic service locator but it can be used as a proper DI with scopes and containers.
- Navigation: no libraries used since app contains only one screen.

### Tests  

Currently there are 2 types of tests:
- [Unit tests](./test/unit_tests)
- [Golden tests](./test/golden_tests)

Libraries:
- Mocking: [mocktail]
- Test API: [flutter_test]

#### Unit tests

Unit tests are used for testing specific method or class. Bloc tests are a specific type of a unit
test that focuses on testing the functionality of BLOC using additional tools which help with
minimizing some boilerplate code.

Libraries:
- Bloc tests: [bloc_test]

[The example of a unit test](./test/unit_tests/location_pick/location_pick_bloc_impl_test.dart)

### Golden tests

Golden tests are used for testing UI layer and paint logic. With [golden_toolkit] it is possible to
create a **snapshot** of a widget in a particular state and then compare it every test with existing
snapshot in order to check if something has changed.

Libraries:
- API for golden testing: [golden_toolkit]

[The example of a golden test](./test/golden_tests/location_pick/location_pick_screen_test.dart)


