# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_postal_code_to_edid_webservice_session',
  :secret      => 'bd6bb5d1948db498617ffd1c8efcd77a9fd780ed73d85fe623d6e1f3327d6d0d55a79b0f2ab56239efb75ad71483200e2cab845698cbb5cdb388208161270208'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
