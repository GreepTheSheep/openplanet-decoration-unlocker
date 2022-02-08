IPatch@ g_patch;

void Main()
{
	@g_patch = PatternPatch(
		"E8 ?? ?? ?? ?? 48 8B 4D 8F 83 F8 FF",
		"90 90 90 90 90"
	);
}

void OnDestroyed()
{
	if (g_patch.IsApplied()) {
		g_patch.Revert();
	}
}

void RenderMenu()
{
	if (UI::MenuItem("\\$cf9" + Icons::Map + "\\$z Unlock all decorations", "", g_patch.IsApplied())) {
		if (g_patch.IsApplied()) {
			g_patch.Revert();
		} else {
			g_patch.Apply();
		}
	}
}
