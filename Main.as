PatternPatch@ g_patchNoStadium;
PatternPatch@ g_patch16x12;

void Main()
{
	// "No stadium" (no sound bug)
	@g_patchNoStadium = PatternPatch(
		"E8 ?? ?? ?? ?? 85 C0 0F 84 ?? ?? ?? ?? 41 81 BF",
		"90 90 90 90 90"
	);

	// "16x12" (sound bug)
	@g_patch16x12 = PatternPatch(
		"E8 ?? ?? ?? ?? 48 8B 4C 24 28 83",
		"90 90 90 90 90"
	);
}

void OnDestroyed()
{
	if (g_patchNoStadium.IsApplied()) {
		g_patchNoStadium.Revert();
	}

	if (g_patch16x12.IsApplied()) {
		g_patch16x12.Revert();
	}
}

void RenderMenu()
{
	if (UI::BeginMenu("\\$cf9" + Icons::Map + "\\$z Unlock all decorations", Permissions::OpenAdvancedMapEditor())) {
		if (UI::MenuItem("Enable \\$cf9No Stadium\\$z decorations (recommended option)", "", g_patchNoStadium.IsApplied())) {
			if (g_patchNoStadium.IsApplied()) {
				g_patchNoStadium.Revert();
			} else {
				g_patchNoStadium.Apply();
			}
		}

		if (UI::MenuItem("Enable legacy \\$cf916x12\\$z decorations (sound bug)", "", g_patch16x12.IsApplied())) {
			if (g_patch16x12.IsApplied()) {
				g_patch16x12.Revert();
			} else {
				g_patch16x12.Apply();
			}
		}

		UI::EndMenu();
	}
}
