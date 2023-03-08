# ================================================ #

# �i�[���t�H���_�̒�`(�Ō����\������邱��)
$src_parent_file_path = "C:\Users\kamiz\OneDrive\�f�X�N�g�b�v\VideoSoter\src\"

# �i�[��t�H���_�̒�`(�Ō����\������邱��)
$dst_parent_path = "C:\Users\kamiz\OneDrive\�f�X�N�g�b�v\VideoSoter\dst\"
$dst_path1 = "FBIG_1080x1080"
$dst_path2 = "LAP_1280x720"
$dst_path3 = "TikTok_720x1280"

# ================================================ #

# ��؂蕶��"\"�ŕ�������B�v�f���������̏ꍇ�̓t�H���_���Ŋ�̏ꍇ�̓t�@�C����
$relative_file_path_list = Get-ChildItem -r -File -n $src_parent_file_path
$temp1 = $relative_file_path_list -split "\\", 2

$i = 1
$child_file_paths = @();
$file_names = @();
foreach($str in $temp1){
    if($i % 2 -eq 0){        
        $file_names += $str
    } else{
        $child_file_paths += $str
    }
     $i += 1
}

for($j = 1; $j -le $file_names.Length; $j++){
    $full_file_path = "$($src_parent_file_path)$($child_file_paths[$j - 1])\$($file_names[$j - 1])"

    $folder_path = Split-Path $full_file_path
    $file_name   = Split-Path $full_file_path -Leaf

    # �V�F���I�u�W�F�N�g���쐬����
    $shell = New-Object -ComObject Shell.Application
    $shell_folder = $shell.namespace($folder_path)
    $shell_file   = $shell_folder.parseName($file_name)

    $height = $shell_folder.getDetailsOf($shell_file, 314)
    $width = $shell_folder.getDetailsOf($shell_file, 316)

    if($width -eq "1080" -and $height -eq "1080"){
        Move-Item -Path $full_file_path -Destination "${dst_parent_path}${dst_path1}"
    } elseif($width -eq "1280" -and $height -eq "720"){
        Move-Item -Path $full_file_path -Destination "${dst_parent_path}${dst_path2}"
    } elseif($width -eq "720" -and $height -eq "1280"){
        Move-Item -Path $full_file_path -Destination "${dst_parent_path}${dst_path3}"
    }
}