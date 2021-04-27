import os
import net.http

fn main() {
	url := 'https://html.spec.whatwg.org/entities.json'
	text := http.get_text(url)
	mut xml_to_value := map[string]string{}
	mut index_quot := 0
	mut start := 0
	mut end := 0
	mut key := ''
	mut key1 := ''
	mut value := ''
	for line in text.split_into_lines() {
		println('$line')
		index_quot = line.index('"') or { -1 }
		if index_quot != -1 {
			start = index_quot + 1
			end = line.index_after('"', start)
			key = line[start..end]
			start = line.index_after('[', end) + 1
			end = line.index_after(']', start)
			key1 = '&#${line[start..end]};'
			value = rune(line[start..end].int()).str()
			xml_to_value[key] = value
			xml_to_value[key1] = value
		}
	}
	mut myfile := os.open_file('../xmlreplacement.v', 'w') or { panic('aie') }
	myfile.writeln('module xmlreplacement\n') or { panic('aie1') }
	myfile.writeln('pub const xml_replacement = map{') or { panic('aie2') }
	for k, v in xml_to_value {
		if v in ["'", '\\', '\n'] {
			myfile.writeln("    '$k': '\\$v'") or { panic('aie3') }
		} else {
			myfile.writeln("    '$k': '$v'") or { panic('aie3') }
		}
	}
	myfile.writeln('}') or { panic('aie4') }
	myfile.close()
	os.execute('v fmt -w ../xmlreplacement.v')
}
