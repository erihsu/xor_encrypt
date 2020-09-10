

set NAME xor_encrypt

create_project $NAME -part xc7z045ffg900-1 -force

import_files -fileset sources_1 ../logical -norecurse -flat
import_files -fileset sim_1 ../testcase -norecurse -flat

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

launch_simulation

