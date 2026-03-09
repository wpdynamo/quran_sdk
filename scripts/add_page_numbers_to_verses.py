import json

# Load pages data
with open('../assets/data/pages.json', 'r', encoding='utf-8') as f:
    pages = json.load(f)

# Load verses data
with open('../assets/data/verses.json', 'r', encoding='utf-8') as f:
    verses = json.load(f)

# Create a mapping of (surah, verse) -> page number
verse_to_page = {}
for page in pages:
    page_number = page['number']
    for verse_info in page['verses']:
        surah = verse_info['surah']
        verse = verse_info['verse']
        key = f"{surah}:{verse}"
        verse_to_page[key] = page_number

print(f"Total pages: {len(pages)}")
print(f"Total verse mappings: {len(verse_to_page)}")

# Add pageNumber to each verse
updated_count = 0
for verse in verses:
    surah = verse['surah_no']
    verse_num = verse['ayah_no']
    key = f"{surah}:{verse_num}"
    
    if key in verse_to_page:
        verse['pageNumber'] = verse_to_page[key]
        updated_count += 1
    else:
        print(f"Warning: No page found for {key}")
        verse['pageNumber'] = None

print(f"Updated {updated_count} verses with page numbers")

# Save updated verses
with open('../assets/data/verses.json', 'w', encoding='utf-8') as f:
    json.dump(verses, f, ensure_ascii=False, indent=2)

print("Done! verses.json updated with page numbers")
