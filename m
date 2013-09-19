Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from georges.telenet-ops.be ([195.130.137.68])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMaGK-0008QP-LZ
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 09:11:01 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] cris/mips: Remove unused setup_simple_* declarations
Date: Thu, 19 Sep 2013 11:10:19 +0200
Message-Id: <1379581819-10976-1-git-send-email-geert@linux-m68k.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, kexec@lists.infradead.org

Presumably these had been copied from ppc.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 kexec/arch/cris/kexec-cris.h |    8 --------
 kexec/arch/mips/kexec-mips.h |    7 -------
 2 files changed, 15 deletions(-)

diff --git a/kexec/arch/cris/kexec-cris.h b/kexec/arch/cris/kexec-cris.h
index 6af49ef..7ee9945 100644
--- a/kexec/arch/cris/kexec-cris.h
+++ b/kexec/arch/cris/kexec-cris.h
@@ -1,14 +1,6 @@
 #ifndef KEXEC_CRIS_H
 #define KEXEC_CRIS_H
 
-extern unsigned char setup_simple_start[];
-extern uint32_t setup_simple_size;
-
-extern struct {
-	uint32_t spr8;
-	uint32_t spr9;
-} setup_simple_regs;
-
 int elf_cris_probe(const char *buf, off_t len);
 int elf_cris_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
diff --git a/kexec/arch/mips/kexec-mips.h b/kexec/arch/mips/kexec-mips.h
index 6d062fc..e67960b 100644
--- a/kexec/arch/mips/kexec-mips.h
+++ b/kexec/arch/mips/kexec-mips.h
@@ -6,13 +6,6 @@
 
 #define CORE_TYPE_ELF32 1
 #define CORE_TYPE_ELF64 2
-extern unsigned char setup_simple_start[];
-extern uint32_t setup_simple_size;
-
-extern struct {
-	uint32_t spr8;
-	uint32_t spr9;
-} setup_simple_regs;
 
 int elf_mips_probe(const char *buf, off_t len);
 int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
