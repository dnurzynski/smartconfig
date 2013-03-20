Feature: yaml configs
  As an application creator
  In order for user to set it up
  I want to load settings from yaml file

  Scenario: loading data from single yaml
    Given a file named "config.yml" with:
    """
    keyname: settings_value
    """
    And SmartConfig definition
    """
    SmartConfig.new! do |config|
      config.key :keyname
    end
    """
    When I access "keyname"
    Then I should receive "settings_value"
