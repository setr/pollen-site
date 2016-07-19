#lang pollen
◊define-meta[tags]{notes, protocol, ipfs}
◊define-meta[title]{My Understanding of IPFS}


◊section{Trading Files}

◊blockquote["anon"]{In order for an IPFS link to continue living, one or more IPFS users must have pinned it, and one or more of them must be online.}

◊extlink["https://github.com/ipfs/ipfs/blob/master/papers/ipfs-cap2pfs/ipfs-p2p-file-system.pdf?raw=true"]{IPFS Whitepaper}

Rereading the BitSwap Protocol now, if I'm reading it correctly, then I'm pretty damn sure you're completely wrong.

IPFS operates on ◊b{blocks,} not files. Files are composed of blocks, and blocks are referenced by their hashes. When you request a file object, what you're actually requesting a series of blocks (from anywhere on the network), which you'll reconstruct at your own machine. Same as bittorrent. 
That list of blocks is stored in the distributed hash table (DHT), pieces of which can be found on ipfs nodes (so when you request [the hash of] a file, you bounce around until you find someone who knows what the file object's merkle tree actually looks like. Then you start requesting the blocks composing it.)

And of course, the point of using a DHT is that there is no SPOF (and you can store it efficiently); You will be hard pressed to find a file's structure-data that can't be found ◊b{somewhere} on the network (and this would become exponentially more difficult as the network grows)

Importantly, unlike bittorrent, there is no ◊b{tracker}, that segregates ◊b{seeding} by file object. Bittorrent limits who you can gather blocks from to the people attached to the particular tracker, for that file object, as the Bittorrent DHT is limited to only storing peer-metadata (which, if I understand correctly, is what you get out of your magnet-links)
The reason you can't download a file with no seeders on it, using the Bittorrent protocol, is because the DHT only stores metadata for ◊b{single files}. 

IPFS removes this limitation, as the IPFS DHT is global. When it requests a block from the network, ◊b{it does not ask where that block came from}. In other words, you can gather blocks from ◊b{people who never saw the file}. 

When you 'publish' a file, you are simply adding the file to the distributed hash table, and getting a hash that you can hand off to people. If you 'pin' a file (the closest thing to hosting it), all you're doing is telling your machine not to delete it during routine garbage collection. 
But that hash you pass around, it's got nothing to do with you. It doesn't matter if you still have the file, or not. Your 'pinning' the file is simply a gaurantee that the necessary blocks ◊b{will} exist on the network. As long as the necessary ◊b{blocks} exist on the network, the file can be reconstructed. So the main question to file permanence is the amount of ◊b{blocks} existing on the network, and the granularity of those blocks (if the block composes the entire file... it wouldn't be very useful. But if every block was a single ascii character, you could reconstruct any plaintext file with very few nodes with file data on the network)

If I understand it correctly, this would also imply that given a large enough network, you could 'publish' a file without ever actually putting that file on an ipfs node. If all the 'blocks' can be found, then the whole file can be constructed.

Also, if I understand it correctly, what the block-based structure ◊b{should} mean is something like this:

=>Lets say you request a png, which would be divided into blocks
=>with some of these blocks being nothing but transparent 
=>Those transparent blocks would be the same for any png with enough transparency
=>So for those blocks, you'll end up pulling it from just about anyone with a sufficiently transparent png on their computer
=>the only pieces that would actually be ◊b{dependent} on the original png existing on the network are those wholly unique to that png

and with more people on the network, the likelihood of such 'unique' blocks existing decreases, and thus such 'originality' dependencies decrease.

