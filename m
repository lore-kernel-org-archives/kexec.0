From: Li Zhengyu <lizhengyu3@huawei.com>
Date: Wed, 30 Mar 2022 16:16:57 +0800
Subject: [PATCH v2 -next 2/6] RISC-V: use memcpy for kexec_file mode
In-Reply-To: <20220330081701.177026-1-lizhengyu3@huawei.com>
References: <20220330081701.177026-1-lizhengyu3@huawei.com>
Message-ID: <20220330081701.177026-3-lizhengyu3@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Liao Chang <liaochang1@huawei.com>

The pointer to buffer loading kernel binaries is in kernel space for
kexec_fil mode, When copy_from_user copies data from pointer to a block
of memory, it checkes that the pointer is in the user space range, on
RISCV-V that is:

static inline bool __access_ok(unsigned long addr, unsigned long size)
{
	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
}

and TASK_SIZE is 0x4000000000 for 64-bits, which now causes
copy_from_user to reject the access of the field 'buf' of struct
kexec_segment that is in range [CONFIG_PAGE_OFFSET - VMALLOC_SIZE,
CONFIG_PAGE_OFFSET), is invalid user space pointer.

This patch fixes this issue by skipping access_ok(), use mempcy() instead.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/riscv/kernel/machine_kexec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index cbef0fc73afa..df8e24559035 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -65,7 +65,9 @@ machine_kexec_prepare(struct kimage *image)
 		if (image->segment[i].memsz <= sizeof(fdt))
 			continue;
 
-		if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
+		if (image->file_mode)
+			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
+		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
 			continue;
 
 		if (fdt_check_header(&fdt))
-- 
2.17.1


