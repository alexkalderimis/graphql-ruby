# Changelog

### Breaking changes

### Deprecations

### New features

### Bug fixes

# 1.12.19 (5 November 2021)

### New Features

- Argument validation: Make `allow_null` and `allow_blank` work standalone #3671
- Add field and path info to Encoding errors #3697
- Add `Resolver#unauthorized_object` for handling loaded but unauthorized objects #3689

### Bug fixes

- Properly hook up `Schema.validate_max_errors` at runtime #3691

# 1.12.18 (2 November 2021)

### New features

- Subscriptions: Add `NO_UPDATE` constant for skipping subscription updates #3664
- Validation: Add `Schema.max_validation_errors(integer)` for halting validation when it reaches a certain number #3683
- Call `self.load_...` methods on Input objects for loading arguments #3682
- Use `import_methods` in Refinements when available #3674
- `AppsignalTracing`: Add `set_action_name` #3659

### Bug fixes

- Authorize objects returned from custom `def load_...` methods #3682
- Fix `context[:current_field]` when argument `prepare:` hooks raise an error #3666
- Raise a helpful error when a Resolver doesn't have a configured `type(...)` #3679
- Better error message when subscription clients are using ActionCable #3668
- Dataloader: Fix dataloading of input object arguments #3666
- Subscriptions: Fix parsing time zones #3667
- Subscriptions: Fix parsing with non-null arguments #3620
- Authorization: Call `schema.unauthorized_field` for unauthorized resolvers
- Fix when literal `null` is used as a value for a list argument #3660

# 1.12.17 (15 October 2021)

### New features

- Support `extras: [:parent]` #3645
- Support ranges in `NumericalityValidator` #3635
- Add some Dataloader methods for testing #3335

### Bug fixes

- Support input object arguments called `context` #3654
- Support single-item default values for list arguments #3652
- Ensure query strings are strings before running a query #3628
- Fix empty hash kwargs for Ruby 3 #3610
- Fix wrongly detecting Ipnut objects in authorization #3606

# 1.12.16 (31 August 2021)

### New features

- Connections: automatically support Mongoid 7.3 #3599
- Support `def self.topic_for` in Subscription classes for server-filtered streams #3597
- When a list item or object field has an invalid null, stop executing that list or

### Bug fixes

- Perf: don't refine String when unnecessary #3593
- BigInt: always parse as base 10 #3586
- Errors: only return one error when a node in a non-null connection has an invalid null #3601

# 1.12.15 (23 August 2021)

### New Features

- Subscriptions: add support for multi-tenant setups when deserializing context #3574
- Analyzers: also track deprecated arguments #3549

# 1.12.14 (22 July 2021)

### Bug fixes

- SDL: support directive arguments referencing overridden built-in scalars #3564
- Use `"_"` as the name for `field :_, ...` fields #3560
- Support `sanitized_printer(...)` in the schema definition for `Query#sanitized_query_string`
- `GraphQL::Backtrace`: fix multiplex support

# 1.12.13 (20 June 2021)

### Breaking changes

- Add a trailing newline to the `Schema.to_definition` output string #3541

### Bug fixes

- Properly handled list results in GraphQL::Backtrace #3540
- Return plain `Hash`es and `Array`s from queries instead of customized subclasses #3533
- Fix errors raised from non-null fields #3537
- Resolver: don't pass frozen array of extensions when none were configured #3515
- Configure the right `owner` for `node` and `nodes` fields #3509
- Improve error message for invalid enum value #3507
- Properly halt on lazily-returned `context.skip`s #3514
- Fix: call overridden `to_h` methods on InputObject classes #3539
- Halt execution when a runtime directive argument raises a `GraphQL::ExecutionError` #3542

# 1.12.12 (31 May 2021)

### Bug fixes

- Directives on inline fragments and fragment spreads receive `.resolve(...)` calls #3499

# 1.12.11 (28 May 2021)

### Bug fixes

- Validate argument default values when adding them to the schema #3496
- Resolvers inherit extensions from superclasses #3500
- Greatly reduce runtime overhead #3494, #3505
- Remove hidden directives from introspection #3488

# 1.12.10 (18 May 2021)

### New features

- Use `GlobalID::Locator.locate_many` for arrays of global Ids #3481
- Support runtime directives (call `.resolve`) on `QUERY` #3474

### Bug fixes

- Don't override Resolver `#load_*` methods when they're inherited #3486
- Fix validation of runtime directive arguments that have input objects #3485
- Add a final newline to rake task output
- Don't add connection arguments to fields loaded from introspection responses #3470
- Fix `rescue_from` on loading arguments #3471

# 1.12.9 (7 May 2021)

### New features

- Overriding `.authorized_new(...)` to call `.new(...)` effectively skips object authorization #3446
- Dataloader copies Fiber-local values from `Thread.current[...]` when initializing new Fibers #3461

### Bug fixes

- Fix introspection of default value input objects #3456
- Add `StandardError => ...` condition to the generated GraphqlController #3460
- Fix `Dataloader::Source` on Ruby 3 with keyword arguments
- Respect directive visibility at runtime #3450
- ActionCable subscriptions: only deserialize the broadcast payload once #3443
- Don't re-add `graphiql-rails` when `generate graphql:install` is run twice #3441
- Allow differing selections on mutually exclusive interfaces #3063
- Respect `max_page_size: nil` override in fields #3438

# 1.12.8 (12 Apr 2021)

### Bug fixes

- Fix loading single-key hashes in Subscriptions #3428
- Fix looking up `rescue_from` handlers inherited from parent schema classes #3431

# 1.12.7 (7 Apr 2021)

### Breaking changes

- `Execution::Errors` (which implements `rescue_from`) was refactored so that, when an error matches more than one registered handler, it picks the _most specific_ handler instead of the _first match_ in the underlying Hash. This might "break" your code if your application registered a handler for a parent class and a child class, but expects instances of the child class to be handled by the handler for the parent class. (This seems very unlikely -- I consider the change to be a "breaking fix.") #3404

### New features

- Errors: pick the most specific error handlers (instead of an order-dependent selection) #3404
- Add `node_nullable(...)` connection configuration options #3389
- Add `has_nodes_field(true|false)` connection configuration option #3388
- Store more metadata in argument-related static validation errors #3406

### Bug fixes

- Fix connection nullability settings to properly handle `false` #3386
- Fix returning `RawValue`s as part of a list #3403
- Fix introspection for deprecated directive arguments #3416
- Optimize `has_next_page` for ActiveRecord::Relation connections #3414
- Tracing: consistent event sequencing when queries are executed with `Query#result` #3408

# 1.12.6 (11 March 2021)

### Breaking changes

- Static validation: previously, variables passed as arguments to input objects were not properly type-checked. #3370 fixed type checking in this case, but may case existing (invalid) queries to break.

### New features

- Connection types: support `edges_nullable(false)` and `edge_nullable(false)` for non-null fields #3376
- Connections: add `.arguments` reader to new `Pagination::Connection` classes #3360

### Bug fixes

- Relation connection: Remove extra `COUNT` query from some scenarios #3373
- Add a Bootsnap-style parsing cache when Bootsnap is detected #3156
- Fix input validation for input object variables #3370

# 1.12.5 (18 February 2021)

### New features

- Resolvers: support `max_page_size` config #3338
- RangeAdd: call `range_add_edge` (if supported) to improve stable connection support #3341

### Bug fixes

- Backtrace: fix new tracer when analyzing multiplex without executing it #3342
- Dataloader: pass along `throw`s #3333
- Skip possible_types filtering for non-interface types #3336
- Improve debugging message for ListResultFailedError #3339

# 1.12.4 (8 February 2021)

### Bug fixes

- Allow prepended modules to add fields #3325
- Fix ConnectionExtension when another extension short-circuits `resolve` #3326
- Backtrace: Fix GraphQL::Backtrace with static validation (used by graphql-client) #3324
- Dataloader: Fix yield from root fiber when accessing arguments from analyzers. Fix arguments sometimes containing unresolved `Execution::Lazy`s #3320
- Dataloader: properly pass raised errors to `handle_error` handlers #3319
- Fix NameError in validation error #3303
- Dataloader: properly batch when parent fields were not batched #3312

# 1.12.3 (27 January 2021)

### Bug fixes

- Fix constant names for legacy scalar types

# 1.12.2 (26 January 2021)

### New features

- `GraphQL::Deprecation.warn` is used for GraphQL-Ruby 2.0 deprecation warnings (and calls through to `ActiveSupport::Deprecation.warn` if it's available) #3292

# 1.12.1 (25 January 2021)

### Bug fixes

- `GraphQL::Dataloader`: properly support selections with multiple fields #3297

# 1.12.0 (20 January 2021)

### Breaking changes

- `GraphQL::Schema` defaults to `GraphQL::Execution::Interpreter`, `GraphQL::Analysis::AST`, `GraphQL::Pagination::Connections`, and `GraphQL::Execution::Errors`. (#3145) To get the previous (deprecated) behaviors:

  ```ruby
  # Revert to deprecated execution behaviors:
  use GraphQL::Execution::Execute
  use GraphQL::Analysis
  # Disable the new connection implementation:
  self.connections = nil
  ```

- `GraphQL::Execution::Interpreter::Arguments` instances are frozen (#3138). (Usually, GraphQL code doesn't interact with these objects, but they're used some places under the hood.)

### Deprecations

- Many, many legacy classes and methods were deprecated. #3275 Deprecation errors include links to migration documentation. For a full list, see: https://github.com/rmosolgo/graphql-ruby/issues/3056

### New features

- Rails-like argument validations (#3207)
- Fiber-based `GraphQL::Dataloader` for batch-loading data #3264
- Connection and edge behaviors are available as mixins #3071
- Schema definition supports schema directives #3224

### Bug fixes

# 1.11.7 (18 January 2021)

### Breaking changes

- Incoming integer values are properly bound (as per the spec) #3206 To continue receiving out-of-bound integer values, add this to your schema's `def self.type_error(err, ctx)` hook:

  ```ruby
  def self.type_error(err, ctx)
    if err.is_a?(GraphQL::IntegerDecodingError)
      return err.integer_value # return it anyways, since this is how graphql-ruby used to work
    end
    # ...
  end
  ```

### New features

- Support Ruby 3.0 #3278
- Add validation timeout option #3234
- Support Prometheus custom_labels in GraphQLCollector #3215

### Bug fixes

- Handle `GraphQL::UnauthorizedError` in interpreter in from arguments #3276
- Set description for auto-generated `input:` argument #3141
- Improve performance of fields will merge validation #3228
- Use `Float` graphql type for ActiveRecord decimal columns #3246
- Add some custom methods to ArrayConnection #3238
- Fix generated fields for types ending Connection #3223
- Improve runtime performance #3217
- Improve argument handling when extensions shortcut the defined resolve #3212
- Bind scalar ints as per the spec #3206
- Validate that input object names are unique #3205

## 1.11.6 (29 October 2020)

### Breaking changes

FieldExtension: pass extended values instead of originals to `after_resolve` #3168

### Deprecations

### New features

- Accept additional options in `global_id_field` macro #3196

### Bug fixes

- Use `graphql_name` in `UnauthorizedError` default message (fixes #3174) #3176
- Improve error handling for base 64 decoding (in `UniqueWithinType`) #3179
- Fix `.valid_isolated_input?` on parsed schemas (fixes #3181) #3182
- Fix fields nullability in subscriptions documentation #3194
- Update `RangeAdd` to use new connections when available #3195

## 1.11.5 (30 September 2020)

### New features

- SanitizedPrinter: accept `inline_variables: false` option and add `#redact_argument_value?` and `#redacted_argument_value` hooks #3167
- GraphQL::Schema::Timeoout#max_seconds(query) can provide a per-query timeout duration #3167
- Implement Interpreter::Arguments#fetch
- Assign `current_{path,field,arguments,object}` in `query.context` #3139. The values at these keys change while the query is running.
- ActionCableSubscriptions: accept `use(..., namespace: "...")` for running multiple schemas in the same application #3076
- Add `deprecation_reason:` to arguments #3015

### Bug fixes

- SanitizedPrinter: Fix lists and JSON scalars #3171
- Improve retained memory in Schema.from_definition #3153
- Make it easier to cache schema parsing #3153
- Make sure deprecated arguments aren't required #3137
- Use `.empty?` instead of `.length.zero?` in lexer #3134
- Return a proper error when a stack error happens #3129
- Assert valid input types on arguments #3120
- Improve Validator#validate performance #3125
- Don't wrap `RawValue` in ConnectionExtension #3122
- Fix interface possible types visibility #3124

## 1.11.4 (24 August 2020)

### Breaking changes

### New features

- Add `node_nullable` option for `edge_type` #3083
- Use module namespacing for template generators #3098

### Bug fixes

- Rescue `SystemStackError`s during validation #3107
- Add `require 'digest/sha2'` for fingerprint #3103
- Optimize `GraphQL::Query::Context#dig` #3090
- Check if new connections before calling method on it (fixes #3059) #3100
- Thread field owner type through interpreter runtime (fixes #3086) #3099
- Check for visible interfaces on the type in warden #3096
- Update `AppOpticsTracing` with latest changes in `PlatformTracing` #3097
- Use throw instead of raise to halt subscriptions early #3084
- Optimize `GraphQL::Query::Context#fetch` #3081

## 1.11.3 (13 August 2020)

### Breaking changes

- Reverted the `required` and `default_value` argument behaviour change in 1.11.2 since it was not spec compliant #3066

### New features

- Improve resolver method conflict warning #3069, #3062
- Store arguments on `Mutation` instances after they're loaded #3073

### Bug fixes

- Fix connection wrappers on lazy lists #3070

## 1.11.2 (1 August 2020)

### Breaking changes

- Previously, GraphQL-Ruby allowed _both_ `default_value: ...` and `required: true` in argument definitions. However, this definition doesn't make sense -- a default value is never used for a `required: true` argument. This configuration now raises an error. Remove the `default_value:` to get rid of the error. #3011

### New features

- Support Date, Time and OpenStruct in Subscription::Serialize #3057

### Bug fixes

- Speed up `DELETE_NODE` check #3053
- Reject invalid enum values during definition #3055
- Fix `.trigger` from unsubscribed ActionCable channel #3051
- Fix error message from VariablesAreUsedAndDefined for anonymous queries #3050
- Fix renaming variable identifiers in AST visitor #3045
- Reject `default_value: ...` used with `required: true` during definition #3011
- Use the configured `edge_class:` with new connections #3036
- Don't call visible for unused arguments #3030, #3031
- Properly load directives from introspection results #3021
- Reject interfaces as members of unions #3024
- Load deprecation reason from introspection results #3014
- Fix arguments caching when extension modify arguments #3009

## 1.11.1 (17 June 2020)

### New Features

- Add `StatsdTracing` #2996

### Bug Fixes

- Raise the proper `InvalidNullError` when a mutation field returns an invalid `nil` #2997

## 1.11.0 (13 June 2020)

### Breaking changes

- Global tracers are removed (deprecated since 1.7.4) #2936
- Fields defined in camel case (`field :doStuff`) will not line up to methods that are underscore case (`def do_stuff`). Instead, the given symbol is used _verbatim_. #2938 To work around this:

  - Change the name of the method to match the field (eg, `def doStuff`)
  - Change the name of the field to match the method (eg, `field :do_stuff`, let graphql-ruby camelize it for you)
  - Or, add `resolver_method: :do_stuff` to explicitly map the field to a method on the object type definition

  You can probably find instances of this in your application with a regexp like `/field :[a-z]+[A-Z]/`, and review them.

### New features

- `extend SubscriptionRoot` is no longer necessary #2770
- Add `broadcast: true` option to subscriptions #2959
- Add `Edge#parent` to new connection classes #2961

### Bug fixes

- Use the field name as configured for hash key or method name #2906

## 1.10.12 (13 June 2020)

### Bug fixes

- Fix compatibility of `YYYY-mm-dd` with `Types::ISO8601DateTime` #2989
- Remove unused ivar in InputObject #2987

## 1.9.21 (12 June 2020)

### Bug fixes

- Fix `extras:` on subscription fields #2983

## 1.10.11 (11 June 2020)

### New features

- Scout tracer adds transaction name to traces #2969
- `resolve_type` can optionally return a resolved object #2976
- DateTime scalar returns a `Time` for better timezone handling #2973
- Interpreter memory improvements #2980, #2978
- Support lazy values from field-level authorization hooks #2977
- Object generator infers fields from model classes #2954
- Add type-specific runtime errors #2957

### Bug fixes

- Fix for error when using `extras:` with subscription fields #2984
- Improve Schema.error_handler inheritance #2975
- Add raw_value to conflict warning list #2958
- Arguments#each_value yields ArgumentValues #2956

## 1.10.10 (20 May 2020)

### Bug Fixes

- Fix lazy `loads:` with list arguments #2949
- Show object fields even when inherited ones are hidden #2950
- Use `reverse_each` in instrumenters #2945
- Fix underscored names in introspection loader #2941
- Fix array input to Date/DateTime types #2927
- Fix method conflict warnings on schema loader #2934
- Fix some Ruby 2.7 warnings #2925

## 1.9.20 (20 May 2020)

### Bug fixes

- Fix `default_value: {}` on Ruby 2.7

## 1.10.9 (4 May 2020)

### New features

- Add `Interpreter::Arguments#dig` #2912

## 1.10.8 (27 April 2020)

### Breaking changes

- With the interpreter, `Query#arguments_for` returns `Interpreter::Arguments` instances instead of plain hashes. (They should work mostly the same, though.) #2881

### New features

- `Schema::Field#introspection?` returns true for built-in introspection-related fields

### Bug fixes

- Fix Ruby 2.7 warning on `Schema.to_json` #2905
- Pass `&block` to nested method calls to reduce stack depths #2900
- Fix lazy `loads:` with list arguments #2894
- Fix `loads:` on nested input object #2895
- Rescue base64 encoding errors in the encoder #2896

## 1.10.7 (16 April 2020)

### Breaking changes

- `Schema.from_introspection(...)` builds class-based schemas #2876

### New features

- `Date` and `DateTime` types also accept well-formatted strings #2848
- `Schema.from_introspection(...)` builds class-based schemas #2876
- `Schema#to_definition` now dumps all directives that were part of the original IDL, if the schema was parsed with `.from_definition` #2879

### Bug fixes

- Fix memory leak in legacy runtime #2884
- Fix interface inheritance in legacy runtime #2882
- Fix description on `List` and `NonNull` types (for introspection) #2875
- Fix over-rescue of NoMethodError when building list responses #2887

## 1.10.6 (6 April 2020)

### New features

- Add options to `implements(...)` and inteface type visibility #2791
- Add `Query#fingerprint` for logging #2859
- Add `--playground` option to install generator #2839
- Support lazy-loaded objects from input object `loads:` #2834

### Bug fixes

- Fix `Language::Nodes` equality: move `eql?` to `==` #2861
- Make rake task properly detect rails `environment` task #2862
- Fix `nil` override for `max_page_size` #2843
- Fix `pageInfo` methods when they're called before `nodes` #2845
- Make the default development error match a normal GraphQL error #2825
- Fix `loads:` with `require: false` #2833
- Fix typeerror for `BigInt` given `nil` #2827

## 1.10.5 (12 March 2020)

### New features

- Add `#field_complexity` hook to `AST::QueryComplexity` analyzer #2807

### Bug fixes

- Pass `nonce: true` when encoding cursors #2821
- Ignore empty-string cursors #2821
- Properly pass along `Analysis::AST` to schema instances #2820
- Support filtering unreachable types in schemas from IDL #2816
- Use `Query#arguments_for` for lookahead arguments #2811
- Fix pagination bug on old connections #2799
- Support new connection system on old runtime #2798
- Add details to raise CoercionErrors #2796

## 1.10.4 (3 March 2020)

### Breaking changes

- When an argument is defined with a symbol (`argument :my_arg, ...`), that symbol is used _verbatim_ to build Ruby keyword arguments. Previously it was converted to underscore-case, but this autotransform was confusing and wrong in some cases. You may have to change the symbol in your `argument(...)` configuration if you were depending on that underscorization. #2792
- Schemas from `.from_definition` previously had half-way connection support. It's now completely removed, so you have to add connection wrappers manually. See #2782 for migration notes.

### New features

- Add `Appoptics` tracing #2789
- Add `Query#sanitized_query_string` #2785
- Improved duplicate type error message #2777

### Bug fixes

- Fix arguments ending in numbers, so they're injected with the same name that they're configured with #2792
- Improve `Query#arguments_for` with interpreter #2781
- Fix visitor replacement of variable definitions #2752
- Remove half-broken connection handling from `Schema.from_definition` #2782

## 1.10.3 (17 Feb 2020)

### New features

- Support `loads:` with plain field arguments #2720
- Support `raw_value(...)` to halt execution with a certain value #2699
- `.read_subscription` can return `nil` to bypass executing a subscription #2741

### Bug fixes

- Connection wrappers are properly inherited #2750
- `prepare(...)` is properly applied to default values in subscription fields #2748
- Code tidying for RSpec warnings #2741
- Include new analysis module when generating a schema #2734
- Include directive argument types in printed schemas #2733
- Use `module_parent_name` in Rails #2713
- Fix overriding default scalars in build_from_definition #2722
- Fix some non-null errors in lists #2651

## 1.10.2 (31 Jan 2020)

### Bug fixes

- Properly wrap nested input objects in instances #2710

## 1.10.1 (28 Jan 2020)

### Bug fixes

- Include Interface-level `orphan_types` when building a schema #2705
- Properly re-enter selections in complexity analyzer #2595
- Fix input objects with null values #2690
- Fix default values of `{}` in `.define`-based schemas #2703
- Fix field extension presence check #2689
- Make new relation connections more efficient #2697
- Don't include fields `@skip(if: true)` or `@include(if: false)` in lookahead #2700

## 1.9.19 (28 Jan 2020)

### Bug Fixes

- Fix argument default value of `{}` with Ruby 2.7 argument handling #2704

## 1.10.0 (20 Jan 2020)

### Breaking Changes

- Class-based schemas using the new interpreter will now use _definition classes_ at runtime. #2363 (Previously, `.to_graphql` methods were used to generate singletons which were used at runtime.) This means:
  - Methods that used to receive types at runtime will now receive classes instead of those singletons.
  - `.name` will now call `Class#name`, which will give the class name. Use `.graphql_name` to get the name of a GraphQL type. (Fields, arguments and directives have `.graphql_name` too, so you can use it everywhere.)
  - Some methods that return hashes are slow because they merge hashes according to class inheritance, for example `MySchema.types` and `MyObjectType.fields`. Instead:
    - If you only need one item out of the Hash, use `.get_type(type_name)` or `.get_field(field_name)` instead. Those methods find a match without performing Hash merges.
    - If you need the whole Hash, get a cached value from `context.warden` (an instance of `GraphQL::Schema::Warden`) at runtime. Those values reflect the types and fields which are permitted for the current query, and they're cached for life of the query. Check the API docs to see methods on the `warden`.
- Class-based schemas using the interpreter _must_ add `use GraphQL::Analysis::AST` to their schema (and update their custom analyzers, see https://graphql-ruby.org/queries/ast_analysis.html) #2363
- ActiveSupport::Notifications events are correctly named in event.library format #2562
- Field and Argument `#authorized?` methods now accept _three_ arguments (instead of 2). They now accept `(obj, args, ctx)`, where `args` is the arguments (for a field) or the argument value (for an argument). #2520
- Double-null `!!` is disallowed by the parser #2397
- (Non-interpreter only) The return value of subscription fields is passed along to execute the subscription. Return `nil` to get the previous behavior. #2536
- `Schema.from_definition` builds a _class-based schema_ from the definition string #2178
- Only integers are accepted for `Int` type #2404
- Custom scalars now call `.coerce_input` on all input values - previously this call was skipped for `null` values.

### Deprecations

- `.define` is deprecated; class-based schema definitions should be used instead. If you're having trouble or you can't find information about an upgrade path, please open an issue on GitHub!

### New Features

- Add tracing events for `.authorized?` and `.resolve_type` calls #2660
- `Schema.from_definition` accepts `using:` for installing plugins (equivalent to `use ...` in class-based schemas) #2307
- Add `$` to variable names in error messages #2531
- Add invalid value to argument error message #2531
- Input object arguments with `loads:` get the loaded object in their `authorized?` hook, as `arg` in `authorized?(obj, args, ctx)`. #2536
- `GraphQL::Pagination` auto-pagination system #2143
- `Schema.from_definition` builds a _class-based schema_ from the definition string #2178

### Bug Fixes

- Fix warnings on Ruby 2.7 #2668
- Fix Ruby keyword list to support Ruby 2.7 #2640
- Reduce memory of class-based schema #2636
- Improve runtime performance of interpreter #2630
- Big numbers (ie, greater than Ruby's `Infinity`) no longer :boom: when being reserialized #2320
- Fix `hasNextPage`/`hasPrevious` page when max_page_size limits the items returned #2608
- Return parse errors for empty documents and empty argument lists #2344
- Properly serialize `defaultValue` of input objects containing enum values #2439
- Don't crash when a query contains `!!`. #2397
- Resolver `loads:` assign the value to argument `@loads` #2364
- Only integers are accepted for `Int` type #2404

## 1.9.18 (15 Jan 2020)

### New features

- Support disabling `__type` or `__schema` individually #2657
- Support Ruby 2.7, and turn on CI for it :tada: #2665

### Bug fixes

- Fix Ruby 2.7 warnings #2653 #2669
- Properly build camelized names for directive classes #2666
- Use schema-defined context class for SDL generation #2656
- Apply visibility checks when generating SDL #2637

## 1.9.17 (17 Dec 2019)

### New features

- Scoped context for propagating values to child fields #2634
- Add `type_membership_class` with possible_type visibility #2391

### Bug fixes

- Don't return unreachable types in introspection response #2596
- Wrap more of execution with error handling #2632
- Fix InputObject `.prepare` for the interpreter #2624
- Fix Ruby keyword list to support Ruby 2.7 #2640
- Fix performance of urlsafe_encode64 backport #2643

## 1.9.16 (2 Dec 2019)

### Breaking changes

- `GraphQL::Schema::Resolver#initialize` accepts a new keyword argument, `field:`. If you have overriden this method, you'll have to add that keyword to your argument list (and pass it along to `super`.) #2605

### Deprecations

- `SkylightTracing` is disabled; the Skylight agent contains its own GraphQL support. See Skylight's docs for migration. #2601

### New features

### Bug fixes

- Fix multiplex max_depth calculation #2613
- Use monotonic time in TimeoutMiddleware #2622
- Use underscored names in Mutation generator #2617
- Fix lookahead when added to mutations in their `field(...)` definitions #2605
- Handle returned lists of errors from Mutations #2567
- Fix lexer error on block strings containing only newlines #2598
- Fix mutation generator to reference the new base class #2580
- Use the right camelization configuration when generating subscription topics #2552

## 1.9.15 (30 Oct 2019)

### New features

- Improve parser performance #2572
- Add `def prepare` API for input objects #1869
- Support `extensions` config in Resolver classes #2570
- Support custom `.connection_extension` in field classes #2561
- Warn when a field name is a Ruby keyword #2559
- Improve performance for ActiveRecord connection #2547

### Bug fixes

- Fix errantly generated `def resolve_field` method in `BaseField` #2578
- Comment out the `null_session` handling in the generated controller, for better compat with Rails API mode #2557
- Fix validation error with duplicate, self-referencing fragment #2577
- Revert the `.authorized?` behavior of InputObjects to handle cyclical references. See 1.10.0.pre1 for a better behavior. #2576
- Replace `NotImplementedError` (which is meant for operating system APIs) with `GraphQL::RequiredImplementationMissingError` #2543

## 1.9.14 (14 Oct 2019)

### New features

- Add `null_session` CSRF handing in `install` generator #2524
- Correctly report InputObjects without arguments and Objects without fields as invalid #2539 #2462

### Bug fixes

- Fix argument incompatibility #2541
- Add a `require` for `Types::ISO8691Date` #2528
- Fix errors re-raised after lazy fields #2525

## 1.9.13 (8 Oct 2019)

### Breaking changes

- Enum values were (erroneously) accepted as ID or String values, but they aren't anymore. #2505

### New features

- Add `Query#executed?` #2486
- Add `Types::ISO8601Date` #2471

### Bug fixes

- Don't accept Enums as IDs or Strings #2505
- Call `.authorized?` hooks on arguments that belong to input objects #2519
- Fix backslash parsing edge case #2510
- Improve performance #2504 #2498
- Properly stringify keys in error extensions #2508
- Fix `extras:` handling in RelayClassicMutation #2484
- Use `Types::BaseField` in scaffold #2470

## 1.9.12 (9 Sept 2019)

### Breaking Changes

- AST Analyzers follow fragments spreads as if they were inline fragments. #2463

### New Features

- `use GraphQL::Execution::Errors` provides error handling for the new interpreter. #2458

### Bug Fixes

- Fix false positive on enum value validation #2454

## 1.9.11 (29 Aug 2019)

### Breaking Changes

- Introspection fields are now considered for query depth validations, so you'll need at least `max_depth: 13` to run the introspection query #2437

### New features

- Add `extras` setter to `GraphQL::Schema::Field` #2450
- Add extensions in `CoercionError` #2431

### Bug fixes

- Make `extensions` kwarg on field on more flexible for extensions with options #2443
- Fix list validation error handling #2441
- Include introspective fields in query depth calculations #2437
- Correct the example for using 'a class method to generate fields' #2435
- Enable multiple execution errors for Fields defined to return a list #2433

## 1.9.10 (20 Aug 2019)

### New features

- Support required arguments with default values #2416

### Bug fixes

- Properly disable `max_complexity` and `max_depth` when `nil` is passed #2409
- Fix printing class-based schemas #2406
- Improve field method naming conflict check #2420

## 1.9.9 (30 July 2019)

### New features

- Memoize generated strings in `.to_query_string` #2400
- Memoize generated strings in platform tracing #2401

### Bug fixes

- Support class-based subscription type in `.define`-based schema #2403

## 1.9.8 (24 July 2019)

### New features

- Schema classes pass their configuration to subclasses #2384
- Improve memory consumption of lexer and complexity validator #2389
- The `install` generator creates a BaseArgument #2379
- When a field name conflicts with a built-in method name, give a warning #2376

### Bug fixes

- When a resolver argument uses `loads:`, the argument definition will preserve the type in `.loads` #2365
- When an required argument is hidden, it won't add a validation error #2393
- Fix handling of invalid UTF-8 #2372, #2377
- Empty block strings are parsed correctly #2381
- For resolvers, only authorize arguments once #2378

## 1.9.7 (25 June 2019)

### Breaking changes

- `Analysis::AST::Visitor#argument_definition` no longer returns the _previous_ argument definition. Instead, it returns the _current_ argument definition and `#previous_argument_definition` returns the previous one. You might have to replace calls to `.argument_definition` with `.previous_argument_definition` for compatibility. #2226

### New features

- Accept a `subscription_scope` configuration in Subscription classes #2297
- Add a `disable_introspection_entry_points` configuration in Schema classes #2327
- Add `Analysis::AST::Visitor#argument_definition` which returns the _current_ argument definition, `#previous_argument_definition` returns the _previous_ one  #2226
- Run CI on Ruby 2.6 #2328
- Autogenerate base field class #2216
- Add timeout support with interpreter #2220

### Bug fixes

- Fix Stack overflow when calling `.to_json` on input objects #2343
- Fix off-by-one error with hasNextPage and ArrayConnections #2349
- Fix GraphQL-Pro operation store compatibility #2350
- Fix class-based transformer when multiple mutations are in one file #2309
- Use `default_graphql_name` for Edge classes #2224
- Support nested `loads:` with input objects #2323
- Support `max_complexity` with multiplex & AST analysis #2306

## 1.9.6 (23 May 2019)

### Bug fixes

- Backport `String#-@` for Ruby 2.2 support #2305

## 1.9.5 (22 May 2019)

### New features

- Support `rescue_from` returning `GraphQL::ExecutionError` #2140
- Accept `context:` in `Schema.validate` #2256
- Include `query:` in interpreter tracing for `execute_field` and `execute_field_lazy` #2236
- Add `Types::JSON` #2227
- Add `null:` option to `BaseEdge.node_type` #2249

### Bug fixes

- Fix Ruby 2.2 compatibility #2302
- Distinguish aliased selections in lookahead #2266
- Properly show list enum default values in introspection #2263
- Performance improvements: #2289, #2244, #2258, #2257, #2240
- Don't recursively unwrap inputs for RelayClassicMutation #2236
- Fix `Schema::Field#scoped?` when no return type #2255
- Properly forward more authorization errors  #2165
- Raise `ParseError` for `.parse(nil)` #2238

## 1.9.4 (5 Apr 2019)

### Breaking Changes

- `GraphQL::Schema::Resolver::LoadApplicationObjectFailedError` was renamed to `GraphQL::LoadApplicationObjectFailedError`. (This will only break if you're referencing the class by name and running Ruby 2.5+) #2080

### New features

- Add `Types::BigInt` #2150
- Add auto-loading arguments support in Input Object types #2080
- Add analytics tag to Datadog tracing #2154

### Bug fixes

- Fix `Query#execute` when no explicit query string is passed in #2142
- Fix when a root type returns nil because unauthorized #2144
- Fix tracing `node` by threading `owner:` through field tracing #2156
- Fix interpreter handling of exceptions raised during argument preparation #2198
- Fix ActionCableLink when there are errors but no data #2176
- Provide empty hash as default option for field resolvers #2189
- Prevent argument names from overwriting Arguments methods #2171
- Include array indices in error paths #2162
- Handle non-node arrays in AST visitor #2161

## 1.9.3 (20 Feb 2019)

### Bug fixes

- Fix `Schema::Subscription` when it has no arguments #2135
- Don't try to scope `nil`, just skip scoping altogether #2134
- Fix when a root `.authorized?` returns `false` and there's no `root_value` #2136
- Fix platform tracing with interpreter & introspection #2137
- Support root Subscription types with name other than `Subscription` #2102
- Fix nested list-type input object nullability validation #2123

## 1.9.2 (15 Feb 2019)

### Bug fixes

- Properly support connection fields with resolve procs #2115

## 1.9.1 (14 Feb 2019)

### Bug fixes

- Properly pass errors to Resolver `load_application_object_failed` methods #2110

## 1.9.0 (13 Feb 2019)

### Breaking Changes

- AST nodes are immutable. To modify a parsed GraphQL query, see `GraphQL::Language::Visitor` for its mutation API, which builds a new AST with the specified mutations applied. #1338, #1740
- Cursors use urlsafe Base64. This won't break your clients (it's backwards-compatible), but it might break your tests, so it's listed here. #1698
- Add `field(..., resolver_method:)` for when GraphQL-Ruby should call a method _other than_ the one whose name matches the field name (#1961). This means that if you're using `method:` to call a different method _on the Schema::Object subclass_, you should update that configuration to `resolver_method:`. (`method:` is still used to call a different method on the _underlying application object_.)
- `Int` type now applies boundaries as [described in the spec](https://facebook.github.io/graphql/June2018/#sec-Int) #2101. To preserve the previous, unbounded behavior, handle the error in your schema's `.type_error(err, ctx)` hook, for example:

  ```ruby
  class MySchema < GraphQL::Schema
    def self.type_error(err, ctx)
      if err.is_a?(GraphQL::IntegerEncodingError)
        # Preserve the previous unbounded behavior
        # by returning the out-of-bounds value
        err.integer_value
      else
        super
      end
    end
  end
  ```

- `field(...)` configurations don't create implicit method definitions (#1961). If one resolver method depended on the implicitly-created method from another field, you'll have to refactor that call or manually add a `def ...` for that field.
- Calling `super` in a field method doesn't work anymore (#1961)
- Error `"problems"` are now in `"extensions" : { "problems": ... }` #2077
- Change schema default to `error_bubbling false` #2069

### New Features

- Add class-based subscriptions with `GraphQL::Schema::Subscription` #1930
- Add `GraphQL::Execution::Interpreter` (#1394) and `GraphQL::Analysis::AST` (#1824) which together cut GraphQL overhead by half (time and memory)
- Add `Schema.unauthorized_field(err)` for when `Field#authorized?` checks fail (#1994)
- Add class-based custom directives for the interpreter (#2055)
- Add `Schema::FieldExtension` for customizing field execution with class-based fields #1795
- Add `Query#lookahead` for root-level selection info #1931
- Validation errors have `"extensions": { ... }` which includes metadata about that error #1970

### Bug fixes

- Fix list-type arguments passed with a single value #2085
- Support `false` as an Enum value #2050
- Support `hash_key:` fields when the key isn't a valid Ruby method name #2016

## 1.8.15 (13 Feb 2019)

### Bug fixes

- Fix unwrapping inputobject types when turning arguments to hashes #2094
- Support lazy objects from `.resolve_type` hooks #2108

## 1.8.14 (9 Feb 2019)

### Bug Fixes

- Fix single-item list inputs that aren't passed as lists #2095

## 1.8.13 (4 Jan 2019)

### Bug fixes

- Fix regression in block string parsing #2032

## 1.8.12 (3 Jan 2019)

### Breaking changes

- When an input object's argument has a validation error, that error is reported on the _argument_ instead of its parent input object. #2013

### New features

- Add `error_bubbling false` Schema configuration for nicer validation of compound inputs #2013
- Print descriptions as block strings in SDL #2011
- Improve string-to-constant resolution #1810
- Add `Query::Context#to_hash` for splatting #1955
- Add `#dig` to `Schema::InputObject` and `Query::Arguments` #1968
- Add `.*_execution_strategy` methods to class-based schemas #1914
- Accept multiple errors when adding `.rescue_from` handlers #1991

### Bug fixes

- Fix scalar tracing in NewRelic and Skylight #1954
- Fix lexer for multiple block strings #1937
- Add `unscope(:order)` when counting relations #1911
- Improve build-from-definition error message #1998
- Fix regression in legacy compat #2000

## 1.8.11 (16 Oct 2018)

### New features

- `extras: [:lookahead]` injects a `GraphQL::Execution::Lookahead`

### Bug fixes

- Fix type printing in Printer #1902
- Rescue `GraphQL::ExecutionError` in `.before_query` hooks #1898
- Properly load default values that are lists of input objects from the IDL #1874

## 1.8.10 (21 Sep 2018)

### Bug fixes

- When using `loads:` with a nullable mutation input field, allow `null` values to be provided. #1851
- When an invalid Base64 encoded cursor is provided, raise a `GraphQL::ExecutionError` instead of `ArgumentError`. #1855
- Fix an issue with `extras: [:path]` would use the field's `path` instead of the `context`. #1859

### New features

- Add scalar type generator `rails g graphql:scalar` #1847
- Add `#dig` method to `Query::Context` #1861

## 1.8.9 (13 Sep 2018)

### Breaking changes

- When `field ... ` is called with a block and the block has one argument, the field is yielded, but `self` inside the block is _not_ changed to the field. #1843

### New features

- `extras: [...]` can inject values from the field instance #1808
- Add `ISO8601DateTime.time_precision` for customization #1845
- Fix input objects with default values of enum #1827
- `Schema.sync_lazy(value)` hook for intercepting lazy-resolved objects #1784

### Bug fixes

- When a field block is provided with an arity of `1`, yield the field #1843

## 1.8.8 (27 Aug 2018)

### Bug fixes

- When using `RelayClassicMutation`, `client_mutation_id` will no longer be passed to `authorized?` method #1771
- Fix issue in schema upgrader script which would cause `.to_non_null_type` calls in type definition to be ignored #1783
- Ensure enum values respond to `graphql_name` #1792
- Fix infinite resolution bug that could occur when an exception not inheriting from `StandardError` is thrown #1804

### New features

- Add `#path` method to schema members #1766
- Add `as:` argument to allow overriding the name of the argument when using `loads:` #1773
- Add support for list of IDs when using `loads:` in an argument definition #1797

## 1.8.7 (9 Aug 2018)

### Breaking changes

- Some mutation authorization hooks added in 1.8.5 were changed, see #1736 and #1737. Roughly:

  - `before_prepare` was changed to `#ready?`
  - `validate_*` hooks were replaced with a single `#authorized?` method

### Bug fixes

- Argument default values include nested default values #1728
- Clean up duplciate method defs #1739

### New features

- Built-in support for Mongoid 5, 6, 7 #1754
- Mutation `#ready?` and `#authorized?` may halt flow and/or return data #1736, #1737
- Add `.scope_items(items, ctx)` hook for filtering lists
- Add `#default_graphql_name` for overriding default logic #1729
- Add `#add_argument` for building schemas #1732
- Cursors are decoded using `urlsafe_decode64` to future-proof for urlsafe cursors #1748

## 1.8.6 (31 July 2018)

### Breaking changes

- Only allow Objects to implement actual Interfaces #1715. Use `include` instead for plain Ruby modules.
- Revert extending interface methods onto Objects #1716. If you were taking advantage of this feature, you can create a plain Ruby module with the functionality and include it in both the interface and object.

### Deprecations

### New features

- Support string descriptions (from June 2018 GraphQL spec) #1725
- Add some accessors to Schema members #1722
- Yield argument for definition block with arity of one #1714
- Yield field for definition blocks with arity of one #1712
- Support grouping by "endpoint" with skylight instrumentation #1663
- Validation: Don't traverse irep if no handlers are registered #1696
- Add `nodes_field` option to `edge_type` to hide nodes field #1693
- Add `GraphQL::Types::ISO8601DateTime` to documentation #1694
- Conditional Analyzers #1690
- Improve error messages in `ActionCableSubscriptions` #1675
- Add Prometheus tracing #1672
- Add `map` to `InputObject` #1669

### Bug fixes

- Improve the mutation generator #1718
- Fix method inheritance for interfaces #1709
- Fix Interface inheritance chain #1686
- Fix require in `tracing.rb` #1685
- Remove delegate for `FieldResolutionContext#schema` #1682
- Remove duplicated `object_class` method #1667

## 1.8.5 (10 July 2018)

### Breaking changes

- GraphQL validation errors now include `"filename"` if the parsed document had a `filename` #1618

### Deprecations

- `TypeKind#resolves?` is deprecated in favor of `TypeKind#abstract?` #1619

### New features

- Add Mutation loading/authorization system #1609
- Interface `definition_methods` are inherited by object type classes #1635
- include `"filename"` in GraphQL errors if the parsed document has a filename #1618
- Add `Schema::InputObject#empty?` #1651
- require `ISO8601DateTime` by default #1660
- Support `extend` in the parser #1620
- Improve generator to have nicer error handling in development

### Bug fixes

- Fix `@skip`/`@include` with default value of `false` #1617
- Fix lists of abstract types with promises #1613
- Don't check the type of `nil` when it's in a list #1610
- Fix NoMethodError when `variables: nil` is passed to `execute(...)` #1661
- Objects returned from `Schema.unauthorized_objects` are properly wrapped by their type proxies #1662

## 1.8.4 (21 June 2018)

### New features

- Add class-based definitions for Relay types #1568
- Add a built-in auth system #1494

### Bug fixes

- Properly rescue coercion errors in variable values #1602

## 1.8.3 (14 June 2018)

### New features

- Add an ISO 8601 DateTime scalar: `Types::ISO8601DateTime`. #1566
- Use classes under the hood for built-in scalars. These are now accessible via `Types::` namespace. #1565
- Add `possible_types` helpers to abstract types #1580

### Bug fixes

- Fix `Language::Visitor` when visiting `InputObjectTypeDefinition` nodes to include child `Directive` nodes. #1584
- Fix an issue preventing proper subclassing of `TimeoutMiddleware`. #1579
- Fix `graphql:interface` generator such that it generates working code. #1577
- Update the description of auto-generated `before` and `after` arguments to better describe their input type. #1572
- Add `Language::Nodes::DirectiveLocation` AST node to represent directive locations in directive definitions. #1564

## 1.8.2 (6 June 2018)

### Breaking changes

- `Schema::InputObject#to_h` recursively transforms hashes to underscorized, symbolized keys. #1555

### New features

- Generators create class-based types #1562
- `Schema::InputObject#to_h` returns a underscorized, symbolized hash #1555

### Bug fixes

- Support `default_mask` in class-based schemas #1563
- Fix null propagation for list types #1558
- Validate unique arguments in queries #1557
- Fix `RelayClassicMutation`s with no arguments #1543

## 1.8.1 (1 June 2018)

### Breaking changes

- When filtering items out of a schema, Unions will now be hidden if their possible types are all hidden or if all fields returning it are hidden. #1515

### New features

- `GraphQL::ExecutionError.new` accepts an `extensions:` option which will be merged into the `"extensions"` key in that error's JSON #1552

### Bug fixes

- When filtering items out of a schema, Unions will now be hidden if their possible types are all hidden or if all fields returning it are hidden. #1515
- Require that fields returning interfaces have selections made on them #1551
- Correctly mark introspection types and fields as `introspection?` #1535
- Remove unused introspection objects #1534
- use `object`/`context` in the upgrader instead of `@object`/`@context` #1529
- (Development) Don't require mongodb for non-mongo tests #1548
- Track position of union member nodes in the parser #1541

## 1.8.0 (17 May 2018)

`1.8.0` has been in prerelease for 6 months. See the prerelease changelog for change-by-change details. Here's a high-level changelog, followed by a detailed list of changes since the last prerelease.

### High-level changes

#### Breaking Changes

- GraphQL-Ruby is not tested on Ruby 2.1. #1070 Because Ruby 2.1 doesn't garbage collect Symbols, it's possible that GraphQL-Ruby will introduce a OOM vulnerability where unique symbols are dynamically created, for example, turning user input into Symbols. No instances of this are known in GraphQL-Ruby ... yet!
- `GraphQL::Delegate`, a duplicate of Ruby's `Forwardable`, was removed. Use `Forwardable` instead, and update your Ruby if you're on `2.4.0`, due to a performance regression in `Forwardable` in that version.
- `MySchema.subscriptions.trigger` asserts that its inputs are valid arguments #1400. So if you were previously passing invalid options there, you'll get an error. Remove those options.

#### New Features

- A new class-based API for schema definition. The old API is completely supported, but the new one is much nicer to use. If you migrate, some schema extensions may require a bit of extra work.
- Built-in support for Mongoid-backed Relay connections
- `.execute(variables: ...)` and `subscriptions.trigger` both accept Symbol-keyed hashes
- Lots of other small things around SDL parsing, tracing, runtime ... everything. Read the details below for a full list.

#### Bug Fixes

- Many, many bug fixes. See the detailed list if you're curious about specific bugs.

### Changes since `1.8.0.pre11`:

#### Breaking Changes

- `GraphQL::Schema::Field#initialize`'s signature changed to accept keywords and a block only. `type:`, `description:` and `name:` were moved to keywords. See `Field.from_options` for how the `field(...)` helper's arguments are merged to go to `Field.new`. #1508

#### New Features

- `Schema::Resolver` is a replacement for `GraphQL::Function` #1472
- Fix subscriptions with class-based schema #1478
- `Tracing::NewRelicTracing` accepts `set_transaction_name:` to use the GraphQL operation name as the NewRelic transaction name #1430

#### Bug fixes

- Backported `accepts_definition`s are inherited #1514
- Fix Schema generator's `resolve_type` method #1481
- Fix constant assignment warnings with interfaces including multiple other interfaces #1465
- InputObject types loaded from SDL have the proper AST node assigned to them #1512

## 1.8.0.pre11 (3 May 2018)

### Breaking changes

- `Schema::Mutation.resolve_mutation` was moved to an instance method; see changes to `Schema::RelayClassicMutation` in #1469 for an example refactor
- `GraphQL::Delegate` was removed, use Ruby's `Forwardable` instead (warning: bad performance on Ruby 2.4.0)
- `GraphQL::Schema::Interface` is a module, not a class #1372. To refactor, use a base module instead of a base class:

  ```ruby
  module BaseInterface
    include GraphQL::Schema::Interface
  end
  ```

  And include that in your interface types:

  ```ruby
  module Reservable
    include BaseInterface
    field :reservations, ...
  end
  ```

  In object types, no change is required; use `implements` as before:

  ```ruby
  class EventVenue < BaseObject
    implements Reservable
  end
  ```

### New features

- `GraphQL::Schema::Interface` is a module
- Support `prepare:` and `as:` argument options #1469
- First-class support for Mongoid connections #1452
- More type inspection helpers for class-based types #1446
- Field methods may call `super` to get the default behavior #1437
- `variables:` accepts symbol keys #1401
- Reprint any directives which were parsed from SDL #1417
- Support custom JSON scalars #1398
- Subscription `trigger` accepts symbol, underscored arguments and validates their presence #1400
- Mutations accept a `null(true | false)` setting to affect field nullability #1406
- `RescueMiddleware` uses inheritance to match errors #1393
- Resolvers may return a list of errors #1231

### Bug fixes

- Better error for anonymous class names #1459
- Input Objects correctly inherit arguments #1432
- Fix `.subscriptions` for class-based Schemas #1391

## 1.8.0.pre10 (4 Apr 2018)

### New features

- Add `Schema::Mutation` and `Schema::RelayClassicMutation` base classes #1360

### Bug fixes

- Fix using anonymous classes for field types #1358

## 1.8.0.pre9 (19 Mar 2018)

- New version number. (I needed this because I messed up build tooling for 1.8.0.pre8).

## 1.8.0.pre8 (19 Mar 2018)

### New Features

- Backport `accepts_definition` for configurations #1357
- Add `#owner` method to Schema objects
- Add `Interface.orphan_types` config for orphan types #1346
- Add `extras: :execution_errors` for `add_error` #1313
- Accept a block to `Schema::Argument#initialize` #1356

### Bug Fixes

- Support `cursor_encoder` #1357
- Don't double-count lazy/eager field time in Tracing #1321
- Fix camelization to support single leading underscore #1315
- Fix `.resolve_type` for Union and Interface classes #1342
- Apply kwargs before block in `Argument.from_dsl` #1350

## 1.8.0.pre7 (27 Feb 2018)

### New features

- Upgrader improvements #1305
- Support `global_id_field` for interfaces #1299
- Add `camelize: false` #1300
- Add readers for `context`, `object` and `arguments` #1283
- Replace `Schema.method_missing` with explicit whitelist #1265

## 1.8.0.pre6 (1 Feb 2018)

### New features

- Custom enum value classes #1264

### Bug fixes

- Properly print SDL type directives #1255

## 1.8.0.pre5 (1 Feb 2018)

### New features

- Upgrade argument access with the upgrader #1251
- Add `Schema#find(str)` for finding schema members by name #1232

### Bug fixes

- Fix `Schema.max_complexity` #1246
- Support cyclical connections/edges #1253

## 1.8.0.pre4 (18 Jan 2018)

### Breaking changes

- `Type.fields`, `Field.arguments`, `Enum.values` and `InputObject.arguments` return a Hash instead of an Array #1222

### New features

- By default, fields try hash keys which match their name, as either a symbol or a string #1225
- `field do ... end` instance_evals on the Field instance, not a FieldProxy #1227
- `[T, null: true]` creates lists with nullable items #1229
- Upgrader improvements #1223

### Bug fixes

- Don't require `parser` unless the upgrader is run #1218

## 1.8.0.pre3 (12 Jan 2018)

### New Features

- Custom `Context` classes for class-based schemas #1161
- Custom introspection for class-based schemas #1170
- Improvements to upgrader tasks and internals #1151, #1178, #1212
- Allow description inside field blocks #1175

## 1.8.0.pre2 (29 Nov 2017)

### New Features

- Add `rake graphql:upgrade[app/graphql]` for automatic upgrade #1110
- Automatically camelize field names and argument names #1143, #1126
- Improved error message when defining `name` instead of `graphql_name` #1104

### Bug fixes

- Fix list wrapping when value is `nil` #1117
- Fix ArgumentError typo #1098

## 1.8.0.pre1 (14 Nov 2017)

### Breaking changes

- Stop official support for Ruby 2.1 #1070

### New features

- Add class-based schema definition API #1037

## 1.7.14 (4 Apr 2018)

### New features

- Support new IDL spec for `&` for interfaces #1304
- Schema members built from IDL have an `#ast_node` #1367

### Bug fixes

- Fix paging backwards with `hasNextPage` #1319
- Add hint for `orphan_types` in error message #1380
- Use an empty hash for `result` when a query has unhandled errors #1382

## 1.7.13 (28 Feb 2018)

### Bug fixes

- `Schema#as_json` returns a hash, not a `GraphQL::Query::Result` #1288

## 1.7.12 (13 Feb 2018)

### Bug fixes

- `typed_children` should always return a Hash #1278

## 1.7.11 (13 Feb 2018)

### Bug fixes

- Fix compatibility of `irep_node.typed_children` on leaf nodes #1277

## 1.7.10 (13 Feb 2018)

### Breaking Changes

- Empty selections (`{ }`) are invalid in the GraphQL spec, but were previously allowed by graphql-ruby. They now return a parse error. #1268

### Bug fixes

- Fix error when inline fragments are spread on scalars #1268
- Fix printing SDL when types have interfaces and directives #1255

## 1.7.9 (1 Feb 2018)

## New Features

- Support block string inputs #1219

## Bug fixes

- Fix deprecation regression in schema printer #1250
- Fix resource names in DataDog tracing #1208
- Fix passing `context` to multiplex in `Query#result` #1200

## 1.7.8 (11 Jan 2018)

### New features

- Refactor `Schema::Printer` to use `Language::Printer` #1159
- Add `ArgumentValue#default_used?` and `Arguments#default_used?` #1152

### Bug fixes

- Fix Scout Tracing #1187
- Call `#inspect` for `EnumType::UnresolvedValueError` #1179
- Parse empty field sets in IDL parser #1145

## 1.7.7 (29 Nov 2017)

### New features

- `Schema#to_document` returns a `Language::Nodes::Document` #1134
- Add `trace_scalars` and `trace: true|false` to monitoring #1103
- Add `Tracing::DataDogPlatform` monitoring #1129
- Support namespaces in `rails g graphql:function` and `:loader` #1127
- Support `serializer:` option for `ActionCableSubscriptions` #1085

### Bug fixes

- Properly count the column after a closing quote #1136
- Fix default value input objects in `Schema.from_definition` #1135
- Fix `rails destroy graphql:mutation` #1119
- Avoid unneeded query in RelationConnection with Sequel #1101
- Improve & document instrumentation stack behavior #1101

## 1.7.6 (13 Nov 2017)

### Bug fixes

- Serialize symbols in with `GraphQL::Subscriptions::Serialize` #1084

## 1.7.5 (7 Nov 2017)

### Breaking changes

- Rename `Backtrace::InspectResult#inspect` to `#inspect_result` #1022

### New features

- Improved website search with Algolia #934
- Support customized generator directory #1047
- Recursively serialize `GlobalID`-compliant objects in Arrays and hashes #1030
- Add `Subscriptions#build_id` helper #1046
- Add `#non_null?` and `#list?` helper methods to type objects #1054

### Bug fixes

- Fix infinite loop in query instrumentation when error is raised #1074
- Don't try to trace error when it's not raised during execution
- Improve validation of query variable definitions #1073
- Fix Scout tracing module load order #1064

## 1.7.4 (9 Oct 2017)

### Deprecations

- `GraphQL::Tracing.install` is deprecated, use schema-local or query-local tracers instead #996

### New features

- Add monitoring plugins for AppSignal, New Relic, Scout and Skylight #994, #1013
- Custom coercion errors for custom scalars #988
- Extra `options` for `GraphQL::ExecutionError` #1002
- Use `GlobalID` for subscription serialization when available #1004
- Schema- and query-local, threadsafe tracers #996

### Bug fixes

- Accept symbol-keyed arguments to `.trigger` #1009

## 1.7.3 (20 Sept 2017)

### Bug fixes

- Fix arguments on `Query.__type` field #978
- Fix `Relay::Edge` objects in `Backtrace` tables #975

## 1.7.2 (20 Sept 2017)

### Bug fixes

- Correctly skip connections that return `ctx.skip` #972

## 1.7.1 (18 Sept 2017)

### Bug fixes

- Properly release changes from 1.7.0

## 1.7.0 (18 Sept 2017)

### Breaking changes

- `GraphQL::Result` is the returned from GraphQL execution. #898 `Schema#execute` and `Query#result` both return a `GraphQL::Result`. It implements Hash-like methods to preserve compatibility.

### New features

- `puts ctx.backtrace` prints out a GraphQL backtrace table #946
- `GraphQL::Backtrace.enable` wraps unhandled errors with GraphQL backtraces #946
- `GraphQL::Relay::ConnectionType.bidrectional_pagination = true` turns on _true_ bi-directional pagination checks for `hasNextPage`/`hasPreviousPage` fields. This will become the default behavior in a future version. #960
- Field arguments may be accessed as methods on the `args` object. This is an alternative to `#[]` syntax which provides did-you-mean behavior instead of returning `nil` on a typo. #924 For example:

  ```ruby
  # using hash syntax:
  args[:limit]    # => 10
  args[:limittt]  # => nil
  # using method syntax:
  args.limit      # => 10
  args.limittt    # => NoMethodError
  ```

  The old syntax is _not_ deprecated.

- Improvements to schema filters #919
  - If a type is not referenced by anything, it's hidden
  - If a type is an abstract type, but has no visible members, it's hidden

- `GraphQL::Argument.define` builds re-usable arguments #948
- `GraphQL::Subscriptions` provides hooks for subscription platforms #672
- `GraphQL::Subscriptions::ActionCableSubscriptions` implements subscriptions over ActionCable #672
- More runtime values are accessble from a `ctx` object #923 :
  - `ctx.parent` returns the `ctx` from the parent field
  - `ctx.object` returns the current `obj` for that field
  - `ctx.value` returns the resolved GraphQL value for that field

  These can be used together, for example, `ctx.parent.object` to get the parent object.
- `GraphQL::Tracing` provides more hooks into gem internals for performance monitoring #917
- `GraphQL::Result` provides access to the original `query` and `context` after executing a query #898

### Bug fixes

- Prevent passing _both_ query string and parsed document to `Schema#execute` #957
- Prevent invalid names for types #947

## 1.6.8 (8 Sept 2017)

### Breaking changes

- Validate against EnumType value names to match `/^[_a-zA-Z][_a-zA-Z0-9]*$/` #915

### New features

- Use stdlib `forwardable` when it's not Ruby 2.4.0 #926
- Improve `UnresolvedTypeError` message #928
- Add a default field to the Rails generated mutation type #922

### Bug fixes

- Find types via directive arguments when traversing the schema #944
- Assign `#connection?` when building a schema from IDL #941
- Initialize `@edge_class` to `nil` #942
- Disallow invalid enum values #915
- Disallow doubly-nested non-null types #916
- Fix `Query#selected_operation_name` when no selections are present #899
- Fix needless `COUNT` query for `hasNextPage` #906
- Fix negative offset with `last` argument #907
- Fix line/col for `ArgumentsAreDefined` validation #890
- Fix Sequel error when limit is `0` #892

## 1.6.7 (11 Aug 2017)

### New features

- Add `GraphQL.parse_file` and `AbstractNode#filename` #873
- Support `.graphql` filepaths with `Schema.from_definition` #872

### Bug fixes

- Fix variable usage inside non-null list #888
- Fix unqualified usage of ActiveRecord::Relation #885
- Fix `FieldsWillMerge` handling of equivalent input objects
- Fix to call `prepare:` on nested input types

## 1.6.6 (14 Jul 2017)

### New features

- Validate `graphql-pro` downloads with `rake graphql:pro:validate[$VERSION]` #846

### Bug fixes

- Remove usage of Rails-only `Array.wrap` #840
- Fix `RelationConnection` to count properly when relation contains an alias #838
- Print name of Enum type when a duplicate value is added #843

## 1.6.5 (13 Jul 2017)

### Breaking changes

- `Schema#types[](type_name)` returns `nil` when there's no type named `type_name` (it used to raise `RuntimeError`). To get an error for missing types, use `.fetch` instead, for example:

  ```ruby
  # Old way:
  MySchema.types[type_name]       # => may raise RuntimeError
  # New way:
  MySchema.types.fetch(type_name) # => may raise KeyError
  ```

- Schema build steps happen in one pass instead of two passes #819 . This means that `instrument(:field)` hooks may not access `Schema#types`, `Schema#possible_types` or `Schema#get_field`, since the underlying data hasn't been prepared yet. There's not really a clear upgrade path here. It's a bit of a mess. If you're affected by this, feel free to open an issue and we'll try to find something that works!

### Deprecations

- `Schema#resolve_type` is now called with `(abstract_type, obj, ctx)` instead of `(obj, ctx)` #834 . To update, add an unused parameter to the beginning of your `resolve_type` hook:

  ```ruby
  MySchema = GraphQL::Schema.define do
    # Old way:
    resolve_type ->(obj, ctx) { ... }
    # New way:
    resolve_type ->(type, obj, ctx) { ... }
  end
  ```

### New features

- `rails g graphql:mutation` will add Mutation boilerplate if it wasn't added already #812
- `InterfaceType` and `UnionType` both accept `resolve_type ->(obj, ctx) { ... }` functions for type-specific resolution. This function takes precedence over `Schema#resolve_type` #829 #834
- `Schema#resolve_type` is called with three arguments, `(abstract_type, obj, ctx)`, so you can distinguish object type based on interface or union.
- `Query#operation_name=` may be assigned during query instrumentation #833
- `query.context.add_error(err)` may be used to add query-level errors #833

### Bug fixes

- `argument(...)` DSL accepts custom keywords #809
- Use single-query `max_complexity` overrides #812
- Return a client error when `InputObjectType` receives an array as input #803
- Properly handle raised errors in `prepare` functions #805
- Fix using `as` and `prepare` in `argument do ... end` blocks #817
- When types are added to the schema with `instrument(:field, ...)`, make sure they're in `Schema#types` #819
- Raise an error when duplicate `EnumValue` is created #831
- Properly resolve all query levels breadth-first when using `lazy_resolve` #835
- Fix tests to run on PostgresQL; Run CI on PostgresQL #814
- When no query string is present, return a client error instead of raising `ArgumentError` #833
- Properly validate lists containing variables #824

## 1.6.4 (20 Jun 2017)

### New features

- `Schema.to_definition` sorts fields and arguments alphabetically #775
- `validate: false` skips static validations in query execution #790

### Bug fixes

- `graphql:install` adds `operation_name: params[:operationName]` #786
- `graphql:install` skips `graphiql-rails` for API-only apps #772
- `SerialExecution` calls `.is_a?(Skip)` to avoid user-defined `#==` methods #794
- `prepare:` functions which return `ExecutionError` are properly handled when default values are present #801

## 1.6.3 (7 Jun 2017)

### Bug fixes

- Run multiplex instrumentation when running a single query with a legacy execution strategy #766
- Check _each_ strategy when looking for overridden execution strategy #765
- Correctly wrap `Method`s with BackwardsCompatibility #763
- Various performance improvements #764
- Don't call `#==(other)` on user-provided objects (use `.is_a?` instead) #761
- Support lazy object from custom connection `#edge_nodes` #762
- If a lazy field returns an invalid null, stop evaluating its siblings #767

## 1.6.2 (2 Jun 2017)

### New features

- `Schema.define { default_max_page_size(...) }` provides a Connection `max_page_size` when no other is provided #752
- `Schema#get_field(type, field)` accepts a string type name #756
- `Schema.define { rescue_from(...) }` accepts multiple error classes for the handler #758

### Bug fixes

- Use `*_execution_strategy` when executing a single query (doesn't support `Schema#multiplex`) #755
- Fix NameError when `ActiveRecord` isn't loaded #747
- Fix `Query#mutation?` etc to support lazily-loaded AST #754

## 1.6.1 (28 May 2017)

### New Features

- `Query#selected_operation_name` returns the operation to execute, even if it was inferred (not provided as `operation_name:`) #746

### Bug fixes

- Return `nil` from `Query#operation_name` if no `operation_name:` was provided #746

## 1.6.0 (27 May 2017)

### Breaking changes

- `InternalRepresentation::Node#return_type` will now return the wrapping type. Use `return_type.unwrap` to access the old value #704
- `instrument(:query, ...)` instrumenters are applied as a stack instead of a queue #735. If you depend on queue-based behavior, move your `before_query` and `after_query` hooks to separate instrumenters.
- In a `Relay::Mutation`, Raising or returning a `GraphQL::Execution` will nullify the mutation field, not the field's children. #731
- `args.to_h` returns a slightly different hash #714
  - keys are always `String`s
  - if an argument is aliased with `as:`, the alias is used as the key
- `InternalRepresentation::Node#return_type` includes the original "wrapper" types (non-null or list types), call `.unwrap` to get the inner type #20

  ```ruby
  # before
  irep_node.return_type
  # after
  irep_node.return_type.unwrap
  ```

### Deprecations

- Argument `prepare` functions which take one argument are deprecated #730

  ```ruby
  # before
  argument :id, !types.ID, prepare: ->(val) { ... }
  # after
  argument :id, !types.ID, prepare: ->(val, ctx) { ... }
  ```

### New features

- `Schema#multiplex(queries)` runs multiple queries concurrently #691
- `GraphQL::RakeTask` supports dumping the schema to IDL or JSON #687
- Improved support for `Schema.from_definition` #699 :
  - Custom scalars are supported with `coerce_input` and `coerce_result` functions
  - `resolve_type` function will be used for abstract types
  - Default resolve behavior is to check `obj` for a method and call it with 0, 1, or 2 arguments.
- `ctx.skip` may be returned from field resolve functions to exclude the field from the response entirely #688
- `instrument(:field, ..., after_built_ins: true)` to apply field instrumentation after Relay wrappers #740
- Argument `prepare` functions are invoked with `(val, ctx)` (previously, it was only `(val)`) #730
- `args.to_h` returns stringified, aliased arguments #714
- `ctx.namespace(:my_namespace)` provides namespaced key-value storage #689
- `GraphQL::Query` can be initialized without a query_string; it can be added after initialization #710
- Improved filter support #713
  - `Schema.execute(only:, except:)` accept a callable _or_ an array of callables (multiple filters)
  - Filters can be added to a query via `Query#merge_filters(only:, except:)`. You can add a filter to every query by merging it in during query instrumentation.

### Bug fixes

- Correctly apply cursors and `max_page_size` in `Relay::RelationConnection` and `Relay::ArrayConnection` #728
- Nullify a mutation field when it raises or returns an error #731

## 1.5.14 (27 May 2017)

### New features

- `UniqueWithinType` Relay ID generator supports `-` in the ID #742
- `assign_metadata_key` assigns `true` when the definition method is called without arguments #724
- Improved lexer performance #737

### Bug fixes

- Assign proper `parent` when a `connection` resolve returns a promise #736

## 1.5.13 (11 May 2017)

- Fix raising `ExecutionError` inside mutation resolve functions (it nullifies the field) #722

## 1.5.12 (9 May 2017)

- Fix returning `nil` from connection resolve functions (now they become `null`) #719
- Fix duplicate AST nodes when merging fragments #721

## 1.5.11 (8 May 2017)

### New features

- `Schema.from_definition` accepts a `parser:` option (to work around lack of schema parser in `graphql-libgraphqlparser`) #712
- `Query#internal_representation` exposes an `InternalRepresentation::Document` #701
- Update generator usage of `graphql-batch` #697

### Bug fixes

- Handle fragments with the same name as operations #706
- Fix type generator: ensure type name is camelized #718
- Fix `Query#operation_name` to return the operation name #707
- Fix pretty-print of non-null & list types #705
- Fix single input objects passed to list-type arguments #716

## 1.5.10 (25 Apr 2017)

### New features

- Support Rails 5.1 #693
- Fall back to `String#encode` for non-UTF-8/non-ASCII strings #676

### Bug Fixes

- Correctly apply `Relay::Mutation`'s `return_field ... property:`  argument #692
- Handle Rails 5.1's `ActionController::Parameters` #693

## 1.5.9 (19 Apr 2017)

### Bug Fixes

- Include instrumentation-related changes in introspection result #681

## 1.5.8 (18 Apr 2017)

### New features

- Use Relay PageInfo descriptions from graphql-js #673

### Bug Fixes

- Allow fields with different arguments when fragments are included within inline fragments of non-overlapping types #680
- Run `lazy_resolve` instrumentation for `connection` fields #679

## 1.5.7 (14 Apr 2017)

### Bug fixes

- `InternalRepresentation::Node#definition` returns `nil` instead of raising NoMethodError for operation fields #675
- `Field#function` is properly populated for fields derived from `GraphQL::Function`s #674

## 1.5.6 (9 Apr 2017)

## Breaking Changes

- Returned strings which aren't encoded as UTF-8 or ASCII will raise `GraphQL::StringEncodingError` instead of becoming `nil` #661

  To preserve the previous behavior, Implement `Schema#type_error` to return `nil` for this error, eg:

  ```ruby
  GraphQL::Schema.define do
    type_error ->(err, ctx) {
      case err
      # ...
      when GraphQL::StringEncodingError
        nil
      end
    }
  ```

- `coerce_non_null_input` and `validate_non_null_input` are private #667

## Deprecations

- One-argument `coerce_input` and `coerce_result` functions for custom scalars are deprecated. #667 Those functions now accept a second argument, `ctx`.

  ```ruby
  # From
  ->(val) { val.to_i }
  # To:
  ->(val, ctx) { val.to_i }
  ```

- Calling `coerce_result`, `coerce_input`, `valid_input?` or `validate_input` without a `ctx` is deprecated. #667 Use `coerce_isolated_result` `coerce_isolated_input`, `valid_isolated_input?`, `validate_input` to explicitly bypass `ctx`.

## New Features

- Include `#types` in `GraphQL::Function` #654
- Accept `prepare:` function for arguments #646
- Scalar coerce functions receive `ctx` #667

## Bug Fixes

- Properly apply default values of `false` #658
- Fix application of argument options in `GraphQL::Relay::Mutation` #660
- Support concurrent-ruby `>1.0.0` #663
- Only raise schema validation errors on `#execute` to avoid messing with Rails constant loading #665

## 1.5.5 (31 Mar 2017)

### Bug Fixes

- Improve threadsafety of `lazy_resolve` cache, use `Concurrent::Map` if it's available #631
- Properly handle unexpeced input objects #638
- Handle errors during definition by preseriving the definition #632
- Fix `nil` input for nullable list types #637, #639
- Handle invalid schema IDL with a validation error #647
- Properly serialize input object default values #635
- Fix `as:` on mutation `input_field` #650
- Fix null propagation for `nil` members of non-null list types #649

## 1.5.4 (22 Mar 2017)

### Breaking Changes

- Stop supporting deprecated one-argument schema masks #616

### Bug Fixes

- Return a client error for unknown variable types when default value is provided or when directives are present #627
- Fix validation performance regression on nested abstract fragment conditions #622, #624
- Put back `InternalRepresentation::Node#parent` and fix it for fragment fields #621
- Ensure enum names are strings #619

## 1.5.3 (20 Mar 2017)

### Bug Fixes

- Fix infinite loop triggered by user input. #620 This query would cause an infinite loop:

  ```graphql
  query { ...frag }
  fragment frag on Query { __typename }
  fragment frag on Query { ...frag }
  ```

- Validate fragment name uniqueness #618

## 1.5.2 (16 Mar 2017)

### Breaking Changes

- Parse errors are no longer raised to the application. #607 Instead, they're returned to the client in the `"errors"` key. To preserve the previous behavior, you can implement `Schema#parse_error` to raise the error:

  ```ruby
  MySchema = GraphQL::Schema.define do
    # ...
    parse_error ->(err, ctx) { raise(err) }
  end
  ```

### New Features

- Add `graphq:enum` generator #611
- Parse errors are returned to the client instead of raised #607

### Bug Fixes

- Handle negative cursor pagination args as `0` #612
- Properly handle returned `GraphQL::ExecutionError`s from connection resolves #610
- Properly handle invalid nulls in lazy scalar fields #609
- Properly handle invalid input objects passed to enum arguments #604
- Fix introspection response of enum default values #605
- Allow `Schema.from_definition` default resolver hashes to have defaults #608

## 1.5.1 (12 Mar 2017)

### Bug fixes

- Fix rewrite performance regressions from 1.5.0 #599
- Remove unused `GraphQL::Execution::Lazy` initialization API #597

## 1.5.0 (10 Mar 2017), yanked

### Breaking changes

- _Only_ UTF-8-encoded strings will be returned by `String` fields. Strings with other encodings (or objects whose `#to_s` method returns a string with a different encoding) will return `nil` instead of that string. #517

  To opt into the _previous_ behavior, you can modify `GraphQL::STRING_TYPE`:

  ```ruby
  # app/graphql/my_schema.rb
  # Restore previous string behavior:
  GraphQL::STRING_TYPE.coerce_result = ->(value) { value.to_s }

  MySchema = GraphQL::Schema.define { ... }
  ```

- Substantial changes to the internal query representation (#512, #536). Query analyzers may notice some changes:
  - Nodes skipped by directives are not visited
  - Nodes are always on object types, so `Node#owner_type` always returns an object type. (Interfaces and Unions are replaced with concrete object types which are valid in the current scope.)

  See [changes to `Analysis::QueryComplexity`](https://github.com/rmosolgo/graphql-ruby/compare/v1.4.5...v1.5.0#diff-8ff2cdf0fec46dfaab02363664d0d201) for an example migration. Here are some other specific changes:

  - Nodes are tracked on object types only, not interface or union types
  - Deprecated, buggy `Node#children` and `Node#path` were removed
  - Buggy `#included` was removed
  - Nodes excluded by directives are entirely absent from the rewritten tree
  - Internal `InternalRepresentation::Selection` was removed (no longer needed)
  - `Node#spreads` was replaced by `Node#ast_spreads` which returns a Set

### New features

- `Schema#validate` returns a list of errors for a query string #513
- `implements ...` adds interfaces to object types _without_ inherit-by-default #548, #574
- `GraphQL::Relay::RangeAdd` for implementing `RANGE_ADD` mutations #587
- `use ...` definition method for plugins #565
- Rails generators #521, #580
- `GraphQL::Function` for reusable resolve behavior with arguments & return type #545
- Support for Ruby 2.4 #475
- Relay `node` & `nodes` field can be extended with a custom block #552
- Performance improvements:
  - Resolve fragments only once when validating #504
  - Reuse `Arguments` objects #500
  - Skip needless `FieldResult`s #482
  - Remove overhead from `ensure_defined` #483
  - Benchmark & Profile tasks for gem maintenance #520, #579
  - Fetch `has_next_page` while fetching items in `RelationConnection` #556
  - Merge selections on concrete object types ahead of time #512
- Support runnable schemas with `Schema.from_definition` #567, #584

### Bug fixes

- Support different arguments on non-overlapping typed fragments #512
- Don't include children of `@skip`ped nodes when parallel branches are not skipped #536
- Fix offset in ArrayConnection when it's larger than the array #571
- Add missing `frozen_string_literal` comments #589

## 1.4.5 (6 Mar 2017)

### Bug Fixes

- When an operation name is provided but no such operation is present, return an error (instead of executing the first operation) #563
- Require unique operation names #563
- Require selections on root type #563
- If a non-null field returns `null`, don't resolve any more sibling fields. #575

## 1.4.4 (17 Feb 2017)

### New features

- `Relay::Node.field` and `Relay::Node.plural_field` accept a custom `resolve:` argument #550
- `Relay::BaseConnection#context` provides access to the query context #537
- Allow re-assigning `Field#name` #541
- Support `return_interfaces` on `Relay::Mutation`s #533
- `BaseType#to_definition` stringifies the type to IDL #539
- `argument ... as:` can be used to alias an argument inside the resolve function #542

### Bug fixes

- Fix negative offset from cursors on PostgresQL #510
- Fix circular dependency issue on `.connection_type`s #535
- Better error when `Relay::Mutation.resolve` doesn't return a Hash

## 1.4.3 (8 Feb 2017)

### New features

- `GraphQL::Relay::Node.plural_field` finds multiple nodes by UUID #525

### Bug fixes

- Properly handle errors from lazy mutation results #528
- Encode all parsed strings as UTF-8 #516
- Improve error messages #501 #519

## 1.4.2 (23 Jan 2017)

### Bug fixes

- Absent variables aren't present in `args` (_again_!) #494
- Ensure definitions were executed when accessing `Field#resolve_proc` #502 (This could have caused errors when multiple instrumenters modified the same field in the schema.)

## 1.4.1 (16 Jan 2017)

### Bug fixes

- Absent variables aren't present in `args` #479
- Fix grouped ActiveRecord relation with `last` only #476
- `Schema#default_mask` & query `only:`/`except:` are combined, not overriden #485
- Root types can be hidden with dynamic filters #480

## 1.4.0 (8 Jan 2017)

### Breaking changes

### Deprecations

- One-argument schema filters are deprecated. Schema filters are now called with _two_ arguments, `(member, ctx)`. #463 To update, add a second argument to your schema filter.
- The arity of middleware `#call` methods has changed. Instead of `next_middleware` being the last argument, it is passed as a block. To update, call `yield` to continue the middleware chain or use `&next_middleware` to capture `next_middleware` into a local variable.

  ```ruby
  # Previous:
  def call(*args, next_middleware)
    next_middleware.call
  end

  # Current
  def call(*args)
    yield
  end
  # Or
  def call(*args, &next_middleware)
    next_middleware.call
  end
  ```

### New features

- You can add a `nodes` field directly to a connection. #451 That way you can say `{ friends { nodes } }` instead of `{ freinds { edges { node } } }`. Either pass `nodes_field: true` when defining a custom connection type, for example:

  ```ruby
  FriendsConnectionType = FriendType.define_connection(nodes_field: true)
  ```

  Or, set `GraphQL::Relay::ConnectionType.default_nodes_field = true` before defining your schema, for example:

  ```ruby
  GraphQL::Relay::ConnectionType.default_nodes_field = true
  MySchema = GraphQL::Schema.define { ... }
  ```

- Middleware performance was dramatically improved by reducing object allocations. #462 `next_middleware` is now passed as a block. In general, [`yield` is faster than calling a captured block](https://github.com/JuanitoFatas/fast-ruby#proccall-and-block-arguments-vs-yieldcode).
- Improve error messages for wrongly-typed variable values #423
- Cache the value of `resolve_type` per object per query #462
- Pass `ctx` to schema filters #463
- Accept whitelist schema filters as `only:` #463
- Add `Schema#to_definition` which accepts `only:/except:` to filter the schema when printing #463
- Add `Schema#default_mask` as a default `except:` filter #463
- Add reflection methods to types #473
   - `#introspection?` marks built-in introspection types
   - `#default_scalar?` marks built-in scalars
   - `#default_relay?` marks built-in Relay types
   - `#default_directive?` marks built-in directives

### Bug fixes

- Fix ArrayConnection: gracefully handle out-of-bounds cursors #452
- Fix ArrayConnection & RelationConnection: properly handle `last` without `before` #362

## 1.3.0 (8 Dec 2016)

### Deprecations

- As per the spec, `__` prefix is reserved for built-in names only. This is currently deprecated and will be invalid in a future version. #427, #450

### New features

- `Schema#lazy_resolve` allows you to define handlers for a second pass of resolution #386
- `Field#lazy_resolve` can be instrumented to track lazy resolution #429
- `Schema#type_error` allows you to handle `InvalidNullError`s and `UnresolvedTypeErrors` in your own way #416
- `Schema#cursor_encoder` can be specified for transforming cursors from built-in Connection implementations #345
- Schema members `#dup` correctly: they shallowly copy their state into new instances #444
- `Query#provided_variables` is now public #430

### Bug fixes

- Schemas created from JSON or strings with custom scalars can validate queries (although they still can't check if inputs are valid for those custom scalars) #445
- Always use `quirks_mode: true` when serializing values (to support non-stdlib `JSON`s) #449
- Calling `#redefine` on a Schema member copies state outside of previous `#define` blocks (uses `#dup`) #444

## 1.2.6 (1 Dec 2016)

### Bug fixes

- Preserve connection behaviors after `redefine` #421
- Implement `respond_to_missing?` on `DefinedObjectProxy` (which is `self` inside `.define { ... }`) #414

## 1.2.5 (22 Nov 2016)

### Breaking changes

- `Visitor` received some breaking changes, though these are largely-private APIs (#401):
  - Global visitor hooks (`Visitor#enter` and `Visitor#leave`) have been removed
  - Returning `SKIP` from a visitor hook no longer skips sibling nodes

### New features

- `Schema#instrument` may be called outside of `Schema.define` #399
- Validation: assert that directives on a node are unique #409
- `instrument(:query)` hooks are executed even if the query raises an error #412

### Bug fixes

- `Mutation#input_fields` should trigger lazy definition #392
- `ObjectType#connection` doesn't modify the provided `GraphQL::Field` #411
- `Mutation#resolve` may return a `GraphQL::ExecutionError` #405
- `Arguments` can handle nullable arguments passed as `nil` #410

## 1.2.4 (14 Nov 2016)

### Bug fixes

- For invalid enum values, print the enum name in the error message (not a Ruby object dump) #403
- Improve detection of invalid UTF-8 escapes #394

## 1.2.3 (14 Nov 2016)

### Bug fixes

- `Lexer` previous token should be a local variable, not a method attribute #396
- `Arguments` should wrap values according to their type, not their value #398

## 1.2.2 (7 Nov 2016)

### New features

- `Schema.execute` raises an error if `variables:` is a string

### Bug fixes

- Dynamic fields `__schema`, `__type` and `__typename` are properly validated #391

## 1.2.1 (7 Nov 2016)

### Bug fixes

- Implement `Query::Context#strategy` and `FieldResolutionContext#strategy` to support GraphQL::Batch #382

## 1.2.0 (7 Nov 2016)

### Breaking changes

- A breaking change from 1.1.0 was reverted: two-character `"\\u"` _is_ longer treated as the Unicode escape character #372

- Due to the execution bug described below, the internal representation of a query has changed. Although `Node` responds to the same methods, tree is built differently and query analyzers visit it differently. #373, #379

  The difference is in cases like this:

  ```graphql
  outer {
    ... on A { inner1 { inner2 } }
    ... on B { inner1 { inner3 } }
  }
  ```

  Previously, visits would be:

  - `outer`, which has one child:
    - `inner1`, which has two definitions (one on `A`, another on `B`), then visit its two `children`:
      - `inner2` which has one definition (on the return type of `inner1`)
      - `inner3` which has one definition (on the return type of `inner1`)

  This can be wrong for some cases. For example, if `A` and `B` are mutually exclusive (both object types, or union types with no shared members), then `inner2` and `inner3` will never be executed together.

  Now, the visit goes like this:

  - `outer` which has two entries in `typed_children`, one on `A` and another on `B`. Visit each `typed_chidren` branch:
    - `inner1`, then its one `typed_children` branch:
      - `inner2`
    - `inner1`, then its one `typed_children` branch:
      - `inner3`

  As you can see, we visit `inner1` twice, once for each type condition. `inner2` and `inner3` are no longer visited as siblings. Instead they're visited as ... cousins? (They share a grandparent, not a parent.)

  Although `Node#children` is still present, it may not contain all children actually resolved at runtime, since multiple `typed_children` branches could apply to the same runtime type (eg, two branches on interface types can apply to the same object type). To track all children, you have to do some bookkeeping during visitation, see `QueryComplexity` for an example.

  You can see PR #373 for how built-in analyzers were changed to reflect this.

### Deprecations

- `InternalRepresentation::Node#children` and `InternalRepresentation::Node#definitions` are deprecated due to the bug described below and the breaking change described above. Instead, use `InternalRepresentation::Node#typed_children` and `InternalRepresentation::Node#defininition`. #373

### New features

- `null` support for the whole library: as a query literal, variable value, and argument default value. To check for the presence of a nullable, use `Arguments#key?` #369

- `GraphQL::Schema::UniqueWithinType.default_id_separator` may be assigned to a custom value #381

- `Context#add_error(err)` may be used to add a `GraphQL::ExecutionError` to the response's `"errors"` key (and the resolve function can still return a value) #367

- The third argument of `resolve` is now a `FieldResolutionContext`, which behaves just like a `Query::Context`, except that it is not modified during query execution. This means you can capture a reference to that context and access some field-level details after the fact: `#path`, `#ast_node`, `#irep_node`. (Other methods are delegated to the underlying `Query::Context`) #379

- `TimeoutMiddleware`'s second argument is a _proxied_ query object: it's `#context` method returns the `FieldResolutionContext` (see above) for the timed-out field. Other methods are delegated to the underlying `Query` #379

### Bug fixes

- Fix deep selection merging on divergently-typed fragments. #370, #373, #379 Previously, nested selections on different fragments were not distinguished. Consider a case like this:

  ```graphql
  ... on A { inner1 { inner2 } }
  ... on B { inner1 { inner3 } }
  ```

  Previously, an object of type `A` would resolve `inner1`, then the result would receive _both_ `inner2` and `inner3`. The same was true for an object of type `B`.

  Now, those are properly distinguished. An object of type `A` resolves `inner1`, then its result receives `inner2`. An object of type `B` receives `inner1`, then `inner3`.

## 1.1.0 (1 Nov 2016)

### Breaking changes

- Two-character `"\\u"` is no longer treated as the Unicode escape character, only the Unicode escape character `"\u"` is treated that way. (This behavior was a bug, the migration path is to use the Unicode escape character.) #366
- `GraphQL::Language::ParserTests` was removed, use `GraphQL::Compatibility` instead. #366
- Non-null arguments can't be defined with default values, because those values would never be used #361

### New features

- `Schema.from_definition(definition_string)` builds a `GraphQL::Schema` out of a schema definition. #346
- Schema members (types, fields, arguments, enum values) can be hidden on a per-query basis with the `except:` option #300
- `GraphQL::Compatibility` contains `.build_suite` functions for testing user-provided parsers and execution strategies with GraphQL internals. #366
- Schema members respond to `#redefine { ... }` for making shallow copies with extended definitions. #357
- `Schema#instrument` provides an avenue for observing query and field resolution with no overhead.
- Some `SerialExecution` objects were converted to functions, resulting in a modest performance improvement for query resolution.

### Bug fixes

- `NonNullType` and `ListType` have no name (`nil`), as per the spec #355
- Non-null arguments can't be defined with default values, because those values would never be used #361

## 1.0.0 (25 Oct 2016)

### Breaking changes

- `validate: false` option removed from `Schema.execute` (it didn't work anyways) #338
- Some deprecated methods were removed: #349
  - `BaseConnection#object` was removed, use `BaseConnection#nodes`
  - `BaseConnection.connection_for_items` was removed, use `BaseConnection#connection_for_nodes`
  - Two-argument resolve functions for `Relay::Mutation`s are not supported, use three arguments instead: `(root_obj, input, ctx)`
  - `Schema.new` no longer accepts initialization options, use `Schema.define` instead
  - `GraphQL::ObjectType::UnresolvedTypeError` was removed, use `GraphQL::UnresolvedTypeError` instead
- Fragment type conditions should be parsed as `TypeName` nodes, not strings. (Users of `graphql-libgraphqlparser` should update to `1.0.0` of that gem.) #342

### New Features

- Set `ast_node` and `irep_node` on query context before sending it to middleware #348
- Enum values can be extended with `.define` #341

### Bug Fixes

- Use `RelationConnection` for Rails 3 relations (which also extend `Array`) #343
- Fix schema printout when arguments have comments #335

## 0.19.4 (18 Oct 2016)

### Breaking changes

- `Relay::BaseConnection#order` was removed (it always returned `nil`) #313
- In the IDL, Interface names & Union members are parsed as `TypeName` nodes instead of Strings #322

### New features

- Print and parse descriptions in the IDL #305
- Schema roots from IDL are omitted when their names match convention #320
- Don't add `rescue_middleware` to a schema if it's not using `rescue_from` #328
- `Query::Arguments#each_value` yields `Query::Argument::ArgumentValue` instances which contain key, value and argument definition #331

### Bug fixes

- Use `JSON.generate(val, quirks_mode: true)` for compatibility with other JSON implementations #316
- Improvements for compatibility with 1.9.3 branch #315 #314 #313
- Raise a descriptive error when calculating a `cursor` for a node which isn't present in the connection's members #327

## 0.19.3 (13 Oct 2016)

### Breaking Changes

- `GraphQL::Query::Arguments.new` requires `argument_definitions:` of type `{String => GraphQL::Argument }` #304

### Deprecations

- `Relay::Mutation#resolve` has a new signature. #301

  Previously, it was called with two arguments:

  ```ruby
  resolve ->(inputs, ctx) { ... }
  ```

  Now, it's called with three inputs:

  ```ruby
  resolve ->(obj, inputs, ctx) { ... }
  ```

  `obj` is the value of `root_value:` given to `Schema#execute`, as with other root-level fields.

  Two-argument resolvers are still supported, but they are deprecated and will be removed in a future version.

### New features

- `Relay::Mutation` accepts a user-defined `return_type` #310
- `Relay::Mutation#resolve` receives the `root_value` passed to `Schema#execute` #301
- Derived `Relay` objects have descriptions #303

### Bug fixes

- Introspection query is 7 levels deep instead of 3 #308
- Unknown variable types cause validation errors, not runtime errors #310
- `Query::Arguments` doesn't wrap hashes from parsed scalars (fix for user-defined "JSONScalar") #304

## 0.19.2 (6 Oct 2016)

### New features

- If a list entry has a `GraphQL::ExecutionError`, replace the entry with `nil` and return the error #295

### Bug fixes

- Support graphql-batch rescuing `InvalidNullError`s #296
- Schema printer prints Enum names, not Ruby values for enums #297

## 0.19.1 (4 Oct 2016)

### Breaking changes

- Previously-deprecated `InterfaceType#resolve_type` hook has been removed, use `Schema#resolve_type` instead #290

### New features

- Eager-load schemas at definition time, validating types & schema-level hooks #289
- `InvalidNullError`s contain the type & field name that returned null #293
- If an object is resolved with `Schema#resolve_type` and the resulting type is not a member of the expected possible types, raise an error #291

### Bug fixes

- Allow `directive` as field or argument name #288

## 0.19.0 (30 Sep 2016)

### Breaking changes

- `GraphQL::Relay::GlobalNodeIdentification` was removed. Its features were moved to `GraphQL::Schema` or `GraphQL::Relay::Node`. The new hooks support more robust & flexible global IDs. #243

  - Relay's `"Node"` interface and `node(id: "...")` field were both moved to `GraphQL::Relay::Node`. To use them in your schema, call `.field` and `.interface`. For example:

    ```ruby
    # Adding a Relay-compliant `node` field:
    field :node, GraphQL::Relay::Node.field
    ```

    ```ruby
    # This object type implements Relay's `Node` interface:
    interfaces [GraphQL::Relay::Node.interface]
    ```

  - UUID hooks were renamed and moved to `GraphQL::Schema`. You should define `id_from_object` and `object_from_id` in your `Schema.define { ... }` block. For example:

    ```ruby
    MySchema = GraphQL::Schema.define do
      # Fetch an object by UUID
      object_from_id ->(id, ctx) {
        MyApp::RelayLookup.find(id)
      }
      # Generate a UUID for this object
      id_from_object ->(obj, type_defn, ctx) {
        MyApp::RelayLookup.to_id(obj)
      }
    end
    ```

  - The new hooks have no default implementation. To use the previous default, use `GraphQL::Schema::UniqueWithinType`, for example:

      ```ruby
      MySchema = GraphQL::Schema.define do
        object_from_id ->(id, ctx) {
          # Break the id into its parts:
          type_name, object_id = GraphQL::Schema::UniqueWithinType.decode(id)
          # Fetch the identified object
          # ...
        }

        id_from_object ->(obj, type_defn, ctx) {
          # Provide the type name & the object's `id`:
          GraphQL::Schema::UniqueWithinType.encode(type_defn.name, obj.id)
        }
      end
      ```

      If you were using a custom `id_separator`, it's now accepted as an input to `UniqueWithinType`'s  methods, as `separator:`. For example:

      ```ruby
      # use "---" as a ID separator
      GraphQL::Schema::UniqueWithinType.encode(type_name, object_id, separator: "---")
      GraphQL::Schema::UniqueWithinType.decode(relay_id, separator: "---")
      ```

  - `type_from_object` was previously deprecated and has been replaced by `Schema#resolve_type`. You should define this hook in your schema to return a type definition for a given object:

    ```ruby
    MySchema = GraphQL::Schema.define do
      # ...
      resolve_type ->(obj, ctx) {
        # based on `obj` and `ctx`,
        # figure out which GraphQL type to use
        # and return the type
      }
    end
    ```

  - `Schema#node_identification` has been removed.

- `Argument` default values have been changed to be consistent with `InputObjectType` default values. #267

  Previously, arguments expected GraphQL values as `default_value`s. Now, they expect application values.   (`InputObjectType`s always worked this way.)

  Consider an enum like this one, where custom values are provided:

  ```ruby
  PowerStateEnum = GraphQL::EnumType.define do
    name "PowerState"
    value("ON", value: 1)
    value("OFF", value: 0)
  end
  ```

  __Previously__, enum _names_ were provided as default values, for example:

  ```ruby
  field :setPowerState, PowerStateEnum do
    # Previously, the string name went here:
    argument :newValue, default_value: "ON"
  end
  ```

  __Now__, enum _values_ are provided as default values, for example:

  ```ruby
  field :setPowerState, PowerStateEnum do
    # Now, use the application value as `default_value`:
    argument :newValue, default_value: 1
  end
  ```

  Note that if you __don't have custom values__, then there's no change, because the name and value are the same.

  Here are types that are affected by this change:

  - Custom scalars (previously, the `default_value` was a string, now it should be the application value, eg `Date` or `BigDecimal`)
  - Enums with custom `value:`s (previously, the `default_value` was the name, now it's the value)

  If you can't replace `default_value`s, you can also use a type's `#coerce_input` method to translate a GraphQL value into an application value. For example:

  ```ruby
  # Using a custom scalar, "Date"
  # PREVIOUSLY, provide a string:
  argument :starts_on, DateType, default_value: "2016-01-01"
  # NOW, transform the string into a Date:
  argument :starts_on, DateType, default_value: DateType.coerce_input("2016-01-01")
  ```

### New features

- Support `@deprecated` in the Schema language #275
- Support `directive` definitions in the Schema language  #280
- Use the same introspection field descriptions as `graphql-js` #284

### Bug fixes

- Operation name is no longer present in execution error `"path"` values #276
- Default values are correctly dumped & reloaded in the Schema language #267

## 0.18.15 (20 Sep 2016)

### Breaking changes

- Validation errors no longer have a `"path"` key in their JSON. It was renamed to `"fields"` #264
- `@skip` and `@include` over multiple selections are handled according to the spec: if the same field is selected multiple times and _one or more_ of them would be included, the field will be present in the response. Previously, if _one or more_ of them would be skipped, it was absent from the response. #256

### New features

- Execution errors include a `"path"` key which points to the field in the response where the error occurred. #259
- Parsing directives from the Schema language is now supported #273

### Bug fixes

- `@skip` and `@include` over multiple selections are now handled according to the spec #256

## 0.18.14 (20 Sep 2016)

### Breaking changes

- Directives are no longer considered as "conflicts" in query validation. This is in conformity with the spec, but a change for graphql-ruby #263

### Features

- Query analyzers may emit errors by raising `GraphQL::AnalysisError`s during `#call` or returning a single error or an array of errors from `#final_value` #262

### Bug fixes

- Merge fields even when `@skip` / `@include` are not identical #263
- Fix possible infinite loop in `FieldsWillMerge` validation #261

## 0.18.13 (19 Sep 2016)

### Bug fixes

- Find infinite loops in nested contexts, too #258

## 0.18.12 (19 Sep 2016)

### New features

- `GraphQL::Analysis::FieldUsage` can be used to check for deprecated fields in the query analysis phase #245

### Bug fixes

- If a schema receives a query on `mutation` or `subscription` but that root doesn't exist, return a validation error #254
- `Query::Arguments#to_h` only includes keys that were provided in the query or have a default value #251

## 0.18.11 (11 Sep 2016)

### New features

- `GraphQL::Language::Nodes::Document#slice(operation_name)` finds that operation and its dependencies and puts them in a new `Document` #241

### Bug fixes

- Validation errors for non-existent fields have the location of the field usage, not the parent field #247
- Properly `require "forwardable"` #242
- Remove `ALLOWED_CONSTANTS` for boolean input, use a plain comparison #240

## 0.18.10 (9 Sep 2016)

### New features

- Assign `#mutation` on objects which are derived from a `Relay::Mutation` #239

## 0.18.9 (6 Sep 2016)

### Bug fixes

- fix backward compatibility for `type_from_object` #238

## 0.18.8 (6 Sep 2016)

### New features

- AST nodes now respond to `#eql?(other)` to test value equality #231

### Bug fixes

- The `connection` helper no longer adds a duplicate field #235

## 0.18.7 (6 Sep 2016)

### New features

- Support parsing nameless fragments (but not executing them) #232

### Bug fixes

- Allow `__type(name: "Whatever")` to return null, as per the spec #233
- Include a Relay mutation's description with a mutation field #225

## 0.18.6 (29 Aug 2016)

### New features

- ` GraphQL::Schema::Loader.load(schema_json)` turns an introspection result into a `GraphQL::Schema` #207
- `.define` accepts plural definitions for: object fields, interface fields field arguments, enum values #222

## 0.18.5 (27 Aug 2016)

### Deprecations

- `Schema.new` is deprecated; use `Schema.define` instead.

  Before:

  ```ruby
  schema = GraphQL::Schema.new(
    query: QueryType,
    mutation: MutationType,
    max_complexity: 100,
    types: [ExtraType, OtherType]
  )
  schema.node_identification = MyGlobalID
  schema.rescue_from(ActiveRecord::RecordNotFound) { |err| "..." }
  ```

  After:

  ```ruby
  schema = GraphQL::Schema.define do
    query QueryType
    mutation MutationType
    max_complexity 100
    node_identification MyGlobalID
    rescue_from(ActiveRecord::RecordNotFound) { |err| "..." }
    # Types was renamed to `orphan_types` to avoid conflict with the `types` helper
    orphan_types [ExtraType, OtherType]
  end
  ```

  This unifies the disparate methods of configuring a schema and provides new, more flexible design space. It also adds `#metadata` to schemas for user-defined storage.

- `UnionType#resolve_type`, `InterfaceType#resolve_type`, and `GlobalNodeIdentification#type_from_object` are deprecated, unify them into `Schema#resolve_type` instead.

  Before:

  ```ruby
  GraphQL::Relay::GlobalNodeIdentification.define do
    type_from_object ->(obj) { ... }
  end

  GraphQL::InterfaceType.define do
    resolve_type ->(obj, ctx) { ... }
  end
  ```

  After:

  ```ruby
  GraphQL::Schema.define do
    resolve_type ->(obj, ctx) { ... }
  end
  ```

  This simplifies type inference and prevents unexpected behavior when different parts of the schema resolve types differently.

### New features

- Include expected type in Argument errors #221
- Define schemas with `Schema.define` #208
- Define a global object-to-type function with `Schema#resolve_type` #216

### Bug fixes

## 0.18.4 (25 Aug 2016)

### New features

- `InvalidNullError`s expose a proper `#message` #217

### Bug fixes

- Return an empty result for queries with no operations #219

## 0.18.3 (22 Aug 2016)

### Bug fixes

- `Connection.new(:field)` is optional, not required #215
- 0.18.2 introduced a more restrictive approach to resolving interfaces & unions; revert that approach #212

## 0.18.2 (17 Aug 2016)

### New features

- Connection objects expose the `GraphQL::Field` that created them via `Connection#field` #206

## 0.18.1 (7 Aug 2016)

### Deprecations

- Unify `Relay` naming around `nodes` as the items of a connection:
  - `Relay::BaseConnection.connection_for_nodes` replaces `Relay::BaseConnection.connection_for_items`
  - `Relay::BaseConnection#nodes` replaces `Relay::BaseConnection#object`

### New features

- Connection fields' `.resolve_proc` is an instance of `Relay::ConnectionResolve` #204
- Types, fields and arguments can store arbitrary values in their `metadata` hashes #203

## 0.18.0 (4 Aug 2016)

### Breaking changes

- `graphql-relay` has been merged with `graphql`, you should remove `graphql-relay` from your gemfile. #195

### Deprecations

### New features

- `GraphQL.parse` can turn schema definitions into a `GraphQL::Language::Nodes::Document`. The document can be stringified again with `Document#to_query_string` #191
- Validation errors include a `path` to the part of the query where the error was found #198
- `.define` also accepts keywords for each helper method, eg `GraphQL::ObjectType.define(name: "PostType", ...)`

### Bug fixes

- `global_id_field`s have default complexity of 1, not `nil`
- Relay `pageInfo` is correct for connections limited by `max_page_size`
- Rescue invalid variable errors & missing operation name errors during query analysis

## 0.17.2 (26 Jul 2016)

### Bug fixes

- Correctly spread fragments when nested inside other fragments #194

## 0.17.1 (26 Jul 2016)

### Bug fixes

- Fix `InternalRepresentation::Node#inspect`

## 0.17.0 (21 Jul 2016)

### Breaking changes

- `InternalRepresentation::Node` API changes:

  - `#definition_name` returns the field name on field nodes (while `#name` may have an alias)
  - `#definitions` returns `{type => field}` pairs for possible fields on this node
  - `#definition` is gone, it is equivalent to `node.definitions.values.first`
  - `#on_types` is gone, it is equivalent to `node.definitions.keys`

### New features

- Accept `hash_key:` field option
- Call `.define { }` block lazily, so `-> { }` is not needed for circular references #182

### Bug fixes

- Support `on` as an Enum value
- If the same field is requested on multiple types, choose the maximum complexity among them (not the first)

## 0.16.1 (20 Jul 2016)

### Bug fixes

- Fix merging fragments on Union types (see #190, broken from #180)

## 0.16.0 (14 Jul 2016)

### Breaking changes & deprecations

- I don't _know_ that this breaks anything, but  `GraphQL::Query::SerialExecution` now iterates over a tree of `GraphQL::InternalRepresentation::Node`s instead of an AST (`GraphQL::Language::Nodes::Document`).

### New features

- Query context keys can be assigned with `Context#[]=` #178
- Cancel further field resolution with `TimeoutMiddleware` #179
- Add `GraphQL::InternalRepresentation` for normalizing queries from AST #180
- Analyze the query before running it #180
- Assign complexity cost to fields, enforce max complexity before running it #180
- Log max complexity or max depth with `MaxComplexity` or `MaxDepth` analyzers #180
- Query context exposes `#irep_node`, the internal representation of the current node #180

### Bug fixes

- Non-null errors are propagated to the next nullable field, all the way up to `data` #174

## 0.15.3 (28 Jun 2016)

### New features

- `EnumValue`s can receive their properties after instantiation #171

## 0.15.2 (16 Jun 2016)

### New features

- Support lazy type arguments in Object's `interfaces` and Union's `possible_types` #169

### Bug fixes

- Support single-member Unions, as per the spec #170

## 0.15.1 (15 Jun 2016)

### Bug fixes

- Whitelist operation types in `lexer.rb`

## 0.15.0 (11 Jun 2016)

### Breaking changes & deprecations

- Remove `debug:` option, propagate all errors. #161

## 0.14.1 (11 Jun 2016)

### Breaking changes & deprecations

- `debug:` is deprecated (#165). Propagating errors (`debug: true`) will become the default behavior. You can get a similar implementation of error gobbling with `CatchallMiddleware`. Add it to your schema:

    ```ruby
    MySchema.middleware << GraphQL::Schema::CatchallMiddleware
    ```

### New features

### Bug fixes

- Restore previous introspection fields on DirectiveType as deprecated #164
- Apply coercion to input default values #162
- Proper Enum behavior when a value isn't found

## 0.14.0 (31 May 2016)

### Breaking changes & deprecations

### New features

- `GraphQL::Language::Nodes::Document#to_query_string` will re-serialize a query AST #151
- Accept `root_value:` when running a query #157
- Accept a `GraphQL::Language::Nodes::Document` to `Query.new` (this allows you to cache parsed queries on the server) #152

### Bug fixes

- Improved parse error messages #149
- Improved build-time validation #150
- Raise a meaningful error when a Union or Interface can't be resolved during query execution #155

## 0.13.0 (29 Apr 2016)

### Breaking changes & deprecations

- "Dangling" object types are not loaded into the schema. The must be passed in `GraphQL::Schema.new(types: [...])`. (This was deprecated in 0.12.1)

### New features

- Update directive introspection to new spec #121
- Improved schema validation errors #113
- 20x faster parsing #119
- Support inline fragments without type condition #123
- Support multiple schemas composed of the same types #142
- Accept argument `description` and `default_value` in the block #138
- Middlewares can send _new_ arguments to subsequent middlewares #129

### Bug fixes

- Don't leak details of internal errors #120
- Default query `context` to `{}` #133
- Fixed list nullability validation #131
- Ensure field names are strings #128
- Fix `@skip` and `@include` implementation #124
- Interface membership is not shared between schemas #142

## 0.12.1 (26 Apr 2016)

### Breaking changes & deprecations

- __Connecting object types to the schema _only_ via interfaces is deprecated.__ It will be unsupported in the next version of `graphql`.

  Sometimes, object type is only connected to the Query (or Mutation) root by being a member of an interface. In these cases, bugs happen, especially with Rails development mode. (And sometimes, the bugs don't appear until you deploy to a production environment!)

  So, in a case like this:

  ```ruby
  HatInterface = GraphQL::ObjectType.define do
    # ...
  end

  FezType = GraphQL::ObjectType.define do
    # ...
    interfaces [HatInterface]
  end

  QueryType = GraphQL::ObjectType.define do
    field :randomHat, HatInterface # ...
  end
  ```

  `FezType` can only be discovered by `QueryType` _through_ `HatInterface`. If `fez_type.rb` hasn't been loaded by Rails, `HatInterface.possible_types` will be empty!

  Now, `FezType` must be passed to the schema explicitly:

  ```ruby
  Schema.new(
    # ...
    types: [FezType]
  )
  ```

  Since the type is passed directly to the schema, it will be loaded right away!

### New features

### Bug fixes

## 0.12.0 (20 Mar 2016)

### Breaking changes & deprecations

- `GraphQL::DefinitionConfig` was replaced by `GraphQL::Define` #116
- Many scalar types are more picky about which inputs they allow (#115). To get the previous behavior, add this to your program:

  ```ruby
  # Previous coerce behavior for scalars:
  GraphQL::BOOLEAN_TYPE.coerce = ->(value) { !!value }
  GraphQL::ID_TYPE.coerce = ->(value) { value.to_s }
  GraphQL::STRING_TYPE.coerce = ->(value) { value.to_s }
  # INT_TYPE and FLOAT_TYPE were unchanged
  ```

- `GraphQL::Field`s can't be renamed because `#resolve` may depend on that name. (This was only a problem if you pass the _same_ `GraphQL::Field` instance to `field ... field:` definitions.)
- `GraphQL::Query::DEFAULT_RESOLVE` was removed. `GraphQL::Field#resolve` handles that behavior.

### New features

- Can override `max_depth:` from `Schema#execute`
- Base `GraphQL::Error` for all graphql-related errors

### Bug fixes

- Include `""` for String default values (so it's encoded as a GraphQL string literal)

## 0.11.1 (6 Mar 2016)

### New features

- Schema `max_depth:` option #110
- Improved validation errors for input objects #104
- Interfaces provide field implementations to object types #108

## 0.11.0 (28 Feb 2016)

### Breaking changes & deprecations

- `GraphQL::Query::BaseExecution` was removed, you should probably extend `SerialExecution` instead #96
- `GraphQL::Language::Nodes` members no longer raise if they don't get inputs during `initialize` #92
- `GraphQL.parse` no longer accepts `as:` for parsing partial queries.  #92

### New features

- `Field#property` & `Field#property=` can be used to access & modify the method that will be sent to the underlying object when resolving a field #88
- When defining a field, you can pass a string for as `type`. It will be looked up in the global namespace.
- `Query::Arguments#to_h` unwraps `Arguments` objects recursively
- If you raise `GraphQL::ExecutionError` during field resolution, it will be rescued and the message will be added to the response's `errors` key. #93
- Raise an error when non-null fields are `nil` #94

### Bug fixes

- Accept Rails params as input objects
- Don't get a runtime error when input contains unknown key #100

## 0.10.9 (15 Jan 2016)

### Bug fixes

- Handle re-assignment of `ObjectType#interfaces` #84
- Fix merging queries on interface-typed fields #85

## 0.10.8 (14 Jan 2016)

### Bug fixes

- Fix transform of nested lists #79
- Fix parse & transform of escaped characters #83

## 0.10.7 (22 Dec 2015)

### New features

- Support Rubinius

### Bug fixes

- Coerce values into one-item lists for ListTypes

## 0.10.6 (20 Dec 2015)

### Bug fixes

- Remove leftover `puts`es

## 0.10.5 (19 Dec 2015)

### Bug fixes

- Accept enum value description in definition #71
- Correctly parse empty input objects #75
- Correctly parse arguments preceded by newline
- Find undefined input object keys during static validation

## 0.10.4 (24 Nov 2015)

### New features

- Add `Arguments#to_h` #66

### Bug fixes

- Accept argument description in definition
- Correctly parse empty lists

## 0.10.3 (11 Nov 2015)

### New features

- Support root-level `subscription` type

### Bug fixes

- Require Set for Schema::Printer

## 0.10.2 (10 Nov 2015)

### Bug fixes

- Handle blank strings in queries
- Raise if a field is configured without a proper type #61

## 0.10.1 (22 Oct 2015)

### Bug fixes

- Properly merge fields on fragments within fragments
- Properly delegate enumerable-ish methods on `Arguments` #56
- Fix & refactor literal coersion & validation #53

## 0.10.0 (17 Oct 2015)

### New features

- Scalars can have distinct `coerce_input` and `coerce_result` methods #48
- Operations don't require a name #54

### Bug fixes

- Big refactors and fixes to variables and arguments:
  - Correctly apply argument default values
  - Correctly apply variable default values
  - Raise at execution-time if non-null variables are missing
  - Incoming values are coerced to their proper types before execution

## 0.9.5 (1 Oct 2015)

### New features

- Add `Schema#middleware` to wrap field access
- Add `RescueMiddleware` to handle errors during field execution
- Add `Schema::Printer` for printing the schema definition #45

### Bug fixes

## 0.9.4 (22 Sept 2015)

### New features

- Fields can return `GraphQL::ExecutionError`s to add errors to the response

### Bug fixes

- Fix resolution of union types in some queries #41

## 0.9.3 (15 Sept 2015)

### New features

- Add `Schema#execute` shorthand for running queries
- Merge identical fields in fragments so they're only resolved once #34
- An error during parsing raises `GraphQL::ParseError`  #33

### Bug fixes

- Find nested input types in `TypeReducer` #35
- Find variable usages inside fragments during static validation

## 0.9.2, 0.9.1 (10 Sept 2015)

### Bug fixes

- remove Celluloid dependency

## 0.9.0 (10 Sept 2015)

### Breaking changes & deprecations

- remove `GraphQL::Query::ParallelExecution` (use [`graphql-parallel`](https://github.com/rmosolgo/graphql-parallel))

## 0.8.1 (10 Sept 2015)

### Breaking changes & deprecations

- `GraphQL::Query::ParallelExecution` has been extracted to [`graphql-parallel`](https://github.com/rmosolgo/graphql-parallel)

## 0.8.0 (4 Sept 2015)

### New features

- Async field resolution with `context.async { ... }`
- Access AST node during resolve with `context.ast_node`

### Bug fixes

- Fix for validating arguments returning up too soon
- Raise if you try to define 2 types with the same name
- Raise if you try to get a type by name but it doesn't exist

## 0.7.1 (27 Aug 2015)

### Bug fixes

- Merge nested results from different fragments instead of using the latest one only

## 0.7.0 (26 Aug 2015)

### Breaking changes & deprecations

- Query keyword argument `params:` was removed, use `variables:` instead.

### Bug fixes

- `@skip` has precedence over `@include`
- Handle when `DEFAULT_RESOVE` returns nil

## 0.6.2 (20 Aug 2015)

### Bug fixes

- Fix whitespace parsing in input objects

## 0.6.1 (16 Aug 2015)

### New features

- Parse UTF-8 characters & escaped characters

### Bug fixes

- Properly parse empty strings
- Fix argument / variable compatibility validation

## 0.6.0 (14 Aug 2015)

### Breaking changes & deprecations

- Deprecate `params` option to `Query#new` in favor of `variables`
- Deprecated `.new { |obj, types, fields, args| }` API was removed (use `.define`)

### New features

- `Query#new` accepts `operation_name` argument
- `InterfaceType` and `UnionType` accept `resolve_type` configs

### Bug fixes

- Gracefully handle blank-string & whitespace-only queries
- Handle lists in variable definitions and arguments
- Handle non-null input types

## 0.5.0 (12 Aug 2015)

### Breaking changes & deprecations

- Deprecate definition API that yielded a bunch of helpers #18

### New features

- Add new definition API #18
