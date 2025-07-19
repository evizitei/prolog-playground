% Huffman Coding Implementation in Prolog
% Huffman coding is a lossless compression algorithm that assigns variable-length
% codes to characters based on their frequency of occurrence.

% Example: Let's encode the string "hello world"
% Character frequencies: h:1, e:1, l:3, o:2, w:1, r:1, d:1, space:1

% Step 1: Define character frequencies
char_freq(h, 1).
char_freq(e, 1).
char_freq(l, 3).
char_freq(o, 2).
char_freq(w, 1).
char_freq(r, 1).
char_freq(d, 1).
char_freq(' ', 1).

% Step 2: Huffman tree node structure
% huffman_tree(Weight, Left, Right) or huffman_leaf(Char, Weight)
huffman_leaf(Char, Weight) :- char_freq(Char, Weight).

% Step 3: Build Huffman tree
% This is a simplified version showing the final tree structure
% for "hello world" with frequencies: h:1, e:1, l:3, o:2, w:1, r:1, d:1, space:1

% The Huffman tree for our example:
% Root (11)
% ├── Left (4) 
% │   ├── Left (2) - 'l' (3)
% │   └── Right (1) - 'o' (2)
% └── Right (7)
%     ├── Left (3)
%     │   ├── Left (1) - 'h' (1)
%     │   └── Right (2) - 'e' (1)
%     └── Right (4)
%         ├── Left (2)
%         │   ├── Left (1) - 'w' (1)
%         │   └── Right (1) - 'r' (1)
%         └── Right (2)
%             ├── Left (1) - 'd' (1)
%             └── Right (1) - ' ' (1)

% Huffman codes (0 = left, 1 = right):
% 'l': 00
% 'o': 01
% 'h': 100
% 'e': 101
% 'w': 1100
% 'r': 1101
% 'd': 1110
% ' ': 1111

% Step 4: Encode a character using the tree
encode_char(Char, Code) :-
    char_freq(Char, _),
    encode_char_tree(Char, Code).

% Simplified encoding based on our tree structure
encode_char_tree(l, [0,0]).
encode_char_tree(o, [0,1]).
encode_char_tree(h, [1,0,0]).
encode_char_tree(e, [1,0,1]).
encode_char_tree(w, [1,1,0,0]).
encode_char_tree(r, [1,1,0,1]).
encode_char_tree(d, [1,1,1,0]).
encode_char_tree(' ', [1,1,1,1]).

% Step 5: Encode a string
encode_string([], []).
encode_string([Char|Rest], Encoded) :-
    encode_char(Char, Code),
    encode_string(Rest, RestEncoded),
    append(Code, RestEncoded, Encoded).

% Step 6: Decode a bit sequence
decode_bits(Bits, [Char|Rest]) :-
    decode_char(Bits, Char, RemainingBits),
    decode_bits(RemainingBits, Rest).
decode_bits([], []).

decode_char([0,0|Rest], l, Rest).
decode_char([0,1|Rest], o, Rest).
decode_char([1,0,0|Rest], h, Rest).
decode_char([1,0,1|Rest], e, Rest).
decode_char([1,1,0,0|Rest], w, Rest).
decode_char([1,1,0,1|Rest], r, Rest).
decode_char([1,1,1,0|Rest], d, Rest).
decode_char([1,1,1,1|Rest], ' ', Rest).

% Example usage and demonstration
demo_huffman :-
    write('=== Huffman Coding Demo ==='), nl,
    write('Original string: "hello world"'), nl,
    
    % Encode
    encode_string([h,e,l,l,o,' ',w,o,r,l,d], Encoded),
    write('Encoded bits: '), write(Encoded), nl,
    
    % Decode
    decode_bits(Encoded, Decoded),
    write('Decoded string: '), write(Decoded), nl,
    
    % Show individual character codes
    write('Character codes:'), nl,
    show_all_codes.

show_all_codes :-
    char_freq(Char, Freq),
    encode_char_tree(Char, Code),
    write('  '), write(Char), write(': '), write(Code), 
    write(' (freq: '), write(Freq), write(')'), nl,
    fail.
show_all_codes.

% Calculate compression ratio
compression_ratio(Original, Compressed, Ratio) :-
    length(Original, OrigBits),
    length(Compressed, CompBits),
    Ratio is OrigBits / CompBits.

% Show compression statistics
show_compression_stats :-
    write('=== Compression Statistics ==='), nl,
    
    % Original ASCII: 8 bits per character
    Original = [h,e,l,l,o,' ',w,o,r,l,d],
    length(Original, CharCount),
    AsciiBits is CharCount * 8,
    write('Original (ASCII): '), write(AsciiBits), write(' bits'), nl,
    
    % Huffman encoded
    encode_string(Original, Encoded),
    length(Encoded, HuffmanBits),
    write('Huffman encoded: '), write(HuffmanBits), write(' bits'), nl,
    
    % Compression ratio
    Ratio is AsciiBits / HuffmanBits,
    write('Compression ratio: '), write(Ratio), write(':1'), nl,
    
    % Space savings
    Savings is AsciiBits - HuffmanBits,
    SavingsPercent is (Savings / AsciiBits) * 100,
    write('Space saved: '), write(Savings), write(' bits ('), 
    write(SavingsPercent), write('%)'), nl. 