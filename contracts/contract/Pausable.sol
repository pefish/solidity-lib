// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;


abstract contract Pausable {
  /**
   * @dev Emitted when the pause is triggered by `account`.
   */
  event Paused(address account);

  /**
   * @dev Emitted when the pause is lifted by `account`.
   */
  event Unpaused(address account);

  bool public paused;
  address public pauseOwner;

  modifier __Pausable_auth () {
    require(msg.sender == pauseOwner, "must be pauseOwner");
    _;
  }

  function __Pausable_init (address _pauseOwner) internal {
    pauseOwner = _pauseOwner;
    paused = false;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is not paused.
   *
   * Requirements:
   *
   * - The contract must not be paused.
   */
  modifier whenNotPaused() {
    require(!paused, "Pausable::whenNotPaused:: paused");
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is paused.
   *
   * Requirements:
   *
   * - The contract must be paused.
   */
  modifier whenPaused() {
    require(paused, "Pausable::whenPaused:: not paused");
    _;
  }

  function pause() external __Pausable_auth {
    _pause();
  }

  /**
   * @dev Triggers stopped state.
   *
   * Requirements:
   *
   * - The contract must not be paused.
   */
  function _pause() internal virtual whenNotPaused {
    paused = true;
    emit Paused(msg.sender);
  }

  function unpause() external __Pausable_auth {
    _unpause();
  }

  /**
   * @dev Returns to normal state.
   *
   * Requirements:
   *
   * - The contract must be paused.
   */
  function _unpause() internal virtual whenPaused {
    paused = false;
    emit Unpaused(msg.sender);
  }
}
