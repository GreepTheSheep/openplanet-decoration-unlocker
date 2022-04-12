IPatch@ g_patch;

void Main()
{
    @g_patch = PatternPatch(
        "E8 ?? ?? ?? ?? 85 C0 0F 84 ?? ?? ?? ?? ?? 81 BD 98 03 00 00 00 20 00 2E",
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
        if (Permissions::OpenAdvancedMapEditor()){
            if (g_patch.IsApplied()) {
                g_patch.Revert();
            } else {
                g_patch.Apply();
            }
        } else {
            UI::ShowNotification(Icons::Times + " Error", "You don't have permission to use this feature.");
        }
    }
}
