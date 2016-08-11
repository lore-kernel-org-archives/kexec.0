Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXz5y-0006uL-D8
 for kexec@lists.infradead.org; Thu, 11 Aug 2016 23:09:11 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BN8f58016487
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:08:45 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24r5ugx51g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:08:45 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 20:08:42 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E1C931DC0054
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:08:30 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BN8d1V29032864
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 20:08:39 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BN8ccu027238
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 20:08:39 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v5 06/13] powerpc: Adapt elf64_apply_relocate_add for
 kexec_file_load.
Date: Thu, 11 Aug 2016 20:08:11 -0300
In-Reply-To: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1470956898-5991-7-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Extend elf64_apply_relocate_add to support relative symbols. This is
necessary because there is a difference between how the module loading
mechanism and the kexec purgatory loading code use Elf64_Sym.st_value
at relocation time: the former changes st_value to point to the absolute
memory address before relocating the module, while the latter does that
adjustment during relocation of the purgatory.

Also, add a check_symbols argument so that the kexec code can be stricter
about undefined symbols.

Finally, add relocation types used by the purgatory.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/elf_util.h |  1 +
 arch/powerpc/kernel/elf_util_64.c   | 84 ++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/module_64.c     |  5 ++-
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/elf_util.h b/arch/powerpc/include/asm/elf_util.h
index a012ba03282d..3405eeabe542 100644
--- a/arch/powerpc/include/asm/elf_util.h
+++ b/arch/powerpc/include/asm/elf_util.h
@@ -67,6 +67,7 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			     const char *strtab, const Elf64_Rela *rela,
 			     unsigned int num_rela, void *syms_base,
 			     void *loc_base, Elf64_Addr addr_base,
+			     bool relative_symbols, bool check_symbols,
 			     const char *obj_name);
 
 #endif /* _ASM_POWERPC_ELF_UTIL_H */
diff --git a/arch/powerpc/kernel/elf_util_64.c b/arch/powerpc/kernel/elf_util_64.c
index 8e5d400ac9f2..80f209a42abd 100644
--- a/arch/powerpc/kernel/elf_util_64.c
+++ b/arch/powerpc/kernel/elf_util_64.c
@@ -74,6 +74,8 @@ static void squash_toc_save_inst(const char *name, unsigned long addr) { }
  * @syms_base:		Contents of the associated symbol table.
  * @loc_base:		Contents of the section to which relocations apply.
  * @addr_base:		The address where the section will be loaded in memory.
+ * @relative_symbols:	Are the symbols' st_value members relative?
+ * @check_symbols:	Fail if an unexpected symbol is found?
  * @obj_name:		The name of the ELF binary, for information messages.
  *
  * Applies RELA relocations to an ELF file already at its final location
@@ -84,11 +86,13 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			     const char *strtab, const Elf64_Rela *rela,
 			     unsigned int num_rela, void *syms_base,
 			     void *loc_base, Elf64_Addr addr_base,
+			     bool relative_symbols, bool check_symbols,
 			     const char *obj_name)
 {
 	unsigned int i;
 	unsigned long *location;
 	unsigned long address;
+	unsigned long sec_base;
 	unsigned long value;
 	const char *name;
 	Elf64_Sym *sym;
@@ -121,8 +125,36 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 		       name, (unsigned long)sym->st_value,
 		       (long)rela[i].r_addend);
 
+		if (check_symbols) {
+			/*
+			 * TOC symbols appear as undefined but should be
+			 * resolved as well, so allow them to be processed.
+			 */
+			if (sym->st_shndx == SHN_UNDEF &&
+					strcmp(name, ".TOC.") != 0) {
+				pr_err("Undefined symbol: %s\n", name);
+				return -ENOEXEC;
+			} else if (sym->st_shndx == SHN_COMMON) {
+				pr_err("Symbol '%s' in common section.\n", name);
+				return -ENOEXEC;
+			}
+		}
+
+		if (relative_symbols && sym->st_shndx != SHN_ABS) {
+			if (sym->st_shndx >= elf_info->ehdr->e_shnum) {
+				pr_err("Invalid section %d for symbol %s\n",
+				       sym->st_shndx, name);
+				return -ENOEXEC;
+			} else {
+				struct elf_shdr *sechdrs = elf_info->sechdrs;
+
+				sec_base = sechdrs[sym->st_shndx].sh_addr;
+			}
+		} else
+			sec_base = 0;
+
 		/* `Everything is relative'. */
-		value = sym->st_value + rela[i].r_addend;
+		value = sym->st_value + sec_base + rela[i].r_addend;
 
 		switch (ELF64_R_TYPE(rela[i].r_info)) {
 		case R_PPC64_ADDR32:
@@ -135,6 +167,10 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			*(unsigned long *)location = value;
 			break;
 
+		case R_PPC64_REL32:
+			*(uint32_t *)location = value - (uint32_t)(uint64_t)location;
+			break;
+
 		case R_PPC64_TOC:
 			*(unsigned long *)location = my_r2(elf_info);
 			break;
@@ -186,6 +222,14 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 				| (value & 0xfffc);
 			break;
 
+		case R_PPC64_TOC16_HI:
+			/* Subtract TOC pointer */
+			value -= my_r2(elf_info);
+			value = value >> 16;
+			*((uint16_t *) location)
+				= (*((uint16_t *) location) & ~0xffff)
+				| (value & 0xffff);
+
 		case R_PPC64_TOC16_HA:
 			/* Subtract TOC pointer */
 			value -= my_r2(elf_info);
@@ -195,6 +239,21 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 				| (value & 0xffff);
 			break;
 
+		case R_PPC64_REL14:
+			/* Convert value to relative */
+			value -= address;
+			if (value + 0x8000 > 0xffff || (value & 3) != 0) {
+				pr_err("%s: REL14 %li out of range!\n", obj_name,
+				       (long int)value);
+				return -ENOEXEC;
+			}
+
+			/* Only replace bits 2 through 16 */
+			*(uint32_t *)location
+				= (*(uint32_t *)location & ~0xfffc)
+				| (value & 0xfffc);
+			break;
+
 		case R_PPC_REL24:
 			/* FIXME: Handle weak symbols here --RR */
 			if (sym->st_shndx == SHN_UNDEF) {
@@ -263,6 +322,29 @@ int elf64_apply_relocate_add(const struct elf_info *elf_info,
 			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
 			break;
 
+		case R_PPC64_ADDR16_LO:
+			*(uint16_t *)location = value & 0xffff;
+			break;
+
+		case R_PPC64_ADDR16_HI:
+			*(uint16_t *)location = (value >> 16) & 0xffff;
+			break;
+
+		case R_PPC64_ADDR16_HA:
+			*(uint16_t *)location = (((value + 0x8000) >> 16) &
+							0xffff);
+			break;
+
+		case R_PPC64_ADDR16_HIGHER:
+			*(uint16_t *)location = (((uint64_t)value >> 32) &
+							0xffff);
+			break;
+
+		case R_PPC64_ADDR16_HIGHEST:
+			*(uint16_t *)location = (((uint64_t)value >> 48) &
+							0xffff);
+			break;
+
 		case R_PPC64_REL16_HA:
 			/* Subtract location pointer */
 			value -= address;
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 590e2413974f..10745ac6b004 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -443,6 +443,9 @@ int restore_r2(u32 *instruction, const char *obj_name)
  * When this function is called, the module is already at its final location in
  * memory, so Elf64_Shdr.sh_addr can be used for accessing the section
  * contents as well as the base address for relocations.
+ *
+ * Also, simplify_symbols already changed all symbols' st_value members
+ * to absolute addresses.
  */
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       const char *strtab,
@@ -472,7 +475,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 	return elf64_apply_relocate_add(&me->arch.elf_info, strtab, rela,
 					num_rela, syms_base, (void *) addr_base,
-					addr_base, me->name);
+					addr_base, false, false, me->name);
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
