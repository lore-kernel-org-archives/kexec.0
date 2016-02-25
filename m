Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hr2.samba.org ([2a01:4f8:192:486::147:1])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aYomm-0002J9-Pv
 for kexec@lists.infradead.org; Thu, 25 Feb 2016 05:48:25 +0000
Date: Thu, 25 Feb 2016 16:47:52 +1100
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH 2/2] ppc64: purgatory: Handle local symbols in ELF ABIv2
Message-ID: <20160225164752.04076869@kryten>
In-Reply-To: <20160225164446.44d8b2be@kryten>
References: <20160225164446.44d8b2be@kryten>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Bill Schmidt <wschmidt@us.ibm.com>, Alan Modra <amodra@gmail.com>, Tony Breeds <tony@bakeyournoodle.com>
Cc: kexec@lists.infradead.org

The PowerPC64 ELF ABIv2 has the concept of global and local symbols
and information on this is encoded in sym->st_other. When doing a
R_PPC64_REL24 branch we want to hit the local entry point, so adjust
it as necessary.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Note: This fixes a hang we see when kexec is built with recent ABIv2
toolchains. Alan and I have no idea how this ever worked, we must
have got lucky.

diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 8604c4f..35c8229 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -5,6 +5,24 @@
 #include "../../kexec-elf.h"
 #include "kexec-ppc64.h"
 
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define STO_PPC64_LOCAL_BIT	5
+#define STO_PPC64_LOCAL_MASK	(7 << STO_PPC64_LOCAL_BIT)
+#define PPC64_LOCAL_ENTRY_OFFSET(other) \
+ (((1 << (((other) & STO_PPC64_LOCAL_MASK) >> STO_PPC64_LOCAL_BIT)) >> 2) << 2)
+
+static unsigned int local_entry_offset(struct mem_sym *sym)
+{
+	/* If this symbol has a local entry point, use it. */
+	return PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
+}
+#else
+static unsigned int local_entry_offset(struct mem_sym *sym)
+{
+	return 0;
+}
+#endif
+
 int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 {
 	if (ehdr->ei_class != ELFCLASS64) {
@@ -114,6 +132,7 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *sym,
 		break;
 
 	case R_PPC64_REL24:
+		value += local_entry_offset(sym);
 		/* Convert value to relative */
 		value -= address;
 		if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0) {
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
