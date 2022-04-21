// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/IERC721ReceiverUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/IERC1155ReceiverUpgradeable.sol";

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

    function burn(uint256 amount) external;
}

/**
 * @dev Required interface of an ERC1155 compliant contract, as defined in the
 * https://eips.ethereum.org/EIPS/eip-1155[EIP].
 *
 * _Available since v3.1._
 */
interface IERC1155 is IERC165 {
    /**
     * @dev Emitted when `value` tokens of token type `id` are transferred from `from` to `to` by `operator`.
     */
    event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value);

    /**
     * @dev Equivalent to multiple {TransferSingle} events, where `operator`, `from` and `to` are the same for all
     * transfers.
     */
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    /**
     * @dev Emitted when `account` grants or revokes permission to `operator` to transfer their tokens, according to
     * `approved`.
     */
    event ApprovalForAll(address indexed account, address indexed operator, bool approved);

    /**
     * @dev Emitted when the URI for token type `id` changes to `value`, if it is a non-programmatic URI.
     *
     * If an {URI} event was emitted for `id`, the standard
     * https://eips.ethereum.org/EIPS/eip-1155#metadata-extensions[guarantees] that `value` will equal the value
     * returned by {IERC1155MetadataURI-uri}.
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev Returns the amount of tokens of token type `id` owned by `account`.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 id) external view returns (uint256);

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {balanceOf}.
     *
     * Requirements:
     *
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(address[] calldata accounts, uint256[] calldata ids)
        external
        view
        returns (uint256[] memory);

    /**
     * @dev Grants or revokes permission to `operator` to transfer the caller's tokens, according to `approved`,
     *
     * Emits an {ApprovalForAll} event.
     *
     * Requirements:
     *
     * - `operator` cannot be the caller.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns true if `operator` is approved to transfer ``account``'s tokens.
     *
     * See {setApprovalForAll}.
     */
    function isApprovedForAll(address account, address operator) external view returns (bool);

    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - If the caller is not `from`, it must be have been approved to spend ``from``'s tokens via {setApprovalForAll}.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {safeTransferFrom}.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
     * acceptance magic value.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
}

contract ApparelMarketplace is Initializable, IERC721ReceiverUpgradeable, UUPSUpgradeable, OwnableUpgradeable {
    
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
    
    using SafeMath for uint256;

    struct NFTDetails{
        address tokenOwner;
        address secondaryOwner;
        address nftAddress;
        uint256 tokenId;
        uint256 priceMetis;
        uint256 pricePeak;
        uint256 royaltyFee;
        uint256 listedTime;
        uint256 updateTime;
        bool isForSale;
        bool isAlreadyListed;
        bool isERC721;
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
        bool isMetis;
        bool isOutForAuction;
    }

    uint256 public platformFee;

    address public NFTA;
    address public NFTATreasury;

    mapping(address => mapping(uint256 => NFTDetails)) public nftDetails;
    mapping(address => uint256[]) private tokenList;
 
    address[] listedNFTs;

    IERC20 peak;

    // required function for implementing proxy
    function initialize(IERC20 _peak, address _NFTA, address _NFTATreasury) public initializer {
        peak = _peak;
        NFTA = _NFTA;
        NFTATreasury = _NFTATreasury;
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

    function onERC1155Received(address, address, uint256, uint256, bytes memory) public returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(address, address, uint256[] memory, uint256[] memory, bytes memory) public returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

    function setPlatformFees(uint256 _fees) public onlyOwner{
        platformFee = _fees;
    }

    function listTokenToMarketplace(address _nftAddress, uint256 _tokenId, uint256 _tokenAmount, uint256 _priceMetis, uint256 _pricePeak, uint256 _royaltyFees, bool _isERC721) public notListed(address(_nftAddress), _tokenId){
        NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];

        nftDetail.tokenOwner = msg.sender;
        nftDetail.secondaryOwner = msg.sender;
        nftDetail.nftAddress = _nftAddress;
        nftDetail.tokenId = _tokenId;
        nftDetail.priceMetis = _priceMetis;
        nftDetail.priceMetis = _pricePeak;
        nftDetail.royaltyFee = _royaltyFees;
        nftDetail.listedTime = block.timestamp;
        nftDetail.updateTime = block.timestamp;
        nftDetail.isForSale = true;
        nftDetail.isAlreadyListed = true;
        nftDetail.isERC721 = _isERC721;

        transferNFT(_nftAddress, _tokenId, _tokenAmount, msg.sender, address(this), _isERC721);

        listedNFTs.push(_nftAddress);
        tokenList[_nftAddress].push(_tokenId);
    }

    function updateListedToken(address _nftAddress, uint256 _tokenId, uint256 _priceMetis, uint256 _pricePeak, uint256 _royalty, bool _isForSale) public isListed(address(_nftAddress), _tokenId) isTokenOwner(address(_nftAddress), _tokenId){
        NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];

        nftDetail.priceMetis = _priceMetis;
        nftDetail.pricePeak = _pricePeak;
        nftDetail.royaltyFee = _royalty;
        nftDetail.updateTime = block.timestamp;
        nftDetail.isForSale = _isForSale;
    }

    function unlistTokenFromMarketplace(address _nftAddress, uint256 _tokenId, uint256 _tokenAmount, bool _isERC721) public isListed(_nftAddress, _tokenId) isTokenOwner(_nftAddress, _tokenId){
         NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];

        nftDetail.priceMetis = 0;
        nftDetail.pricePeak = 0;
        nftDetail.royaltyFee = 0;
        nftDetail.updateTime = block.timestamp;
        nftDetail.isForSale = false;

        transferNFT(_nftAddress, _tokenId, _tokenAmount, address(this), msg.sender, _isERC721);
    }

    function buyToken(address _nftAddress, uint256 _tokenId, uint256 _tokenAmount, bool _isMetis, bool _isERC721) public payable isListed(address(_nftAddress), _tokenId){
        NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];

        require(nftDetail.auctionDetail[_tokenId].isOutForAuction == false, "Token is on auction");

        if(_isMetis){
            (, uint treasury, uint fee, uint amountTobePaid) = calculateFeesForMetis(nftDetail.priceMetis);
            require(msg.value == nftDetail.priceMetis, "Incorrenct price");
            payable(NFTA).transfer(fee);
            payable(NFTATreasury).transfer(treasury);
            payable(nftDetail.tokenOwner).transfer(getRoyaltyAmount(_nftAddress, _tokenId));
            payable(nftDetail.secondaryOwner).transfer(amountTobePaid.sub(getRoyaltyAmount(_nftAddress, _tokenId)));
        }else{
            (, uint burn, uint fee, uint amountTobePaid) = calculateFeesForPeak(nftDetail.pricePeak);
            peakTransferFrom(msg.sender, address(this), nftDetail.pricePeak);
            peakTransfer(nftDetail.tokenOwner, getRoyaltyAmount(_nftAddress, _tokenId));
            peak.burn(burn);
            peakTransfer(NFTA, fee);
            peakTransfer(nftDetail.secondaryOwner, amountTobePaid.sub(getRoyaltyAmount(_nftAddress, _tokenId)));
        }

        transferNFT(_nftAddress, _tokenId, _tokenAmount, address(this), msg.sender, _isERC721);

        nftDetail.priceMetis = 0;
        nftDetail.pricePeak = 0;
        nftDetail.secondaryOwner = msg.sender;
        nftDetail.updateTime = block.timestamp;
        nftDetail.isForSale = false;
    }

    function startAuction(address _nftAddress, uint256 _tokenId, uint256 _startTime, uint256 _endTime, uint256 _baseAmount, bool _isMetis) public isTokenOwner(address(_nftAddress), _tokenId){
        NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];
        require(!nftDetail.auctionDetail[_tokenId].isOutForAuction, "Token is on auction");
        require(_startTime > block.timestamp && _startTime > _endTime, "Invalid time");
        nftDetail.auctionDetail[_tokenId].startTime = _startTime;
        nftDetail.auctionDetail[_tokenId].endTime = _endTime;
        nftDetail.auctionDetail[_tokenId].baseAmount = _baseAmount;
        nftDetail.auctionDetail[_tokenId].isMetis = _isMetis;
        nftDetail.auctionDetail[_tokenId].isOutForAuction = true;
    }

    function participateInAuction(address _nftAddress, uint256 _tokenId, uint256 _amount) public payable isOutForAuction(_nftAddress, _tokenId){
        NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];
        require(block.timestamp < nftDetail.auctionDetail[_tokenId].endTime, "Invalid time");
        if(nftDetail.auctionDetail[_tokenId].isMetis){
            require(msg.value >= nftDetail.auctionDetail[_tokenId].baseAmount, "Invalid metis amount");
            nftDetail.auctionDetail[_tokenId].bidAmount.push(msg.value);
        }else{
            require(nftDetail.auctionDetail[_tokenId].baseAmount <= _amount, "Invalid peak amount");
            peakTransferFrom(msg.sender, address(this), _amount);
            nftDetail.auctionDetail[_tokenId].bidAmount.push(_amount);
        }

        nftDetail.auctionDetail[_tokenId].participatedUser.push(msg.sender);
    }

    function cancelAuction(address _nftAddress, uint256 _tokenId) public isOutForAuction(_nftAddress, _tokenId) isTokenOwner(address(_nftAddress), _tokenId){
        NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];

        nftDetail.auctionDetail[_tokenId].isOutForAuction = false;
        nftDetail.auctionDetail[_tokenId].startTime = 0;
        nftDetail.auctionDetail[_tokenId].endTime = 0;
        nftDetail.auctionDetail[_tokenId].baseAmount = 0;
    }

    function endAuction(address _nftAddress, uint256 _tokenId) public isOutForAuction(_nftAddress, _tokenId) isTokenOwner(address(_nftAddress), _tokenId){
        NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];

        require(block.timestamp > nftDetail.auctionDetail[_tokenId].endTime, "Invalid time");
        
        nftDetail.auctionDetail[_tokenId].isOutForAuction = false;

        uint[] memory bidAmount = nftDetail.auctionDetail[_tokenId].bidAmount;
        address[] memory participatedUsers = nftDetail.auctionDetail[_tokenId].participatedUser;
        
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

        if(nftDetail.auctionDetail[_tokenId].isMetis){
            (, uint treasury, uint fee, uint amountTobePaid) = calculateFeesForMetis(bidAmount[bidAmount.length.sub(1)]);
            payable(NFTA).transfer(fee);
            payable(NFTATreasury).transfer(treasury);
            payable(nftDetail.tokenOwner).transfer(getRoyaltyAmount(_nftAddress, _tokenId));
            payable(nftDetail.secondaryOwner).transfer(amountTobePaid.sub(getRoyaltyAmount(_nftAddress, _tokenId)));
        } else {
            (, uint burn, uint fee, uint amountTobePaid) = calculateFeesForPeak(nftDetail.pricePeak);
            peakTransferFrom(msg.sender, address(this), nftDetail.pricePeak);
            peakTransfer(nftDetail.tokenOwner, getRoyaltyAmount(_nftAddress, _tokenId));
            peak.burn(burn);
            peakTransfer(NFTA, fee);
            peakTransfer(nftDetail.secondaryOwner, amountTobePaid.sub(getRoyaltyAmount(_nftAddress, _tokenId)));
        }

        nftDetail.secondaryOwner = participatedUsers[participatedUsers.length.sub(1)];
        nftDetail.priceMetis = 0;
        nftDetail.pricePeak = 0;
        nftDetail.updateTime = block.timestamp;
        nftDetail.isForSale = false;
        nftDetail.auctionDetail[_tokenId].auctionWinner = participatedUsers[participatedUsers.length.sub(1)];
        nftDetail.auctionDetail[_tokenId].startTime = 0;
        nftDetail.auctionDetail[_tokenId].endTime = 0;
        nftDetail.auctionDetail[_tokenId].baseAmount = 0;

        removeParticipatedUserFromAuctionDetails(_nftAddress, nftDetail.auctionDetail[_tokenId].auctionWinner, _tokenId);

        transferNFT(_nftAddress, _tokenId, 1, address(this), msg.sender, nftDetail.isERC721);
    }

    function refundAuctionTokens(address _nftAddress, uint256 _tokenId) public payable{
        NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];
        require(!nftDetail.auctionDetail[_tokenId].isOutForAuction, "Auction is not ended yet.");
        
        uint[] memory bidAmount = nftDetail.auctionDetail[_tokenId].bidAmount;
        address[] memory participatedUsers = nftDetail.auctionDetail[_tokenId].participatedUser;

        for(uint i = 0; i < bidAmount.length; i++){
            if(msg.sender == participatedUsers[i]){
                require(msg.sender == nftDetail.auctionDetail[_tokenId].auctionWinner, "You can not get refund");
                if(nftDetail.auctionDetail[_tokenId].isMetis){
                    payable(msg.sender).transfer(bidAmount[i]);
                }else{
                    peakTransfer(msg.sender, bidAmount[i]);
                }
            }
        }

        removeParticipatedUserFromAuctionDetails(_nftAddress, msg.sender, _tokenId);
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

    function getRoyaltyAmount(address _nftAddress, uint256 _tokenId) public view returns(uint256){
        return nftDetails[_nftAddress][_tokenId].pricePeak.mul(nftDetails[_nftAddress][_tokenId].royaltyFee).div(1e4);
    }

    // Internal functions
    function peakTransfer(address _to, uint256 _amount) internal {
        require(peak.transfer(_to, _amount), "Transfer failed");
    }

    function peakTransferFrom(address _from, address _to, uint256 _amount) internal {
        require(peak.transferFrom(_from, _to, _amount), "Transferfrom failed");
    }

    function transferNFT(address _nftAddress, uint256 _tokenId, uint256 _tokenAmount, address _from, address _to, bool _isERC721) internal {
        if(_isERC721){
            IERC721(_nftAddress).safeTransferFrom(_from, _to, _tokenId);
        } else {
            IERC1155(_nftAddress).safeTransferFrom(_from, _to, _tokenId, _tokenAmount, "0x00");
        }
    }

    function calculateFeesForPeak(uint _amount) internal view returns( uint256 totalFee, uint256 burn, uint256 fee, uint256 amountTobePaid){
        totalFee = _amount.mul(platformFee).div(1e4);
        burn = fee.div(2);
        fee = totalFee.sub(burn);
        amountTobePaid = _amount.sub(totalFee);
        return (totalFee, burn, fee, amountTobePaid);
    }

    function calculateFeesForMetis(uint _amount) internal view returns(uint256 totalFee, uint256 treasury, uint256 fee, uint256 amountTobePaid){
        totalFee = _amount.mul(platformFee).div(1e4);
        treasury = fee.div(3);
        fee = totalFee.sub(treasury);
        amountTobePaid = _amount.sub(totalFee);
        return (totalFee, treasury, fee, amountTobePaid);
    }

    function removeParticipatedUserFromAuctionDetails(address _nftAddress, address _participatedUser, uint256 _tokenId) internal {
        NFTDetails storage nftDetail = nftDetails[_nftAddress][_tokenId];
        for(uint i = 0; i < nftDetail.auctionDetail[_tokenId].participatedUser.length; i++){
            if(_participatedUser == nftDetail.auctionDetail[_tokenId].participatedUser[i]){
                for (uint j = i; j < nftDetail.auctionDetail[_tokenId].participatedUser.length - 1; j++) {
                    nftDetail.auctionDetail[_tokenId].participatedUser[j] = nftDetail.auctionDetail[_tokenId].participatedUser[j + 1];
                    nftDetail.auctionDetail[_tokenId].bidAmount[j] = nftDetail.auctionDetail[_tokenId].bidAmount[j + 1];
                }
                nftDetail.auctionDetail[_tokenId].participatedUser.pop();
                nftDetail.auctionDetail[_tokenId].bidAmount.pop();
            }
        }
    }

}
