module xmlreplacement

fn test_htmlentity_to_string() {
	data := '&amp; &#162;'
	assert htmlentity_to_string(data) == '& ¢'
}
