% Grace Rico 7/19/23
% EEG data visualization script
% Input is each of the filenames of ST and DEV saved from EEG sessions.
% Input filenames are sorted by type and data is loaded
% MMN is calculated from loaded data and plotted in 3D axis with the
% order by month then ISI (indicated by figure legend)

% reset and run main
close all; clear all; clc;
main;

function main
    % % KO DATA
    % 3 month data
    KO3mo400st = [];
    KO3mo800st = [];
    KO3mo1600st = [];
    
    KO3mo400dev = [];
    KO3mo800dev = [];
    KO3mo1600dev = [];
    
    % 5 month data
    KO5mo400st = [];
    KO5mo800st = [];
    KO5mo1600st = [];
    
    KO5mo400dev = [];
    KO5mo800dev = [];
    KO5mo1600dev = [];
    
    % 7 month data
    KO7mo400st = [];
    KO7mo800st = [];
    KO7mo1600st = [];
    
    KO7mo400dev = [];
    KO7mo800dev = [];
    KO7mo1600dev = [];
    
    % 9 months data
    KO9mo400st = [];
    KO9mo800st = [];
    KO9mo1600st = [];
    
    KO9mo400dev = [];
    KO9mo800dev = [];
    KO9mo1600dev = [];
    
    
    % % WT DATA
    % 3 month data
    WT3mo400st = [];
    WT3mo800st = [];
    WT3mo1600st = [];
    
    WT3mo400dev = [];
    WT3mo800dev = [];
    WT3mo1600dev = [];
    
    % 5 month data
    WT5mo400st = [];
    WT5mo800st = [];
    WT5mo1600st = [];
    
    WT5mo400dev = [];
    WT5mo800dev = [];
    WT5mo1600dev = [];
    
    % 7 month data
    WT7mo400st = [];
    WT7mo800st = [];
    WT7mo1600st = [];
    
    WT7mo400dev = [];
    WT7mo800dev = [];
    WT7mo1600dev = [];
    
    % 9 months data
    WT9mo400st = [];
    WT9mo800st = [];
    WT9mo1600st = [];
    
    WT9mo400dev = [];
    WT9mo800dev = [];
    WT9mo1600dev = [];
    
    % list of file paths names as string to sort through later - ONLY INPUT
    filepaths = ["C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13902R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928L2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928L2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928L2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928L2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928L2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928L2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13928R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13951R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13951R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13951R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13951R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13951R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13951R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13765R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13765R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13765R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13765R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13765R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13765R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13878R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13878R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13878R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13878R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13878R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13878R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13900R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13900R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13900R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13900R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13900R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13900R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13902R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13902R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13902R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13902R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\CLN3\13902R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928R4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928R4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928R4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928R4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928R4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928R4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13951L1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13951L1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13951L1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13951L1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13951L1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13951L1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13955R2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13955R2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13955R2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13955R2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13955R2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13955R2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13772L3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13772L3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13772L3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13772L3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13772L3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13772L3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13900R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13900R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13900R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13900R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13900R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13900R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13902R2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13902R2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13902R2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13902R2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13902R2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13902R2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13904R4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13920R1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13920R1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13920R1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13920R1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13920R1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13920R1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\3 Mon\WT\13928L4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13951L1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13951L1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13951L1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13951L1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13951L1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13955R2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13955R2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13955R2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13955R2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13955R2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13955R2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13772R4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13772R4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13772R4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13772R4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13772R4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13772R4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13827R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13827R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13827R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13827R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13827R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13827R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13855L2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13855L2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13855L2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13855L2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13855L2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13855L2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13873R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13873R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13873R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13873R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13873R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13873R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13900R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13900R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13900R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13900R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13900R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13900R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13902R2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13902R2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13902R2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13902R2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13902R2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13902R2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13904R4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13920R1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13920R1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13920R1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13920R1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13920R1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13920R1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928L4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928R4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928R4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928R4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928R4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928R4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13928R4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\WT\13951L1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13763R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13951R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13928L2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13902R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13900R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13878R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829R3CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\5 Mon\CLN3\13829L2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13951R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13951R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13951R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13951R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13951R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13951R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13765R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13765R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13765R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13765R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13765R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13765R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829L2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829L2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829L2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829L2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829L2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829L2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829R3CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829R3CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829R3CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829R3CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829R3CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13829R3CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13878R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13878R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13878R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13878R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13878R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13878R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13900R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13900R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13900R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13900R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13900R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13900R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13902R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13902R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13902R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13902R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13902R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13902R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928L2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928L2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928L2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928L2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928L2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928L2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\CLN3\13928R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13951L1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13951L1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13951L1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13951L1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13951L1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13955R2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13955R2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13955R2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13955R2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13955R2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13955R2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13827R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13827R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13827R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13827R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13827R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13827R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13855L2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13855L2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13855L2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13855L2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13855L2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13855L2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13873R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13873R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13873R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13873R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13873R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13873R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13900R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13900R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13900R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13900R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13900R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13900R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13902R2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13902R2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13902R2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13902R2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13902R2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13902R2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13904R4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928L4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928R4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928R4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928R4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928R4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928R4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13928R4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\7 Mon\WT\13951L1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928L2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928L2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13951R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13951R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13951R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13951R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13951R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13951R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13763R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13763R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13763R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13763R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13763R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13763R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829L2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829L2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829L2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829L2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829L2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829L2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829R3CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829R3CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829R3CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829R3CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829R3CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13829R3CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13900R2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13900R2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13900R2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13900R2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13900R2CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13900R2CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13902R1CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13902R1CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13902R1CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13902R1CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13902R1CLN31600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13902R1CLN31600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928L2CLN3400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928L2CLN3400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928L2CLN3800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\CLN3\13928L2CLN3800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13955R2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13955R2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13955R2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13955R2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772L3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772L3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772L3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772L3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772L3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772L3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772R4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772R4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772R4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772R4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772R4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13772R4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13827R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13827R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13827R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13827R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13827R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13827R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13855L2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13855L2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13855L2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13855L2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13855L2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13855L2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13873R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13873R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13873R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13873R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13873R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13873R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13900R3WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13900R3WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13900R3WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13900R3WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13900R3WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13900R3WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13902R2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13902R2WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13902R2WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13902R2WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13902R2WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13902R2WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928L4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928R4WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928R4WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928R4WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928R4WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928R4WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13928R4WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13951L1WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13951L1WT400ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13951L1WT800ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13951L1WT800ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13951L1WT1600ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13951L1WT1600ms_STD.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13955R2WT400ms_DEV.mat"
"C:\Users\grico\Box\Male MMN Data\9 Mon\WT\13955R2WT400ms_STD.mat"];
    
% sort through the file names and add to variables depending on substrings
% in the filepath 
    for files = 1:length(filepaths)
        filename = filepaths{files};
        if contains(filename, "3 Mon")
               if contains(filename, "CLN3")
                   if contains(filename, "STD")
                       if contains(filename, "400ms")
                           KO3mo400st = cat(1, KO3mo400st, load(filename).meanAllST(21, :));
                       elseif contains(filename, "800ms")
                           KO3mo800st = cat(1, KO3mo800st, load(filename).meanAllST(21, :));
                       else contains(filename, "1600ms")
                           KO3mo1600st = cat(1, KO3mo1600st, load(filename).meanAllST(21, :));
                       end
                    else 
                       if contains(filename, "400ms")
                           KO3mo400dev = cat(1, KO3mo400dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "800ms")
                           KO3mo800dev = cat(1, KO3mo800dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "1600ms")
                           KO3mo1600dev = cat(1, KO3mo1600dev, load(filename).meanAllDEV(21, :));
                       end
    
                   end
                    
               else 
                   if contains(filename, "STD")
                       if contains(filename, "400ms")
                           WT3mo400st = cat(1, WT3mo400st, load(filename).meanAllST(21, :));
                       elseif contains(filename, "800ms")
                           WT3mo800st = cat(1, WT3mo800st, load(filename).meanAllST(21, :));
                       else contains(filename, "1600ms")
                           WT3mo1600st = cat(1, WT3mo1600st, load(filename).meanAllST(21, :));
                       end
                    else 
                       if contains(filename, "400ms")
                           WT3mo400dev = cat(1, WT3mo400dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "800ms")
                           WT3mo800dev = cat(1, WT3mo800dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "1600ms")
                           WT3mo1600dev = cat(1, WT3mo1600dev, load(filename).meanAllDEV(21, :));
                       end
    
                   end
    
               end
        elseif contains(filename, "5 Mon")
            if contains(filename, "CLN3")
                   if contains(filename, "STD")
                       if contains(filename, "400ms")
                           KO5mo400st = cat(1, KO5mo400st, load(filename).meanAllST(21, :));
                       elseif contains(filename, "800ms")
                           KO5mo800st = cat(1, KO5mo800st, load(filename).meanAllST(21, :));
                       else contains(filename, "1600ms")
                           KO5mo1600st = cat(1, KO5mo1600st, load(filename).meanAllST(21, :));
                       end
                    else 
                       if contains(filename, "400ms")
                           KO5mo400dev = cat(1, KO5mo400dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "800ms")
                           KO5mo800dev = cat(1, KO5mo800dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "1600ms")
                           KO5mo1600dev = cat(1, KO5mo1600dev, load(filename).meanAllDEV(21, :));
                       end
    
                   end
                    
               else 
                   if contains(filename, "STD")
                       if contains(filename, "400ms")
                           WT5mo400st = cat(1, WT5mo400st, load(filename).meanAllST(21, :));
                       elseif contains(filename, "800ms")
                           WT5mo800st = cat(1, WT5mo800st, load(filename).meanAllST(21, :));
                       else contains(filename, "1600ms")
                           WT5mo1600st = cat(1, WT5mo1600st, load(filename).meanAllST(21, :));
                       end
                    else 
                       if contains(filename, "400ms")
                           WT5mo400dev = cat(1, WT5mo400dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "800ms")
                           WT5mo800dev = cat(1, WT5mo800dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "1600ms")
                           WT5mo1600dev = cat(1, WT5mo1600dev, load(filename).meanAllDEV(21, :));
                       end
    
                   end
    
            end
        elseif contains(filename, "7 Mon")
            if contains(filename, "CLN3")
                   if contains(filename, "STD")
                       if contains(filename, "400ms")
                           KO7mo400st = cat(1, KO7mo400st, load(filename).meanAllST(21, :));
                       elseif contains(filename, "800ms")
                           KO7mo800st = cat(1, KO7mo800st, load(filename).meanAllST(21, :));
                       else contains(filename, "1600ms")
                           KO7mo1600st = cat(1, KO7mo1600st, load(filename).meanAllST(21, :));
                       end
                    else 
                       if contains(filename, "400ms")
                           KO7mo400dev = cat(1, KO7mo400dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "800ms")
                           KO7mo800dev = cat(1, KO7mo800dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "1600ms")
                           KO7mo1600dev = cat(1, KO7mo1600dev, load(filename).meanAllDEV(21, :));
                       end
    
                   end
                    
               else 
                   if contains(filename, "STD")
                       if contains(filename, "400ms")
                           WT7mo400st = cat(1, WT7mo400st, load(filename).meanAllST(21, :));
                       elseif contains(filename, "800ms")
                           WT7mo800st = cat(1, WT7mo800st, load(filename).meanAllST(21, :));
                       else contains(filename, "1600ms")
                           WT7mo1600st = cat(1, WT7mo1600st, load(filename).meanAllST(21, :));
                       end
                    else 
                       if contains(filename, "400ms")
                           WT7mo400dev = cat(1, WT7mo400dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "800ms")
                           WT7mo800dev = cat(1, WT7mo800dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "1600ms")
                           WT7mo1600dev = cat(1, WT7mo1600dev, load(filename).meanAllDEV(21, :));
                       end
    
                   end
    
            end
        elseif contains(filename, "9 Mon")
            if contains(filename, "CLN3")
                   if contains(filename, "STD")
                       if contains(filename, "400ms")
                           KO9mo400st = cat(1, KO9mo400st, load(filename).meanAllST(21, :));
                       elseif contains(filename, "800ms")
                           KO9mo800st = cat(1, KO9mo800st, load(filename).meanAllST(21, :));
                       else contains(filename, "1600ms")
                           KO9mo1600st = cat(1, KO9mo1600st, load(filename).meanAllST(21, :));
                       end
                    else 
                       if contains(filename, "400ms")
                           KO9mo400dev = cat(1, KO9mo400dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "800ms")
                           KO9mo800dev = cat(1, KO9mo800dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "1600ms")
                           KO9mo1600dev = cat(1, KO9mo1600dev, load(filename).meanAllDEV(21, :));
                       end
    
                   end
                    
               else 
                   if contains(filename, "STD")
                       if contains(filename, "400ms")
                           WT9mo400st = cat(1, WT9mo400st, load(filename).meanAllST(21, :));
                       elseif contains(filename, "800ms")
                           WT9mo800st = cat(1, WT9mo800st, load(filename).meanAllST(21, :));
                       else contains(filename, "1600ms")
                           WT9mo1600st = cat(1, WT9mo1600st, load(filename).meanAllST(21, :));
                       end
                    else 
                       if contains(filename, "400ms")
                           WT9mo400dev = cat(1, WT9mo400dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "800ms")
                           WT9mo800dev = cat(1, WT9mo800dev, load(filename).meanAllDEV(21, :));
                       elseif contains(filename, "1600ms")
                           WT9mo1600dev = cat(1, WT9mo1600dev, load(filename).meanAllDEV(21, :));
                       end
    
                   end
    
               end
        end
    
    end 
    
% one variable aggreggate of each independent variable type
    alldata = {KO3mo400st, KO3mo400dev, KO3mo800st, KO3mo800dev, KO3mo1600st, KO3mo1600dev, KO5mo400st, KO5mo400dev, KO5mo800st, KO5mo800dev, KO5mo1600st, KO5mo1600dev, KO7mo400st, KO7mo400dev, KO7mo800st, KO7mo800dev, KO7mo1600st, KO7mo1600dev, KO9mo400st, KO9mo400dev, KO9mo800st, KO9mo800dev, KO9mo1600st, KO9mo1600dev, WT3mo400st, WT3mo400dev, WT3mo800st, WT3mo800dev, WT3mo1600st, WT3mo1600dev, WT5mo400st, WT5mo400dev, WT5mo800st, WT5mo800dev, WT5mo1600st, WT5mo1600dev, WT7mo400st, WT7mo400dev, WT7mo800st, WT7mo800dev, WT7mo1600st, WT7mo1600dev, WT9mo400st, WT9mo400dev, WT9mo800st, WT9mo800dev, WT9mo1600st, WT9mo1600dev};
    allmmn = zeros(406,24);
    
    % average the data in each variable of alldata
    %set the first row of the variable to the averaged data
    avg = 0;
    for num = 1:48
        sample = alldata{1, num};
        sample = mean(sample, 1);
        for y = 1:406
            alldata{y, num} = sample(y);
        end
    end
    
    %format 
    alldata = cell2mat(alldata);
    
    % calculate the MMN
    for i = 1:24
        allmmn(:, i) = alldata(:, i*2) - alldata(:, i*2-1);
    end
        
    % x and z coordinates for 3d plot and colors
    space = zeros(406, 1);
    times = -5:400;
    style = ["-", "-.", ":", "-", "-.", ":", "-", "-.", ":", "-", "-.", ":", "-", "-.", ":", "-", "-.", ":", "-", "-.", ":", "-", "-.", ":"]; 
    color = ['k', 'k', 'k', 'r', 'r', 'r', 'g', 'g', 'g', 'b', 'b', 'b', 'k', 'k', 'k', 'r', 'r', 'r', 'g', 'g', 'g', 'b', 'b', 'b'];
    
    % plot KO figure left subplot
    subplot(1, 2, 1);
    hold on
    % set to iso view
    view(3);
    % set axis limits for ideal view
    xlim([-5 400]);
    ylim([0 240]);
    title("CLN3 KO");
    % KO data
    for i = 1:12
        % add line plotted from allmmn to lines list of line vars
        lines(i) = plot3(times, space, allmmn(:, i), 'LineWidth', 2, 'LineStyle', style(i), 'Color', color(i));
        % increment the space between lines
        space = space + 20;
    end
    
    % buttons 
    % set location, name, and associated function
    sideview = uicontrol('String','Side View','Units','normalized','Position',[0.00995568263045,0.95,.05,0.0354],'Visible','on', 'Enable', 'on', 'Callback', @snapToSideView);
    frontview = uicontrol('String', 'Front View', 'Units','normalized','Position',[0.00995568263045,0.905,0.05,0.0354], 'Visible', 'on', 'Enable', 'on', 'Callback', @snaptofront);
    button3mo = uicontrol('Style', 'togglebutton', 'String', '3 MO', 'Units','normalized','Position',[0.00995568263045,0.86,0.05,0.0354], 'Visible', 'on', 'Enable', 'on', 'Callback', @three_mo_toggle);
    button5mo = uicontrol('Style', 'togglebutton', 'String', '5 MO', 'Units','normalized','Position',[0.00995568263045,0.815,0.05,0.0354], 'Visible', 'on', 'Enable', 'on', 'Callback', @five_mo_toggle);
    button7mo = uicontrol('Style', 'togglebutton', 'String', '7 MO', 'Units', 'normalized', 'Position', [0.00995568263045,0.77,0.05,0.0354], 'Visible', 'on', 'Enable', 'on', 'Callback', @seven_mo_toggle);
    button9mo = uicontrol('Style', 'togglebutton', 'String', '9 MO', 'Units', 'normalized', 'Position', [0.00995568263045,0.725,0.05,0.0354], 'Visible', 'on', 'Enable', 'on', 'Callback', @nine_mo_toggle);
    b400 = uicontrol('Style', 'togglebutton', 'String', '400 ms', 'Units', 'normalized', 'Position', [0.00995568263045,0.68,0.05,0.0354], 'Visible', 'on', 'Enable', 'on', 'Callback', @b400_toggle);
    b800 = uicontrol('Style', 'togglebutton', 'String', '800 ms', 'Units', 'normalized', 'Position', [0.00995568263045,0.635,0.05,0.0354], 'Visible', 'on', 'Enable', 'on', 'Callback', @b800_toggle);
    b1600 = uicontrol('Style', 'togglebutton', 'String', '1600 ms', 'Units', 'normalized', 'Position', [0.00995568263045,0.59,0.05,0.0354], 'Visible', 'on', 'Enable', 'on', 'Callback', @b1600_toggle);
    reset = uicontrol('String', 'Reset View', 'Units', 'normalized', 'Position', [0.00995568263045,0.545,0.05,0.0354], 'Visible', 'on', 'Enable', 'on', 'Callback', @reset_view);

    %plot WT figure in right subplot
    subplot(1, 2, 2);
    % reset the spaces between the lines to 0
    space = zeros(406, 1);
    hold on
    % set second plot view to iso
    view(3);
    % set plot 2 axis
    xlim([-5 400]);
    ylim([0 240]);
    title("CLN3 WT");

    % WT data
    for i = 13:24
        % plot each line taken from allmmn and assign it to the
        % corresponding index in the lines var
        lines(i) = plot3(times, space, allmmn(:, i), 'LineWidth', 2, 'LineStyle', style(i), 'Color', color(i));
        % increment the space between the lines
        space = space + 20;
    end  

    % add a legend in the order of the variables added in allmmn (taken
    % from alldata)
    legend("3mo400ms", "3mo800ms", "3mo1600ms", "5mo400ms", "5mo800ms", "5mo1600ms", "7mo400ms", "7mo800ms", "7mo1600ms", "9mo400ms", "9mo800ms", "9mo1600ms", 'Position', [0.486647487190949 0.791334798994975 0.065403859899928 0.177763819095477]);
    
   % function to reset visibilities and views
   function reset_view(~, ~)
        subplot(1, 2, 1);
        view(3);
        subplot(1, 2, 2);
        view(3);
        for i = 1:24
            lines(i).LineStyle = style(i);
        end
        button3mo.Value = 0;
        button5mo.Value = 0;
        button7mo.Value = 0;
        button9mo.Value = 0;
        b400.Value = 0;
        b800.Value = 0;
        b1600.Value = 0;
   end
    
    % function to change subplots' views to side (to see amplitude
    % differences)
    function snapToSideView(~, ~)
        subplot(1, 2, 1);
        view(-90, 0);
        subplot(1, 2, 2);
        view(-90, 0);
    end
    
    % function to change subplots' views to the front
    % intended to see head on differences between MMNs - 2d view
    function snaptofront(~, ~)
        subplot(1, 2, 1);
        view(0, 0);
        subplot(1, 2, 2);
        view(0, 0);
    end
    
    % button function to toggle the visibility of 3mo data
    function three_mo_toggle(~, ~)
        if button3mo.Value
            lines(1).LineStyle = 'none';
            lines(2).LineStyle = 'none';
            lines(3).LineStyle = 'none';
            lines(13).LineStyle = 'none';
            lines(14).LineStyle = 'none';
            lines(15).LineStyle = 'none';
        else
            lines(1).LineStyle = '-';
            lines(2).LineStyle = '-.';
            lines(3).LineStyle = ':';
            lines(13).LineStyle = '-';
            lines(14).LineStyle = '-.';
            lines(15).LineStyle = ':';
        end
    end
    
    % button function to toggle the visibility of the 5 mo data
    function five_mo_toggle(~, ~)
        if button5mo.Value
            lines(4).LineStyle = 'none';
            lines(5).LineStyle = 'none';
            lines(6).LineStyle = 'none';
            lines(16).LineStyle = 'none';
            lines(17).LineStyle = 'none';
            lines(18).LineStyle = 'none';
        else
            lines(4).LineStyle = '-';
            lines(5).LineStyle = '-.';
            lines(6).LineStyle = ':';
            lines(16).LineStyle = '-';
            lines(17).LineStyle = '-.';
            lines(18).LineStyle = ':';
        end
    end

    % button function to toggle the visibility of the 7 mo data
    function seven_mo_toggle(~, ~)
        if button7mo.Value
            lines(7).LineStyle = 'none';
            lines(8).LineStyle = 'none';
            lines(9).LineStyle = 'none';
            lines(19).LineStyle = 'none';
            lines(20).LineStyle = 'none';
            lines(21).LineStyle = 'none';
        else 
            lines(7).LineStyle = '-';
            lines(8).LineStyle = '-.';
            lines(9).LineStyle = ':';
            lines(19).LineStyle = '-';
            lines(20).LineStyle = '-.';
            lines(21).LineStyle = ':';
        end
    end

    % button function to toggle the visibility of the 9 mo data
    function nine_mo_toggle(~, ~)
        if button9mo.Value
            lines(10).LineStyle = 'none';
            lines(11).LineStyle = 'none';
            lines(12).LineStyle = 'none';
            lines(22).LineStyle = 'none';
            lines(23).LineStyle = 'none';
            lines(24).LineStyle = 'none';
        else 
            lines(10).LineStyle = '-';
            lines(11).LineStyle = '-.';
            lines(12).LineStyle = ':';
            lines(22).LineStyle = '-';
            lines(23).LineStyle = '-.';
            lines(24).LineStyle = ':';
        end
    end

    % button function to toggle the visibility of 400ms data
    function b400_toggle(~, ~)
        if b400.Value
            lines(1).LineStyle = 'none';
            lines(4).LineStyle = 'none';
            lines(7).LineStyle = 'none';
            lines(10).LineStyle = 'none';
            lines(13).LineStyle = 'none';
            lines(16).LineStyle = 'none';
            lines(19).LineStyle = 'none';
            lines(22).LineStyle = 'none';
        else 
            lines(1).LineStyle = '-';
            lines(4).LineStyle = '-';
            lines(7).LineStyle = '-';
            lines(10).LineStyle = '-';
            lines(13).LineStyle = '-';
            lines(16).LineStyle = '-';
            lines(19).LineStyle = '-';
            lines(22).LineStyle = '-';
        end
    end

    % button function to toggle the visibility of the 800ms data
    function b800_toggle(~, ~)
        if b800.Value
            lines(2).LineStyle = 'none';
            lines(5).LineStyle = 'none';
            lines(8).LineStyle = 'none';
            lines(11).LineStyle = 'none';
            lines(14).LineStyle = 'none';
            lines(17).LineStyle = 'none';
            lines(20).LineStyle = 'none';
            lines(23).LineStyle = 'none';
        else 
            lines(2).LineStyle = '-.';
            lines(5).LineStyle = '-.';
            lines(8).LineStyle = '-.';
            lines(11).LineStyle = '-.';
            lines(14).LineStyle = '-.';
            lines(17).LineStyle = '-.';
            lines(20).LineStyle = '-.';
            lines(23).LineStyle = '-.';
        end
    end

    % button function to toggle the visibility of 1600ms data
    function b1600_toggle(~, ~)
        if b1600.Value
            lines(3).LineStyle = 'none';
            lines(6).LineStyle = 'none';
            lines(9).LineStyle = 'none';
            lines(12).LineStyle = 'none';
            lines(15).LineStyle = 'none';
            lines(18).LineStyle = 'none';
            lines(21).LineStyle = 'none';
            lines(24).LineStyle = 'none';
        else 
            lines(3).LineStyle = ':';
            lines(6).LineStyle = ':';
            lines(9).LineStyle = ':';
            lines(12).LineStyle = ':';
            lines(15).LineStyle = ':';
            lines(18).LineStyle = ':';
            lines(21).LineStyle = ':';
            lines(24).LineStyle = ':';
        end
    end

end 
   
    