From: Li Zhengyu <lizhengyu3@huawei.com>
Date: Wed, 30 Mar 2022 16:17:01 +0800
Subject: [PATCH v2 -next 6/6] RISC-V: Load purgatory in kexec_file
In-Reply-To: <20220330081701.177026-1-lizhengyu3@huawei.com>
References: <20220330081701.177026-1-lizhengyu3@huawei.com>
Message-ID: <20220330081701.177026-7-lizhengyu3@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

This patch supports kexec_file to load and relocate purgatory.
It works well on riscv64 QEMU, being tested with devmem.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 arch/riscv/kernel/elf_kexec.c | 151 ++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 911d65d5a123..9cb85095fd45 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -182,6 +182,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	unsigned long new_kernel_pbase = 0UL;
 	unsigned long initrd_pbase = 0UL;
 	unsigned long headers_sz;
+	unsigned long kernel_start;
 	void *fdt, *headers;
 	struct elfhdr ehdr;
 	struct kexec_buf kbuf;
@@ -196,6 +197,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 			     &old_kernel_pbase, &new_kernel_pbase);
 	if (ret)
 		goto out;
+	kernel_start = image->start;
 	pr_notice("The entry point of kernel at 0x%lx\n", image->start);
 
 	/* Add the kernel binary to the image */
@@ -246,6 +248,22 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 		cmdline = modified_cmdline;
 	}
 
+#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
+	/* Add purgatory to the image */
+	kbuf.top_down = true;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	ret = kexec_load_purgatory(image, &kbuf);
+	if (ret) {
+		pr_err("Error loading purgatory ret=%d\n", ret);
+		goto out;
+	}
+	ret = kexec_purgatory_get_set_symbol(image, "riscv_kernel_entry",
+					     &kernel_start,
+					     sizeof(kernel_start), 0);
+	if (ret)
+		pr_err("Error update purgatory ret=%d\n", ret);
+#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
+
 	/* Add the initrd to the image */
 	if (initrd != NULL) {
 		kbuf.buffer = initrd;
@@ -291,6 +309,139 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	return ret ? ERR_PTR(ret) : NULL;
 }
 
+#define RV_X(x, s, n)  (((x) >> (s)) & ((1 << (n)) - 1))
+#define RISCV_IMM_BITS 12
+#define RISCV_IMM_REACH (1LL << RISCV_IMM_BITS)
+#define RISCV_CONST_HIGH_PART(x) \
+	(((x) + (RISCV_IMM_REACH >> 1)) & ~(RISCV_IMM_REACH - 1))
+#define RISCV_CONST_LOW_PART(x) ((x) - RISCV_CONST_HIGH_PART(x))
+
+#define ENCODE_ITYPE_IMM(x) \
+	(RV_X(x, 0, 12) << 20)
+#define ENCODE_BTYPE_IMM(x) \
+	((RV_X(x, 1, 4) << 8) | (RV_X(x, 5, 6) << 25) | \
+	(RV_X(x, 11, 1) << 7) | (RV_X(x, 12, 1) << 31))
+#define ENCODE_UTYPE_IMM(x) \
+	(RV_X(x, 12, 20) << 12)
+#define ENCODE_JTYPE_IMM(x) \
+	((RV_X(x, 1, 10) << 21) | (RV_X(x, 11, 1) << 20) | \
+	(RV_X(x, 12, 8) << 12) | (RV_X(x, 20, 1) << 31))
+#define ENCODE_CBTYPE_IMM(x) \
+	((RV_X(x, 1, 2) << 3) | (RV_X(x, 3, 2) << 10) | (RV_X(x, 5, 1) << 2) | \
+	(RV_X(x, 6, 2) << 5) | (RV_X(x, 8, 1) << 12))
+#define ENCODE_CJTYPE_IMM(x) \
+	((RV_X(x, 1, 3) << 3) | (RV_X(x, 4, 1) << 11) | (RV_X(x, 5, 1) << 2) | \
+	(RV_X(x, 6, 1) << 7) | (RV_X(x, 7, 1) << 6) | (RV_X(x, 8, 2) << 9) | \
+	(RV_X(x, 10, 1) << 8) | (RV_X(x, 11, 1) << 12))
+#define ENCODE_UJTYPE_IMM(x) \
+	(ENCODE_UTYPE_IMM(RISCV_CONST_HIGH_PART(x)) | \
+	(ENCODE_ITYPE_IMM(RISCV_CONST_LOW_PART(x)) << 32))
+#define ENCODE_UITYPE_IMM(x) \
+	(ENCODE_UTYPE_IMM(x) | (ENCODE_ITYPE_IMM(x) << 32))
+
+#define CLEAN_IMM(type, x) \
+	((~ENCODE_##type##_IMM((uint64_t)(-1))) & (x))
+
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section,
+				     const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtab)
+{
+	const char *strtab, *name, *shstrtab;
+	const Elf_Shdr *sechdrs;
+	Elf_Rela *relas;
+	int i, r_type;
+
+	/* String & section header string table */
+	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
+	strtab = (char *)pi->ehdr + sechdrs[symtab->sh_link].sh_offset;
+	shstrtab = (char *)pi->ehdr + sechdrs[pi->ehdr->e_shstrndx].sh_offset;
+
+	relas = (void *)pi->ehdr + relsec->sh_offset;
+
+	for (i = 0; i < relsec->sh_size / sizeof(*relas); i++) {
+		const Elf_Sym *sym;	/* symbol to relocate */
+		unsigned long addr;	/* final location after relocation */
+		unsigned long val;	/* relocated symbol value */
+		unsigned long sec_base;	/* relocated symbol value */
+		void *loc;		/* tmp location to modify */
+
+		sym = (void *)pi->ehdr + symtab->sh_offset;
+		sym += ELF64_R_SYM(relas[i].r_info);
+
+		if (sym->st_name)
+			name = strtab + sym->st_name;
+		else
+			name = shstrtab + sechdrs[sym->st_shndx].sh_name;
+
+		loc = pi->purgatory_buf;
+		loc += section->sh_offset;
+		loc += relas[i].r_offset;
+
+		if (sym->st_shndx == SHN_ABS)
+			sec_base = 0;
+		else if (sym->st_shndx >= pi->ehdr->e_shnum) {
+			pr_err("Invalid section %d for symbol %s\n",
+			       sym->st_shndx, name);
+			return -ENOEXEC;
+		} else
+			sec_base = pi->sechdrs[sym->st_shndx].sh_addr;
+
+		val = sym->st_value;
+		val += sec_base;
+		val += relas[i].r_addend;
+
+		addr = section->sh_addr + relas[i].r_offset;
+
+		r_type = ELF64_R_TYPE(relas[i].r_info);
+
+		switch (r_type) {
+		case R_RISCV_BRANCH:
+			*(u32 *)loc = CLEAN_IMM(BTYPE, *(u32 *)loc) |
+				 ENCODE_BTYPE_IMM(val - addr);
+			break;
+		case R_RISCV_JAL:
+			*(u32 *)loc = CLEAN_IMM(JTYPE, *(u32 *)loc) |
+				 ENCODE_JTYPE_IMM(val - addr);
+			break;
+		/*
+		 * With no R_RISCV_PCREL_LO12_S, R_RISCV_PCREL_LO12_I
+		 * sym is expected to be next to R_RISCV_PCREL_HI20
+		 * in purgatory relsec. Handle it like R_RISCV_CALL
+		 * sym, instead of searching the whole relsec.
+		 */
+		case R_RISCV_PCREL_HI20:
+		case R_RISCV_CALL:
+			*(u64 *)loc = CLEAN_IMM(UITYPE, *(u64 *)loc) |
+				 ENCODE_UJTYPE_IMM(val - addr);
+			break;
+		case R_RISCV_RVC_BRANCH:
+			*(u32 *)loc = CLEAN_IMM(CBTYPE, *(u32 *)loc) |
+				 ENCODE_CBTYPE_IMM(val - addr);
+			break;
+		case R_RISCV_RVC_JUMP:
+			*(u32 *)loc = CLEAN_IMM(CJTYPE, *(u32 *)loc) |
+				 ENCODE_CJTYPE_IMM(val - addr);
+			break;
+		case R_RISCV_ADD32:
+			*(u32 *)loc += val;
+			break;
+		case R_RISCV_SUB32:
+			*(u32 *)loc -= val;
+			break;
+		/* It has been applied by R_RISCV_PCREL_HI20 sym */
+		case R_RISCV_PCREL_LO12_I:
+		case R_RISCV_ALIGN:
+		case R_RISCV_RELAX:
+			break;
+		default:
+			pr_err("Unknown rela relocation: %d\n", r_type);
+			return -ENOEXEC;
+		}
+	}
+	return 0;
+}
+
 const struct kexec_file_ops elf_kexec_ops = {
 	.probe = kexec_elf_probe,
 	.load  = elf_kexec_load,
-- 
2.17.1


