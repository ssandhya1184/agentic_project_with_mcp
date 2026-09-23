Feature: Password validation
  As a user of the password validation service
  I want password inputs to be accepted or rejected according to the documented rules
  So that the validation result is reliable and predictable

  @TC-001
  Scenario: TC-001 accepts exactly 8 valid characters
    Given the common password validation precondition is met
    And the password input is "Aa1bcde@"
    When validate_password is called
    Then the result is exactly True

  @TC-002
  Scenario: TC-002 accepts exactly 20 valid characters
    Given the common password validation precondition is met
    And the password input is "Aa1234567890123456@"
    When validate_password is called
    Then the result is exactly True

  @TC-003
  Scenario: TC-003 rejects 7 characters
    Given the common password validation precondition is met
    And the password input is "Aa1@bcd"
    When validate_password is called
    Then the result is exactly False

  @TC-004
  Scenario: TC-004 rejects 21 characters
    Given the common password validation precondition is met
    And the password input is "Aa12345678901234567@"
    When validate_password is called
    Then the result is exactly False

  @TC-005
  Scenario: TC-005 accepts a typical valid password
    Given the common password validation precondition is met
    And the password input is "SecurePass1@"
    When validate_password is called
    Then the result is exactly True

  @TC-006
  Scenario: TC-006 rejects a password without an uppercase letter
    Given the common password validation precondition is met
    And the password input is "aa1bcde@"
    When validate_password is called
    Then the result is exactly False

  @TC-007
  Scenario: TC-007 rejects a password without a lowercase letter
    Given the common password validation precondition is met
    And the password input is "AA1BCDE@"
    When validate_password is called
    Then the result is exactly False

  @TC-008
  Scenario: TC-008 rejects a password without a digit
    Given the common password validation precondition is met
    And the password input is "Aabcdef@"
    When validate_password is called
    Then the result is exactly False

  @TC-009
  Scenario: TC-009 rejects a password without an allowed special character
    Given the common password validation precondition is met
    And the password input is "Aa1bcdef"
    When validate_password is called
    Then the result is exactly False

  @TC-010
  Scenario: TC-010 accepts each supported special character
    Given the common password validation precondition is met
    And the password inputs are "Aa1bcde@", "Aa1bcde#", "Aa1bcde$", "Aa1bcde%", "Aa1bcde^", "Aa1bcde&", "Aa1bcde*", and "Aa1bcde!"
    When validate_password is called once for each parameterized value
    Then every call returns exactly True

  @TC-011
  Scenario: TC-011 accepts an allowed special character in any position
    Given the common password validation precondition is met
    And the password inputs are "@Aa1bcde", "Aa@1bcde", and "Aa1bcde@"
    When validate_password is called once for each parameterized value
    Then every call returns exactly True

  @TC-012
  Scenario: TC-012 rejects every unsupported ASCII special character
    Given the common password validation precondition is met
    And the password inputs are "Aa1bcde'", "Aa1bcde(", "Aa1bcde)", "Aa1bcde+", "Aa1bcde,", "Aa1bcde-", "Aa1bcde.", "Aa1bcde/", "Aa1bcde:", "Aa1bcde;", "Aa1bcde<", "Aa1bcde=", "Aa1bcde>", "Aa1bcde?", "Aa1bcde[", "Aa1bcde\", "Aa1bcde]", "Aa1bcde_", "Aa1bcde`", "Aa1bcde{", "Aa1bcde|", "Aa1bcde}", and "Aa1bcde~"
    When validate_password is called once for each parameterized value
    Then every call returns exactly False

  @TC-013
  Scenario: TC-013 rejects a password containing allowed and unsupported special characters
    Given the common password validation precondition is met
    And the password input is "Aa1bcd@-"
    When validate_password is called
    Then the result is exactly False

  @TC-014
  Scenario: TC-014 rejects an internal space
    Given the common password validation precondition is met
    And the password input is "Aa1bc de@"
    When validate_password is called
    Then the result is exactly False

  @TC-015
  Scenario: TC-015 rejects a leading or trailing space
    Given the common password validation precondition is met
    And the password inputs are "[space]Aa1bcde@" and "Aa1bcde@[space]"
    When validate_password is called once for each parameterized value
    Then every call returns exactly False

  @TC-016
  Scenario: TC-016 rejects all supported whitespace characters
    Given the common password validation precondition is met
    And the password inputs are "Aa1bc[tab]de@", "Aa1bc[newline]de@", "Aa1bc[carriage return]de@", "Aa1bc[vertical tab]de@", and "Aa1bc[form feed]de@"
    When validate_password is called once for each parameterized value
    Then every call returns exactly False

  @TC-017
  Scenario: TC-017 rejects None without raising an exception
    Given the common password validation precondition is met
    And the password input is None
    When validate_password is called
    Then the result is exactly False
    And no exception is raised

  @TC-018
  Scenario: TC-018 rejects an empty string without raising an exception
    Given the common password validation precondition is met
    And the password input is an empty string
    When validate_password is called
    Then the result is exactly False
    And no exception is raised

  @TC-019
  Scenario: TC-019 rejects non-string scalar values without raising an exception
    Given the common password validation precondition is met
    And the password inputs are 123, 12.5, and True
    When validate_password is called once for each parameterized value
    Then every call returns exactly False
    And no exception is raised for any call

  @TC-020
  Scenario: TC-020 rejects non-string collections and objects without raising an exception
    Given the common password validation precondition is met
    And the password inputs are [], {}, and object()
    When validate_password is called once for each parameterized value
    Then every call returns exactly False
    And no exception is raised for any call

  @TC-021
  Scenario: TC-021 rejects non-ASCII uppercase and lowercase letters
    Given the common password validation precondition is met
    And the password inputs are "Äa1bcde@" and "Aaé1bcd@"
    When validate_password is called once for each parameterized value
    Then every call returns exactly False

  @TC-022
  Scenario: TC-022 rejects a non-ASCII digit
    Given the common password validation precondition is met
    And the password input is "Aa١bcde@"
    When validate_password is called
    Then the result is exactly False

  @TC-023
  Scenario: TC-023 accepts repeated letters, digits, and special characters
    Given the common password validation precondition is met
    And the password input is "AAaa11@@"
    When validate_password is called
    Then the result is exactly True

  @TC-024
  Scenario: TC-024 returns Boolean True for valid input, not another truthy value
    Given the common password validation precondition is met
    And the password input is "Aa1bcde@"
    When the result is stored and asserted to be True
    Then the assertion passes

  @TC-025
  Scenario: TC-025 returns Boolean False for invalid input, not another falsy value
    Given the common password validation precondition is met
    And the password input is "Aa1bcdef"
    When the result is stored and asserted to be False
    Then the assertion passes
