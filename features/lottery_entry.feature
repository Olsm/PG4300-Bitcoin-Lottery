Feature: Lottery Entry
  Users must be able to view and enter the current lottery
  For entry the user must send minimum amount to the pool
  Chance of winning should be determined from the transaction amount.

  Scenario: Pay for lottery entry
    Given I am in the homepage
     And see A lottery I can join
     When I send payment to the lottery pool?s address
      And payment amount is the minimum entry amount
     Then I expect to have an entry for the lottery
      And my chance to win to be based on how much I paid

