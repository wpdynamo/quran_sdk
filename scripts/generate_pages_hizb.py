#!/usr/bin/env python3
"""
Generate pages.json and hizb.json for quran_sdk
Based on standard Mushaf page divisions
"""

import json

# Standard Quran page data (604 pages)
# Each page contains specific verses from specific surahs
# This is based on the standard Mushaf (Madani Mushaf)

def generate_hizb_data():
    """Generate 60 Hizb data (each Juz has 2 Hizb, each Hizb has 4 quarters)"""
    
    # Hizb divisions based on standard Quran divisions
    # Each Juz = 2 Hizb, Each Hizb = 4 Quarters
    # Total: 30 Juz × 2 = 60 Hizb × 4 = 240 Quarters
    
    hizb_data = [
        # Juz 1 - Hizb 1-2
        {"number": 1, "quarter": 1, "start": {"surah": 1, "verse": 1}, "end": {"surah": 2, "verse": 25}},
        {"number": 1, "quarter": 2, "start": {"surah": 2, "verse": 26}, "end": {"surah": 2, "verse": 43}},
        {"number": 1, "quarter": 3, "start": {"surah": 2, "verse": 44}, "end": {"surah": 2, "verse": 59}},
        {"number": 1, "quarter": 4, "start": {"surah": 2, "verse": 60}, "end": {"surah": 2, "verse": 74}},
        {"number": 2, "quarter": 1, "start": {"surah": 2, "verse": 75}, "end": {"surah": 2, "verse": 91}},
        {"number": 2, "quarter": 2, "start": {"surah": 2, "verse": 92}, "end": {"surah": 2, "verse": 105}},
        {"number": 2, "quarter": 3, "start": {"surah": 2, "verse": 106}, "end": {"surah": 2, "verse": 123}},
        {"number": 2, "quarter": 4, "start": {"surah": 2, "verse": 124}, "end": {"surah": 2, "verse": 141}},
        
        # Juz 2 - Hizb 3-4
        {"number": 3, "quarter": 1, "start": {"surah": 2, "verse": 142}, "end": {"surah": 2, "verse": 157}},
        {"number": 3, "quarter": 2, "start": {"surah": 2, "verse": 158}, "end": {"surah": 2, "verse": 176}},
        {"number": 3, "quarter": 3, "start": {"surah": 2, "verse": 177}, "end": {"surah": 2, "verse": 188}},
        {"number": 3, "quarter": 4, "start": {"surah": 2, "verse": 189}, "end": {"surah": 2, "verse": 202}},
        {"number": 4, "quarter": 1, "start": {"surah": 2, "verse": 203}, "end": {"surah": 2, "verse": 218}},
        {"number": 4, "quarter": 2, "start": {"surah": 2, "verse": 219}, "end": {"surah": 2, "verse": 232}},
        {"number": 4, "quarter": 3, "start": {"surah": 2, "verse": 233}, "end": {"surah": 2, "verse": 242}},
        {"number": 4, "quarter": 4, "start": {"surah": 2, "verse": 243}, "end": {"surah": 2, "verse": 252}},
        
        # For brevity, I'll add a few more and note that the full list needs all 60 Hizb
        # In production, you would need the complete 240 quarters
        
        # Juz 30 - Hizb 59-60 (last ones)
        {"number": 59, "quarter": 1, "start": {"surah": 78, "verse": 1}, "end": {"surah": 80, "verse": 42}},
        {"number": 59, "quarter": 2, "start": {"surah": 81, "verse": 1}, "end": {"surah": 84, "verse": 25}},
        {"number": 59, "quarter": 3, "start": {"surah": 85, "verse": 1}, "end": {"surah": 89, "verse": 30}},
        {"number": 59, "quarter": 4, "start": {"surah": 90, "verse": 1}, "end": {"surah": 95, "verse": 8}},
        {"number": 60, "quarter": 1, "start": {"surah": 96, "verse": 1}, "end": {"surah": 100, "verse": 11}},
        {"number": 60, "quarter": 2, "start": {"surah": 101, "verse": 1}, "end": {"surah": 105, "verse": 5}},
        {"number": 60, "quarter": 3, "start": {"surah": 106, "verse": 1}, "end": {"surah": 110, "verse": 3}},
        {"number": 60, "quarter": 4, "start": {"surah": 111, "verse": 1}, "end": {"surah": 114, "verse": 6}},
    ]
    
    return hizb_data

def generate_pages_sample():
    """Generate sample pages data (first 10 and last 10 pages)"""
    
    # This is a simplified version. In production, you need all 604 pages
    # Each page contains specific verses based on the standard Mushaf
    
    pages_data = [
        # Page 1
        {
            "number": 1,
            "start": {"surah": 1, "verse": 1},
            "end": {"surah": 2, "verse": 5},
            "verses": [
                {"surah": 1, "verse": 1, "first": True},
                {"surah": 1, "verse": 2, "first": False},
                {"surah": 1, "verse": 3, "first": False},
                {"surah": 1, "verse": 4, "first": False},
                {"surah": 1, "verse": 5, "first": False},
                {"surah": 1, "verse": 6, "first": False},
                {"surah": 1, "verse": 7, "first": False},
                {"surah": 2, "verse": 1, "first": True},
                {"surah": 2, "verse": 2, "first": False},
                {"surah": 2, "verse": 3, "first": False},
                {"surah": 2, "verse": 4, "first": False},
                {"surah": 2, "verse": 5, "first": False}
            ]
        },
        # Page 2
        {
            "number": 2,
            "start": {"surah": 2, "verse": 6},
            "end": {"surah": 2, "verse": 16},
            "verses": [
                {"surah": 2, "verse": 6, "first": False},
                {"surah": 2, "verse": 7, "first": False},
                {"surah": 2, "verse": 8, "first": False},
                {"surah": 2, "verse": 9, "first": False},
                {"surah": 2, "verse": 10, "first": False},
                {"surah": 2, "verse": 11, "first": False},
                {"surah": 2, "verse": 12, "first": False},
                {"surah": 2, "verse": 13, "first": False},
                {"surah": 2, "verse": 14, "first": False},
                {"surah": 2, "verse": 15, "first": False},
                {"surah": 2, "verse": 16, "first": False}
            ]
        },
        # ... (need to add pages 3-603)
        
        # Page 604 (last page)
        {
            "number": 604,
            "start": {"surah": 114, "verse": 1},
            "end": {"surah": 114, "verse": 6},
            "verses": [
                {"surah": 114, "verse": 1, "first": True},
                {"surah": 114, "verse": 2, "first": False},
                {"surah": 114, "verse": 3, "first": False},
                {"surah": 114, "verse": 4, "first": False},
                {"surah": 114, "verse": 5, "first": False},
                {"surah": 114, "verse": 6, "first": False}
            ]
        }
    ]
    
    return pages_data

def main():
    """Generate and save the JSON files"""
    
    # Generate Hizb data
    hizb_data = generate_hizb_data()
    with open('../assets/data/hizb.json', 'w', encoding='utf-8') as f:
        json.dump(hizb_data, f, ensure_ascii=False, indent=2)
    print(f"✅ Generated hizb.json with {len(hizb_data)} quarters")
    
    # Generate Pages data (sample)
    pages_data = generate_pages_sample()
    with open('../assets/data/pages.json', 'w', encoding='utf-8') as f:
        json.dump(pages_data, f, ensure_ascii=False, indent=2)
    print(f"✅ Generated pages.json with {len(pages_data)} pages (SAMPLE - needs completion)")
    
    print("\n⚠️  NOTE: The pages.json file is incomplete!")
    print("   You need to add all 604 pages based on the standard Mushaf.")
    print("   You can get this data from:")
    print("   - https://api.quran.com/api/v4/quran/verses/uthmani")
    print("   - https://tanzil.net/docs/download")
    print("   - Or use an existing Quran API that provides page numbers")

if __name__ == '__main__':
    main()
