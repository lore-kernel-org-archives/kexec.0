From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 18 May 2022 23:48:28 +0530
Subject: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-ID: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
symbols") [1], binutils (v2.36+) started dropping section symbols that
it thought were unused.  This isn't an issue in general, but with
kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
separate .text.unlikely section and the section symbol ".text.unlikely"
is being dropped. Due to this, recordmcount is unable to find a non-weak
symbol in .text.unlikely to generate a relocation record against.

Address this by dropping the weak attribute from these functions:
- arch_kexec_apply_relocations() is not overridden by any architecture
  today, so just drop the weak attribute.
- arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
  Retain the function prototype for those and move the weak
  implementation into the header as a static inline for other
  architectures.

[1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 include/linux/kexec.h | 28 ++++++++++++++++++++++++----
 kernel/kexec_file.c   | 19 +------------------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 58d1b58a971e34..e656f981f43a73 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -193,10 +193,6 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
 int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 				  unsigned long buf_len);
 void *arch_kexec_kernel_image_load(struct kimage *image);
-int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
-				     Elf_Shdr *section,
-				     const Elf_Shdr *relsec,
-				     const Elf_Shdr *symtab);
 int arch_kexec_apply_relocations(struct purgatory_info *pi,
 				 Elf_Shdr *section,
 				 const Elf_Shdr *relsec,
@@ -229,6 +225,30 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mend);
 extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 				       void **addr, unsigned long *sz);
+
+#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section,
+				     const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtab);
+#else
+/*
+ * arch_kexec_apply_relocations_add - apply relocations of type RELA
+ * @pi:		Purgatory to be relocated.
+ * @section:	Section relocations applying to.
+ * @relsec:	Section containing RELAs.
+ * @symtab:	Corresponding symtab.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static inline int
+arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
+				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
+{
+	pr_err("RELA relocation unsupported.\n");
+	return -ENOEXEC;
+}
+#endif /* CONFIG_X86_64 || CONFIG_S390 */
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b96..6bae253b4d315e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -108,23 +108,6 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 }
 #endif
 
-/*
- * arch_kexec_apply_relocations_add - apply relocations of type RELA
- * @pi:		Purgatory to be relocated.
- * @section:	Section relocations applying to.
- * @relsec:	Section containing RELAs.
- * @symtab:	Corresponding symtab.
- *
- * Return: 0 on success, negative errno on error.
- */
-int __weak
-arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
-				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
-{
-	pr_err("RELA relocation unsupported.\n");
-	return -ENOEXEC;
-}
-
 /*
  * arch_kexec_apply_relocations - apply relocations of type REL
  * @pi:		Purgatory to be relocated.
@@ -134,7 +117,7 @@ arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
  *
  * Return: 0 on success, negative errno on error.
  */
-int __weak
+int
 arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
 			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
 {

base-commit: ef1302160bfb19f804451d0e919266703501c875
-- 
2.36.1


