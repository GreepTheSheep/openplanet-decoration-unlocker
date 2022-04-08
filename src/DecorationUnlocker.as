IPatch@ g_patch;

void Main()
{
    ChangePatchMode(PatchModes.Find(selectedPatchMode));
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
                UI::ShowNotification(Icons::Check + " Patch disabled");
            } else {
                g_patch.Apply();
                UI::ShowNotification(Icons::Check + " Patch applied on mode: " + selectedPatchMode);
            }
        } else {
            UI::ShowNotification(Icons::Times + " Error", "You don't have permission to use this feature.");
        }
    }
}

void ChangePatchMode(int mode)
{
    if (mode == 0) {// no sound bug
        @g_patch = PatternPatch(
            "E8 ?? ?? ?? ?? 85 C0 0F 84 ?? ?? ?? ?? ?? 81 BD 98 03 00 00 00 20 00 2E",
            "90 90 90 90 90"
        );
    } else if (mode == 1) { // no block below grass
        @g_patch = PatternPatch(
            "E8 ?? ?? ?? ?? 48 8B 4D 8F 83 F8 FF",
            "90 90 90 90 90"
        );
    } else {
        UI::ShowNotification(Icons::Times + " Error", "Selected decoration unlocker patch mode was not found.\nCheck your settings");
    }
}