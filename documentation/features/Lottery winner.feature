Feature: Lottery Winner
  Users must receive the prize if they win a lottery

  Scenario: Pay for lottery entry
    Given that I have an entry in the lottery
     When my entry is chosen
      And I win the lottery
     Then I expect to receive the prize to my chosen address