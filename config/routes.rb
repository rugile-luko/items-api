Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace 'api' do
    namespace 'v1' do
      resources :products, only: %i[index show create update destroy]
      resources :users, only: [:create]
    end
  end
end
