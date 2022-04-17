// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/IERC721ReceiverUpgradeable.sol";

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

// File: @openzeppelin/contracts/utils/introspection/IERC165.sol


// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
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

// File: @openzeppelin/contracts/utils/introspection/ERC165.sol


// OpenZeppelin Contracts v4.4.1 (utils/introspection/ERC165.sol)

/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 *
 * Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation.
 */
abstract contract ERC165 is IERC165 {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}

// File: @openzeppelin/contracts/token/ERC721/IERC721.sol


// OpenZeppelin Contracts v4.4.1 (token/ERC721/IERC721.sol)

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
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

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
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


contract ApparelMarketplace is Initializable, IERC721ReceiverUpgradeable, UUPSUpgradeable, OwnableUpgradeable {
    
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
    
    using SafeMath for uint256;

    struct NFTDetails{
        address tokenOwner;
        address secondaryOwner;
        IERC721 nftAddress;
        uint256 tokenId;
        uint256 priceMetis;
        uint256 pricePeak;
        uint256 royaltyFee;
        uint256 listedTime;
        uint256 updateTime;
        bool isForSale;
        bool isAlreadyListed;
        mapping(uint256 => Auction) auctionDetail;
    }

    struct Auction{
        uint256 tokenId;
        uint256 startTime;
        uint256 endTime;
        uint256 baseAmount;
        address auctionWinner;
        address[] participatedUser;
        uint256[] bidAmount;
        bool isOutForAuction;
    }

    uint256 public platformFee;

    mapping(address => mapping(uint256 => NFTDetails)) public nftDetails;
    mapping(address => uint256[]) private tokenList;
 
    address[] listedNFTs;

    IERC20 peak;

    // required function for implementing proxy
    function initialize(IERC20 _peak) public initializer {
        peak = _peak;
        platformFee = 200;
        __Ownable_init();
    }

    modifier notListed(address nftAddress, uint256 tokenId){
        require(nftDetails[nftAddress][tokenId].isAlreadyListed == false, "Already listed");
        _;
    }

    modifier isListed(address nftAddress, uint256 tokenId){
        require(nftDetails[nftAddress][tokenId].isAlreadyListed == true, "Not listed");
        _;
    }

    modifier isOutForAuction(address nftAddress, uint256 tokenId){
        require(nftDetails[nftAddress][tokenId].auctionDetail[tokenId].isOutForAuction == true, "Token is not available for auction");
        _;
    }

    modifier isTokenOwner(address nftAddress, uint256 tokenId){
        require(nftDetails[nftAddress][tokenId].secondaryOwner == msg.sender, "Not authorized");
        _;
    }

    function onERC721Received(address, address, uint256, bytes memory) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function setPlatformFees(uint256 _fees) public onlyOwner{
        platformFee = _fees;
    }

    function listTokenToMarketplace(address _nftAddress, uint256 _tokenId, uint256 _priceMetis, uint256 _pricePeak, uint256 _royaltyFees) public notListed(address(_nftAddress), _tokenId){
        nftDetails[_nftAddress][_tokenId].tokenOwner = msg.sender;
        nftDetails[_nftAddress][_tokenId].secondaryOwner = msg.sender;
        nftDetails[_nftAddress][_tokenId].nftAddress = IERC721(_nftAddress);
        nftDetails[_nftAddress][_tokenId].tokenId = _tokenId;
        nftDetails[_nftAddress][_tokenId].priceMetis = _priceMetis;
        nftDetails[_nftAddress][_tokenId].priceMetis = _pricePeak;
        nftDetails[_nftAddress][_tokenId].royaltyFee = _royaltyFees;
        nftDetails[_nftAddress][_tokenId].listedTime = block.timestamp;
        nftDetails[_nftAddress][_tokenId].updateTime = block.timestamp;
        nftDetails[_nftAddress][_tokenId].isForSale = true;
        nftDetails[_nftAddress][_tokenId].isAlreadyListed = true;
        IERC721(_nftAddress).safeTransferFrom(msg.sender, address(this), _tokenId);
        listedNFTs.push(_nftAddress);
        tokenList[_nftAddress].push(_tokenId);
    }

    function updateListedToken(address _nftAddress, uint256 _tokenId, uint256 _priceMetis, uint256 _pricePeak, uint256 _royalty, bool _isForSale) public isListed(address(_nftAddress), _tokenId) isTokenOwner(address(_nftAddress), _tokenId){
        nftDetails[_nftAddress][_tokenId].priceMetis = _priceMetis;
        nftDetails[_nftAddress][_tokenId].pricePeak = _pricePeak;
        nftDetails[_nftAddress][_tokenId].royaltyFee = _royalty;
        nftDetails[_nftAddress][_tokenId].updateTime = block.timestamp;
        nftDetails[_nftAddress][_tokenId].isForSale = _isForSale;
    }

    function buyToken(address _nftAddress, uint256 _tokenId, bool _isMetis) public payable isListed(address(_nftAddress), _tokenId){
        if(_isMetis){
            uint fee = nftDetails[_nftAddress][_tokenId].priceMetis.mul(platformFee).div(1e4);
            require(msg.value == nftDetails[_nftAddress][_tokenId].priceMetis, "Incorrenct price");
            payable(nftDetails[_nftAddress][_tokenId].tokenOwner).transfer(getRoyaltyAmount(_nftAddress, _tokenId));
            payable(nftDetails[_nftAddress][_tokenId].secondaryOwner).transfer(nftDetails[_nftAddress][_tokenId].priceMetis.sub(fee).sub(getRoyaltyAmount(_nftAddress, _tokenId)));
        }else{
            uint fee = nftDetails[_nftAddress][_tokenId].pricePeak.mul(platformFee).div(1e4);
            require(peak.transferFrom(msg.sender, nftDetails[_nftAddress][_tokenId].tokenOwner, getRoyaltyAmount(_nftAddress, _tokenId)), "Transfer failed");
            require(peak.transferFrom(msg.sender, nftDetails[_nftAddress][_tokenId].secondaryOwner, nftDetails[_nftAddress][_tokenId].pricePeak.sub(fee).sub(getRoyaltyAmount(_nftAddress, _tokenId))), "Transfer failed");
        }
        IERC721(_nftAddress).safeTransferFrom(address(this), msg.sender, _tokenId);
        nftDetails[_nftAddress][_tokenId].priceMetis = 0;
        nftDetails[_nftAddress][_tokenId].pricePeak = 0;
        nftDetails[_nftAddress][_tokenId].secondaryOwner = msg.sender;
        nftDetails[_nftAddress][_tokenId].updateTime = block.timestamp;
        nftDetails[_nftAddress][_tokenId].isForSale = false;
    }

    function startAuction(address _nftAddress, uint256 _tokenId, uint256 _startTime, uint256 _endTime, uint256 _baseAmount) public isOutForAuction(_nftAddress, _tokenId) isTokenOwner(address(_nftAddress), _tokenId){
        require(_startTime > block.timestamp && _startTime > _endTime, "Invalid time");
        nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].startTime = _startTime;
        nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].endTime = _endTime;
        nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].baseAmount = _baseAmount;
        nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].isOutForAuction = true;
    }

    function participateInAuction(address _nftAddress, uint256 _tokenId, uint256 _amount) public isOutForAuction(_nftAddress, _tokenId){
        require(nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].baseAmount <= _amount, "Invalid amount");
        require(peak.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].participatedUser.push(msg.sender);
        nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].bidAmount.push(_amount);
    }

    function endAuction(address _nftAddress, uint256 _tokenId) public isOutForAuction(_nftAddress, _tokenId) isTokenOwner(address(_nftAddress), _tokenId){
        require(block.timestamp > nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].endTime, "Invalid time");
        nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].isOutForAuction = false;

        uint[] memory bidAmount = nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].bidAmount;
        address[] memory participatedUsers = nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].participatedUser;
        
        require(bidAmount.length == participatedUsers.length, "Length should be same");
        for(uint i = 0; i < bidAmount.length.sub(1); i++){
            if(bidAmount[i] > bidAmount[i+1]){
                uint temp = bidAmount[i+1];
                address tempAdd = participatedUsers[i+1];
                bidAmount[i+1] = bidAmount[i];
                participatedUsers[i+1] = participatedUsers[i];
                bidAmount[i] = temp;
                participatedUsers[i] = tempAdd;
            }
        }
        uint256 amount = bidAmount[bidAmount.length.sub(1)];
        address newOwner = participatedUsers[participatedUsers.length.sub(1)];

        nftDetails[_nftAddress][_tokenId].secondaryOwner = newOwner;
        nftDetails[_nftAddress][_tokenId].priceMetis = 0;
        nftDetails[_nftAddress][_tokenId].pricePeak = 0;
        nftDetails[_nftAddress][_tokenId].secondaryOwner = newOwner;
        nftDetails[_nftAddress][_tokenId].updateTime = block.timestamp;
        nftDetails[_nftAddress][_tokenId].isForSale = false;
        nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].auctionWinner = newOwner;

        uint fee = amount.mul(platformFee).div(1e4);
        require(peak.transfer(nftDetails[_nftAddress][_tokenId].tokenOwner, getRoyaltyAmount(_nftAddress, _tokenId)), "Transfer failed");
        require(peak.transfer(msg.sender, amount.sub(fee).sub(getRoyaltyAmount(_nftAddress, _tokenId))), "Transfer Failed");

    }

    function refundAuctionTokens(address _nftAddress, uint256 _tokenId) public {
        require(!nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].isOutForAuction, "Auction is not ended yet.");
        
        uint[] memory bidAmount = nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].bidAmount;
        address[] memory participatedUsers = nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].participatedUser;

        for(uint i = 0; i < bidAmount.length; i++){
            if(msg.sender == participatedUsers[i]){
                require(msg.sender == nftDetails[_nftAddress][_tokenId].auctionDetail[_tokenId].auctionWinner, "You can not get refund");
                peak.transfer(msg.sender, bidAmount[i]);
            }
        }
    }

    function getPeakAddress() public view returns(IERC20){
        return peak;
    }

    function getNumberOfListedNFTs() public view returns(uint256){
        return listedNFTs.length;
    }

    function getListedNFTs() public view returns(address[] memory){
        return listedNFTs;
    }

    function getListedTokenIds(address _nftAddress) public view returns(uint256[] memory){
        return tokenList[_nftAddress];
    }

    function getRoyaltyAmount(address _nftAddress, uint _tokenId) public view returns(uint256){
        return nftDetails[_nftAddress][_tokenId].pricePeak.mul(nftDetails[_nftAddress][_tokenId].royaltyFee).div(1e4);
    }
}
