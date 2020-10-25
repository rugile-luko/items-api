require 'swagger_helper'

RSpec.describe 'Products API', type: :request do
  path '/api/v1/products' do
    get('list products') do
      tags 'Products'
      consumes 'application/json'
      parameter name: :title, in: :query, type: :string, required: false
      parameter name: :page, in: :query, type: :integer, default: 1, required: false
      produces 'application/json'

      let!(:user) do
        create(:user)
      end
      let!(:products) do
        3.times do
          create(:product, user: user)
        end
      end

      context 'Filtering' do
        response(200, 'Search products by title and get zero') do
          let(:title) { 'Name' }
          it 'Returns 0 products' do
            body = JSON(response.body)
            expect(body['products'].count).to eq(0)
          end
          run_test!
        end

        response(200, 'Search products by title and get three') do
          let(:title) { 'Title' }
          it 'Returns 3 products' do
            body = JSON(response.body)
            expect(body['products'].count).to eq(3)
          end
          run_test!
        end
      end

      response(200, 'No products in page 2') do
        let(:page) { 2 }
        it 'Returns 0 products' do
          body = JSON(response.body)
          expect(body['products'].count).to eq(0)
        end
        run_test!
      end

      response(200, 'Get list of products') do
        it 'Returns 3 products' do
          body = JSON(response.body)
          expect(body['products'].count).to eq(3)
        end
        run_test!
      end
    end

    post('create product') do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: { '$ref' => '#/components/schemas/product' }
      produces 'application/json'

      let!(:user) { create(:user) }

      response(201, 'Create a product') do
        let!(:product) { create(:product, user: user) }
        run_test!
      end

      response(422, 'Not creating product if fields not valid') do
        let(:product) { {} }
        run_test!
      end

    end
  end

  path '/api/v1/products/{id}' do
    get('show products') do
      tags 'Products'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      produces 'application/json'

      let!(:user) { create(:user) }

      response(200, 'Show one product') do
        let(:product) { create(:product, user: user) }
        let(:id) { product.id }
        run_test!
      end

      # response(404, 'Not Found') do
      #   let(:id) { 'invalid' }
      #   run_test!
      # end
    end

    put('update product') do
      tags 'Products'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :product, in: :body, required: true, schema: { '$ref' => '#/components/schemas/product' }
      produces 'application/json'

      let!(:user) { create(:user) }

      response(200, 'Update a product') do
        let(:id) { create(:product, user: user).id }
        let(:product) { { title: 'title1' } }
        run_test!
      end

      # response(404, 'Not Found') do
      #   let(:id) { 'invalid' }
      #   let(:product) { {title: 'hello'} }
      #   run_test!
      # end
    end

    delete('delete product') do
      tags 'Products'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      produces 'application/json'

      let!(:user) { create(:user) }

      response(204, 'Delete a product') do
        let(:id) { create(:product, user: user).id }
        run_test!
      end
    end
  end
end

