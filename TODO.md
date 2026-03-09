# TODO List for quran_sdk 0.1.2

## ⚠️ Critical - Must Complete Before Publishing

### 1. Complete pages.json Data
**Status**: 🔴 INCOMPLETE (only 1 page out of 604)

The `assets/data/pages.json` file currently contains only page 1 as a sample. You need to add all 604 pages.

**Options to get the data:**
1. **Use Quran.com API**: https://api.quran.com/api/v4/quran/verses/uthmani
2. **Use Tanzil.net**: https://tanzil.net/docs/download
3. **Use existing Quran databases**: Many open-source projects have this data
4. **Manual entry**: Time-consuming but accurate

**Recommended approach:**
```python
# Use the Quran.com API to fetch page data
import requests
import json

pages_data = []
for page_num in range(1, 605):
    response = requests.get(f'https://api.quran.com/api/v4/verses/by_page/{page_num}')
    data = response.json()
    # Process and format the data
    # Add to pages_data list

# Save to pages.json
with open('assets/data/pages.json', 'w') as f:
    json.dump(pages_data, f, indent=2)
```

### 2. Update verses.json with New Fields
**Status**: 🔴 NOT STARTED

Need to add these fields to each verse in `verses.json`:
- `page`: Page number (1-604)
- `hizb`: Hizb number (1-60)
- `sajda`: Boolean (true/false)
- `sajdaType`: String ("obligatory"/"recommended") if sajda is true

**Script needed:**
```python
# Read existing verses.json
# For each verse, determine:
#   - Which page it's on (from pages.json)
#   - Which hizb it's in (from hizb.json)
#   - If it's a sajda verse (from sajda.json)
# Update and save verses.json
```

## ✅ Completed

- [x] Created Models (Page, Sajda, Hizb)
- [x] Updated Verse model with new fields
- [x] Created sajda.json (15 verses) - COMPLETE
- [x] Created hizb.json (60 Hizb) - COMPLETE
- [x] Updated DataLoader
- [x] Updated QuranSDK with new functions
- [x] Updated pubspec.yaml
- [x] Updated exports
- [x] Created CHANGELOG.md

## 📝 Before Publishing

### Testing
- [ ] Test all new functions
- [ ] Test pages loading
- [ ] Test sajda functions
- [ ] Test hizb functions
- [ ] Test with example app

### Documentation
- [ ] Update README.md with new features
- [ ] Add examples for pages
- [ ] Add examples for sajda
- [ ] Add examples for hizb
- [ ] Update API documentation

### Quality Assurance
- [ ] Run `flutter analyze`
- [ ] Run `flutter test` (if tests exist)
- [ ] Check for any errors
- [ ] Verify all JSON files are valid
- [ ] Test on real device

### Publishing
- [ ] Update version to 0.1.2 in pubspec.yaml ✅
- [ ] Create git tag: `git tag v0.1.2`
- [ ] Push to GitHub: `git push origin v0.1.2`
- [ ] Publish to pub.dev: `flutter pub publish`

## 🚀 Future Enhancements (0.1.3+)

- [ ] Add Tafsir (interpretation)
- [ ] Add word-by-word translation
- [ ] Add bookmarks system
- [ ] Add reading history
- [ ] Add more translations (Arabic, French, etc.)
- [ ] Add Widgets (QuranPageView, VerseWidget, etc.)

## 📞 Need Help?

If you need help completing the pages.json data:
1. Check existing Quran projects on GitHub
2. Use Quran.com API (free and reliable)
3. Contact Islamic organizations for data
4. Ask in Muslim developer communities

---

**Priority**: Complete pages.json and update verses.json BEFORE publishing!
