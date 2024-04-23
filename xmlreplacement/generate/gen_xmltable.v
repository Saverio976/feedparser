import os
import net.http

const head = [
	'module xmlreplacement',
	'',
	'pub const xml_replacement = map{',
	'',
]
const func = [
	'}',
	'',
	'// htmlentity_to_string convert a html entity to its rune',
	'pub fn htmlentity_to_string(data string) string {',
	'	mut data_trasnform := data',
	"	if data.contains('&') {",
	'		for key, value in xmlreplacement.xml_replacement {',
	'			data_trasnform = data_trasnform.replace(key, value)',
	'		}',
	'	}',
	'	return data_transform',
	'}',
	'',
]

fn main() {
	url := 'https://html.spec.whatwg.org/entities.json'
	mut text_lines := http.get_text(url).split_into_lines()

	if text_lines.len == 0 {
		text_lines = os.read_lines('entities.json') or {
			panic('Should be run in the generate/ folder itself')
		}
	} else {
		os.write_file('entities.json', text_lines.join_lines()) or {
			panic('Should be run in the generate/ folder itself')
		}
	}

	mut xml_to_value := map[string]string{}
	mut index_quot := 0
	mut start := 0
	mut end := 0
	mut key := ''
	mut key1 := ''
	mut value := ''

	for line in text_lines {
		println('${line}')
		index_quot = line.index('"') or { -1 }
		if index_quot != -1 {
			start = index_quot + 1
			end = line.index_after('"', start)
			key = line[start..end]
			start = line.index_after('[', end) + 1
			end = line.index_after(']', start)
			key1 = '&#${line[start..end]};'
			value = rune(line[start..end].int()).str()
			if key.contains(';') {
				xml_to_value[key] = value
			}
			xml_to_value[key1] = value
		}
	}

	mut myfile := os.open_file('../xmlreplacement.v', 'w') or {
		panic('Should be run in the generate/ folder itself')
	}
	myfile.write_string('${head.join_lines()}') or { panic("can't write") }
	for k, v in xml_to_value {
		if v in ["'", '\\', '\n'] {
			myfile.writeln("    '${k}': '\\${v}'") or { panic("can't write") }
		} else {
			myfile.writeln("    '${k}': '${v}'") or { panic("can't write") }
		}
	}
	myfile.writeln('${func.join_lines()}') or { panic("can't write") }
	myfile.close()

	os.execute('v fmt -w ../xmlreplacement.v')
}
