Feature: default values
  As an application creator
  In order to minimize user trouble using app
  I want to define default settings

  Scenario: single default value without config
    Given SmartConfig definition
    """
    SmartConfig.new! do |config|
      config.key :keyname, :default => 'default_value'
    end
    """
    When I access "keyname"
    Then I should receive "default_value"

  Scenario: config overriding default
    Given a file named "config.yml" with:
    """
    keyname: settings_value
    """
    And SmartConfig definition
    """
    SmartConfig.new!('config.yml') do |config|
      config.key :keyname, :default => 'default_value'
    end
    """
    When I access "keyname"
    Then I should receive "settings_value"
