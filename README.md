# CrossSide
# Project 1 - Robust Deep-learning-based Side-Channel Attacks

This folder contains all code, collected data, and presentation work from our project on Robust Deep-Learning-based Side-Channel Attacks. It highlights background information, objectives, analysis steps, and explains all the necessary steps we took to obtain our results. 

# Side-Channel Attacks (SCA)
* An attacker analyzes power or electromagnetic (EM) signals of a target (microcontroller or FPGA) when it runs encryption algorithm (e.g., AES) and recovers encryption keys.
* Why? Power consumption is correlated with the value processed by the target.
* 0x00 requires less power than 0xFF

# Deep-Learning SCA
* Advantages: no need to pre-process traces, and can defeat existing countermeasures (masking and random delays)
* High accuracy (>90%) in the same-device setting (meaning, train with device A, test with device A).

# Problem
* Poor performace (<10% accuracy or failure to recover keys) in cross-device settting) 
* Train with device A, test with device B.
* Challenges:  
  * Limited traces from device B
  * Unknown ket from device B
  * Complex discrepancies caused by hardware and software
 
 # Objectives
 * Task 1: Collect EM traces on microcontrollers and test results with our existing ML code.
 * Task 2: Study instruction rewriting in assembly on AVR XMEGA and ARM STM32 as well as examine the impact of instructions rewriting in deep learning side channel attacks.
 * Task 3: Collect EM traces of AES encryption compiled with different optimizations and study the optimizations’ effects.
 
 # Content
 * ```code/instruction_rewriting/``` contains rewritten AES assembly files and instructions on how to use them
 * ```code/data_collection/``` contains scripts for capturing power and EM traces using the ChipWhisperer CW308 UFO board and STM32 or XMEGA target boards
 * ```code/analysis/``` provides code that analyzes data captured with the ChipWhisperer platform. It contains the files to run NICV, CPA, SNR, and train and test a CNN
 * ```code/cw305_fpga_trogan``` contains a sample aes implementation for use with the ChipWhisperer CW305 FPGA board. It also includes a sample project and information on how to generate a bitstream.
 * ```datasets/``` contains datasets collected by REU students
 * ```results/``` contains an example info-sheet for a dataset
 * ```crypto/``` contains the AES implementations leveraged by students with the ChipWhisperer platform. Their original implementations can be found [here](https://github.com/Ko-/aes-armcortexm), [here](https://github.com/ANSSI-FR/secAES-ATmega8515), and [here](https://github.com/kokke/tiny-AES-c).

 
 # EM Data Collection Setup
 * Computer: Desktop in Dr. Wang's Lab, Linux (Ubuntu 20.04.4), either PC1 or PC2
 * Capture Board: Chipwhisperer Kit
   * Channing's board refers to CB 1
   * Jimmy's board refers to CB 2
 * Target Board: Chipwhisperer Kit - XMEGA or STM32
   * Channing's board refers to Target 1
   * Jimmy's board refers to Target 2
 * EM Probe: Chipwhisperer EM probe
   * Setup image can be found [here](EM_probe_setup.png)

# EM Data Collection Process
* Collect 6 50k EM datasets
  * XMEGA unmasked PC1 and PC2
  * XMEGA masked PC1 and PC2
  * STM32 unmasked PC1 and PC2
* Attack Windows: We use the term attack window to denote the corresponding subsequence of power/EM consumption associated with SubBytes of the first round of AES-128.
  * XMEGA unmasked AES: [1800, 2800], (offset = 0)
  * XMEGA masked AES: [1600, 4500], (offset = 17,500] 
  * STM32 unmasked AES: [1200, 2200], (offset = 0)
* Perform Normal Inter-Class Variance (NICV) to identify and locate leakage within a defined attack window.
  * ```code/analysis/NICV/```
  * An example of an NICV graph collected can be found [here](NICV_XMEGAun_example.png)
* Perform Signal to Noise Ratio (SNR)
  * ```code/analysis/SNR/```
  * An example of an SNR graph collected can be found [here](SNR_XMEGAmask_example.png)
* Run CPA attack to recover keys
  * ```code/analysis/CPA/```
* Train and test data using Convolutional Neural Network (CNN)
  * ```code/analysis/CNN/```
  * Firstly, train and test in the same-device scenario.
  * Move on to cross-device after completion. 
  * For both scenarios, use 40k for training and 10k for testing

  * Train:
    * python train.py --input path_to_dataset --output path_to_save_the_model --verbose --target_byte TARGET_BYTE --network_type choose_network_type{hw_model,mlp,cnn2,wang,cnn} --attack_window ATTACK_WINDOW
  * Test:
    * python test.py --input path_to_dataset --output path_to_save_the_test_results --model_file MODEL_FILE --verbose --target_byte TARGET_BYTE --network_type choose_network_type{wang,cnn2,cnn,mlp} --attack_window ATTACK_WINDOW



# Power Trace Data Collection Process
* Compile rewritten AES encryption code and load onto XMEGA target
  * ```code/instruction_rewriting/XMEGA/``` 
* Collect 2 50k Power datasets
  * XMEGA masked PC2
  * XMEGA rewritten PC2
* Perform Normal Inter-Class Variance (NICV) to identify and locate leakage within a defined attack window.
  * ```code/analysis/NICV/```
* Perform Signal to Noise Ratio (SNR)
  * ```code/analysis/SNR/```
* Run CPA attack to recover keys
  * ```code/analysis/CPA/```
* Train and test data using Convolutional Neural Network (CNN)
  * ```code/analysis/CNN/```
  * Firstly, train and test masked AES in the same-software scenario.
  * Move on to test rewritten AES 
  * For both scenarios, use 40k for training and 10k for testing
  * Test original masked AES attack window and adjusted attack window based on NICV results

# Contact Information
* Channing Smith, smithcs@g.cofc.edu, College of Charleston <br />
* Joel Ward, joelward@cedarville.edu., Cedarville University <br />
* Chenggang Wang, wang2c9@mail.uc.edu, University of Cincinnati <br />

* Mentors: 
  * Dr. Boyang Wang, wang2ba@ucmail.uc.edu, University of Cincinnati
  * Dr. Marty Emmert, emmertj@ucmail.uc.edu, University of Cincinnati



