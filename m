Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hr2.samba.org ([2a01:4f8:192:486::147:1])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aZCUC-0001R8-KP
 for kexec@lists.infradead.org; Fri, 26 Feb 2016 07:06:49 +0000
Date: Fri, 26 Feb 2016 18:06:15 +1100
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH 3/3] Properly align powerpc64 .toc
Message-ID: <20160226180615.20d86d70@kryten>
In-Reply-To: <20160226180311.2938d804@kryten>
References: <20160226180311.2938d804@kryten>
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

From: Alan Modra <amodra@gmail.com>

gcc leaves .toc byte aligned, relying on the linker to align the section.

	* kexec/arch/ppc64/kexec-elf-rel-ppc64.c (machine_verify_elf_rel):
	Fudge alignment of .toc section.

Signed-off-by: Alan Modra <amodra@gmail.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 43851f6..5f8e3f2 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -23,18 +23,6 @@ static unsigned int local_entry_offset(struct mem_sym *UNUSED(sym))
 }
 #endif
 
-int machine_verify_elf_rel(struct mem_ehdr *ehdr)
-{
-	if (ehdr->ei_class != ELFCLASS64) {
-		return 0;
-	}
-	if (ehdr->e_machine != EM_PPC64) {
-		return 0;
-	}
-
-	return 1;
-}
-
 static struct mem_shdr *toc_section(const struct mem_ehdr *ehdr)
 {
 	struct mem_shdr *shdr, *shdr_end;
@@ -52,6 +40,24 @@ static struct mem_shdr *toc_section(const struct mem_ehdr *ehdr)
 	return NULL;
 }
 
+int machine_verify_elf_rel(struct mem_ehdr *ehdr)
+{
+	struct mem_shdr *toc;
+
+	if (ehdr->ei_class != ELFCLASS64) {
+		return 0;
+	}
+	if (ehdr->e_machine != EM_PPC64) {
+		return 0;
+	}
+
+	/* Ensure .toc is sufficiently aligned.  */
+	toc = toc_section(ehdr);
+	if (toc && toc->sh_addralign < 256)
+		toc->sh_addralign = 256;
+	return 1;
+}
+
 /* r2 is the TOC pointer: it actually points 0x8000 into the TOC (this
    gives the value maximum span in an instruction which uses a signed
    offset) */
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
