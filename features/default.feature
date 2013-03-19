Feature: default values
  Scenario: single default value
    Given SmartConfig definition
    """
    SmartConfig.new do |config|
      config.key :keyname, :default => 'val'
    end
    """
    When I access "keyname"
    Then I should receive "val"
