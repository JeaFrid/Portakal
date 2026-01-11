import os

def create_content_index(source_folder, output_file):
    target_special_file = os.path.join('theme', 'icons.dart')

    with open(output_file, 'w', encoding='utf-8') as out_f:
        for root, dirs, files in os.walk(source_folder):
            for file in files:
                file_path = os.path.join(root, file)
                
                separator = f"\n\n{'='*60}\nDOSYA: {file_path}\n{'='*60}\n\n"
                out_f.write(separator)
                
                try:
                    with open(file_path, 'r', encoding='utf-8', errors='replace') as in_f:
                        if file_path.endswith(target_special_file):
                            lines_read = 0
                            while lines_read < 300:
                                line = in_f.readline()
                                if not line:
                                    break
                                out_f.write(line)
                                lines_read += 1
                            out_f.write("\n\n... [Bu dosya büyük olduğu için sadece ilk 300 satır yazıldı] ...\n")
                        else:
                            content = in_f.read()
                            out_f.write(content)
                except Exception as e:
                    out_f.write(f"[DOSYA OKUNAMADI] - {str(e)}")

if __name__ == "__main__":
    if os.path.exists('lib'):
        create_content_index('lib', 'index.txt')
        print("İşlem tamamlandı. index.txt oluşturuldu.")
    else:
        print("Hata: lib klasörü bulunamadı.")