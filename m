Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxPmZ-0005dw-As
 for kexec@lists.infradead.org; Fri, 21 Oct 2016 02:42:10 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L2d4Ud030236
 for <kexec@lists.infradead.org>; Thu, 20 Oct 2016 22:41:48 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2675ymh3pb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 20 Oct 2016 22:41:47 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 00:41:45 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id D6C0D352006C
 for <kexec@lists.infradead.org>; Thu, 20 Oct 2016 22:41:15 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L2fgLx31391814
 for <kexec@lists.infradead.org>; Fri, 21 Oct 2016 00:41:42 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L2ffS3006109
 for <kexec@lists.infradead.org>; Fri, 21 Oct 2016 00:41:42 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v9 05/10] powerpc: Factor out relocation code in module_64.c
Date: Fri, 21 Oct 2016 00:40:12 -0200
In-Reply-To: <1477017617-8540-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1477017617-8540-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1477017617-8540-6-git-send-email-bauerman@linux.vnet.ibm.com>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

The kexec_file_load system call needs to relocate the purgatory, so
factor out the module relocation code so that it can be shared.

This patch's purpose is to move the ELF relocation logic from
apply_relocate_add to the new function elf64_apply_relocate_add_item
with as few changes as possible. The following changes were needed:

elf64_apply_relocate_add_item takes a my_r2 argument because the kexec
code can't use the my_r2 function since it doesn't have a struct module
to pass to it. For the same reason, it also takes an obj_name argument to
use in error messages. It still takes a pointer to struct module argument,
but kexec code can just pass NULL because except for the TOC symbol, the
purgatory doesn't have undefined symbols so the module pointer isn't used.

Apart from what is described in the paragraph above, the code has no
functional changes.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/module_64.c | 344 +++++++++++++++++++++-------------------
 1 file changed, 182 insertions(+), 162 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 183368e008cf..61baad036639 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -507,6 +507,181 @@ static int restore_r2(u32 *instruction, struct module *me)
 	return 1;
 }
 
+static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
+					 const char *strtab,
+					 const Elf64_Rela *rela,
+					 const Elf64_Sym *sym,
+					 unsigned long *location,
+					 unsigned long value,
+					 unsigned long my_r2,
+					 const char *obj_name,
+					 struct module *me)
+{
+	switch (ELF64_R_TYPE(rela->r_info)) {
+	case R_PPC64_ADDR32:
+		/* Simply set it */
+		*(u32 *)location = value;
+		break;
+
+	case R_PPC64_ADDR64:
+		/* Simply set it */
+		*(unsigned long *)location = value;
+		break;
+
+	case R_PPC64_TOC:
+		*(unsigned long *)location = my_r2;
+		break;
+
+	case R_PPC64_TOC16:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		if (value + 0x8000 > 0xffff) {
+			pr_err("%s: bad TOC16 relocation (0x%lx)\n",
+			       obj_name, value);
+			return -ENOEXEC;
+		}
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	case R_PPC64_TOC16_LO:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	case R_PPC64_TOC16_DS:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
+			pr_err("%s: bad TOC16_DS relocation (0x%lx)\n",
+			       obj_name, value);
+			return -ENOEXEC;
+		}
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xfffc)
+			| (value & 0xfffc);
+		break;
+
+	case R_PPC64_TOC16_LO_DS:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		if ((value & 3) != 0) {
+			pr_err("%s: bad TOC16_LO_DS relocation (0x%lx)\n",
+			       obj_name, value);
+			return -ENOEXEC;
+		}
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xfffc)
+			| (value & 0xfffc);
+		break;
+
+	case R_PPC64_TOC16_HA:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		value = ((value + 0x8000) >> 16);
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	case R_PPC_REL24:
+		/* FIXME: Handle weak symbols here --RR */
+		if (sym->st_shndx == SHN_UNDEF) {
+			/* External: go via stub */
+			value = stub_for_addr(sechdrs, value, me);
+			if (!value)
+				return -ENOENT;
+			if (!restore_r2((u32 *)location + 1, me))
+				return -ENOEXEC;
+
+			squash_toc_save_inst(strtab + sym->st_name, value);
+		} else
+			value += local_entry_offset(sym);
+
+		/* Convert value to relative */
+		value -= (unsigned long)location;
+		if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0) {
+			pr_err("%s: REL24 %li out of range!\n",
+			       obj_name, (long int)value);
+			return -ENOEXEC;
+		}
+
+		/* Only replace bits 2 through 26 */
+		*(uint32_t *)location
+			= (*(uint32_t *)location & ~0x03fffffc)
+			| (value & 0x03fffffc);
+		break;
+
+	case R_PPC64_REL64:
+		/* 64 bits relative (used by features fixups) */
+		*location = value - (unsigned long)location;
+		break;
+
+	case R_PPC64_TOCSAVE:
+		/*
+		 * Marker reloc indicates we don't have to save r2.
+		 * That would only save us one instruction, so ignore
+		 * it.
+		 */
+		break;
+
+	case R_PPC64_ENTRY:
+		/*
+		 * Optimize ELFv2 large code model entry point if
+		 * the TOC is within 2GB range of current location.
+		 */
+		value = my_r2 - (unsigned long)location;
+		if (value + 0x80008000 > 0xffffffff)
+			break;
+		/*
+		 * Check for the large code model prolog sequence:
+		 *	ld r2, ...(r12)
+		 *	add r2, r2, r12
+		 */
+		if ((((uint32_t *)location)[0] & ~0xfffc)
+		    != 0xe84c0000)
+			break;
+		if (((uint32_t *)location)[1] != 0x7c426214)
+			break;
+		/*
+		 * If found, replace it with:
+		 *	addis r2, r12, (.TOC.-func)@ha
+		 *	addi r2, r12, (.TOC.-func)@l
+		 */
+		((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
+		((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
+		break;
+
+	case R_PPC64_REL16_HA:
+		/* Subtract location pointer */
+		value -= (unsigned long)location;
+		value = ((value + 0x8000) >> 16);
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	case R_PPC64_REL16_LO:
+		/* Subtract location pointer */
+		value -= (unsigned long)location;
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	default:
+		pr_err("%s: Unknown ADD relocation: %lu\n", obj_name,
+		       (unsigned long)ELF64_R_TYPE(rela->r_info));
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       const char *strtab,
 		       unsigned int symindex,
@@ -514,6 +689,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       struct module *me)
 {
 	unsigned int i;
+	int ret;
 	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
 	unsigned long *location;
@@ -548,168 +724,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		/* `Everything is relative'. */
 		value = sym->st_value + rela[i].r_addend;
 
-		switch (ELF64_R_TYPE(rela[i].r_info)) {
-		case R_PPC64_ADDR32:
-			/* Simply set it */
-			*(u32 *)location = value;
-			break;
-
-		case R_PPC64_ADDR64:
-			/* Simply set it */
-			*(unsigned long *)location = value;
-			break;
-
-		case R_PPC64_TOC:
-			*(unsigned long *)location = my_r2(sechdrs, me);
-			break;
-
-		case R_PPC64_TOC16:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			if (value + 0x8000 > 0xffff) {
-				pr_err("%s: bad TOC16 relocation (0x%lx)\n",
-				       me->name, value);
-				return -ENOEXEC;
-			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC64_TOC16_LO:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC64_TOC16_DS:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
-				pr_err("%s: bad TOC16_DS relocation (0x%lx)\n",
-				       me->name, value);
-				return -ENOEXEC;
-			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xfffc)
-				| (value & 0xfffc);
-			break;
-
-		case R_PPC64_TOC16_LO_DS:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			if ((value & 3) != 0) {
-				pr_err("%s: bad TOC16_LO_DS relocation (0x%lx)\n",
-				       me->name, value);
-				return -ENOEXEC;
-			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xfffc)
-				| (value & 0xfffc);
-			break;
-
-		case R_PPC64_TOC16_HA:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			value = ((value + 0x8000) >> 16);
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC_REL24:
-			/* FIXME: Handle weak symbols here --RR */
-			if (sym->st_shndx == SHN_UNDEF) {
-				/* External: go via stub */
-				value = stub_for_addr(sechdrs, value, me);
-				if (!value)
-					return -ENOENT;
-				if (!restore_r2((u32 *)location + 1, me))
-					return -ENOEXEC;
-
-				squash_toc_save_inst(strtab + sym->st_name, value);
-			} else
-				value += local_entry_offset(sym);
-
-			/* Convert value to relative */
-			value -= (unsigned long)location;
-			if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0){
-				pr_err("%s: REL24 %li out of range!\n",
-				       me->name, (long int)value);
-				return -ENOEXEC;
-			}
-
-			/* Only replace bits 2 through 26 */
-			*(uint32_t *)location
-				= (*(uint32_t *)location & ~0x03fffffc)
-				| (value & 0x03fffffc);
-			break;
-
-		case R_PPC64_REL64:
-			/* 64 bits relative (used by features fixups) */
-			*location = value - (unsigned long)location;
-			break;
-
-		case R_PPC64_TOCSAVE:
-			/*
-			 * Marker reloc indicates we don't have to save r2.
-			 * That would only save us one instruction, so ignore
-			 * it.
-			 */
-			break;
-
-		case R_PPC64_ENTRY:
-			/*
-			 * Optimize ELFv2 large code model entry point if
-			 * the TOC is within 2GB range of current location.
-			 */
-			value = my_r2(sechdrs, me) - (unsigned long)location;
-			if (value + 0x80008000 > 0xffffffff)
-				break;
-			/*
-			 * Check for the large code model prolog sequence:
-		         *	ld r2, ...(r12)
-			 *	add r2, r2, r12
-			 */
-			if ((((uint32_t *)location)[0] & ~0xfffc)
-			    != 0xe84c0000)
-				break;
-			if (((uint32_t *)location)[1] != 0x7c426214)
-				break;
-			/*
-			 * If found, replace it with:
-			 *	addis r2, r12, (.TOC.-func)@ha
-			 *	addi r2, r12, (.TOC.-func)@l
-			 */
-			((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
-			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
-			break;
-
-		case R_PPC64_REL16_HA:
-			/* Subtract location pointer */
-			value -= (unsigned long)location;
-			value = ((value + 0x8000) >> 16);
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC64_REL16_LO:
-			/* Subtract location pointer */
-			value -= (unsigned long)location;
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		default:
-			pr_err("%s: Unknown ADD relocation: %lu\n",
-			       me->name,
-			       (unsigned long)ELF64_R_TYPE(rela[i].r_info));
-			return -ENOEXEC;
-		}
+		ret = elf64_apply_relocate_add_item(sechdrs, strtab, &rela[i],
+						    sym, location, value,
+						    my_r2(sechdrs, me),
+						    me->name, me);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
