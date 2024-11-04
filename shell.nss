settings
{
	priority=1
	exclude.where = !process.is_explorer
	showdelay = 200
	// Options to allow modification of system items
	modify.remove.duplicate=1
	tip.enabled=true
}

import 'imports/theme.nss'
import 'imports/images.nss'

import 'imports/modify.nss'

menu(mode="multiple" title="Pin/Unpin" image=icon.pin)
{
}

menu(mode="multiple" title=title.more_options image=icon.more_options)
{
}


theme
{
	name="modern"
	dark=auto
	background
	{
		color=auto
		opacity=10
		effect=auto
	}
	image.align=2
}

remove(find="Upload to WPS Cloud")
remove(find="Scan with Microsoft Defender")
remove(find="TeraCopy")
remove(find="New folder with selection")
remove(find="Add to Favorites")



import 'imports/terminal.nss'
import 'imports/file-manage.nss'
import 'imports/develop.nss'
import 'imports/goto.nss'
import 'imports/taskbar.nss'
