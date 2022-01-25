From: d.hatayama@fujitsu.com <d.hatayama@fujitsu.com>
Date: Tue, 25 Jan 2022 12:55:15 +0000
Subject: [PATCH] sadump, kaslr: fix failure of calculating kaslr_offset
Message-ID: <TYAPR01MB6507256A4DFD279894910A24955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On kernels v5.8 or later, makedumpfile fails for memory dumps in the
sadump-related formats as follows:

    # makedumpfile -f -l -d 31 -x ./vmlinux /dev/sdd4 /root/vmcore-ld31
    __vtop4_x86_64: Can't get a valid pud_pte.
    ...110 lines of the same message...
    __vtop4_x86_64: Can't get a valid pud_pte.
    calc_kaslr_offset: failed to calculate kaslr_offset and phys_base; default to 0
    readmem: type_addr: 1, addr:ffffffff85411858, size:8
    __vtop4_x86_64: Can't get pgd (page_dir:ffffffff85411858).
    readmem: Can't convert a virtual address(ffffffff059be980) to physical address.
    readmem: type_addr: 0, addr:ffffffff059be980, size:1024
    cpu_online_mask_init: Can't read cpu_online_mask memory.

    makedumpfile Failed.

This is caused by the kernel commit 9d06c4027f21 ("x86/entry: Convert
Divide Error to IDTENTRY") that renamed divide_error to
asm_exc_divide_error, breaking logic for calculating kaslr offset.

Fix this by adding initialization of asm_exc_divide_error.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@fujitsu.com>
---
 makedumpfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index a51bdaf..7ed9756 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1667,6 +1667,8 @@ get_symbol_info(void)
 	SYMBOL_INIT(cur_cpu_spec, "cur_cpu_spec");
 
 	SYMBOL_INIT(divide_error, "divide_error");
+	if (SYMBOL(divide_error) == NOT_FOUND_SYMBOL)
+		SYMBOL_INIT(divide_error, "asm_exc_divide_error");
 	SYMBOL_INIT(idt_table, "idt_table");
 	SYMBOL_INIT(saved_command_line, "saved_command_line");
 	SYMBOL_INIT(pti_init, "pti_init");
-- 
2.31.1

