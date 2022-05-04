/*
 
    PARKS (FOR ENTHUSIASTS)

    By 0xGarfield

    Contracts adapted From:
        - @ExistentialEnso
        - @dhof

 */
 pragma solidity ^0.8.7;

 import "./ERC721A.sol";
 import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
 import "@openzeppelin/contracts/access/Ownable.sol";
 
 // SPDX-License-Identifier: CC0-1.0
 contract PARKS is ERC721A, ReentrancyGuard, Ownable {
     constructor() ERC721A("Parks", "PARKS") Ownable() {}
 
     uint256 public mintPrice = 0.001 ether;
     uint256 public constant maxTokens = 10000;
 
     string[] private manufacturer = [
        "Mack",
        "Intamin",
        "RMC",
        "Vekoma",
        "Gerstlauer",
        "Bolliger and Mabillard",
        "GCI",
        "Zamperla",
        "Zierer",
        "TOGO",
        "Arrow Dynamics",
        "Schwarzkopf"
     ];
 
     string[] private location = [
        "California",
        "New York",
        "The United Kingdom",
        "Germany",
        "Texas",
        "Canada",
        "Sweden",
        "France",
        "China",
        "Japan",
        "Ukraine",
        "Australia",
        "Spain"
     ];
     
     string[] private coasterType = [
        "Flying",
        "Multi-Launch",
        "Launched",
        "Giga",
        "Hyper",
        "Spinning",
        "Inverted",
        "Wooden",
        "Hybrid",
        "Single Rail"
     ];
     
     string[] private inversions = [
        "with One Inversion",
        "with Two Inversions",
        "with Three Inversions",
        "with Four Inversions",
        "with Five Inversions",
        "with Six Inversions",
        "with Seven Inversions",
        "with Eight Inversions",
        "with Nine Inversions",
        "with Ten Inversions",
        "with Eleven Inversions",
        "with Twelve Inversions",
        "with Thirteen Inversions",
        "with Fourteen Inversions",
        "with Fifteen Inversions",
        "with Sixteen Inversions"
     ];

     string[] private records = [
        "Fastest",
        "Longest",
        "Steepest",
        "Most Forceful",
        "Scariest",
        "Tallest"
     ];

     string[] private flatrides = [
        "Top Spin",
        "Gyro Swing",
        "Drop Tower",
        "Pirate Ship",
        "Screamin' Swing",
        "Sky Fly",
        "Disko",
        "Teacups"
     ];

     string[] private waterrides = [
        "Shoot the Chute",
        "Log Flume",
        "Water Coaster",
        "River Rapids",
        "Indoor Boat Ride",
        "Splash Battle"
     ];

     string[] private darkrides = [
        "Ghost Train",
        "Trackless",
        "OmniMover",
        "Indoor Coaster",
        "Interactive Shooter",
        "4D Cinema",
        "Flying Theatre"
     ];
     
     string[] private extras = [
        "Has a Family Coaster",
        "Has a Dole Whip Stand",
        "Above Average Food Outlets",
        "Has a Replica Eiffel Tower",
        "Grand Castle Dominates Center",
        "Happiest Place on Earth",
        "On it's own Island",
        "Has a monorail",
        "Has Boat Transportation around the park",
        "Free Fast Track",
        "Overpriced Fast Track",
        "One Coaster is Designed by John Wardley",
        "One Coaster is themed to Oscar the Grouch"
     ];

     function random(string memory input) internal pure returns (uint256) {
         return uint256(keccak256(abi.encodePacked(input)));
     }
     
     function getManufacturer(uint256 tokenId) public view returns (string memory) {
         return pluck(tokenId, "MANUFACTURER", manufacturer);
     }
 
     function getLocation(uint256 tokenId) public view returns (string memory) {
         return pluck(tokenId, "LOCATION", location);
     }
     
     function getCoasterType(uint256 tokenId) public view returns (string memory) {
         return pluck(tokenId, "TYPE", coasterType);
     }
     
     function getInversions(uint256 tokenId) public view returns (string memory) {
         return pluck(tokenId, "INVERSIONS", inversions);
     }

     function getRecords(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "RECORDS", records);
    }

    function getFlats(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "FLATRIDE", flatrides);
    }

    function getWater(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "WATERRIDE", waterrides);
    }

    function getDarkRide(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "DARK", darkrides);
    }

    function getExtra(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "EXTRA", extras);
    }
     
    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
        string memory output = sourceArray[rand % sourceArray.length];
        
        return output;
    }
 
     function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[19] memory parts;
        string[9] memory traits;

        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base" fill="#FF0000">';

        parts[1] = string(abi.encodePacked("In ", getLocation(tokenId)));
        traits[0] = string(abi.encodePacked('{"trait_type":"LOCATION","value":"In ', parts[1], '"},')); 

        parts[2] = '</text><text x="10" y="40" class="base" fill="#FFFFFF">';

        parts[3] = string(abi.encodePacked(getCoasterType(tokenId)," by ",getManufacturer(tokenId)," ",getInversions(tokenId)));
        traits[1] = string(abi.encodePacked('{"trait_type":"COASTER 1","value":"', parts[3], '"},')); 

        parts[4] = '</text><text x="10" y="60" class="base" fill="#FF0000">';

        parts[5] = string(abi.encodePacked("World's ", getRecords(tokenId), " coaster by ", getManufacturer(tokenId+(maxTokens*7))));
        traits[2] = string(abi.encodePacked('{"trait_type":"COASTER 2","value":"', parts[5], '"},')); 

        parts[6] = '</text><text x="10" y="80" class="base" fill="#FFFFFF">';

        parts[7] = string(abi.encodePacked(getCoasterType(tokenId+(maxTokens*3))," by ",getManufacturer(tokenId+(maxTokens*3))," ",getInversions(tokenId+(maxTokens*3))));
        traits[3] = string(abi.encodePacked('{"trait_type":"COASTER 3","value":"', parts[7], '"},')); 

        parts[8] = '</text><text x="10" y="100" class="base" fill="#FF0000">';

        parts[9] = getFlats(tokenId);
        traits[4] = string(abi.encodePacked('{"trait_type":"FLAT RIDE","value":"', parts[9], '"},'));

        parts[10] = '</text><text x="10" y="120" class="base" fill="#FFFFFF">';

        parts[11] = getWater(tokenId);
        traits[5] = string(abi.encodePacked('{"trait_type":"WATER RIDE","value":"', parts[11], '"},'));

        parts[12] = '</text><text x="10" y="140" class="base" fill="#FF0000">';

        parts[13] = string(abi.encodePacked(getDarkRide(tokenId), " Dark Ride"));
        traits[6] = string(abi.encodePacked('{"trait_type":"DARK RIDE","value":"', parts[13], '"},'));

        parts[14] = '</text><text x="10" y="160" class="base" fill="#FFFFFF">';

        parts[15] = getExtra(tokenId);
        traits[7] = string(abi.encodePacked('{"trait_type":"EXTRA","value":"', parts[15], '"},'));

        parts[16] = '</text><text x="10" y="180" class="base" fill="#FF0000">';

        parts[17] = string(abi.encodePacked("And a few more mediocre ", getManufacturer(tokenId+(maxTokens*5)), "s"));
        traits[8] = string(abi.encodePacked('{"trait_type":"FILLERCOASTERS","value":"', getManufacturer(tokenId+(maxTokens*5)), '"}'));

        parts[18] = '</text></svg>';


        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));
        output = string(abi.encodePacked(output, parts[9], parts[10], parts[11], parts[12], parts[13], parts[14], parts[15], parts[16], parts[17], parts[18]));

        string memory traitList = string(abi.encodePacked(traits[0],traits[1],traits[2],traits[3],traits[4], traits[5], traits[6], traits[7], traits[8]));
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Park #', toString(tokenId), '", "description": "A Park (For Enthusiasts). A CC0 Collection of On-Chain Fully Randomised Theme Parks!", "attributes": [', traitList ,'], "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;
     }
 
     function _startTokenId() internal pure override returns (uint256) {
         return 1;
     }
 
     function setPrice(uint256 newPrice) public onlyOwner {
         mintPrice = newPrice;
     }
 
     function withdraw() public onlyOwner {
         payable(msg.sender).transfer(address(this).balance);
     }
 
     function mintPark(uint256 qty) public payable nonReentrant {
         require(qty <= 100, 'MAX_QTY_EXCEEDED');
         unchecked { require(mintPrice * qty <= msg.value, 'LOW_ETHER'); }
         unchecked { require(totalSupply() + qty <= maxTokens, 'MAX_REACHED'); }
         _safeMint(msg.sender, qty);
     }

     //hewwooooo
     
     function toString(uint256 value) internal pure returns (string memory) {
         // Inspired by OraclizeAPI's implementation - MIT license
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
 }
 
 /// [MIT License]
 /// @title Base64
 /// @notice Provides a function for encoding some bytes in base64
 /// @author Brecht Devos <brecht@loopring.org>
 library Base64 {
     bytes internal constant TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
 
     /// @notice Encodes some bytes to the base64 representation
     function encode(bytes memory data) internal pure returns (string memory) {
         uint256 len = data.length;
         if (len == 0) return "";
 
         // multiply by 4/3 rounded up
         uint256 encodedLen = 4 * ((len + 2) / 3);
 
         // Add some extra buffer at the end
         bytes memory result = new bytes(encodedLen + 32);
 
         bytes memory table = TABLE;
 
         assembly {
             let tablePtr := add(table, 1)
             let resultPtr := add(result, 32)
 
             for {
                 let i := 0
             } lt(i, len) {
 
             } {
                 i := add(i, 3)
                 let input := and(mload(add(data, i)), 0xffffff)
 
                 let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                 out := shl(8, out)
                 out := add(out, and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF))
                 out := shl(8, out)
                 out := add(out, and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF))
                 out := shl(8, out)
                 out := add(out, and(mload(add(tablePtr, and(input, 0x3F))), 0xFF))
                 out := shl(224, out)
 
                 mstore(resultPtr, out)
 
                 resultPtr := add(resultPtr, 4)
             }
 
             switch mod(len, 3)
             case 1 {
                 mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
             }
             case 2 {
                 mstore(sub(resultPtr, 1), shl(248, 0x3d))
             }
 
             mstore(result, encodedLen)
         }
 
         return string(result);
     }
 }