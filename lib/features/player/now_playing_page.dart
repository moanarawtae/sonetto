import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/models/track.dart';
import '../../services/audio/player_service.dart';
import '../widgets/track_artwork.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerServiceProvider);
    return StreamBuilder<SequenceState?>(
      stream: player.sequenceState,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final track = state?.currentSource?.tag as Track?;
        return Scaffold(
          appBar: AppBar(title: const Text('tocando agora')),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: track == null
                ? const Center(child: Text('nenhuma faixa selecionada'))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TrackArtwork(
                        size: 220,
                        artworkUrl: track.artworkUrl,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      const SizedBox(height: 24),
                      Text(track.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      Text('${track.artist} · ${track.album}',
                          textAlign: TextAlign.center),
                      const SizedBox(height: 24),
                      _PositionSlider(player: player),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: player.previous,
                              icon: const Icon(Icons.skip_previous)),
                          IconButton(
                            onPressed: player.togglePlayPause,
                            iconSize: 48,
                            icon: StreamBuilder<PlayerState>(
                              stream: player.playerState,
                              builder: (context, snapshot) {
                                final playing = snapshot.data?.playing ?? false;
                                return Icon(playing
                                    ? Icons.pause_circle
                                    : Icons.play_circle);
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: player.next,
                              icon: const Icon(Icons.skip_next)),
                        ],
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _PositionSlider extends ConsumerStatefulWidget {
  const _PositionSlider({required this.player});

  final PlayerService player;

  @override
  ConsumerState<_PositionSlider> createState() => _PositionSliderState();
}

class _PositionSliderState extends ConsumerState<_PositionSlider> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
      stream: widget.player.durationStream,
      builder: (context, durationSnapshot) {
        final total = durationSnapshot.data ?? Duration.zero;
        return StreamBuilder<Duration?>(
          stream: widget.player.positionStream,
          builder: (context, positionSnapshot) {
            final position = _dragValue != null
                ? Duration(milliseconds: _dragValue!.round())
                : positionSnapshot.data ?? Duration.zero;
            final maxMillis =
                total.inMilliseconds == 0 ? 1 : total.inMilliseconds;
            final currentMillis = position.inMilliseconds.clamp(0, maxMillis);
            return Slider(
              value: currentMillis.toDouble(),
              max: maxMillis.toDouble(),
              onChanged: (value) {
                setState(() => _dragValue = value);
              },
              onChangeEnd: (value) {
                _dragValue = null;
                widget.player.seek(Duration(milliseconds: value.round()));
              },
            );
          },
        );
      },
    );
  }
}
