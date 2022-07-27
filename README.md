# CrossSide
# Project 1 - Robust Deep-learning-based Side-Channel Attacks
Channing Smith, College of Charleston <br />
Joel Ward, Cedarville University <br />
Chenggang Wang, University of Cincinnati <br />

Mentors: Dr. Boyang Wang, Dr. Marty Emmert

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
* Collect 8 50k EM datasets
  * XMEGA unmasked PC1 and PC2
  * XMEGA masked PC1 and PC2
  * STM32 unmasked PC1 and PC2
  * STM32 masked PC1 and PC2
* Perform Normal Inter-Class Variance (NICV) to identify and locate leakage within a defined attack window.
  * NICV scripts can be found in the TripletPower project.
* Perform Signal to Noise Ratio (SNR)
  * SNR scripts can be found in the TripletPower project.
* Run CPA attack to recover keys
  * CPA attack script can be found in the TripletPower project.
* Train and test data using Convolutional Neural Network (CNN)
  * Firstly, train and test in the same-device scenario.
  * Move on to cross-device after completion. 
  * For both scenarios, use 40k for training and 10k for testing

  * Train:
    * python train.py --input path_to_dataset --output path_to_save_the_model --verbose --target_byte TARGET_BYTE --network_type choose_network_type{hw_model,mlp,cnn2,wang,cnn} --attack_window ATTACK_WINDOW
  * Test:
    * python test.py --input path_to_dataset --output path_to_save_the_test_results --model_file MODEL_FILE --verbose --target_byte TARGET_BYTE --network_type choose_network_type{wang,cnn2,cnn,mlp} --attack_window ATTACK_WINDOW
# Instruciton Rewriting
* Causes software discrepancy.
* Train with masked AES, test with rewritten AES.
* Rewrote lines of assembly code with 1-3 comparable lines.
* Focused on SubBytes and addRoundKey routines.
* 24 lines rewritten.

# Power Traces Data Collection
* Collect 50k masked AES power traces.
* Collect 50k rewritten masked AES power traces.
  * 40k traces for training
  * 10k traces for testing
* Run NICV, SNR, and CPA







