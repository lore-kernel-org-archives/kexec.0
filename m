Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RPrWs-0004at-PQ
 for kexec@lists.infradead.org; Mon, 14 Nov 2011 08:04:35 +0000
Date: Mon, 14 Nov 2011 18:54:33 +1100
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH 2/3] kexec-tools: powerpc: Add more 64bit relocations
Message-ID: <20111114185433.0297c2c8@kryten>
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


Add all the TOC16 relocations. These were hit when building kexec
with a recent toolchain.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kexec-tools/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2011-11-14 18:02:44.933276441 +1100
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2011-11-14 18:06:07.492903716 +1100
@@ -46,6 +46,19 @@ unsigned long my_r2(const struct mem_ehd
 	return shdr->sh_addr + 0x8000;
 }
 
+static void do_relative_toc(unsigned long value, uint16_t *location,
+	unsigned long mask, int complain_signed)
+{
+	if (complain_signed && (value + 0x8000 > 0xffff)) {
+		die("TOC16 relocation overflows (%lu)\n", value);
+	}
+
+	if ((~mask & 0xffff) & value) {
+		die("bad TOC16 relocation (%lu)\n", value);
+	}
+
+	*location = (*location & ~mask) | (value & mask);
+}
 
 void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 	void *location, unsigned long address, unsigned long value)
@@ -70,15 +83,30 @@ void machine_apply_elf_rel(struct mem_eh
 		*(uint64_t *)location = my_r2(ehdr);
 		break;
 
+	case R_PPC64_TOC16:
+		do_relative_toc(value - my_r2(ehdr), location, 0xffff, 1);
+		break;
+
 	case R_PPC64_TOC16_DS:
-		/* Subtact TOC pointer */
-		value -= my_r2(ehdr);
-		if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
-			die("bad TOC16_DS relocation (%lu)\n", value);
-		}
-		*((uint16_t *) location)
-			= (*((uint16_t *) location) & ~0xfffc)
-			| (value & 0xfffc);
+		do_relative_toc(value - my_r2(ehdr), location, 0xfffc, 1);
+		break;
+
+	case R_PPC64_TOC16_LO:
+		do_relative_toc(value - my_r2(ehdr), location, 0xffff, 0);
+		break;
+
+	case R_PPC64_TOC16_LO_DS:
+		do_relative_toc(value - my_r2(ehdr), location, 0xfffc, 0);
+		break;
+
+	case R_PPC64_TOC16_HI:
+		do_relative_toc((value - my_r2(ehdr)) >> 16, location,
+			0xffff, 0);
+		break;
+
+	case R_PPC64_TOC16_HA:
+		do_relative_toc((value - my_r2(ehdr) + 0x8000) >> 16, location,
+			0xffff, 0);
 		break;
 
 	case R_PPC64_REL24:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
