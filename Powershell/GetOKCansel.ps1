function Get-OkCancel
{
param ($question="Is the answer to Life the Universe and Everything 42?")
function point ($x,$y)
{
New-Object Drawing.Point $x,$y
}
[reflection.assembly]::LoadWithPartialName(
"System.Drawing") > $null
[reflection.assembly]::LoadWithPartialName(
"System.Windows.Forms") > $null
$form = New-Object Windows.Forms.Form
$form.Text = "Pick OK or Cancel"
$form.Size = point 400 200
$label = New-Object Windows.Forms.Label
$label.Text = $question
$label.Location = point 50 50
$label.Size = point 350 50
$label.Anchor="top"
$ok = New-Object Windows.Forms.Button
$ok.text="OK"
$ok.Location = point 50 120
$ok.Anchor="bottom,left"
$ok.add_click({
$form.DialogResult = "OK"
$form.close()
})
$cancel = New-Object Windows.Forms.Button
$cancel.text="Cancel"
$cancel.Location = point 275 120
$cancel.Anchor="bottom,right"
$cancel.add_click({
$form.DialogResult = "Cancel"
$form.close()
})
$form.controls.addRange(($label,$ok,$cancel))
$form.Add_Shown({$form.Activate()})
$form.ShowDialog()
}