# spits out a random free port
function port
    set temp_file_1 (mktemp)
    set temp_file_2 (mktemp)

    seq 49152 65535 | sort > $temp_file_1
    ss -tan | awk 'NR > 1 {print $4}' | cut -d: -f2 | sort -u > $temp_file_2

    set free_port (comm -23 $temp_file_1 $temp_file_2 | shuf | head -n 1)

    rm $temp_file_1 $temp_file_2

    echo $free_port
end
