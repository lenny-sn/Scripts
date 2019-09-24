[void][reflection.assembly]::LoadWithPartialName(
"System.Drawing")
[void][reflection.assembly]::LoadWithPartialName(
"System.Windows.Forms")
function Point {New-Object System.Drawing.Point $args}
function Size {New-Object System.Drawing.Size $args}
function Form ($Control,$Properties)
{
$c = New-Object "Windows.Forms.$control"
if ($properties)
{
foreach ($prop in $properties.keys)
{
$c.$prop = $properties[$prop]
}
}$c}
function Drawing ($control,$constructor,$properties)
{
$c = new-object "Drawing.$control" $constructor
if ($properties.count)
{
foreach ($prop in $properties.keys)
{
$c.$prop = $properties[$prop]
}
}$c}
function RightEdge ($x, $offset=1)
{
$x.Location.X + $x.Size.Width + $offset
}
function LeftEdge ($x)
{
$x.Location.X
}
function BottomEdge ($x, $offset=1)
{
$x.Location.Y + $x.Size.Height + $offset
}
function TopEdge ($x) {
$x.Location.Y
}
function Message ($string,
$title='PowerShell Message')
{
[windows.forms.messagebox]::Show($string, $title)
}
function New-Menustrip ($Form, [scriptblock] $Menu)
{
$ms = Form MenuStrip
[void]$ms.Items.AddRange((&$menu))
$form.MainMenuStrip = $ms
$ms
}
function New-Menu($Name, [scriptblock] $Items)
{
$menu = Form ToolStripMenuItem @{Text = $name}
[void] $menu.DropDownItems.AddRange((&$items))
$menu
}
function New-MenuItem($Name, $Action)
{
$item = Form ToolStripMenuItem @{Text = $name}
[void] $item.Add_Click($action)
$item
}
function New-Separator { Form ToolStripSeparator }
function Style ($RowOrColumn="row",$Percent=-1)
{
if ($Percent -eq -1)
{
$typeArgs = "AutoSize"
}
else
{
$typeArgs = "Percent",$percent
}
New-Object Windows.Forms.${RowOrColumn}Style $typeArgs}