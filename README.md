***CIE 442 Project 1: Image Compression with DCT and DFT***
This project is a comprehensive implementation and analysis of block-based image compression, comparing the performance of the Discrete Cosine Transform (DCT) and the Discrete Fourier Transform (DFT). The work was completed for the Digital Signal Processing (CIE 442) course at [Your University Name].

**Project Objective**
The primary goal is to experimentally compare the energy compaction properties of the DCT and DFT. By applying these transforms to image blocks, we analyze which transform more effectively concentrates visual information into a small number of coefficients, leading to better quality reconstruction at a given compression level.

**Features**
Custom Transform Implementations: 2D DFT and DCT are built from their 1D counterparts, along with their respective inverse transforms (IDFT2, IDCT2).
Block-Based Processing: Supports non-overlapping block sizes of 4x4, 8x8, and 16x16, following the JPEG standard.
Coefficient Reduction: Simulates compression by retaining only the largest-magnitude coefficients (e.g., 10%, 25%, 50%).
Quantitative Analysis: Calculates the Mean Squared Error (MSE) between the original and reconstructed images to measure quality loss.
Visual Comparison: Generates side-by-side comparisons of original, DCT-reconstructed, and DFT-reconstructed images.
Bonus: Full Entropy Coding Pipeline:
Zig-Zag Scanning: Converts 2D coefficient blocks into 1D vectors.
Run-Length Encoding (RLE): Compresses consecutive zeros.
Huffman Coding: Applies variable-length coding to the RLE output for further compression.
Metrics Calculation: Reports the final bits per pixel (bpp) and compression ratio.

**Project Structure**
.
├── images/
│   └── cameraman.tif             # Example input image
├── CIE442_Project1_ImageCompression.mlx # Main MATLAB Live Script
│
├── DFT.m                         # 1D DFT implementation
├── DFT2.m                        # 2D DFT implementation
├── IDFT.m                        # 1D Inverse DFT
├── IDFT2.m                       # 2D Inverse DFT
│
├── DCT.m                         # 1D DCT implementation
├── DCT2.m                        # 2D DCT implementation
├── IDCT.m                        # 1D Inverse DCT
├── IDCT2.m                       # 2D Inverse DCT
│
├── compressBlocks.m               # Function for coefficient reduction
├── compareTransform.m             # Function to verify custom transforms
│
├── zigzag.m                      # Zig-zag scan (2D to 1D)
├── inverseZigzag.m               # Inverse zig-zag scan (1D to 2D)
├── rle.m                         # Run-length encoder
├── rle_decode.m                  # Run-length decoder
├── huffman_encode.m               # Huffman encoder
├── huffman_decode.m               # Huffman decoder
│
└── README.md                     # This file


**Theoretical Background**
Discrete Fourier Transform (DFT)
The DFT decomposes a signal into a sum of complex sinusoids, representing its frequency content. While powerful, it produces complex-valued coefficients and assumes periodicity, which can introduce artifacts at block boundaries.

Discrete Cosine Transform (DCT)
The DCT is a real-valued transform closely related to the DFT. It is particularly effective for image compression because it has superior energy compaction properties. It tends to pack most of the signal's energy into a few low-frequency coefficients, making it ideal for quantization and compression. The DCT also implicitly assumes even symmetry, which reduces boundary discontinuities.

***How to Run***
**Prerequisites**
MATLAB (R2021a or later recommended)
Image Processing Toolbox
Signal Processing Toolbox (optional, but recommended for verification)
**Setup**
Clone this repository to your local machine.
Ensure the images folder exists and contains a grayscale image (e.g., cameraman.tif).
Open MATLAB and navigate to the cloned repository's folder.
**Execution**
Open the CIE442_Project1_ImageCompression.mlx live script.
Execute the script section by section. The code is organized to follow the project's workflow:
Image loading and blocking.
Application of DFT and DCT.
Coefficient reduction (compression).
Image reconstruction.
Analysis and comparison.
Bonus entropy coding pipeline.
***Results and Discussion***
**DCT vs. DFT Performance**
The experimental results confirm that the DCT provides significantly better reconstruction quality than the DFT for the same number of retained coefficients. This is evidenced by a consistently lower Mean Squared Error (MSE) for DCT-reconstructed images.

Why? The DCT's superior energy compaction means that the most important visual information is concentrated in fewer coefficients. When we discard the high-frequency coefficients, the DCT loses less critical information compared to the DFT. Furthermore, the DCT's real-valued output avoids the phase-related artifacts and overhead associated with the complex-valued DFT.
**Effect of Block Size**
4x4 Blocks: Preserve fine details well but offer lower energy compaction, resulting in less efficient compression.
8x8 Blocks: Offer a good balance between detail preservation and compression efficiency, which is why it is the standard in JPEG.
16x16 Blocks: Provide the best energy compaction but can lead to more noticeable "blocking" artifacts at high compression rates, as a large area is reconstructed with limited information.
**Visual Artifacts**
When too few coefficients are retained, both methods exhibit:

Blurring: Loss of high-frequency details.
Blocking Artifacts: The grid-like structure of the blocks becomes visible, especially in smooth areas.
Ringing: More pronounced in DFT reconstructions, appearing as ghosting near sharp edges.
***Bonus:*** Entropy Coding
The bonus section successfully implemented a complete entropy coding pipeline. For a 25% coefficient retention rate on the test image, the system achieved:

Average Bits Per Pixel (bpp): 2.3867 bpp
Compression Ratio: 3.35:1
This demonstrates the power of entropy coding in achieving significant compression beyond simple coefficient reduction.

***References***
Gonzalez, R. C., & Woods, R. E. (2018). Digital Image Processing (4th ed.). Pearson.
Oppenheim, A. V., Schafer, R. W., & Buck, J. R. (1999). Discrete-Time Signal Processing (2nd ed.). Prentice Hall.
Ahmed, N., Natarajan, T., & Rao, K. R. (1974). Discrete Cosine Transform. IEEE Transactions on Computers, C-23(1), 90-93.
Wallace, G. K. (1991). The JPEG still picture compression standard. IEEE Transactions on Consumer Electronics, 38(1), xviii-xxxiv.
