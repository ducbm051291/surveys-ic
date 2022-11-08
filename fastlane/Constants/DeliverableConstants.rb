# frozen_string_literal: true

class DeliverableConstants

  ##################
  #### FIREBASE ####
  ##################

  # a gsp files directory
  def self.GSP_DIRECTORY
    './'
  end

  # a gsp file name for staging
  def self.GSP_STAGING
    './Surveys/Configurations/Plists/GoogleService/Staging/GoogleService-Info.plist'
  end

  # a gsp file name for production
  def self.GSP_PRODUCTION
    './Surveys/Configurations/Plists/GoogleService/Production/GoogleService-Info.plist'
  end

  # The path to the upload-symbols file of the Fabric app
  def self.BINARY_PATH
    './Pods/FirebaseCrashlytics/upload-symbols'
  end

  # a firebase app ID for Staging
  def self.FIREBASE_APP_ID_STAGING
    '1:475550343370:ios:c5d267097cb01e469f5433'
  end

  # a firebase app ID for Production
  def self.FIREBASE_APP_ID_PRODUCTION
    '1:475550343370:ios:bd45950724ab58b89f5433'
  end

  # Firebase Tester group name, seperate by comma(,) string
  def self.FIREBASE_TESTER_GROUPS
    "nimble-dev"
  end

  ##################
  ### DEV PORTAL ###
  ##################

  # Apple ID for Apple Developer Portal
  def self.DEV_PORTAL_APPLE_ID
    'duc@nimblehq.co'
  end

  #####################
  ### App Store API ###
  #####################

  # App Store Connect API Key ID
  def self.APP_STORE_KEY_ID
    'MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgt4anH2TRpfzANXi1ZZKhs61Q5lbLeD4qvYz+nbL33aWgCgYIKoZIzj0DAQehRANCAATeS3nWfdW+i4qH+oB7l6da6S4YPiIiyXqaskCRnKU6lkw2zhmY+UhZae3iWorfR6QkLLfqOZpfvd2thOgYp7Xj'
  end

  # App Store Connect API Issuer ID
  def self.APP_STORE_ISSUER_ID
    '69a6de82-b7cb-47e3-e053-5b8c7c11a4d1'
  end

end
