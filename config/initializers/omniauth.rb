Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV.fetch('GITHUB_CLIENT_ID', 'Iv1.139dc1f9c190f0c3'), ENV.fetch('GITHUB_CLIENT_SECRET', 'ed0c28995354ebf6425cd564706b934aed25c815'), scope: 'user'
end