Rails.application.routes.draw do
  use_doorkeeper
  root 'orgs#index'
  get 'api-docs', to: 'api_docs#index'
  scope 'ims' do
    scope 'oneroster' do
      namespace 'v1p1' do
        root 'orgs#index'
        resources 'academicSessions', param: :sourcedId, controller: 'academic_sessions', only: [:index, :show]
        resources 'courses', param: :sourcedId, only: [:index, :show, :create, :update, :destroy]
        resources 'enrollments', param: :sourcedId, only: [:index, :show, :create, :update, :destroy]
        resources 'orgs', param: :sourcedId, only: [:index, :show]
        resources 'classes', param: :sourcedId, controller: 'rclasses', only: [:index, :show, :create, :update, :destroy]
        resources 'users', param: :sourcedId, only: [:index, :show]
        get 'terms(/:sourcedId)', to: 'academic_sessions#term'
        get 'terms/:termSourcedId/classes', to: 'rclasses#term'
        get 'schools/:orgSourcedId/courses', to: 'courses#school'
        get 'schools(/:sourcedId)', to: 'orgs#schools'
        get 'students(/:sourcedId)', to: 'users#students'
        get 'teachers(/:sourcedId)', to: 'users#teachers'
        get 'classes/:classSourcedId/students', to: 'users#students_in_class'
        get 'classes/:classSourcedId/teachers', to: 'users#teachers_in_class'
      end
    end
  end
end
