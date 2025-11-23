import 'package:barberzlink/models/state_profile_model.dart';
import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  final StateProfileModel state;
  final VoidCallback onTap;

  const StateCard({super.key, required this.state, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 2.5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- TOP ROW (ICON + STATE NAME + ARROW)
              Row(
                children: [
                  const Icon(Icons.map_rounded, size: 40, color: Colors.red),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      state.stateName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      size: 18, color: Colors.black54),
                ],
              ),

              const SizedBox(height: 12),

              /// --- BOARD NAME
              Text(
                state.boardName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              /// --- WEBSITE PREVIEW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.language, size: 18, color: Colors.red),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      state.websiteLink,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              /// --- TRANSFER / RECIPROCITY PREVIEW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.sync_alt, size: 18, color: Colors.red),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      state.transferLink,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
