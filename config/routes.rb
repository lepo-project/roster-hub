Rails.application.routes.draw do
  use_doorkeeper
  root 'orgs#index'
  get 'api-docs', to: 'api_docs#index'
  scope 'ims' do
    scope 'oneroster' do
      namespace 'v1p1' do
        root 'orgs#index'
        get 'academicSessions(/:sourcedId)', to: 'academic_sessions#index'
        get 'terms(/:sourcedId)', to: 'academic_sessions#term'
        get 'terms/:termSourcedId/classes', to: 'rclasses#term'
        get 'courses(/:sourcedId)', to: 'courses#index'
        get 'enrollments(/:sourcedId)', to: 'enrollments#index'
        get 'orgs(/:sourcedId)', to: 'orgs#index'
        # get 'schools/:orgSourcedId/courses', to: 'courses#school'
        # get 'schools/:orgSourcedId/classes/:rclassSourcedId/enrollments', to: 'enrollments#school'
        get 'schools(/:sourcedId)', to: 'orgs#schools'
        get 'classes(/:sourcedId)', to: 'rclasses#index'
        get 'users(/:sourcedId)', to: 'users#index'
        get 'students(/:sourcedId)', to: 'users#students'
        get 'teachers(/:sourcedId)', to: 'users#teachers'
      end
    end
  end
end
