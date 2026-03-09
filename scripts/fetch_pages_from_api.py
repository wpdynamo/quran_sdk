#!/usr/bin/env python3
"""
Fetch complete pages data from Quran.com API
This script will generate the complete pages.json file with all 604 pages
"""

import requests
import json
import time
from typing import List, Dict

def fetch_page_data(page_number: int) -> Dict:
    """Fetch data for a specific page from Quran.com API"""
    url = f'https://api.quran.com/api/v4/verses/by_page/{page_number}'
    params = {
        'words': 'false',
        'translations': '131',  # English translation
        'fields': 'text_uthmani',
        'per_page': 50
    }
    
    try:
        response = requests.get(url, params=params)
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        print(f"❌ Error fetching page {page_number}: {e}")
        return None

def process_page_data(page_number: int, api_data: Dict) -> Dict:
    """Process API data into our format"""
    if not api_data or 'verses' not in api_data:
        return None
    
    verses = api_data['verses']
    if not verses:
        return None
    
    # Get start and end positions
    first_verse = verses[0]
    last_verse = verses[-1]
    
    # Build verses list
    verses_list = []
    current_surah = None
    
    for verse in verses:
        surah_number = verse['verse_key'].split(':')[0]
        verse_number = verse['verse_key'].split(':')[1]
        
        is_first = (surah_number != current_surah)
        current_surah = surah_number
        
        verses_list.append({
            'surah': int(surah_number),
            'verse': int(verse_number),
            'first': is_first
        })
    
    # Build page object
    page_data = {
        'number': page_number,
        'start': {
            'surah': int(first_verse['verse_key'].split(':')[0]),
            'verse': int(first_verse['verse_key'].split(':')[1])
        },
        'end': {
            'surah': int(last_verse['verse_key'].split(':')[0]),
            'verse': int(last_verse['verse_key'].split(':')[1])
        },
        'verses': verses_list
    }
    
    return page_data

def fetch_all_pages() -> List[Dict]:
    """Fetch all 604 pages"""
    all_pages = []
    
    print("🚀 Starting to fetch all 604 pages from Quran.com API...")
    print("⏱️  This will take approximately 10-15 minutes...")
    print()
    
    for page_num in range(1, 605):
        print(f"📄 Fetching page {page_num}/604...", end=' ')
        
        # Fetch data from API
        api_data = fetch_page_data(page_num)
        
        if api_data:
            # Process the data
            page_data = process_page_data(page_num, api_data)
            
            if page_data:
                all_pages.append(page_data)
                print("✅")
            else:
                print("⚠️  No data")
        else:
            print("❌ Failed")
        
        # Be nice to the API - wait a bit between requests
        if page_num % 10 == 0:
            print(f"   Progress: {page_num}/604 ({page_num/604*100:.1f}%)")
            time.sleep(1)  # Wait 1 second every 10 pages
        else:
            time.sleep(0.1)  # Wait 100ms between requests
    
    return all_pages

def save_pages_data(pages: List[Dict], filename: str = '../assets/data/pages.json'):
    """Save pages data to JSON file"""
    try:
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(pages, f, ensure_ascii=False, indent=2)
        print(f"\n✅ Successfully saved {len(pages)} pages to {filename}")
        return True
    except Exception as e:
        print(f"\n❌ Error saving file: {e}")
        return False

def main():
    """Main function"""
    print("=" * 60)
    print("Quran Pages Data Fetcher")
    print("=" * 60)
    print()
    
    # Fetch all pages
    pages = fetch_all_pages()
    
    if not pages:
        print("\n❌ No pages were fetched. Please check your internet connection.")
        return
    
    print()
    print(f"📊 Total pages fetched: {len(pages)}")
    
    # Save to file
    if save_pages_data(pages):
        print("\n🎉 Done! The pages.json file is now complete.")
        print("\n📝 Next steps:")
        print("   1. Verify the pages.json file")
        print("   2. Run the update_verses_with_page_numbers.py script")
        print("   3. Test the package")
        print("   4. Publish to pub.dev")
    else:
        print("\n❌ Failed to save the file. Please try again.")

if __name__ == '__main__':
    main()
