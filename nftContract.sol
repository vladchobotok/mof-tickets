// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);


    function mint(address to, uint256 tokenId, string memory _tokenURI) external;

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;
}

interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

interface IERC721Metadata is IERC721 {
    /**
     * @dev Returns the token collection name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI(uint256 tokenId) external view returns (string memory);
    
    function currentTokenAmount() external view returns (uint);
    
    function contractOwner() external view returns (address);
}

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) private pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _setOwner(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

library Strings {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}

abstract contract ERC165 is IERC165 {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}

contract ERC721 is Context, ERC165, IERC721, IERC721Metadata, Ownable{
    using Address for address;
    using Strings for uint256;

    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Token URI
    string private _baseTokenURI;
    
    // Current token ID
    uint private _currentTokenAmount;

    // Mapping from token ID to owner address
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping(address => uint256) private _balances;
    
    // Optional mapping for token URIs
    mapping (uint256 => string) private _tokenURIs;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
     */
    constructor(string memory name_, string memory symbol_, string memory baseTokenURI_) {
        _name = name_;
        _symbol = symbol_;
        _baseTokenURI = baseTokenURI_;
    }

    function contractOwner() public view virtual override returns (address) {
        return owner();
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC721-balanceOf}.
     */
    function balanceOf(address owner) public view virtual override returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");
        return _balances[owner];
    }

    /**
     * @dev See {IERC721-ownerOf}.
     */
    function ownerOf(uint256 tokenId) public view virtual override returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }
    
    function currentTokenAmount() public view virtual override returns (uint) {
        return _currentTokenAmount;
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
     * by default, can be overriden in child contracts.
     */
    function _baseURI() internal view virtual returns (string memory) {
        return _baseTokenURI;
    }
    
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        
        string memory _tokenURI = _tokenURIs[tokenId];
        string memory baseURI = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(baseURI).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(baseURI, _tokenURI));
        }
        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(baseURI, tokenId.toString()));
        
    }
    /**
     * @dev See {IERC721-approve}.
     */
    function approve(address to, uint256 tokenId) public virtual override {
        address owner = ERC721.ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(
            _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _approve(to, tokenId);
    }

    /**
     * @dev See {IERC721-getApproved}.
     */
    function getApproved(uint256 tokenId) public view virtual override returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev See {IERC721-setApprovalForAll}.
     */
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(operator != _msgSender(), "ERC721: approve to caller");

        _operatorApprovals[_msgSender()][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }

    /**
     * @dev See {IERC721-isApprovedForAll}.
     */
    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev See {IERC721-transferFrom}.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _transfer(from, to, tokenId);
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public virtual override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransfer(from, to, tokenId, _data);
    }

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * `_data` is additional data, it has no specified format and it is sent in call to `to`.
     *
     * This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.
     * implement alternative mechanisms to perform token transfer, such as signature-based.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeTransfer(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal virtual {
        _transfer(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Returns whether `tokenId` exists.
     *
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     *
     * Tokens start existing when they are minted (`_mint`),
     * and stop existing when they are burned (`_burn`).
     */
    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return _owners[tokenId] != address(0);
    }

    /**
     * @dev Returns whether `spender` is allowed to manage `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ERC721.ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Safely mints `tokenId` and transfers it to `to`.
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeMint(address to, uint256 tokenId, string memory tokenURI_) internal virtual {
        _safeMint(to, tokenId, tokenURI_, "");
    }

    /**
     * @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`], with an additional `data` parameter which is
     * forwarded in {IERC721Receiver-onERC721Received} to contract recipients.
     */
    function _safeMint(
        address to,
        uint256 tokenId,
        string memory tokenURI_,
        bytes memory _data
    ) internal virtual {
        _mint(to, tokenId, tokenURI_);
        require(
            _checkOnERC721Received(address(0), to, tokenId, _data),
            "ERC721: transfer to non ERC721Receiver implementer"
        );
    }

    /**
     * @dev Mints `tokenId` and transfers it to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - `to` cannot be the zero address.
     *
     * Emits a {Transfer} event.
     */
    function _mint(address to, uint256 tokenId, string memory tokenURI_) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");
            
        _beforeTokenTransfer(address(0), to, tokenId);

        _balances[to] += 1;
        _owners[tokenId] = to;
        
        _setTokenURI(tokenId, tokenURI_);
        
        _currentTokenAmount +=1;
        
        emit Transfer(address(0), to, tokenId);
    }

    function mint(address to, uint256 tokenId, string memory tokenURI_) onlyOwner public override virtual {
      _mint(to, tokenId, tokenURI_);
    }

    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     *
     * Emits a {Transfer} event.
     */
    function _burn(uint256 tokenId) internal virtual {
        address owner = ERC721.ownerOf(tokenId);

        _beforeTokenTransfer(owner, address(0), tokenId);

        // Clear approvals
        _approve(address(0), tokenId);

        _balances[owner] -= 1;
        delete _owners[tokenId];

        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Transfers `tokenId` from `from` to `to`.
     *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     *
     * Emits a {Transfer} event.
     */
    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        require(ERC721.ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _beforeTokenTransfer(from, to, tokenId);

        // Clear approvals from the previous owner
        _approve(address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Approve `to` to operate on `tokenId`
     *
     * Emits a {Approval} event.
     */
    function _approve(address to, uint256 tokenId) internal virtual {
        _tokenApprovals[tokenId] = to;
        emit Approval(ERC721.ownerOf(tokenId), to, tokenId);
    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) private returns (bool) {
        if (to.isContract()) {
            try IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, _data) returns (bytes4 retval) {
                return retval == IERC721Receiver(to).onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert("ERC721: transfer to non ERC721Receiver implementer");
                } else {
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    }

    /**
     * @dev Hook that is called before any token transfer. This includes minting
     * and burning.
     *
     * Calling conditions:
     *
     * - When `from` and `to` are both non-zero, ``from``'s `tokenId` will be
     * transferred to `to`.
     * - When `from` is zero, `tokenId` will be minted for `to`.
     * - When `to` is zero, ``from``'s `tokenId` will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {}
}

library ConsumerTicketInfo {
    struct consumerTicketInfo {
        string ticketName;
        int ticketPrice;
    }
}

interface IEventsManagment {
    function getPriceOfExactTicket(address _eventContractAddress, string memory _ticketName) external returns (int);
    
    function getPriceOfAllTickets(address _eventContractAddress) external returns (ConsumerTicketInfo.consumerTicketInfo[] memory);
    
    function getTicketNamebyTicketId(address _eventContractAddress, uint8 _ticketId) external view returns (string memory);
    
    function getTicketIdbyTicketName (address _eventContractAddress,string memory _ticketName) external view returns (uint8);
    
    function getTicketURIbyTicketName(address _eventContractAddress, string memory _ticketName) external view returns (string memory);

    function getEventName (address _eventContractAddress) external view returns (string memory);

    function getEventDescription (address _eventContractAddress) external view returns (string memory);

    function getEventDates (address _eventContractAddress) external view returns (string memory);

    function getEventPlace (address _eventContractAddress) external view returns (string memory);

    function getTicketAmount (address _eventContractAddress, string memory _ticketName) external view returns (uint8);

    function getNftCollectionAddress (address _eventContractAddress) external view returns (address);

    function getEventStatus (address _eventContractAddress) external view returns (bool);
    
    function contractOwner() external view returns (address);
}

interface IConsumerEvent {
   function buyTicket (address eventContractAddress, string memory _ticketName, string memory _userName) external payable returns (uint256);

   function getPriceList(address _eventContractAddress) external view returns (ConsumerTicketInfo.consumerTicketInfo[] memory);
   
   function getPriceByTicketName (address _eventContractAddress, string memory _ticketName) external view returns (int);
}

interface AggregatorV3Interface {

  function decimals()
    external
    view
    returns (
      uint8
    );

  function description()
    external
    view
    returns (
      string memory
    );

  function version()
    external
    view
    returns (
      uint256
    );

  // getRoundData and latestRoundData should both raise "No data present"
  // if they do not have data to report, instead of returning unset values
  // which could be misinterpreted as actual reported values.
  function getRoundData(
    uint80 _roundId
  )
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

}

contract PriceConsumerV3 {

   AggregatorV3Interface internal priceFeed;

   /**
    * Network: Rinkeby Testnet
    * Aggregator: ETH/USD
    * Address: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
    */
   constructor() {
       priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
   }

   /**
    * Returns the latest price
    */
   function getThePrice() public view returns (int) {
       (
           uint80 roundID,
           int price,
           uint startedAt,
           uint timeStamp,
           uint80 answeredInRound
       ) = priceFeed.latestRoundData();
       return price;
   }
}

contract ConsumerEvent is Ownable, IConsumerEvent {
    
    address public ManagmentAddress;
    address public nftCollection;
    address payable private receiver;
    EventsManagment private eventsManagment;
    ConsumerTicketInfo.consumerTicketInfo[] private priceList;
    
    struct boughtTickets {
        string boughtTicketName;
        uint8 numberOfBoughtTickets;
    }
    
    mapping (string => uint8) private ticketsSold;
    mapping (address => string) private userNames;
    mapping (string => address) private userAddresses;
    mapping (address => mapping(address => boughtTickets[])) private boughtTicketsBase;

    constructor (address _ManagmentAddress, address _nftCollection) {
      ManagmentAddress = _ManagmentAddress;
      nftCollection = _nftCollection;
      eventsManagment = EventsManagment(_ManagmentAddress);
    //   receiver = payable(owner());
    }
    
    // Administrative functions

    function updateReceiverAddress (address payable _receiver) public {
      require(IEventsManagment(ManagmentAddress).contractOwner() == msg.sender, "Caller is not owner");
      receiver = _receiver;
    }

    function updateEventsManagmentAddress (address _ManagmentAddress) public {
      require(IEventsManagment(ManagmentAddress).contractOwner() == msg.sender, "Caller is not owner");
      ManagmentAddress = _ManagmentAddress;
    }

    function updateNftCollectionAddress (address _nftCollection) public {
      require(IEventsManagment(ManagmentAddress).contractOwner() == msg.sender, "Caller is not owner");
      nftCollection = _nftCollection;
    }
    
    function getContractBalance() public view returns(uint) {
        require(IEventsManagment(ManagmentAddress).contractOwner() == msg.sender, "Caller is not owner");
        return address(this).balance;
    }

    // function withdrawEther(uint value) public {
    //   require(IEventsManagment(ManagmentAddress).contractOwner() == msg.sender, "Caller is not owner");
    //   receiver.transfer(value);
    // }

    function withdrawEtherTo(address payable _to, uint value) public {
        require(IEventsManagment(ManagmentAddress).contractOwner() == msg.sender, "Caller is not owner");
        _to.transfer(value);
    }

    // Consumer's functions
    function getPriceList (address _eventContractAddress) public view override returns (ConsumerTicketInfo.consumerTicketInfo[] memory) {
      return eventsManagment.getPriceOfAllTickets(_eventContractAddress);
    }
    
    function getPriceByTicketName (address _eventContractAddress, string memory _ticketName) public view override returns (int) {
      int price = eventsManagment.getPriceOfExactTicket(_eventContractAddress, _ticketName);
      return price;
    }

    function buyTicket (address _eventContractAddress, string memory _ticketName, string memory _userName) public override payable returns (uint256) {
      int price = IEventsManagment(ManagmentAddress).getPriceOfExactTicket(_eventContractAddress, _ticketName);
      uint8 tickets = IEventsManagment(ManagmentAddress).getTicketAmount(_eventContractAddress, _ticketName);
      int priceMore = price * 105 / 100;
      int priceLess = price * 95 / 100;
        
      require(msg.sender != address(0), "Address can not be empty");
      require(int(msg.value) <= priceMore, "Amount is not correct");
      require(int(msg.value) >= priceLess, "Amount is not correct");
      require (ticketsSold[_ticketName] < tickets, "All tickets are sold!" );
      ticketsSold[_ticketName]++;
      
      if(boughtTicketsBase[_eventContractAddress][msg.sender].length == 0) {
          boughtTicketsBase[_eventContractAddress][msg.sender].push(boughtTickets(_ticketName, 0));
      }
      for(uint8 i = 0; i < boughtTicketsBase[_eventContractAddress][msg.sender].length; i++) {
          if(keccak256(abi.encodePacked(boughtTicketsBase[_eventContractAddress][msg.sender][i].boughtTicketName)) == keccak256(abi.encodePacked(_ticketName))) {
            boughtTicketsBase[_eventContractAddress][msg.sender][i].numberOfBoughtTickets++;
          } else if (keccak256(abi.encodePacked(boughtTicketsBase[_eventContractAddress][msg.sender][i].boughtTicketName)) != keccak256(abi.encodePacked(_ticketName)) && i == boughtTicketsBase[_eventContractAddress][msg.sender].length - 1){
            boughtTicketsBase[_eventContractAddress][msg.sender].push(boughtTickets(_ticketName, 0));
          }
      }
      
      IERC721(nftCollection).mint(msg.sender, IERC721Metadata(nftCollection).currentTokenAmount() + 1, IEventsManagment(ManagmentAddress).getTicketURIbyTicketName(_eventContractAddress, _ticketName)); 

      userNames[msg.sender] = _userName;
      userAddresses[_userName] = msg.sender;
      
      return IERC721Metadata(nftCollection).currentTokenAmount();
    }

    function mintTicket(address to, uint256 tokenId, string memory tokenURI_) public {
      require(IEventsManagment(ManagmentAddress).contractOwner() == msg.sender, "Caller is not owner");
      IERC721(nftCollection).mint(to, tokenId, tokenURI_); 
    }
    
    function getOwnedTicketsIds (address _walletAddress) public view returns(uint256[] memory) {
        require(_walletAddress != address(0), "Address can not be empty");
        uint256 arrayIndex = 0;
        for(uint256 i = 1; i <= IERC721Metadata(nftCollection).currentTokenAmount(); i++) {
            if(_walletAddress == IERC721(nftCollection).ownerOf(i)) {
                arrayIndex++;
            }
        }
        uint256[] memory userTokenIds = new uint256[](arrayIndex);
        arrayIndex = 0;
        for(uint256 i = 1; i <= IERC721Metadata(nftCollection).currentTokenAmount(); i++) {
            if(_walletAddress == IERC721(nftCollection).ownerOf(i)) {
                userTokenIds[arrayIndex] = i;
                arrayIndex++;
            }
        }
        return userTokenIds;
    }
    
    function getBoughtTickets (address _eventContractAddress, address _walletAddress) public view returns(boughtTickets[] memory) {
      require(_walletAddress != address(0), "Address can not be empty");
      return boughtTicketsBase[_eventContractAddress][_walletAddress];
    }
    
    function getEventAddress () public view returns(address) {
        return eventsManagment.eventAdress();
    }

    // Metadata functions
    function getUserNamebyAddress (address _userAddress) onlyOwner public view returns (string memory) {
      return userNames[_userAddress];
    }
    
    function getUserAddressByName (string memory _userName) onlyOwner public view returns (address) {
      return userAddresses[_userName];
    }
}

contract EventsManagment is Ownable, IEventsManagment {

    int private priceUsdinUahRate = 2700;
    int private priceEthInWei = 10**18;
    
    address public priceConsumerV3Address;
    address public eventAdress;

    struct eventDetails {
        string eventName; // The name of event;
        string eventDescription; // The description of event;
        string eventDates; // Event dates;
        string eventPlace; // Event place;
        bool eventStatus; // Active - 1; Not active - 0;
        address nftCollectionAddress;
    }

    struct ticketDetails {
        uint8 ticketIndex;
        string ticketName;
        int ticketPrice;
        uint8 ticketAmount;
        string ticketURI;
    }

     // Information about all events;
    mapping (address => eventDetails) private Events;

     // Information about all tickets within event;
    mapping (address => ticketDetails[]) private Tickets;
    
    // function to update USD to UAH rate
    function updateUsdinUahRate (int _priceUsdinUahRate) onlyOwner public returns (int) {
      priceUsdinUahRate = _priceUsdinUahRate;
      return priceUsdinUahRate;
    }

    // function to create new event

    function createEvent (
        // bytes32 salt,
        // uint arg,
        string memory _eventName,
        string memory _eventDescription,
        string memory _eventDates,
        string memory _eventPlace,
        bool _eventStatus,
        string memory name,
        string memory symbol,
        string memory baseTokenURI) onlyOwner public {
            // Generate contract addresses via "new" statement

            ERC721 _nftCollectionAddress = new ERC721(name,symbol,baseTokenURI);
            ConsumerEvent eventContractAddress = new ConsumerEvent (address(this), address(_nftCollectionAddress));
            PriceConsumerV3 priceConsumerV3AddressInstance = new PriceConsumerV3();
            priceConsumerV3Address = address(priceConsumerV3AddressInstance);
            eventAdress = address(eventContractAddress);
            _nftCollectionAddress.transferOwnership(eventAdress);

            Events[address(eventContractAddress)].eventName = _eventName;
            Events[address(eventContractAddress)].eventDescription = _eventDescription;
            Events[address(eventContractAddress)].eventDates = _eventDates;
            Events[address(eventContractAddress)].eventPlace = _eventPlace;
            Events[address(eventContractAddress)].eventStatus = _eventStatus;
            Events[address(eventContractAddress)].nftCollectionAddress = address(_nftCollectionAddress);
    }

    // activate o deactivate certain event. Active - 1; Not active - 0;
    function changeEventStatus (address eventContractAddress, bool _eventStatus) onlyOwner public {
        Events[eventContractAddress].eventStatus = _eventStatus;
    }

    // function to add new ticket to certain event.
    // @ticketArray: [[0,"Standard", 1000, 50, "https://gateway.pinata.cloud/ipfs/QmNvXUPVi7ZccmPZnWqy5gQ99Ra9a1AnH32RVTRPP7XoU6"], [1,"Afterparty", 1500, 30, "https://gateway.pinata.cloud/ipfs/QmY2zhnbhksC1EmbNbAojhv5KZKeRAPb9g9FcyeVmJAxD3"], [2, "Vip", 3000, 20, "https://gateway.pinata.cloud/ipfs/QmPC5poiq1EED6AdxHGwDakBiUCf99XvouKoQi4D4z8FKm"]]
    /* Tickets for press:
    BitokBlog: https://gateway.pinata.cloud/ipfs/QmPQTvnohLyr1y7nYsPWNhxnUTCksa67XshFYgPcZDPGm2
    BitsMedia: https://gateway.pinata.cloud/ipfs/QmbmrxK6YH5ZdQoWV5p4TpLnLSfrgg1NxnQnnWtYbEERgq
    Blockchain24: https://gateway.pinata.cloud/ipfs/QmYCs4WL4R3G6vcV9EM6nbeZBBrT91rohST1ZgSmXZvdro
    ForkLog: https://gateway.pinata.cloud/ipfs/QmZiTGvRWwiEeypmzEW8bLspZVRUofwKGj1NzntYBQBrS6
    ForkNews: https://gateway.pinata.cloud/ipfs/QmQmJ7vR4izLUakX8ot21192h4JHvbe9oR33V7Sm5EYJLC
    Incrypted: https://gateway.pinata.cloud/ipfs/QmZXa4wNumYhsPeCjhdu1WGcDP7j3yeezFvvhTurvMRvGP
    Kriptovalyuta: https://gateway.pinata.cloud/ipfs/QmVFAombZXUXPTzPzqMW2YN5kZSdrXzMU24JE2cxjRqboo
    MiningKriptovaluty: https://gateway.pinata.cloud/ipfs/QmRqVKatTF7ZpwSNuG5AuUDp8gfVYuZYeYgTKmGJbj4aZY
    NaChasi: https://gateway.pinata.cloud/ipfs/QmPRXoNeYzmhGEreCMdcEuhKkQEYovdyWLHAfY11QxDcuP
    Prostocoin: https://gateway.pinata.cloud/ipfs/QmcLSaMgwpZR6s4y7a1Q77fz6qPcDxBhYHnZgxoCP8Rk1V
    */
    
    function addTickets(address _eventContractAddress, ticketDetails[] calldata ticketArray) onlyOwner public {
      for (uint8 i = 0; i < ticketArray.length; i++) {
          Tickets[_eventContractAddress].push(ticketDetails(i, ticketArray[i].ticketName, ticketArray[i].ticketPrice, ticketArray[i].ticketAmount, ticketArray[i].ticketURI));
      }
    }

    function getTicketIdbyTicketName(address _eventContractAddress, string memory _ticketName) public view override returns (uint8) {
        uint8 j = 0;
        while (keccak256(abi.encodePacked(Tickets[_eventContractAddress][j].ticketName)) != keccak256(abi.encodePacked(_ticketName))) {j++;} return j;
    }
    
    function getTicketURIbyTicketName(address _eventContractAddress, string memory _ticketName) public view override returns (string memory) {
        return Tickets[_eventContractAddress][getTicketIdbyTicketName(_eventContractAddress, _ticketName)].ticketURI;
    }

    function getPriceOfExactTicket(address _eventContractAddress, string memory _ticketName) public view override returns (int) {
        int priceEthInUSD = PriceConsumerV3(priceConsumerV3Address).getThePrice();
        int priceUAHinWei = priceEthInWei * 10 ** 8 / priceEthInUSD / priceUsdinUahRate * 10 ** 2;
        uint8 index = getTicketIdbyTicketName(_eventContractAddress,_ticketName);
        int price = Tickets[_eventContractAddress][index].ticketPrice * priceUAHinWei;
        return price;
    }
    
    function getPriceOfAllTickets(address _eventContractAddress) public view override returns (ConsumerTicketInfo.consumerTicketInfo[] memory) {
        ConsumerTicketInfo.consumerTicketInfo[] memory cti = new ConsumerTicketInfo.consumerTicketInfo[](Tickets[_eventContractAddress].length);
        for(uint8 i = 0; i < Tickets[_eventContractAddress].length; i++) {
           cti[i] = ConsumerTicketInfo.consumerTicketInfo(Tickets[_eventContractAddress][i].ticketName, getPriceOfExactTicket(_eventContractAddress, Tickets[_eventContractAddress][i].ticketName));
        }
        return cti;
    }
    
    function getTicketNamebyTicketId(address _eventContractAddress, uint8 _ticketId) public view override returns (string memory) {
        return Tickets[_eventContractAddress][_ticketId].ticketName;
    }

  // Metadata functions

    function contractOwner() public view override returns (address) {
        return owner();
    }
    
    function getNftCollectionAddress (address _eventContractAddress) public override view returns (address) {
      return Events[_eventContractAddress].nftCollectionAddress;
    }

    function getEventStatus (address _eventContractAddress) public override view returns (bool) {
      return Events[_eventContractAddress].eventStatus;
    }

    function getEventName (address _eventContractAddress) public override view returns (string memory) {
      return Events[_eventContractAddress].eventName;
    }

    function getEventDescription (address _eventContractAddress) public override view returns (string memory) {
      return Events[_eventContractAddress].eventDescription;
    }

    function getEventDates (address _eventContractAddress) public override view returns (string memory) {
      return Events[_eventContractAddress].eventDates;
    }

    function getEventPlace (address _eventContractAddress) public override view returns (string memory) {
      return Events[_eventContractAddress].eventPlace;
    }

    function getTicketAmount (address _eventContractAddress, string memory _ticketName) public override view returns (uint8) {
      uint8 index = getTicketIdbyTicketName(_eventContractAddress,_ticketName);
      uint8 ticketAmount_ = Tickets[_eventContractAddress][index].ticketAmount;
      return ticketAmount_;
    }
}
