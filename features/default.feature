Feature: default values
  As a application creator
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
