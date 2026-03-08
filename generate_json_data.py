#!/usr/bin/env python3
"""
Generate JSON data files for Flutter package from existing public/api JSON files
"""

import json
import os
import glob

def load_json_file(filepath):
    """Load JSON file with UTF-8 encoding"""
    with open(filepath, 'r', encoding='utf-8') as f:
        return json.load(f)

def generate_surahs_json():
    """Generate surahs.json from public/api/*.json files"""
    surahs_data = []
    
    # Read all surah JSON files (1.json to 114.json)
    for surah_no in range(1, 115):
        filepath = f'public/api/{surah_no}.json'
        if not os.path.exists(filepath):
            print(f"Warning: {filepath} not found")
            continue
        
        data = load_json_file(filepath)
        
        surahs_data.append({
            'surah_no': data['surahNo'],
            'surah_name': data['surahName'],
            'surah_name_ar': data['surahNameArabic'],
            'surah_name_ar_long': data['surahNameArabicLong'],
            'surah_name_translation': data['surahNameTranslation'],
            'revelation_place': data['revelationPlace'],
            'total_ayah': data['totalAyah'],
        })
    
    with open('quran_sdk/assets/data/surahs.json', 'w', encoding='utf-8') as f:
        json.dump(surahs_data, f, ensure_ascii=False, indent=2)
    
    print(f"✓ Generated surahs.json with {len(surahs_data)} surahs")

def generate_verses_json():
    """Generate verses.json from public/api/*/*.json files"""
    verses_data = []
    
    # Read all verse JSON files
    for surah_no in range(1, 115):
        surah_dir = f'public/api/{surah_no}'
        if not os.path.isdir(surah_dir):
            print(f"Warning: {surah_dir} not found")
            continue
        
        # Get all verse files in this surah directory
        verse_files = glob.glob(f'{surah_dir}/*.json')
        
        for verse_file in verse_files:
            verse_no = int(os.path.basename(verse_file).replace('.json', ''))
            data = load_json_file(verse_file)
            
            verses_data.append({
                'surah_no': data['surahNo'],
                'ayah_no': data['ayahNo'],
                'text_english': data['english'],
                'text_arabic_with_tashkeel': data['arabic1'],
                'text_arabic_without_tashkeel': data['arabic2'],
            })
    
    # Sort by surah and ayah number
    verses_data.sort(key=lambda x: (x['surah_no'], x['ayah_no']))
    
    with open('quran_sdk/assets/data/verses.json', 'w', encoding='utf-8') as f:
        json.dump(verses_data, f, ensure_ascii=False, indent=2)
    
    print(f"✓ Generated verses.json with {len(verses_data)} verses")

def generate_juz_json():
    """Generate juz.json"""
    juz_data = [
        {"juz": 1, "start": {"surah": 1, "verse": 1}, "end": {"surah": 2, "verse": 141}},
        {"juz": 2, "start": {"surah": 2, "verse": 142}, "end": {"surah": 2, "verse": 252}},
        {"juz": 3, "start": {"surah": 2, "verse": 253}, "end": {"surah": 3, "verse": 92}},
        {"juz": 4, "start": {"surah": 3, "verse": 93}, "end": {"surah": 4, "verse": 23}},
        {"juz": 5, "start": {"surah": 4, "verse": 24}, "end": {"surah": 4, "verse": 147}},
        {"juz": 6, "start": {"surah": 4, "verse": 148}, "end": {"surah": 5, "verse": 81}},
        {"juz": 7, "start": {"surah": 5, "verse": 82}, "end": {"surah": 6, "verse": 110}},
        {"juz": 8, "start": {"surah": 6, "verse": 111}, "end": {"surah": 7, "verse": 87}},
        {"juz": 9, "start": {"surah": 7, "verse": 88}, "end": {"surah": 8, "verse": 40}},
        {"juz": 10, "start": {"surah": 8, "verse": 41}, "end": {"surah": 9, "verse": 92}},
        {"juz": 11, "start": {"surah": 9, "verse": 93}, "end": {"surah": 11, "verse": 5}},
        {"juz": 12, "start": {"surah": 11, "verse": 6}, "end": {"surah": 12, "verse": 52}},
        {"juz": 13, "start": {"surah": 12, "verse": 53}, "end": {"surah": 14, "verse": 52}},
        {"juz": 14, "start": {"surah": 15, "verse": 1}, "end": {"surah": 16, "verse": 128}},
        {"juz": 15, "start": {"surah": 17, "verse": 1}, "end": {"surah": 18, "verse": 74}},
        {"juz": 16, "start": {"surah": 18, "verse": 75}, "end": {"surah": 20, "verse": 135}},
        {"juz": 17, "start": {"surah": 21, "verse": 1}, "end": {"surah": 22, "verse": 78}},
        {"juz": 18, "start": {"surah": 23, "verse": 1}, "end": {"surah": 25, "verse": 20}},
        {"juz": 19, "start": {"surah": 25, "verse": 21}, "end": {"surah": 27, "verse": 55}},
        {"juz": 20, "start": {"surah": 27, "verse": 56}, "end": {"surah": 29, "verse": 45}},
        {"juz": 21, "start": {"surah": 29, "verse": 46}, "end": {"surah": 33, "verse": 30}},
        {"juz": 22, "start": {"surah": 33, "verse": 31}, "end": {"surah": 36, "verse": 27}},
        {"juz": 23, "start": {"surah": 36, "verse": 28}, "end": {"surah": 39, "verse": 31}},
        {"juz": 24, "start": {"surah": 39, "verse": 32}, "end": {"surah": 41, "verse": 46}},
        {"juz": 25, "start": {"surah": 41, "verse": 47}, "end": {"surah": 45, "verse": 37}},
        {"juz": 26, "start": {"surah": 46, "verse": 1}, "end": {"surah": 51, "verse": 30}},
        {"juz": 27, "start": {"surah": 51, "verse": 31}, "end": {"surah": 57, "verse": 29}},
        {"juz": 28, "start": {"surah": 58, "verse": 1}, "end": {"surah": 66, "verse": 12}},
        {"juz": 29, "start": {"surah": 67, "verse": 1}, "end": {"surah": 77, "verse": 50}},
        {"juz": 30, "start": {"surah": 78, "verse": 1}, "end": {"surah": 114, "verse": 6}},
    ]
    
    with open('quran_sdk/assets/data/juz.json', 'w', encoding='utf-8') as f:
        json.dump(juz_data, f, ensure_ascii=False, indent=2)
    
    print(f"✓ Generated juz.json with {len(juz_data)} juz")

if __name__ == '__main__':
    print("Generating JSON data files for Flutter package...")
    print()
    
    # Check if public/api directory exists
    if not os.path.exists('public/api'):
        print("Error: public/api directory not found!")
        print("Please run this script from the Quran-API-main directory")
        exit(1)
    
    generate_surahs_json()
    generate_verses_json()
    generate_juz_json()
    
    print()
    print("✓ All JSON files generated successfully!")
    print()
    print("File sizes:")
    for filename in ['surahs.json', 'verses.json', 'juz.json']:
        filepath = f'quran_sdk/assets/data/{filename}'
        size = os.path.getsize(filepath)
        size_mb = size / (1024 * 1024)
        print(f"  {filename}: {size_mb:.2f} MB")
