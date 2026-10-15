require 'json'
require 'time'
require 'uri'
require 'yaml'

action = YAML.load_file('action.yml')
resolved = {}
action.fetch('runs').fetch('steps').each do |step|
  next unless step.key?('uses')

  reference = step.fetch('uses')
  match = reference.match(%r{\A([\w.-]+/[\w.-]+)@([^\s]+)\z})
  abort "Unsupported action reference: #{reference}" unless match

  package, version = match.captures
  resolved[reference] = {
    package_url: "pkg:githubactions/#{package}@#{URI.encode_www_form_component(version)}",
    relationship: 'direct',
    scope: 'runtime'
  }
end

abort 'No action dependencies found' if resolved.empty?

puts JSON.pretty_generate(
  version: 0,
  sha: ENV.fetch('GITHUB_SHA'),
  ref: ENV.fetch('GITHUB_REF'),
  job: {
    id: "#{ENV.fetch('GITHUB_RUN_ID')}-#{ENV.fetch('GITHUB_RUN_ATTEMPT')}",
    correlator: 'action-setup-env-composite'
  },
  detector: {
    name: 'action-setup-env-composite',
    version: '1.0.0',
    url: 'https://github.com/yetanalytics/action-setup-env'
  },
  scanned: Time.now.utc.iso8601,
  manifests: {
    'action.yml' => {
      name: 'action.yml',
      file: { source_location: 'action.yml' },
      resolved: resolved
    }
  }
)
