From: Li Zhengyu <lizhengyu3@huawei.com>
Date: Wed, 1 Jun 2022 14:39:24 +0800
Subject: [PATCH] RISCV: kexec: Fix build error without CONFIG_MODULES
Message-ID: <20220601063924.13037-1-lizhengyu3@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

When CONFIG_MODULES is not set/enabled:

../arch/riscv/kernel/elf_kexec.c:353:9: error: unknown type name 'Elf_Rela'; did you mean 'Elf64_Rela'?
  353 |         Elf_Rela *relas;
      |         ^~~~~~~~
      |         Elf64_Rela

Replace Elf_Rela by Elf64_Rela to avoid relying on CONFIG_MODULES.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 arch/riscv/kernel/elf_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 9cb85095fd45..0cb94992c15b 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -349,7 +349,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 {
 	const char *strtab, *name, *shstrtab;
 	const Elf_Shdr *sechdrs;
-	Elf_Rela *relas;
+	Elf64_Rela *relas;
 	int i, r_type;
 
 	/* String & section header string table */
-- 
2.17.1


