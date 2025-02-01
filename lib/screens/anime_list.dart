import 'package:flutter/material.dart';
import '../apis/anime_introduce.dart';
import 'anime_introduce.dart';

class AnimeList extends StatelessWidget {
  final AnimeIntroduceAPI animeIntroduceAPI = AnimeIntroduceAPI();
  final TextEditingController searchController = TextEditingController();

  // 검색어를 저장하는 ValueNotifier
  final ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');

  // 전체 애니 목록을 저장하는 ValueNotifier
  final ValueNotifier<List<Map<String, dynamic>>> fullAnimeListNotifier =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // 필터링된 애니메이션 리스트를 저장하는 ValueNotifier
  final ValueNotifier<List<Map<String, dynamic>>> filteredAnimeListNotifier =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  AnimeList({Key? key}) : super(key: key) {
    fetchAnimeList(); // 초기 데이터 로드
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("애니메이션 목록"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildSearchAnime(),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: filteredAnimeListNotifier,
              builder: (context, animeList, _) {
                if (animeList.isEmpty) {
                  return const Center(child: Text("검색 결과가 없습니다."));
                }
                return ListView.builder(
                  itemCount: animeList.length,
                  itemBuilder: (context, index) {
                    return renderItem(context, animeList[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 검색창 UI
  Widget buildSearchAnime() {
    return TextField(
      controller: searchController,
      onChanged: (query) {
        searchQueryNotifier.value = query;
        searchAnimeName();
      },
      decoration: InputDecoration(
        labelText: "애니 제목 입력...",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: searchAnimeName,
          icon: const Icon(Icons.search),
        ),
      ),
      onSubmitted: (_) => searchAnimeName(),
    );
  }

  // 전체 애니 데이터를 가져와서 초기화
  void fetchAnimeList() async {
    final animeList = await animeIntroduceAPI.getAll();
    if (animeList != null) {
      final List<Map<String, dynamic>> fullList =
          List<Map<String, dynamic>>.from(animeList);
      fullAnimeListNotifier.value = fullList;
      filteredAnimeListNotifier.value = fullList;
    }
  }

  // 검색 기능: 전체 목록(fullAnimeListNotifier)에서 검색어를 포함하는 항목만 필터링
  void searchAnimeName() {
    final query = searchQueryNotifier.value.trim();
    final allAnimeList = fullAnimeListNotifier.value;

    if (query.isEmpty) {
      filteredAnimeListNotifier.value = List<Map<String, dynamic>>.from(allAnimeList);
    } else {
      final filteredList = allAnimeList.where((anime) {
        return anime['anime_korean_name']
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();

      filteredAnimeListNotifier.value = filteredList;
    }
  }

  // 애니 클릭 시, 소개 화면으로 이동
  void moveToAnimeIntroduce(BuildContext context, String title, String content, String image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimeIntroduce(
          title: title,
          image: image,
          content: content,
        ),
      ),
    );
  }

  // 애니 목록 표시
  Widget renderItem(BuildContext context, Map<String, dynamic> anime) {
    return GestureDetector(
      onTap: () => moveToAnimeIntroduce(
        context,
        anime['anime_korean_name'],
        anime['content_korean'],
        anime['anime_image'],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Image.network(
                  anime['anime_image'],
                  errorBuilder: (context, error, stackTrace) =>
                      const Text("로드 실패"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 150,
                  child: Text(
                    anime['anime_korean_name'],
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}