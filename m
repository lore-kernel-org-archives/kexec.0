Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RPrWs-0004as-PP
 for kexec@lists.infradead.org; Mon, 14 Nov 2011 08:04:35 +0000
Date: Mon, 14 Nov 2011 18:56:22 +1100
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH 3/3] kexec-tools: powerpc: Cleanup relocation code
Message-ID: <20111114185622.79fe0a18@kryten>
In-Reply-To: <20111114185329.19ddc2b4@kryten>
References: <20111114185329.19ddc2b4@kryten>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Matt Evans <matt@ozlabs.org>, Michael Neuling <mikey@neuling.org>, Milton Miller <miltonm@bga.com>, amodra@gmail.com
Cc: kexec@lists.infradead.org


Some cleanup of the relocation code:

- Whitespace changes
- Use braces to add clarity to nested for/if loop.
- Order ADDR16 relocations
- No need for to return from a void function.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kexec-tools/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2011-11-14 18:06:07.492903716 +1100
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2011-11-14 18:09:14.168245553 +1100
@@ -16,6 +16,7 @@ int machine_verify_elf_rel(struct mem_eh
 	if (ehdr->e_machine != EM_PPC64) {
 		return 0;
 	}
+
 	return 1;
 }
 
@@ -23,13 +24,16 @@ static struct mem_shdr *toc_section(cons
 {
 	struct mem_shdr *shdr, *shdr_end;
 	unsigned char *strtab;
+
 	strtab = (unsigned char *)ehdr->e_shdr[ehdr->e_shstrndx].sh_data;
 	shdr_end = &ehdr->e_shdr[ehdr->e_shnum];
-	for(shdr = ehdr->e_shdr; shdr != shdr_end; shdr++)
-		if ( shdr->sh_size &&
-			strcmp((char *)&strtab[shdr->sh_name],
-						".toc") == 0)
+	for (shdr = ehdr->e_shdr; shdr != shdr_end; shdr++) {
+		if (shdr->sh_size &&
+			strcmp((char *)&strtab[shdr->sh_name], ".toc") == 0) {
 			return shdr;
+		}
+	}
+
 	return NULL;
 }
 
@@ -39,10 +43,12 @@ static struct mem_shdr *toc_section(cons
 unsigned long my_r2(const struct mem_ehdr *ehdr)
 {
 	struct mem_shdr *shdr;
+
 	shdr = toc_section(ehdr);
 	if (!shdr) {
 		die("TOC reloc without a toc section?");
 	}
+
 	return shdr->sh_addr + 0x8000;
 }
 
@@ -112,14 +118,13 @@ void machine_apply_elf_rel(struct mem_eh
 	case R_PPC64_REL24:
 		/* Convert value to relative */
 		value -= address;
-		if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0){
-			die("REL24 %li out of range!\n",
-				(long int)value);
+		if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0) {
+			die("REL24 %li out of range!\n", (long int)value);
 		}
 
 		/* Only replace bits 2 through 26 */
-		*(uint32_t *)location = (*(uint32_t *)location & ~0x03fffffc)
-					| (value & 0x03fffffc);
+		*(uint32_t *)location = (*(uint32_t *)location & ~0x03fffffc) |
+					(value & 0x03fffffc);
 		break;
 
 	case R_PPC64_ADDR16_LO:
@@ -127,23 +132,23 @@ void machine_apply_elf_rel(struct mem_eh
 		break;
 
 	case R_PPC64_ADDR16_HI:
-		*(uint16_t *)location = (value>>16) & 0xffff;
+		*(uint16_t *)location = (value >> 16) & 0xffff;
 		break;
 
 	case R_PPC64_ADDR16_HA:
-		*(uint16_t *)location = (((value+0x8000)>>16)  & 0xffff);
+		*(uint16_t *)location = (((value + 0x8000) >> 16) & 0xffff);
 		break;
 
-	case R_PPC64_ADDR16_HIGHEST:
-		*(uint16_t *)location = (((uint64_t)value>>48)  & 0xffff);
-		break;
 	case R_PPC64_ADDR16_HIGHER:
-		*(uint16_t *)location = (((uint64_t)value>>32)  & 0xffff);
+		*(uint16_t *)location = (((uint64_t)value >> 32) & 0xffff);
+		break;
+
+	case R_PPC64_ADDR16_HIGHEST:
+		*(uint16_t *)location = (((uint64_t)value >> 48) & 0xffff);
 		break;
 
 	default:
 		die("Unknown rela relocation: %lu\n", r_type);
 		break;
 	}
-	return;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
