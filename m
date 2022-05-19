From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 19 May 2022 15:41:39 +1000
Subject: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
In-Reply-To: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <874k1mnkoc.fsf@mpe.ellerman.id.au>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [1], binutils (v2.36+) started dropping section symbols that
> it thought were unused.  This isn't an issue in general, but with
> kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
> separate .text.unlikely section and the section symbol ".text.unlikely"
> is being dropped. Due to this, recordmcount is unable to find a non-weak
> symbol in .text.unlikely to generate a relocation record against.
>
> Address this by dropping the weak attribute from these functions:
> - arch_kexec_apply_relocations() is not overridden by any architecture
>   today, so just drop the weak attribute.
> - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>   Retain the function prototype for those and move the weak
>   implementation into the header as a static inline for other
>   architectures.
>
> [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  include/linux/kexec.h | 28 ++++++++++++++++++++++++----
>  kernel/kexec_file.c   | 19 +------------------
>  2 files changed, 25 insertions(+), 22 deletions(-)

I think it could be cleaner done with the #define foo foo style, see
patch below. It does have its downsides, but for a simple hook like this
I think it's not too bad.

cheers


(only build tested)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 7f3c9ac34bd8..e818b58ccc43 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -74,6 +74,8 @@ void *kexec_file_add_components(struct kimage *image,
 int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
 			 unsigned long addr);
 
+#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
+
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 11b7c06e2828..58e3939a350a 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -186,6 +186,8 @@ extern int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages,
 extern void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages);
 #define arch_kexec_pre_free_pages arch_kexec_pre_free_pages
 
+#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
+
 #endif
 
 typedef void crash_vmclear_fn(void);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..6f07acb59f29 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -108,6 +108,7 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 }
 #endif
 
+#ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
  * @pi:		Purgatory to be relocated.
@@ -117,14 +118,16 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
  *
  * Return: 0 on success, negative errno on error.
  */
-int __weak
+int
 arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
 				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
 {
 	pr_err("RELA relocation unsupported.\n");
 	return -ENOEXEC;
 }
+#endif
 
+#ifndef arch_kexec_apply_relocations
 /*
  * arch_kexec_apply_relocations - apply relocations of type REL
  * @pi:		Purgatory to be relocated.
@@ -134,13 +137,14 @@ arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
  *
  * Return: 0 on success, negative errno on error.
  */
-int __weak
+int
 arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
 			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
 {
 	pr_err("REL relocation unsupported.\n");
 	return -ENOEXEC;
 }
+#endif
 
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary


