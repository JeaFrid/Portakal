import os

def generate_exports():
    root_dir = os.getcwd()
    lib_path = os.path.join(root_dir, 'lib/src')
    output_file_path = os.path.join(lib_path, 'portakal.dart')

    if not os.path.exists(lib_path):
        print("Lib klasörü bulunamadı. Lütfen scripti projenin ana dizininde (pubspec.yaml olduğu yer) çalıştırın.")
        return

    export_lines = []

    for current_root, dirs, files in os.walk(lib_path):
        for file in files:
            if file.endswith('.dart'):
                file_full_path = os.path.join(current_root, file)
                
                if os.path.abspath(file_full_path) == os.path.abspath(output_file_path):
                    continue

                relative_path = os.path.relpath(file_full_path, lib_path)
                
                formatted_path = relative_path.replace(os.sep, '/')
                
                export_lines.append(f"export '{formatted_path}';")

    export_lines.sort()

    content = "// Delevop by JeaFriday!\n"
    content += "\n".join(export_lines)
    content += "\n"

    with open(output_file_path, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f"İşlem tamamlandı. {len(export_lines)} adet dosya lib/portakal.dart dosyasına export edildi.")

if __name__ == "__main__":
    generate_exports()