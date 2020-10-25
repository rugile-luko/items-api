# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + '/swagger'

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'PRODUCTS API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          product: {
            type: :object,
            properties: {
              id: { type: :integer },
              created_at: { type: :string },
              updated_at: { type: :string },
              title: { type: :string, example: 'Product Title' },
              description: { type: :text, example: 'Product Description 1' },
              price: { type: :float, example: '32.5' },
              status: { type: :string, example: 'Available' },
              user_id: { type: :string, example: '1' }
            },
            required: %i[title description price status]
          },
          user: {
            type: :object,
            properties: {
              id: { type: :integer },
              created_at: { type: :string },
              updated_at: { type: :string },
              name: { type: :string, example: 'User Name' },
              email: { type: :string, example: 'test@testing.com' }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
  config.swagger_dry_run = false
end
