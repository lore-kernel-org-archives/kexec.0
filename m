Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WAKfC-0002Ub-Ps
 for kexec@lists.infradead.org; Mon, 03 Feb 2014 14:38:19 +0000
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 3 Feb 2014 14:37:54 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2FA9517D805F
 for <kexec@lists.infradead.org>; Mon,  3 Feb 2014 14:38:14 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s13EbdGZ25231588
 for <kexec@lists.infradead.org>; Mon, 3 Feb 2014 14:37:39 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s13Ebp2E012719
 for <kexec@lists.infradead.org>; Mon, 3 Feb 2014 07:37:51 -0700
Subject: [RESEND PATCH] kexec/ppc64 ELF ABIv2 ABI support
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 03 Feb 2014 15:37:49 +0100
Message-ID: <20140203143749.7503.74213.stgit@nimbus>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

When building in PPC64 little endian mode, the compiler is now using the
new ABI v2. Among other changes, this new ABI removes the function
descriptors and changes the way the TOC address is computed when entering a
C function.

The purgatory assembly part where the dot symbols are removed, and ELF
relocation code are impacted in this patch.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/elf.h                          |    4 ++++
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c |   27 +++++++++++++++++++++++++++
 kexec/kexec-elf-rel.c                  |   10 +++++-----
 purgatory/arch/ppc64/Makefile          |    6 ++++--
 purgatory/arch/ppc64/hvCall.S          |    5 +++--
 purgatory/arch/ppc64/ppc64_asm.h       |   16 ++++++++++++++++
 purgatory/arch/ppc64/v2wrap.S          |    4 +++-
 7 files changed, 62 insertions(+), 10 deletions(-)
 create mode 100644 purgatory/arch/ppc64/ppc64_asm.h

diff --git a/include/elf.h b/include/elf.h
index 1a2eb5a..5db637b 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1984,6 +1984,10 @@ typedef Elf32_Addr Elf32_Conflict;
 #define R_PPC64_DTPREL16_HIGHERA 104 /* half16	(sym+add)@dtprel@highera */
 #define R_PPC64_DTPREL16_HIGHEST 105 /* half16	(sym+add)@dtprel@highest */
 #define R_PPC64_DTPREL16_HIGHESTA 106 /* half16	(sym+add)@dtprel@highesta */
+#define R_PPC64_REL16           249 /* half16   (sym+add-.) */
+#define R_PPC64_REL16_LO        250 /* half16   (sym+add-.)@l */
+#define R_PPC64_REL16_HI        251 /* half16   (sym+add-.)@h */
+#define R_PPC64_REL16_HA        252 /* half16   (sym+add-.)@ha */
 
 /* Keep this the last entry.  */
 #define R_PPC64_NUM		107
diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 5fc2f87..9b191d0 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -144,6 +144,33 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 		*(uint16_t *)location = (((uint64_t)value >> 48) & 0xffff);
 		break;
 
+		/* R_PPC64_REL16_HA and R_PPC64_REL16_LO are handled to support
+		 * ABIv2 r2 assignment based on r12 for PIC executable.
+		 * Here address is know so replace
+		 *	0:	addis 2,12,.TOC.-0b@ha
+		 *		addi 2,2,.TOC.-0b@l
+		 * by
+		 *		lis 2,.TOC.@ha
+		 *		addi 2,2,.TOC.@l
+		 */
+	case R_PPC64_REL16_HA:
+		/* check that we are dealing with the addis 2,12 instruction */
+		if (((*(uint32_t*)location) & 0xffff0000) != 0x3c4c0000)
+			die("Unexpected instruction for  R_PPC64_REL16_HA");
+		value += my_r2(ehdr);
+		/* replacing by lis 2 */
+		*(uint32_t *)location = 0x3c400000 + ((value >> 16) & 0xffff);
+		break;
+
+	case R_PPC64_REL16_LO:
+		/* check that we are dealing with the addi 2,2 instruction */
+		if (((*(uint32_t*)location) & 0xffff0000) != 0x38420000)
+			die("Unexpected instruction for R_PPC64_REL16_LO");
+
+		value += my_r2(ehdr) - 4;
+		*(uint16_t *)location = value & 0xffff;
+		break;
+
 	default:
 		die("Unknown rela relocation: %lu\n", r_type);
 		break;
diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
index 020cab0..c625f30 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -379,12 +379,12 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 			 * Relocation Entries: If the index is STN_UNDEF,
 			 * the undefined symbol index, the relocation uses 0
 			 * as the "symbol value".
-			 * So, is this really an error condition to flag die?
+			 * TOC symbols appear as undefined but should be
+			 * resolved as well. Their type is STT_NOTYPE so allow
+			 * such symbols to be processed.
 			 */
-			/*
-				die("Undefined symbol: %s\n", name);
-			*/
-				continue;
+				if (ELF32_ST_TYPE(sym.st_info) != STT_NOTYPE)
+					die("Undefined symbol: %s\n", name);
 			}
 			sec_base = 0;
 			if (sym.st_shndx == SHN_COMMON) {
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 6f6716e..c2d0586 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -9,10 +9,12 @@ ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/console-ppc64.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/crashdump_backup.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/misc.S
 
-ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -mcall-aixdesc -msoft-float
-ppc64_PURGATORY_EXTRA_ASFLAGS += -m64 -mcall-aixdesc
+ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float
+ppc64_PURGATORY_EXTRA_ASFLAGS += -m64
 ifeq ($(SUBARCH),BE)
 	ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc
+	ppc64_PURGATORY_EXTRA_CFLAGS += -mcall-aixdesc
+	ppc64_PURGATORY_EXTRA_ASFLAGS += -mcall-aixdesc
 else
 	ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64lppc
 	ppc64_PURGATORY_EXTRA_CFLAGS += -mlittle-endian
diff --git a/purgatory/arch/ppc64/hvCall.S b/purgatory/arch/ppc64/hvCall.S
index bdc4cb0..a96c489 100644
--- a/purgatory/arch/ppc64/hvCall.S
+++ b/purgatory/arch/ppc64/hvCall.S
@@ -9,12 +9,13 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#include "ppc64_asm.h"
 
 #define HVSC	.long 0x44000022
 .text
 	.machine ppc64
-.globl .plpar_hcall_norets
-.plpar_hcall_norets:
+.globl DOTSYM(plpar_hcall_norets)
+DOTSYM(plpar_hcall_norets):
 	or	6,6,6			# medium low priority
         mfcr	0
         stw	0,8(1)
diff --git a/purgatory/arch/ppc64/ppc64_asm.h b/purgatory/arch/ppc64/ppc64_asm.h
new file mode 100644
index 0000000..b8746fd
--- /dev/null
+++ b/purgatory/arch/ppc64/ppc64_asm.h
@@ -0,0 +1,16 @@
+/*
+ * ppc64_asm.h - common defines for PPC64 assembly parts
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+/*
+ * ABIv1 requires dot symbol while ABIv2 does not.
+ */
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define DOTSYM(a)	a
+#else
+#define GLUE(a,b)	a##b
+#define DOTSYM(a)	GLUE(.,a)
+#endif
diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
index 16fb63d..2761c14 100644
--- a/purgatory/arch/ppc64/v2wrap.S
+++ b/purgatory/arch/ppc64/v2wrap.S
@@ -18,6 +18,8 @@
 #  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 #
 
+#include "ppc64_asm.h"
+
 # v2wrap.S
 # a wrapper to call purgatory code to backup first
 # 32kB of first kernel into the backup region
@@ -77,7 +79,7 @@ master:
 	ld      1,0(6)          #setup stack
 
 	subi    1,1,112
-	bl      .purgatory
+	bl      DOTSYM(purgatory)
 	nop
 
 	or	3,3,3		# ok now to high priority, lets boot


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
