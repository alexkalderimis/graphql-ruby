# frozen_string_literal: true
require "spec_helper"

describe GraphQL::StaticValidation::VariableUsagesAreAllowed do
  include StaticValidationHelpers

  let(:query_string) {'
    query getCheese(
        $goodInt: Int = 1,
        $okInt: Int!,
        $badInt: Int,
        $badStr: String!,
        $goodAnimals: [DairyAnimal!]!,
        $badAnimals: [DairyAnimal]!,
        $deepAnimals: [[DairyAnimal!]!]!,
        $goodSource: DairyAnimal!,
    ) {
      goodCheese:   cheese(id: $goodInt)  { source }
      okCheese:     cheese(id: $okInt)    { source }
      badCheese:    cheese(id: $badInt)   { source }
      badStrCheese: cheese(id: $badStr)   { source }
      cheese(id: 1) {
        similarCheese(source: $goodAnimals) { source }
        other: similarCheese(source: $badAnimals) { source }
        tooDeep: similarCheese(source: $deepAnimals) { source }
        nullableCheese(source: $goodAnimals) { source }
        deeplyNullableCheese(source: $deepAnimals) { source }
      }

      milk(id: 1) {
        flavors(limit: $okInt)
      }

      searchDairy(product: [{source: $goodSource}]) {
        ... on Cheese { id }
      }
    }
  '}

  it "finds variables used as arguments but don't match the argument's type" do
    assert_equal(4, errors.length)
    expected = [
      {
        "message"=>"Nullability mismatch on variable $badInt and argument id (Int / Int!)",
        "locations"=>[{"line"=>14, "column"=>28}],
        "path"=>["query getCheese", "badCheese", "id"],
        "extensions"=>{"code"=>"variableMismatch", "variableName"=>"badInt", "typeName"=>"Int", "argumentName"=>"id", "errorMessage"=>"Nullability mismatch"}
      },
      {
        "message"=>"Type mismatch on variable $badStr and argument id (String! / Int!)",
        "locations"=>[{"line"=>15, "column"=>28}],
        "path"=>["query getCheese", "badStrCheese", "id"],
        "extensions"=>{"code"=>"variableMismatch", "variableName"=>"badStr", "typeName"=>"String!", "argumentName"=>"id", "errorMessage"=>"Type mismatch"}
      },
      {
        "message"=>"Nullability mismatch on variable $badAnimals and argument source ([DairyAnimal]! / [DairyAnimal!]!)",
        "locations"=>[{"line"=>18, "column"=>30}],
        "path"=>["query getCheese", "cheese", "other", "source"],
        "extensions"=>{"code"=>"variableMismatch", "variableName"=>"badAnimals", "typeName"=>"[DairyAnimal]!", "argumentName"=>"source", "errorMessage"=>"Nullability mismatch"}
      },
      {
        "message"=>"List dimension mismatch on variable $deepAnimals and argument source ([[DairyAnimal!]!]! / [DairyAnimal!]!)",
        "locations"=>[{"line"=>19, "column"=>32}],
        "path"=>["query getCheese", "cheese", "tooDeep", "source"],
        "extensions"=>{"code"=>"variableMismatch", "variableName"=>"deepAnimals", "typeName"=>"[[DairyAnimal!]!]!", "argumentName"=>"source", "errorMessage"=>"List dimension mismatch"}
      }
    ]
    assert_equal(expected, errors)
  end

  describe "input objects that are out of place" do
    let(:query_string) { <<-GRAPHQL
      query getCheese($id: ID!) {
        cheese(id: {blah: $id} ) {
          __typename @nonsense(id: {blah: $id})
          nonsense(id: {blah: {blah: $id}})
        }
      }
    GRAPHQL
    }

    it "adds an error" do
      assert_equal 3, errors.length
      assert_equal "Argument 'id' on Field 'cheese' has an invalid value ({blah: $id}). Expected type 'Int!'.", errors[0]["message"]
    end
  end

  describe "list-type variables" do
    let(:schema) {
      GraphQL::Schema.from_definition <<-GRAPHQL
      input ImageSize {
        height: Int
        width: Int
        scale: Int
      }

      type Query {
        imageUrl(height: Int, width: Int, size: ImageSize, sizes: [ImageSize!]): String!
        sizedImageUrl(sizes: [ImageSize!]!): String!
      }
      GRAPHQL
    }

    describe "nullability mismatch" do
      let(:query_string) {
        <<-GRAPHQL
        # This variable _should_ be [ImageSize!]
        query ($sizes: [ImageSize]) {
          imageUrl(sizes: $sizes)
        }
        GRAPHQL
      }

      it "finds invalid inner definitions" do
        assert_equal 1, errors.size
        expected_message = "Nullability mismatch on variable $sizes and argument sizes ([ImageSize] / [ImageSize!])"
        assert_equal [expected_message], errors.map { |e| e["message"] }
      end
    end

    describe "list dimension mismatch" do
      let(:query_string) {
        <<-GRAPHQL
        query ($sizes: [ImageSize]) {
          imageUrl(sizes: [$sizes])
        }
        GRAPHQL
      }

      it "finds invalid inner definitions" do
        assert_equal 1, errors.size
        expected_message = "List dimension mismatch on variable $sizes and argument sizes ([[ImageSize]]! / [ImageSize!])"
        assert_equal [expected_message], errors.map { |e| e["message"] }
      end
    end

    describe 'list is in the argument' do
      let(:query_string) {
        <<-GRAPHQL
        query ($size: ImageSize!) {
          imageUrl(sizes: [$size])
        }
        GRAPHQL
      }

      it "is a valid query" do
        assert_equal 0, errors.size
      end

      describe "mixed with invalid literals" do
        let(:query_string) {
          <<-GRAPHQL
          query ($size: ImageSize!) {
            imageUrl(sizes: [$size, 1, true])
          }
          GRAPHQL
        }

        it "is an invalid query" do
          assert_equal 1, errors.size
        end
      end

      describe "mixed with invalid variables" do
        let(:query_string) {
          <<-GRAPHQL
          query ($size: ImageSize!, $wrongSize: Boolean!) {
            imageUrl(sizes: [$size, $wrongSize])
          }
          GRAPHQL
        }

        it "is an invalid query" do
          assert_equal 1, errors.size
        end
      end

      describe "mixed with valid literals and invalid variables" do
        let(:query_string) {
          <<-GRAPHQL
          query ($size: ImageSize!, $wrongSize: Boolean!) {
            imageUrl(sizes: [$size, {height: 100} $wrongSize])
          }
          GRAPHQL
        }

        it "is an invalid query" do
          assert_equal 1, errors.size
        end
      end
    end

    describe 'argument contains a list with literal values' do
      let(:query_string) {
        <<-GRAPHQL
        query  {
          imageUrl(sizes: [{height: 100, width: 100, scale: 1}])
        }
        GRAPHQL
      }

      it "is a valid query" do
        assert_equal 0, errors.size
      end
    end

    describe 'argument contains a list with both literal and variable values' do
      let(:query_string) {
        <<-GRAPHQL
        query($size1: ImageSize!, $size2: ImageSize!)  {
          imageUrl(sizes: [{height: 100, width: 100, scale: 1}, $size1, {height: 1920, width: 1080, scale: 2}, $size2])
        }
        GRAPHQL
      }

      it "is a valid query" do
        assert_equal 0, errors.size
      end
    end

    describe "variable in non-null list" do
      let(:query_string) {
        <<-GRAPHQL
        # This should work
        query ($size: ImageSize!) {
          sizedImageUrl(sizes: [$size])
        }
        GRAPHQL
      }

      it "is allowed" do
        assert_equal [], errors
      end
    end

    describe "nullability mismatch in non-null list" do
      let(:query_string) {
        <<-GRAPHQL
        query ($sizes: [ImageSize!]) {
          sizedImageUrl(sizes: $sizes)
        }
        GRAPHQL
      }

      it "gives the right error" do
        err =  "Nullability mismatch on variable $sizes and argument sizes ([ImageSize!] / [ImageSize!]!)"
        assert_equal [err], errors.map { |e| e["message"]}
      end
    end
  end

  describe "for input properties" do
    class InputVariableSchema < GraphQL::Schema
      class Input < GraphQL::Schema::InputObject
        argument(:id, String, required: true)
      end

      class FooMutation < GraphQL::Schema::Mutation
        field(:foo, String, null: true)
        argument(:input, Input, required: true)

        def resolve(input:)
          { foo: input.id }
        end
      end

      class Mutation < GraphQL::Schema::Object
        field(:foo_mutation, mutation: FooMutation)
      end

      mutation(Mutation)
    end

    it "gives a proper error" do
      res1 = InputVariableSchema.execute("mutation($id: String) { fooMutation(input: { id: $id }) { foo } }")
      assert_equal ["Nullability mismatch on variable $id and argument id (String / String!)"], res1["errors"].map { |e| e["message"] }

      res2 = InputVariableSchema.execute("mutation($id: String!) { fooMutation(input: { id: $id }) { foo } }", variables: { id: "abc" })
      refute res2.key?("errors")
      assert_equal "abc", res2["data"]["fooMutation"]["foo"]
    end
  end

  describe "with error limiting" do
    describe("disabled") do
      let(:args) {
        { max_errors: nil }
      }

      it "does not limit the number of errors" do
        assert_equal(error_messages.length, 4)
        assert_equal(error_messages, [
          "Nullability mismatch on variable $badInt and argument id (Int / Int!)",
          "Type mismatch on variable $badStr and argument id (String! / Int!)",
          "Nullability mismatch on variable $badAnimals and argument source ([DairyAnimal]! / [DairyAnimal!]!)",
          "List dimension mismatch on variable $deepAnimals and argument source ([[DairyAnimal!]!]! / [DairyAnimal!]!)"
        ])
      end
    end

    describe("enabled") do
      let(:args) {
        { max_errors: 1 }
      }

      it "does limit the number of errors" do
        assert_equal(error_messages.length, 1)
        assert_equal(error_messages, [
          "Nullability mismatch on variable $badInt and argument id (Int / Int!)"
        ])
      end
    end
  end
end
