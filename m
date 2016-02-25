Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hr2.samba.org ([2a01:4f8:192:486::147:1])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aYokE-0001Na-SL
 for kexec@lists.infradead.org; Thu, 25 Feb 2016 05:45:48 +0000
Date: Thu, 25 Feb 2016 16:44:46 +1100
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH 1/2] Pass struct mem_sym into machine_apply_elf_rel()
Message-ID: <20160225164446.44d8b2be@kryten>
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

On PowerPC64 ABIv2 we need to look at the symbol to determine
if it has a local entry point. Pass struct mem_sym into
machine_apply_elf_rel() so we can.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 kexec/arch/arm/kexec-elf-rel-arm.c       | 5 +++--
 kexec/arch/cris/kexec-elf-rel-cris.c     | 5 +++--
 kexec/arch/i386/kexec-elf-rel-x86.c      | 5 +++--
 kexec/arch/ia64/kexec-elf-rel-ia64.c     | 5 +++--
 kexec/arch/m68k/kexec-elf-rel-m68k.c     | 4 +++-
 kexec/arch/mips/kexec-elf-rel-mips.c     | 4 +++-
 kexec/arch/ppc/kexec-elf-rel-ppc.c       | 5 +++--
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c   | 5 +++--
 kexec/arch/s390/kexec-elf-rel-s390.c     | 3 ++-
 kexec/arch/sh/kexec-elf-rel-sh.c         | 5 +++--
 kexec/arch/x86_64/kexec-elf-rel-x86_64.c | 5 +++--
 kexec/kexec-elf-rel.c                    | 2 +-
 kexec/kexec-elf.h                        | 5 +++--
 13 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/kexec/arch/arm/kexec-elf-rel-arm.c b/kexec/arch/arm/kexec-elf-rel-arm.c
index 214f0cc..a939cf4 100644
--- a/kexec/arch/arm/kexec-elf-rel-arm.c
+++ b/kexec/arch/arm/kexec-elf-rel-arm.c
@@ -18,8 +18,9 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+	struct mem_sym *UNUSED(sym), unsigned long r_type, void *location,
+	unsigned long address, unsigned long value)
 {
 	switch(r_type) {
 	case R_ARM_ABS32:
diff --git a/kexec/arch/cris/kexec-elf-rel-cris.c b/kexec/arch/cris/kexec-elf-rel-cris.c
index c4427cc..255cc2c 100644
--- a/kexec/arch/cris/kexec-elf-rel-cris.c
+++ b/kexec/arch/cris/kexec-elf-rel-cris.c
@@ -29,8 +29,9 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+	struct mem_sym *UNUSED(sym), unsigned long r_type, void *location,
+	unsigned long address, unsigned long value)
 {
 	switch(r_type) {
 
diff --git a/kexec/arch/i386/kexec-elf-rel-x86.c b/kexec/arch/i386/kexec-elf-rel-x86.c
index fdc3d52..55a214e 100644
--- a/kexec/arch/i386/kexec-elf-rel-x86.c
+++ b/kexec/arch/i386/kexec-elf-rel-x86.c
@@ -18,8 +18,9 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+	struct mem_sym *UNUSED(sym), unsigned long r_type, void *location,
+	unsigned long address, unsigned long value)
 {
 	switch(r_type) {
 	case R_386_32:
diff --git a/kexec/arch/ia64/kexec-elf-rel-ia64.c b/kexec/arch/ia64/kexec-elf-rel-ia64.c
index cfb1061..f847626 100644
--- a/kexec/arch/ia64/kexec-elf-rel-ia64.c
+++ b/kexec/arch/ia64/kexec-elf-rel-ia64.c
@@ -72,8 +72,9 @@ bundle (const uint64_t insn)
         return insn & ~0xfUL;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+	struct mem_sym *UNUSED(sym), unsigned long r_type, void *location,
+	unsigned long address, unsigned long value)
 {
 	uint64_t gp_value = ehdr->rel_addr + 0x200000;
 	switch(r_type) {
diff --git a/kexec/arch/m68k/kexec-elf-rel-m68k.c b/kexec/arch/m68k/kexec-elf-rel-m68k.c
index fa12a16..0cc38cc 100644
--- a/kexec/arch/m68k/kexec-elf-rel-m68k.c
+++ b/kexec/arch/m68k/kexec-elf-rel-m68k.c
@@ -23,7 +23,9 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+			   struct mem_sym *UNUSED(sym),
+			   unsigned long r_type,
 			   void *UNUSED(location),
 			   unsigned long UNUSED(address),
 			   unsigned long UNUSED(value))
diff --git a/kexec/arch/mips/kexec-elf-rel-mips.c b/kexec/arch/mips/kexec-elf-rel-mips.c
index 6f43639..5bc22d5 100644
--- a/kexec/arch/mips/kexec-elf-rel-mips.c
+++ b/kexec/arch/mips/kexec-elf-rel-mips.c
@@ -29,7 +29,9 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+			   struct mem_sym *UNUSED(sym),
+			   unsigned long r_type,
 			   void *UNUSED(location),
 			   unsigned long UNUSED(address),
 			   unsigned long UNUSED(value))
diff --git a/kexec/arch/ppc/kexec-elf-rel-ppc.c b/kexec/arch/ppc/kexec-elf-rel-ppc.c
index 90a66f4..1acbd86 100644
--- a/kexec/arch/ppc/kexec-elf-rel-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-rel-ppc.c
@@ -17,8 +17,9 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+	struct mem_sym *UNUSED(sym), unsigned long r_type, void *location,
+	unsigned long address, unsigned long value)
 {
 	switch(r_type) {
 	case R_PPC_ADDR32:
diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 9b191d0..8604c4f 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -63,8 +63,9 @@ static void do_relative_toc(unsigned long value, uint16_t *location,
 	*location = (*location & ~mask) | (value & mask);
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *sym,
+	unsigned long r_type, void *location, unsigned long address,
+	unsigned long value)
 {
 	switch(r_type) {
 	case R_PPC64_ADDR32:
diff --git a/kexec/arch/s390/kexec-elf-rel-s390.c b/kexec/arch/s390/kexec-elf-rel-s390.c
index 80bcd1b..a5e1b73 100644
--- a/kexec/arch/s390/kexec-elf-rel-s390.c
+++ b/kexec/arch/s390/kexec-elf-rel-s390.c
@@ -23,7 +23,8 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *ehdr,
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+			   struct mem_sym *UNUSED(sym),
 			   unsigned long r_type,
 			   void *loc,
 			   unsigned long address,
diff --git a/kexec/arch/sh/kexec-elf-rel-sh.c b/kexec/arch/sh/kexec-elf-rel-sh.c
index 0bfc45e..3993ee8 100644
--- a/kexec/arch/sh/kexec-elf-rel-sh.c
+++ b/kexec/arch/sh/kexec-elf-rel-sh.c
@@ -28,8 +28,9 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	return 1;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
-	void *orig_loc, unsigned long UNUSED(address), unsigned long relocation)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+	struct mem_sym *UNUSED(sym), unsigned long r_type, void *orig_loc,
+	unsigned long UNUSED(address), unsigned long relocation)
 {
 	uint32_t *location = orig_loc;
 	uint32_t value;
diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
index c795037..7fdde73 100644
--- a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
@@ -57,8 +57,9 @@ static const char *reloc_name(unsigned long r_type)
 	return name;
 }
 
-void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+	struct mem_sym *UNUSED(sym), unsigned long r_type, void *location,
+	unsigned long address, unsigned long value)
 {
 	dbgprintf("%s\n", reloc_name(r_type));
 	switch(r_type) {
diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
index c625f30..9a6e63d 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -408,7 +408,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 			dbgprintf("sym: %s value: %lx addr: %lx\n",
 				name, value, address);
 
-			machine_apply_elf_rel(ehdr, rel.r_type,
+			machine_apply_elf_rel(ehdr, &sym, rel.r_type,
 				(void *)location, address, value);
 		}
 	}
diff --git a/kexec/kexec-elf.h b/kexec/kexec-elf.h
index d0e9dc0..1164db4 100644
--- a/kexec/kexec-elf.h
+++ b/kexec/kexec-elf.h
@@ -129,7 +129,8 @@ unsigned long elf_max_addr(const struct mem_ehdr *ehdr);
 
 /* Architecture specific helper functions */
 extern int machine_verify_elf_rel(struct mem_ehdr *ehdr);
-extern void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type, 
-	void *location, unsigned long address, unsigned long value);
+extern void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *sym,
+	unsigned long r_type, void *location, unsigned long address,
+	unsigned long value);
 #endif /* KEXEC_ELF_H */
 
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
