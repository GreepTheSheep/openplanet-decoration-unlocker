array<string> PatchModes = {
    "Stadium Sound Fix",
    "No Block Below"
};

[Setting hidden]
string selectedPatchMode = PatchModes[0];

[SettingsTab name="Patch Mode Selector"]
void RenderPatchModeSelectorSetting()
{
    UI::Markdown("This plugin has "+ PatchModes.Length +" patch modes:\n\n"
        "__Stadium Sound Fix__: This patch mode fixes the sound bug by adding possibility to build below the grass. (Patch by Beu)\n"
        "__No Block Below__: This patch mode prevents the player from being able to place blocks below the grass, but there's no sound bug. (Patch by Moski)");

    UI::NewLine();
    UI::Separator();

    if (!g_patch.IsApplied()) {
        if (UI::BeginCombo("Patch Mode", selectedPatchMode)){
            for (uint i = 0; i < PatchModes.Length; i++) {
                string patchMode = PatchModes[i];

                if (UI::Selectable(patchMode, selectedPatchMode == patchMode)) {
                    selectedPatchMode = patchMode;
                    ChangePatchMode(PatchModes.Find(selectedPatchMode));
                }

                if (selectedPatchMode == patchMode) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }
    } else {
        UI::Text('\\$f00' + Icons::Times + '\\$z Please disable patch through menu before changing patch mode.');
    }
}