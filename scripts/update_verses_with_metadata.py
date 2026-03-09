"""
Script to add pageNumber, hizbNumber, and sajda info to verses.json
"""
import json

print("Loading data files...")

# Load pages data
with open('../assets/data/pages.json', 'r', encoding='utf-8') as f:
    pages = json.load(f)

# Load hizb data
with open('../assets/data/hizb.json', 'r', encoding='utf-8') as f:
    hizb_list = json.load(f)

# Load sajda data
with open('../assets/data/sajda.json', 'r', encoding='utf-8') as f:
    sajda_list = json.load(f)

# Load verses data
with open('../assets/data/verses.json', 'r', encoding='utf-8') as f:
    verses = json.load(f)

print(f"Loaded {len(pages)} pages, {len(hizb_list)} hizb, {len(sajda_list)} sajda verses, {len(verses)} verses")

# Create mappings
print("\nCreating mappings...")

# 1. Verse to Page mapping
verse_to_page = {}
for page in pages:
    page_number = page['number']
    for verse_info in page['verses']:
        surah = verse_info['surah']
        verse = verse_info['verse']
        key = f"{surah}:{verse}"
        verse_to_page[key] = page_number

print(f"Created {len(verse_to_page)} verse-to-page mappings")

# 2. Verse to Hizb mapping
verse_to_hizb = {}
for hizb in hizb_list:
    hizb_number = hizb['number']
    start_surah = hizb['start']['surah']
    start_verse = hizb['start']['verse']
    end_surah = hizb['end']['surah']
    end_verse = hizb['end']['verse']
    
    # This is simplified - we'll assign hizb based on page ranges
    # For now, we'll calculate it properly by checking verse ranges

print(f"Loaded {len(hizb_list)} hizb definitions")

# 3. Sajda verses mapping
sajda_verses = {}
for sajda in sajda_list:
    surah = sajda['surah']
    verse = sajda['verse']
    key = f"{surah}:{verse}"
    sajda_verses[key] = sajda['type']

print(f"Created {len(sajda_verses)} sajda verse mappings")

# Update verses
print("\nUpdating verses...")
updated_page = 0
updated_sajda = 0
missing_page = []

for verse in verses:
    surah = verse['surah_no']
    verse_num = verse['ayah_no']
    key = f"{surah}:{verse_num}"
    
    # Add pageNumber
    if key in verse_to_page:
        verse['pageNumber'] = verse_to_page[key]
        updated_page += 1
    else:
        verse['pageNumber'] = None
        missing_page.append(key)
    
    # Add sajda info
    if key in sajda_verses:
        verse['sajda'] = True
        verse['sajdaType'] = sajda_verses[key]
        updated_sajda += 1
    else:
        verse['sajda'] = False
        verse['sajdaType'] = None
    
    # Add hizbNumber (we'll calculate from page number)
    # Each hizb is approximately 10 pages (604 pages / 60 hizb ≈ 10)
    if verse['pageNumber']:
        # Use hizb data to find correct hizb
        verse_page = verse['pageNumber']
        hizb_num = None
        
        for hizb in hizb_list:
            # Get first and last page of this hizb
            start_key = f"{hizb['start']['surah']}:{hizb['start']['verse']}"
            end_key = f"{hizb['end']['surah']}:{hizb['end']['verse']}"
            
            if start_key in verse_to_page and end_key in verse_to_page:
                start_page = verse_to_page[start_key]
                end_page = verse_to_page[end_key]
                
                if start_page <= verse_page <= end_page:
                    hizb_num = hizb['number']
                    break
        
        verse['hizb'] = hizb_num
    else:
        verse['hizb'] = None

print(f"\nUpdated {updated_page} verses with page numbers")
print(f"Updated {updated_sajda} verses with sajda info")

if missing_page:
    print(f"\nWarning: {len(missing_page)} verses missing page numbers:")
    for key in missing_page[:10]:  # Show first 10
        print(f"  - {key}")

# Save updated verses
print("\nSaving updated verses.json...")
with open('../assets/data/verses.json', 'w', encoding='utf-8') as f:
    json.dump(verses, f, ensure_ascii=False, indent=2)

print("Done! verses.json updated with all metadata")
print("\nSummary:")
print(f"  - Total verses: {len(verses)}")
print(f"  - With page numbers: {updated_page}")
print(f"  - With sajda info: {updated_sajda}")
print(f"  - With hizb info: {sum(1 for v in verses if v.get('hizb'))}")
