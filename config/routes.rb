Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :session, only: [:create, :destroy]
      resources :passwords, param: :token, only: [:new, :create, :edit, :update]
      resources :bed_types
      resources :beds
      resources :companies
      resources :company_types
      resources :states
      resources :cities
      resources :users
      resources :roles
      resources :medical_records
      resources :notifications do
        member do
          patch :mark_as_read
        end
      end
      resources :exam_types
      resources :consultation_types
      resources :exams
      resources :consultations
      resources :hospitalizations
      resources :prescriptions
    end
  end
end
